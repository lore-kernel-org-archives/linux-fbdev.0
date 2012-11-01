From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 01 Nov 2012 00:36:58 +0000
Subject: Re: [PATCH 08/10] video: exynos_dp: Move hotplug into a workqueue
Message-Id: <001e01cdb7c9$00a204e0$01e60ea0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344398064-13563-9-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1344398064-13563-9-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, November 01, 2012 2:20 AM Sean Paul wrote
> 
> On Tue, Aug 7, 2012 at 11:54 PM, Sean Paul <seanpaul@chromium.org> wrote:
> > Move the hotplug related code from probe and resume into a workqueue.
> > This allows us to initialize the DP driver (and resume it) when there
> > is no monitor connected.
> >
> 
> Comments?

It looks good, but, I have to test this.


> 
> 
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > Reviewed-by: Olof Johansson <olofj@chromium.org>
> > ---
> >  drivers/video/exynos/exynos_dp_core.c |   94 +++++++++++++++++----------------
> >  drivers/video/exynos/exynos_dp_core.h |    1 +
> >  2 files changed, 50 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> > index 2882362..68ad494 100644
> > --- a/drivers/video/exynos/exynos_dp_core.c
> > +++ b/drivers/video/exynos/exynos_dp_core.c
> > @@ -834,6 +834,45 @@ static irqreturn_t exynos_dp_irq_handler(int irq, void *arg)
> >         return IRQ_HANDLED;
> >  }
> >
> > +static void exynos_dp_hotplug(struct work_struct *work)
> > +{
> > +       struct exynos_dp_device *dp;
> > +       int ret;
> > +
> > +       dp = container_of(work, struct exynos_dp_device, hotplug_work);
> > +
> > +       ret = exynos_dp_detect_hpd(dp);
> > +       if (ret) {
> > +               dev_err(dp->dev, "unable to detect hpd\n");
> > +               return;
> > +       }
> > +
> > +       ret = exynos_dp_handle_edid(dp);
> > +       if (ret) {
> > +               dev_err(dp->dev, "unable to handle edid\n");
> > +               return;
> > +       }
> > +
> > +       ret = exynos_dp_set_link_train(dp, dp->video_info->lane_count,
> > +                                       dp->video_info->link_rate);
> > +       if (ret) {
> > +               dev_err(dp->dev, "unable to do link train\n");
> > +               return;
> > +       }
> > +
> > +       exynos_dp_enable_scramble(dp, 1);
> > +       exynos_dp_enable_rx_to_enhanced_mode(dp, 1);
> > +       exynos_dp_enable_enhanced_mode(dp, 1);
> > +
> > +       exynos_dp_set_lane_count(dp, dp->video_info->lane_count);
> > +       exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
> > +
> > +       exynos_dp_init_video(dp);
> > +       ret = exynos_dp_config_video(dp, dp->video_info);
> > +       if (ret)
> > +               dev_err(&dp->dev, "unable to config video\n");
> > +}
> > +
> >  static int __devinit exynos_dp_probe(struct platform_device *pdev)
> >  {
> >         struct resource *res;
> > @@ -886,6 +925,8 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
> >                 goto err_clock;
> >         }
> >
> > +       INIT_WORK(&dp->hotplug_work, exynos_dp_hotplug);
> > +
> >         ret = devm_request_irq(&pdev->dev, dp->irq, exynos_dp_irq_handler, 0,
> >                                 "exynos-dp", dp);
> >         if (ret) {
> > @@ -899,36 +940,8 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
> >
> >         exynos_dp_init_dp(dp);
> >
> > -       ret = exynos_dp_detect_hpd(dp);
> > -       if (ret) {
> > -               dev_err(&pdev->dev, "unable to detect hpd\n");
> > -               goto err_clock;
> > -       }
> > -
> > -       exynos_dp_handle_edid(dp);
> > -
> > -       ret = exynos_dp_set_link_train(dp, dp->video_info->lane_count,
> > -                               dp->video_info->link_rate);
> > -       if (ret) {
> > -               dev_err(&pdev->dev, "unable to do link train\n");
> > -               goto err_clock;
> > -       }
> > -
> > -       exynos_dp_enable_scramble(dp, 1);
> > -       exynos_dp_enable_rx_to_enhanced_mode(dp, 1);
> > -       exynos_dp_enable_enhanced_mode(dp, 1);
> > -
> > -       exynos_dp_set_lane_count(dp, dp->video_info->lane_count);
> > -       exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
> > -
> > -       exynos_dp_init_video(dp);
> > -       ret = exynos_dp_config_video(dp, dp->video_info);
> > -       if (ret) {
> > -               dev_err(&pdev->dev, "unable to config video\n");
> > -               goto err_clock;
> > -       }
> > -
> >         platform_set_drvdata(pdev, dp);
> > +       schedule_work(&dp->hotplug_work);
> >
> >         return 0;
> >
> > @@ -943,6 +956,9 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
> >         struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
> >         struct exynos_dp_device *dp = platform_get_drvdata(pdev);
> >
> > +       if (work_pending(&dp->hotplug_work))
> > +               flush_work_sync(&dp->hotplug_work);
> > +
> >         if (pdata && pdata->phy_exit)
> >                 pdata->phy_exit();
> >
> > @@ -959,6 +975,9 @@ static int exynos_dp_suspend(struct device *dev)
> >         struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
> >         struct exynos_dp_device *dp = platform_get_drvdata(pdev);
> >
> > +       if (work_pending(&dp->hotplug_work))
> > +               flush_work_sync(&dp->hotplug_work);
> > +
> >         if (pdata && pdata->phy_exit)
> >                 pdata->phy_exit();
> >
> > @@ -979,22 +998,7 @@ static int exynos_dp_resume(struct device *dev)
> >         clk_enable(dp->clock);
> >
> >         exynos_dp_init_dp(dp);
> > -
> > -       exynos_dp_detect_hpd(dp);
> > -       exynos_dp_handle_edid(dp);
> > -
> > -       exynos_dp_set_link_train(dp, dp->video_info->lane_count,
> > -                               dp->video_info->link_rate);
> > -
> > -       exynos_dp_enable_scramble(dp, 1);
> > -       exynos_dp_enable_rx_to_enhanced_mode(dp, 1);
> > -       exynos_dp_enable_enhanced_mode(dp, 1);
> > -
> > -       exynos_dp_set_lane_count(dp, dp->video_info->lane_count);
> > -       exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
> > -
> > -       exynos_dp_init_video(dp);
> > -       exynos_dp_config_video(dp, dp->video_info);
> > +       schedule_work(&dp->hotplug_work);
> >
> >         return 0;
> >  }
> > diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
> > index 6431c65..cf1010b 100644
> > --- a/drivers/video/exynos/exynos_dp_core.h
> > +++ b/drivers/video/exynos/exynos_dp_core.h
> > @@ -32,6 +32,7 @@ struct exynos_dp_device {
> >
> >         struct video_info       *video_info;
> >         struct link_train       link_train;
> > +       struct work_struct      hotplug_work;
> >  };
> >
> >  /* exynos_dp_reg.c */
> > --
> > 1.7.7.3
> >

