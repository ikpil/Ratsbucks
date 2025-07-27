namespace Ratsbucks.Pages.Practices;

public class CounterPageState
{
    public int Counter { get; set; }
}

public class CounterPage : Component<CounterPageState>
{
    public override VisualNode Render()
    {
        return ContentPage("Counter Samples", VStack(
                Label($"Counter: {State.Counter}")
                    .AutomationId("Counter_Label"),
                Button("Click to Increment", () => SetState(s => s.Counter++))
                    .AutomationId("Counter_Button")
            )
            .Spacing(10)
            .Center()
        );
    }
}