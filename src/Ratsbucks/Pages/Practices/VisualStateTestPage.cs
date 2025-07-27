using static Microsoft.Maui.Controls.VisualStateManager;

namespace Ratsbucks.Pages.Practices;

class VisualStateTestPage : Component
{
    public override VisualNode Render()
        => ContentPage("Visual States Test Page",
            VStack(
                    Entry()
                        .Placeholder("Entry 1")
                        .VisualState(nameof(CommonStates), CommonStates.Normal, MauiControls.Entry.FontSizeProperty, 35)
                        .VisualState(nameof(CommonStates), CommonStates.Focused, MauiControls.VisualElement.BackgroundColorProperty, Colors.Red)
                        .VisualState(nameof(CommonStates), "Unfocused", MauiControls.VisualElement.BackgroundColorProperty, Colors.Yellow),
                    Entry()
                        .Placeholder("Entry 2")
                        .VisualState(nameof(CommonStates), CommonStates.Normal, MauiControls.Entry.FontSizeProperty, 35)
                        .VisualState(nameof(CommonStates), CommonStates.Focused, MauiControls.VisualElement.BackgroundColorProperty, Colors.Red)
                        .VisualState(nameof(CommonStates), "Unfocused", MauiControls.VisualElement.BackgroundColorProperty, Colors.Yellow),
                    Button("Button")
                        .VisualState(nameof(CommonStates), CommonStates.Normal)
                        .VisualState(nameof(CommonStates), "Pressed", MauiControls.VisualElement.BackgroundColorProperty, Colors.Aqua)
                )
                .Spacing(10)
                .Center()
        );
}