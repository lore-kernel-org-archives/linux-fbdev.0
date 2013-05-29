From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Wed, 29 May 2013 19:20:13 +0000
Subject: Re: [PATCH] fbdev: bfin-lq035q1-fb: Use dev_pm_ops
Message-Id: <20130529192013.GA19468@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369829859-13405-1-git-send-email-lars@metafoo.de>
 <51A60F83.7070403@analog.com>
In-Reply-To: <51A60F83.7070403@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hennerich <michael.hennerich@analog.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org

On 16:24 Wed 29 May     , Michael Hennerich wrote:
> On 05/29/2013 02:17 PM, Lars-Peter Clausen wrote:
> >Use dev_pm_ops instead of the legacy suspend/resume callbacks.
> >
> >Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> >---
> >  drivers/video/bfin-lq035q1-fb.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> >diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
> >index 29d8c04..6084c17 100644
> >--- a/drivers/video/bfin-lq035q1-fb.c
> >+++ b/drivers/video/bfin-lq035q1-fb.c
> >@@ -170,16 +170,19 @@ static int lq035q1_spidev_remove(struct spi_device *spi)
> >  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
> >  }
> >-#ifdef CONFIG_PM
> >-static int lq035q1_spidev_suspend(struct spi_device *spi, pm_message_t state)
> >+#ifdef CONFIG_PM_SLEEP
> >+static int lq035q1_spidev_suspend(struct device *dev)
> >  {
> >+	struct spi_device *spi = to_spi_device(dev);
> >+
> >  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
> >  }
> >-static int lq035q1_spidev_resume(struct spi_device *spi)
> >+static int lq035q1_spidev_resume(struct device *dev)
> >  {
> >-	int ret;
> >+	struct spi_device *spi = to_spi_device(dev);
> >  	struct spi_control *ctl = spi_get_drvdata(spi);
> >+	int ret;
> >  	ret = lq035q1_control(spi, LQ035_DRIVER_OUTPUT_CTL, ctl->mode);
> >  	if (ret)
> >@@ -187,9 +190,13 @@ static int lq035q1_spidev_resume(struct spi_device *spi)
> >  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_ON);
> >  }
> >+
> >+static SIMPLE_DEV_PM_OPS(lq035q1_spidev_pm_ops, lq035q1_spidev_suspend,
> >+	lq035q1_spidev_resume);
> >+#define LQ035Q1_SPIDEV_PM_OPS (&lq035q1_spidev_pm_ops)
> >+
> >  #else
> >-# define lq035q1_spidev_suspend NULL
> >-# define lq035q1_spidev_resume  NULL
> >+#define LQ035Q1_SPIDEV_PM_OPS NULL
> >  #endif
we really need to ahve a macro like for DT of_match_ptr to drop the #else

I known it's related to this patch but someone should do it

Rafael what do you think

Best Regards,
J.
> >  /* Power down all displays on reboot, poweroff or halt */
> >@@ -708,8 +715,7 @@ static int bfin_lq035q1_probe(struct platform_device *pdev)
> >  	info->spidrv.probe    = lq035q1_spidev_probe;
> >  	info->spidrv.remove   = lq035q1_spidev_remove;
> >  	info->spidrv.shutdown = lq035q1_spidev_shutdown;
> >-	info->spidrv.suspend  = lq035q1_spidev_suspend;
> >-	info->spidrv.resume   = lq035q1_spidev_resume;
> >+	info->spidrv.driver.pm = LQ035Q1_SPIDEV_PM_OPS;
> >  	ret = spi_register_driver(&info->spidrv);
> >  	if (ret < 0) {
> 
> 
> -- 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
> Margaret Seif
> 
> 
