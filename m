From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 29 May 2020 08:22:31 +0000
Subject: Re: [PATCH] omapfb: Fix reference count leak in display_init_sysfs.
Message-Id: <20200529082231.GA847132@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200528194424.11596-1-wu000273@umn.edu>
In-Reply-To: <20200528194424.11596-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wu000273@umn.edu
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kjlu@umn.edu, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Alexios Zavras <alexios.zavras@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Enrico Weigelt <info@metux.net>, Allison Randal <allison@lohutok.net>

On Thu, May 28, 2020 at 02:44:23PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object.
> Because function omap_dss_put_device() doesn't handle dssdev->kobj,
> thus we need insert kobject_put() to clean up the kobject,
> when kobject_init_and_add() fails.
> 
> Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
> index 6dbe265b312d..51322ac7df07 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
> @@ -316,6 +316,7 @@ int display_init_sysfs(struct platform_device *pdev)
>  			&pdev->dev.kobj, "%s", dssdev->alias);
>  		if (r) {
>  			DSSERR("failed to create sysfs files\n");
> +			kobject_put(&dssdev->kobj);
>  			omap_dss_put_device(dssdev);
>  			goto err;
>  		}

Why is a driver creating "raw" kobjects and the like at all?

/me goes off to look...


Ick, no, that's not ok, this just needs to be an attribute group
attached to the device, no need for a kobject at all.  Having a kobject
means that the files will be ignored totally by userspace tools that
monitor sysfs changes.  So these files are probably not even being
used...

Please fix this up properly.

thanks,

greg k-h
