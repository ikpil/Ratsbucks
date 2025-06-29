using MauiReactor;
using Ratsbucks.Models;

namespace Ratsbucks.Pages;

public class ListViewExtendedTestPageState
{
    public Person? SelectedPerson { get; set; }
}

public class ListViewExtendedTestPage : Component<ListViewExtendedTestPageState>
{
    public override VisualNode Render()
    {
        return new ContentPage("ListView Extended")
        {
            new ListView(ListViewCachingStrategy.RecycleElement)
                .IsGroupingEnabled(true)
                .ItemsSource<ListView, GroupOfPerson, Person>(GroupOfPerson.All, RenderGroup, RenderItem)
                .SeparatorVisibility(SeparatorVisibility.None)
                .OnItemSelected(OnSelectedItem)
                .Header(Label("Header"))
                .Footer(Label("Footer"))
        };
    }

    private void OnSelectedItem(object? sender, SelectedItemChangedEventArgs args)
    {
        SetState(s => s.SelectedPerson = args.SelectedItem as Person);
    }

    private ViewCell RenderGroup(GroupOfPerson person)
    {
        return ViewCell(
            Label(person.Initial,
                    MenuFlyout(
                        MenuFlyoutItem("MenuItem1")
                            .OnClicked(() => OnClickMenuItem("MenuItem1")),
                        MenuFlyoutItem("MenuItem2")
                            .OnClicked(() => OnClickMenuItem("MenuItem2")),
                        MenuFlyoutItem("MenuItem3")
                            .OnClicked(() => OnClickMenuItem("MenuItem3"))
                    )
                )
                .FontSize(14.0)
                .FontAttributes(FontAttributes.Bold)
                .Margin(5)
                .BackgroundColor(Colors.LightGray)
        );
    }

    private ViewCell RenderItem(Person person)
    {
        return ViewCell(
        [
            Label($"{person.FirstName} {person.LastName}")
                .FontSize(14.0)
                .FontAttributes(FontAttributes.Bold)
                .Padding(5)
                .VerticalTextAlignment(TextAlignment.Center)
        ]);
    }

    private void OnClickMenuItem(string title)
    {
        ContainerPage?.DisplayAlert("MauiReactor", $"Clicked menu {title}", "OK");
    }
}