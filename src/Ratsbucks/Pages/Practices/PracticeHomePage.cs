namespace Ratsbucks.Pages.Practices;

public class PracticeHomePage : Component
{
    public override VisualNode Render()
    {
        return Shell(
                FlyoutItem("Counter", new CounterPage()),
                FlyoutItem("Counter with service", new CounterWithServicePage()),
                FlyoutItem("Parameters", new ParametersPage()),
                FlyoutItem("CollectionView", new CollectionViewPage()),
                FlyoutItem("EditableCollectionView", new EditableCollectionViewPage()),
                FlyoutItem("ListView", new ListViewPage()),
                FlyoutItem("ListView Extended Test", new ListViewExtendedTestPage()),
                FlyoutItem("AnimationBasics", new AnimationBasics()),
                FlyoutItem("CardsAnimationPage", new CardsAnimationPage()),
                FlyoutItem("CanvasCardsAnimationPage", new CanvasCardsAnimationPage()),
                FlyoutItem("Image", new ImagePage()),
                FlyoutItem("AnimatedCollectionViewPage", new AnimatedCollectionViewPage()),
                FlyoutItem("AnimationShowcasePage", new AnimationShowcasePage()),
                FlyoutItem("AnimationLoopPage", new AnimationLoopPage()),
                FlyoutItem("NavigationMainPage", new NavigationMainPage()),
                FlyoutItem("ElementRefPage", new ElementRefPage()),
                FlyoutItem("CanvasPage", new CanvasPage()),
                FlyoutItem("LandscapePage", new LandscapePage()),
                FlyoutItem("GraphicsViewPage", new GraphicsViewPage()),
                FlyoutItem("RemainingItemsThresholdTestPage", new RemainingItemsThresholdTestPage()),
                FlyoutItem("AnimatedButtonPage", new AnimatedButtonPage()),
                FlyoutItem("Border Corner Radius Test", new BorderCornerRadiusPage()),
                FlyoutItem("ShowPopupTestPage", new ShowPopupTestPage()),
                FlyoutItem("CarouselTestPage", new CarouselTestPage()),
                FlyoutItem("CarouselTestWithImagesPage", new CarouselTestWithImagesPage()),
                FlyoutItem("Canvas AutoV/HStack Test", new CanvasAutoStackPage()),
                FlyoutItem("Inline components", new InlineComponentsPage()),
                FlyoutItem("Collection View Grouped", new CollectionViewExtendedTestPage()),
                FlyoutItem("Drag & Drop", new DragDropTestPage()),
                FlyoutItem("Gradient Test", new GradientPage()),
                FlyoutItem("Behavior Test", new BehaviorTestPage()),
                FlyoutItem("Pickers Page", new PickerPage()),
                FlyoutItem("Visual State Test Page", new VisualStateTestPage()),
                FlyoutItem("FormattedText Test Page", new FormattedTextTestPage()),
                FlyoutItem("Theming Test Page", new ThemeTestPage()),
                FlyoutItem("CollectionView Multiple Selection Test Page", new CollectionViewSelectionPage()),
                FlyoutItem("Animating Label Test Page", new AnimatingLabelTestPage()),
                FlyoutItem("Grid Test Page", new GridPage()),
                FlyoutItem("EmptyPage", new EmptyPage())
            )
            .ItemTemplate(RenderItemTemplate);
    }

    private static VisualNode RenderItemTemplate(Microsoft.Maui.Controls.BaseShellItem item)
    {
        return new Grid("68", "*")
        {
            new Label(item.Title)
                .VCenter()
                .Margin(10, 0),
        };
    }
}