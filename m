From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Thu, 25 Feb 2010 09:19:23 +0000
Subject: Re: [PATCH 2/2] vga_switcheroo: initial implementation (v8)
Message-Id: <b170af451002250119y52c7097er995e7592248128c0@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1267074476-28347-1-git-send-email-airlied@gmail.com>
	 <1267074476-28347-2-git-send-email-airlied@gmail.com>
	 <1267074476-28347-3-git-send-email-airlied@gmail.com>
In-Reply-To: <1267074476-28347-3-git-send-email-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.sf.net

Oh, sorry, but I don't like such a hidden changes, touching not
directly related things.


2010/2/25 Dave Airlie <airlied@gmail.com>:
> diff --git a/drivers/gpu/drm/radeon/r600_audio.c b/drivers/gpu/drm/radeon/r600_audio.c
> index 0dcb690..7def989 100644
> --- a/drivers/gpu/drm/radeon/r600_audio.c
> +++ b/drivers/gpu/drm/radeon/r600_audio.c
> @@ -163,6 +163,9 @@ int r600_audio_init(struct radeon_device *rdev)
>        rdev->audio_status_bits = 0;
>        rdev->audio_category_code = 0;
>
> +       if (!radeon_audio)
> +               return 0;
> +

Good catch but not for this patch. Plus we could handle audio on/off better.


> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> (...)
> +static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switcheroo_state state)
> +{
> +       struct drm_device *dev = pci_get_drvdata(pdev);
> +       struct radeon_device *rdev = dev->dev_private;
> +       pm_message_t pmm = { .event = PM_EVENT_SUSPEND };
> +       if (state = VGA_SWITCHEROO_ON) {
> +               printk(KERN_ERR "VGA switched radeon on\n");
> +               /* don't suspend or resume card normally */
> +               rdev->powered_down = false;
> +               radeon_resume_kms(dev);
> +               r600_audio_init(rdev);
> +       } else {
> +               printk(KERN_ERR "VGA switched radeon off\n");
> +               r600_audio_fini(rdev);
> +               radeon_suspend_kms(dev, pmm);
> +               /* don't suspend or resume card normally */
> +               rdev->powered_down = true;
> +       }
> +}

Don't mess with r600_audio_* there. You call if for all chipsets which
is not needed and break nice S&R layout, which is chipset specific.

I guess you needed that because you didn't work on branch containing my patch:
http://git.kernel.org/?p=linux/kernel/git/airlied/drm-2.6.git;a=commitdiff;h8fd2c6ff526e6a59edfa8e08f6f0724646784c4
(you commited it to drm-linus)


> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 8ba3de7..69017f2 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -87,7 +87,7 @@ int radeon_testing = 0;
>  int radeon_connector_table = 0;
>  int radeon_tv = 1;
>  int radeon_new_pll = 1;
> -int radeon_audio = 1;
> +int radeon_audio = 0;

Why?! What for we disable this feature by default?! If you see some
reason for that, explain it to others please. I can change my mind,
but for now I don't like this. It makes audio an option from just
working-out-of-box.

-- 
Rafał
