namespace Ratsbucks.Pages;

public class EmptyPage : Component
{
    public override VisualNode Render()
    {
        return ContentPage("Empty");
    }
}