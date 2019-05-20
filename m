From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 20 May 2019 08:37:23 +0000
Subject: Re: [PATCH 30/33] vgaswitcheroo: call fbcon_remap_all directly
Message-Id: <20190520083723.xgjrocuuhwq4mcms@wunner.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-31-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-31-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org

On Mon, May 20, 2019 at 10:22:13AM +0200, Daniel Vetter wrote:
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3146,16 +3146,16 @@ void fbcon_fb_unregistered(struct fb_info *info)
>  }
>  
>  /* called with console_lock held */
> -static void fbcon_remap_all(int idx)

That comment needs to be removed as well.

Not an expert on fbcon code but this looks sane to me, so in case it helps:
Acked-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas
