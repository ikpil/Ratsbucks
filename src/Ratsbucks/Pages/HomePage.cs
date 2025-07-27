using Ratsbucks.Resources.Styles;

namespace Ratsbucks.Pages;

public class HomePage : Component
{
    public override VisualNode Render()
    {
        return ContentPage("home",
                Grid("*", "*",
                    new NavBar(),
                    new NavBar()
                )
            )
            .Set(MauiControls.NavigationPage.HasNavigationBarProperty, false)
            .BackgroundColor(ApplicationTheme.DarkBackground);
    }
}