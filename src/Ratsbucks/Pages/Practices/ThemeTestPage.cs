using Ratsbucks.Resources.Styles;

namespace Ratsbucks.Pages.Practices;

class ThemeTestPage : Component
{
    public override VisualNode Render()
    {
        System.Diagnostics.Debug.WriteLine(Theme.CurrentAppTheme);
        return ContentPage("Theming test page",
            VStack(
                    Label($"Current Theme: {Theme.CurrentAppTheme} "),
                    Button("Toggle", ApplicationTheme.ToggleCurrentAppTheme)
                )
                .Spacing(10)
                .Center()
        );
    }
}