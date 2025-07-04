﻿using MauiReactor;

namespace Ratsbucks.Pages;

class MainPage : Component
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
                FlyoutItem("BorderCornerRadiusPage", new BorderCornerRadiusPage()),
                FlyoutItem("ShowPopupTestPage", new ShowPopupTestPage()),
                FlyoutItem("CarouselTestPage", new CarouselTestPage()),
                FlyoutItem("CarouselTestWithImagesPage", new CarouselTestWithImagesPage()),
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