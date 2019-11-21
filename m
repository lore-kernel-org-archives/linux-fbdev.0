From: Wei Hu <weh@microsoft.com>
Date: Thu, 21 Nov 2019 02:47:17 +0000
Subject: RE: [PATCH] video: hyperv_fb: Fix hibernation for the deferred IO feature
Message-Id: <PU1P153MB01699A8B75901F896F1E4503BB4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1574234028-48574-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1574234028-48574-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>

> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Wednesday, November 20, 2019 3:14 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> sashal@kernel.org; b.zolnierkie@samsung.com; linux-hyperv@vger.kernel.org;
> dri-devel@lists.freedesktop.org; linux-fbdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>; Sasha Levin
> <Alexander.Levin@microsoft.com>
> Cc: Wei Hu <weh@microsoft.com>; Dexuan Cui <decui@microsoft.com>
> Subject: [PATCH] video: hyperv_fb: Fix hibernation for the deferred IO feature
> 
> fb_deferred_io_work() can access the vmbus ringbuffer by calling
> fbdefio->deferred_io() -> synthvid_deferred_io() -> synthvid_update().
> 
> Because the vmbus ringbuffer is inaccessible between hvfb_suspend() and
> hvfb_resume(), we must cancel info->deferred_work before calling
> vmbus_close() and then reschedule it after we reopen the channel in
> hvfb_resume().
> 
> Fixes: a4ddb11d297e ("video: hyperv: hyperv_fb: Support deferred IO for
> Hyper-V frame buffer driver")
> Fixes: 824946a8b6fb ("video: hyperv_fb: Add the support of hibernation")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> This patch fixes the 2 aforementioned patches on Sasha Levin's Hyper-V tree's
> hyperv-next branch:
> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kern
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fhyperv%2Flinux.git%2Flog
> %2F%3Fh%3Dhyperv-
> next&amp;data=02%7C01%7Cweh%40microsoft.com%7C451143ff78f04401d9
> 6f08d76d893a84%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637
> 098308493217121&amp;sdata=P2fo%2F1TJUMIj5FtJCOp2QwDrghhVfPSCEJ4f1
> vkOXvI%3D&amp;reserved=0
> 
> The 2 aforementioned patches have not appeared in the mainline yet, so please
> pick up this patch onto he same hyperv-next branch.
> 
>  drivers/video/fbdev/hyperv_fb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 4cd27e5172a1..08bc0dfb5ce7 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1194,6 +1194,7 @@ static int hvfb_suspend(struct hv_device *hdev)
>  	fb_set_suspend(info, 1);
> 
>  	cancel_delayed_work_sync(&par->dwork);
> +	cancel_delayed_work_sync(&info->deferred_work);
> 
>  	par->update_saved = par->update;
>  	par->update = false;
> @@ -1227,6 +1228,7 @@ static int hvfb_resume(struct hv_device *hdev)
>  	par->fb_ready = true;
>  	par->update = par->update_saved;
> 
> +	schedule_delayed_work(&info->deferred_work, info->fbdefio->delay);
>  	schedule_delayed_work(&par->dwork, HVFB_UPDATE_DELAY);
> 
>  	/* 0 means do resume */
> --
> 2.19.1

Signed-off-by: Wei Hu <weh@microsoft.com>
