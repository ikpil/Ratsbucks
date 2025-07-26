namespace Ratsbucks.Pages;

class InlineComponentsPage : Component
{
    public override VisualNode Render()
    {
        return new ContentPage
        {
            new VStack
                {
                    Buttons.IncrementButton()
                }
                .HCenter()
                .VCenter()
        };
    }
}

static class Buttons
{
    public static VisualNode IncrementButton()
    {
        return Component.Render<int>(state =>
        {
            return new Button(
                state.Value == 0 ? "Click me!" : $"Counter is {state.Value}",
                () => state.Set(s => ++s));
        });
    }
}