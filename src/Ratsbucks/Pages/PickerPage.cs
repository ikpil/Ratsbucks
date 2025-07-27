namespace Ratsbucks.Pages;

class PickerPageState
{
    public DateTime TimeStamp { get; set; } = DateTime.Now;
}

class PickerPage : Component<PickerPageState>
{
    public override VisualNode Render()
    {
        return ContentPage("Pickers Page",
            VStack(spacing: 10,
                    DatePicker()
                        .Date(State.TimeStamp)
                        .OnDateSelected(newDate => SetState(s => s.TimeStamp = new DateTime(DateOnly.FromDateTime(newDate), TimeOnly.FromDateTime(s.TimeStamp)))),
                    TimePicker()
                        .Time(State.TimeStamp.TimeOfDay)
                        .OnTimeSelected(newTime => SetState(s => s.TimeStamp = new DateTime(DateOnly.FromDateTime(s.TimeStamp), TimeOnly.FromTimeSpan(newTime))))
                )
                .Center()
        );
    }
}