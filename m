From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Tue, 26 Jun 2012 14:52:41 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <CAJe_ZhcxVAUuuMDZ8p1LVae4N2aZb_vFs_nRLfb7atJ2j6j=Sg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	<1340616643.3395.19.camel@deskari>
	<CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	<1340628094.3395.63.camel@deskari>
	<CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	<1340632161.3395.100.camel@deskari>
	<CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
	<1340695166.2093.22.camel@lappyti>
	<CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
	<1340701660.24530.17.camel@deskari>
	<CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
	<1340712213.24530.21.camel@deskari>
In-Reply-To: <1340712213.24530.21.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 26 June 2012 17:33, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2012-06-26 at 15:27 +0530, Jassi Brar wrote:
>
>> Seems similar, but I only tested OMAP4 HDMI.
>
> Would something like this one below work for you? It fixes the issues on
> my overo board.
>
I think this should work too (I will get to test it only tomorrow).

Though I don't think it'll fix stack spew when run without
CONFIG_PM_RUNTIME. Maybe we could simply remove the WARN_ON in the
xxx_runtime_put() as Alan noted?

-j

> Instead of using omapdss device's suspend/resume callbacks, this one
> uses PM notifier calls which happen before suspend and after resume.
>
> I still think the suspend handling is wrong, omapdss shouldn't be
> enabling and disabling panel devices like that, but this one should
> remove the biggest issues with the current suspend method.
>
>  Tomi
>
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index 5066eee..c35a248 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -32,6 +32,7 @@
>  #include <linux/io.h>
>  #include <linux/device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/suspend.h>
>
>  #include <video/omapdss.h>
>
> @@ -201,6 +202,30 @@ int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
>  #endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
>
>  /* PLATFORM DEVICE */
> +static int omap_dss_pm_notif(struct notifier_block *b, unsigned long v, void *d)
> +{
> +       DSSDBG("pm notif %lu\n", v);
> +
> +       switch (v)
> +       {
> +       case PM_SUSPEND_PREPARE:
> +               DSSDBG("suspending displays\n");
> +               return dss_suspend_all_devices();
> +
> +       case PM_POST_SUSPEND:
> +               DSSDBG("resuming displays\n");
> +               return dss_resume_all_devices();
> +
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static struct notifier_block omap_dss_pm_notif_block > +{
> +       .notifier_call = omap_dss_pm_notif,
> +};
> +
>  static int __init omap_dss_probe(struct platform_device *pdev)
>  {
>        struct omap_dss_board_info *pdata = pdev->dev.platform_data;
> @@ -224,6 +249,8 @@ static int __init omap_dss_probe(struct platform_device *pdev)
>        else if (pdata->default_device)
>                core.default_display_name = pdata->default_device->name;
>
> +       register_pm_notifier(&omap_dss_pm_notif_block);
> +
>        return 0;
>
>  err_debugfs:
> @@ -233,6 +260,8 @@ err_debugfs:
>
>  static int omap_dss_remove(struct platform_device *pdev)
>  {
> +       unregister_pm_notifier(&omap_dss_pm_notif_block);
> +
>        dss_uninitialize_debugfs();
>
>        dss_uninit_overlays(pdev);
> @@ -247,25 +276,9 @@ static void omap_dss_shutdown(struct platform_device *pdev)
>        dss_disable_all_devices();
>  }
>
> -static int omap_dss_suspend(struct platform_device *pdev, pm_message_t state)
> -{
> -       DSSDBG("suspend %d\n", state.event);
> -
> -       return dss_suspend_all_devices();
> -}
> -
> -static int omap_dss_resume(struct platform_device *pdev)
> -{
> -       DSSDBG("resume\n");
> -
> -       return dss_resume_all_devices();
> -}
> -
>  static struct platform_driver omap_dss_driver = {
>        .remove         = omap_dss_remove,
>        .shutdown       = omap_dss_shutdown,
> -       .suspend        = omap_dss_suspend,
> -       .resume         = omap_dss_resume,
>        .driver         = {
>                .name   = "omapdss",
>                .owner  = THIS_MODULE,
>



-- 
Linaro.org │ Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
