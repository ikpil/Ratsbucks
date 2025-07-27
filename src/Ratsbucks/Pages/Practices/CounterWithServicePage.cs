using Ratsbucks.Services;

namespace Ratsbucks.Pages.Practices;

public partial class CounterWithServicePage : Component<CounterPageState>
{
    [Inject]
    private IncrementService _incrementService;

    public override VisualNode Render()
    {
        return ContentPage("Counter Sample",
            VStack(spacing: 10,
                    Label($"Counter: {State.Counter}")
                        .AutomationId("Counter_Label")
                        .VCenter()
                        .HCenter(),
                    Button("Click to Increment", () => SetState(s => s.Counter = _incrementService.Increment(s.Counter)))
                        .AutomationId("Counter_Button")
                )
                .VCenter()
                .HCenter()
        );
    }
}