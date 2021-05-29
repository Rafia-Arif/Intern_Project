using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


public enum RadSchedulerAdvancedFormAdvancedFormMode
{
    Insert, Edit
}

public partial class Controls_ucRoomMeetingAdvancedForm : System.Web.UI.UserControl
{
    #region Private members

    private bool FormInitialized
    {
        get
        {
            return (bool)(ViewState["FormInitialized"] ?? false);
        }

        set
        {
            ViewState["FormInitialized"] = value;
        }
    }

    private RadSchedulerAdvancedFormAdvancedFormMode mode = RadSchedulerAdvancedFormAdvancedFormMode.Insert;

    #endregion

    #region Protected properties

    protected RadScheduler Owner
    {
        get
        {
            return Appointment.Owner;
        }
    }

    protected Appointment Appointment
    {
        get
        {
            SchedulerFormContainer container = (SchedulerFormContainer)BindingContainer;
            return container.Appointment;
        }
    }

    #endregion

    #region Attributes and resources

    [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
    public object RoomID
    {
        get
        {
            return ResRoom.Value;
        }

        set
        {
            ResRoom.Value = value;
        }
    }

    [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
    public object RoomFacilityID
    {
        get
        {
            return ResRoomFacility.Value;
        }

        set
        {
            ResRoomFacility.Value = value;
        }
    }

    #endregion

    #region Public properties

    public RadSchedulerAdvancedFormAdvancedFormMode Mode
    {
        get
        {
            return mode;
        }
        set
        {
            mode = value;
        }
    }

    [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
    public string Subject
    {
        get
        {
            return SubjectText.Text;
        }

        set
        {
            SubjectText.Text = value;
        }
    }

    [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
    public string EmployeeId
    {
        get
        {
            return rdEmployees.SelectedValue;
        }

        set
        {
            //Get all employees
            if (rdEmployees.Items.Count == 0)
            {
                DataSet ds = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Employees", null);
                
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    rdEmployees.Items.Add(new RadComboBoxItem(row["empcod"].ToString() + " - " + row["empprn"].ToString(), row["recidd"].ToString()));
                }

                rdEmployees.Items.Insert(0, new RadComboBoxItem("", ""));
            }
            
            if (string.IsNullOrEmpty(value))
                return;
            rdEmployees.SelectedValue = value;
        }
    }

    [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
    public DateTime Start
    {
        get
        {
            DateTime result = StartDate.SelectedDate.Value.Date;

            if (AllDayEvent.Checked)
            {
                result = result.Date;
            }
            else
            {
                TimeSpan time = StartTime.SelectedDate.Value.TimeOfDay;
                result = result.Add(time);
            }

            return Owner.DisplayToUtc(result);
        }

        set
        {
            StartDate.SelectedDate = Owner.UtcToDisplay(value);
            StartTime.SelectedDate = Owner.UtcToDisplay(value);
        }
    }

    [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
    public DateTime End
    {
        get
        {
            DateTime result = EndDate.SelectedDate.Value.Date;

            if (AllDayEvent.Checked)
            {
                result = result.Date.AddDays(1);
            }
            else
            {
                TimeSpan time = EndTime.SelectedDate.Value.TimeOfDay;
                result = result.Add(time);
            }

            return Owner.DisplayToUtc(result);
        }

        set
        {
            EndDate.SelectedDate = Owner.UtcToDisplay(value);
            EndTime.SelectedDate = Owner.UtcToDisplay(value);
        }
    }

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        UpdateButton.ValidationGroup = Owner.ValidationGroup;
        UpdateButton.CommandName = Mode == RadSchedulerAdvancedFormAdvancedFormMode.Edit ? "Update" : "Insert";
        SubjectText.LabelWidth = Unit.Empty;

        InitializeStrings();

        if (!FormInitialized)
        {
            UpdateResetExceptionsVisibility();
        }
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        if (!FormInitialized)
        {
            if (IsAllDayAppointment(Appointment))
            {
                EndDate.SelectedDate = EndDate.SelectedDate.Value.AddDays(-1);
            }

            FormInitialized = true;
        }

    }

    protected void BasicControlsPanel_DataBinding(object sender, EventArgs e)
    {
        AllDayEvent.Checked = IsAllDayAppointment(Appointment);
    }

    protected void DurationValidator_OnServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = (End - Start) > TimeSpan.Zero;
    }

    protected void ResetExceptions_OnClick(object sender, EventArgs e)
    {
        Owner.RemoveRecurrenceExceptions(Appointment);
        ResetExceptions.Text = Owner.Localization.AdvancedDone;
    }

    #region Private methods

    private void InitializeStrings()
    {
        AllDayEvent.Text = Owner.Localization.AdvancedAllDayEvent;

        StartDateValidator.ErrorMessage = Owner.Localization.AdvancedStartDateRequired;
        StartDateValidator.ValidationGroup = Owner.ValidationGroup;

        StartTimeValidator.ErrorMessage = Owner.Localization.AdvancedStartTimeRequired;
        StartTimeValidator.ValidationGroup = Owner.ValidationGroup;

        EndDateValidator.ErrorMessage = Owner.Localization.AdvancedEndDateRequired;
        EndDateValidator.ValidationGroup = Owner.ValidationGroup;

        EndTimeValidator.ErrorMessage = Owner.Localization.AdvancedEndTimeRequired;
        EndTimeValidator.ValidationGroup = Owner.ValidationGroup;

        DurationValidator.ErrorMessage = Owner.Localization.AdvancedStartTimeBeforeEndTime;
        DurationValidator.ValidationGroup = Owner.ValidationGroup;

        ResetExceptions.Text = Owner.Localization.AdvancedReset;

        SharedCalendar.FastNavigationSettings.OkButtonCaption = Owner.Localization.AdvancedCalendarOK;
        SharedCalendar.FastNavigationSettings.CancelButtonCaption = Owner.Localization.AdvancedCalendarCancel;
        SharedCalendar.FastNavigationSettings.TodayButtonCaption = Owner.Localization.AdvancedCalendarToday;
    }

    private void UpdateResetExceptionsVisibility()
    {
        // Render the reset exceptions checkbox when using web service binding
        if (string.IsNullOrEmpty(Owner.WebServiceSettings.Path))
        {
            ResetExceptions.Visible = false;
            RecurrenceRule rrule;
            if (RecurrenceRule.TryParse(Appointment.RecurrenceRule, out rrule))
            {
                ResetExceptions.Visible = rrule.Exceptions.Count > 0;
            }
        }
    }

    private bool IsAllDayAppointment(Appointment appointment)
    {
        DateTime displayStart = Owner.UtcToDisplay(appointment.Start);
        DateTime displayEnd = Owner.UtcToDisplay(appointment.End);
        return displayStart.CompareTo(displayStart.Date) == 0 && displayEnd.CompareTo(displayEnd.Date) == 0;
    }

    #endregion
}