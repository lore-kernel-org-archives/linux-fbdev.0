From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date: Mon, 24 Jun 2019 09:00:25 +0000
Subject: Re: [PATCH] fbcon: Export fbcon_remap_all
Message-Id: <ca17f6dd-b691-b3ce-af28-46f4ba2fe0c7@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190624083255.13235-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190624083255.13235-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Hans de Goede <hdegoede@redhat.com>, kbuild test robot <lkp@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>, linux-fbdev@vger.kernel.org, Yisheng Xie <ysxie@foxmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Sam Ravnborg <sam@ravnborg.org>

Op 24-06-2019 om 10:32 schreef Daniel Vetter:
> Fixes linking fail when fbcon/fbdev is moduler and vgaswitcheroo is
> enabled:
>
> x86_64-linux-gnu-ld: drivers/gpu/vga/vga_switcheroo.o: in function `vga_switchto_stage2':
> vga_switcheroo.c:(.text+0x997): undefined reference to `fbcon_remap_all'
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 1cd51b5d200d ("vgaswitcheroo: call fbcon_remap_all directly")
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> --
> wrt merging probably best if Maarten adds this to the topic branch we
> have already and sends out an updated pull request.
>
> Apologies for the mess.
> -Daniel
> ---
>  drivers/video/fbdev/core/fbcon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index c9235a2f42f8..199ca723c768 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3194,6 +3194,7 @@ void fbcon_remap_all(struct fb_info *info)
>  	}
>  	console_unlock();
>  }
> +EXPORT_SYMBOL(fbcon_remap_all);
>  
>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
>  static void fbcon_select_primary(struct fb_info *info)

Did you test this on a allmodconfig?

fbcon_remap_all is in a module, vga switcheroo is builtin, even with this patch you will still get the same compile failure.

~Maarten
