namespace Ratsbucks.Pages;

[Scaffold(typeof(CommunityToolkit.Maui.Behaviors.IconTintColorBehavior))]
partial class IconTintColorBehavior
{
}

public class BehaviorTestPageState
{
    public Color Color { get; set; } = Colors.Red;
}

public class BehaviorTestPage : Component<BehaviorTestPageState>
{
    public override VisualNode Render()
    {
        return new ContentPage()
        {
            new VStack(spacing: 10)
                {
                    new Image("shield.png")
                    {
                        new IconTintColorBehavior()
                            .TintColor(State.Color)
                    },

                    new HStack(spacing: 5)
                        {
                            new Button(nameof(Colors.Red), () => SetState(s => s.Color = Colors.Red)),
                            new Button(nameof(Colors.Green), () => SetState(s => s.Color = Colors.Green)),
                            new Button(nameof(Colors.Black), () => SetState(s => s.Color = Colors.Black)),
                        }
                        .HCenter()
                }
                .Center()
        };
    }
}