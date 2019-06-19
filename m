From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date: Wed, 19 Jun 2019 09:44:07 +0000
Subject: Re: [PATCH] fbcon: Export fbcon_update_vcs
Message-Id: <2849b344-5cdb-a06f-5998-075cf91e15ed@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190619081115.27921-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190619081115.27921-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>
Cc: kbuild test robot <lkp@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel.vetter@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Peter Rosin <peda@axentia.se>, Mikulas Patocka <mpatocka@redhat.com>, linux-fbdev@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Lukas Wunner <lukas@wunner.de>, dri-devel@lists.freedesktop.org

Op 19-06-2019 om 10:11 schreef Daniel Vetter:
> I failed to spot this while compile-testing. Oops.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 9e1467002630 ("fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls")
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index b8067e07f8a8..c9235a2f42f8 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3037,6 +3037,7 @@ void fbcon_update_vcs(struct fb_info *info, bool all)
>  	else
>  		fbcon_modechanged(info);
>  }
> +EXPORT_SYMBOL(fbcon_update_vcs);
>  
>  int fbcon_mode_deleted(struct fb_info *info,
>  		       struct fb_videomode *mode)

Thanks, pushed to topic branch. :)
