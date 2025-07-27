namespace Ratsbucks.Pages;

public class AppShell : Component
{
    public override VisualNode Render()
    {
        return Shell(
                TabBar(
                    Tab()
                        .Title("Home")
                        .Icon("home.png"),
                    //.Items(ShellContent<HomePage>()),
                    Tab()
                        .Title("Pay")
                        .Icon("chat.png"),
                    //.Items(ShellContent<PayPage>()),
                    Tab()
                        .Title("Order")
                        .Icon("order.png"),
                    //.Items(ShellContent<OrderPage>()),
                    Tab()
                        .Title("Shop")
                        .Icon("profile.png"),
                    //.Items(ShellContent<ShopPage>()),
                    Tab()
                        .Title("Other")
                        .Icon("profile.png")
                    //.Items(ShellContent<OtherPage>())
                )
            )
            .BackgroundColor(Colors.White)
            .FlyoutBackgroundColor(Color.FromArgb("#00704A")); // Starbu
    }
}