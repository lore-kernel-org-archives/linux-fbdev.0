From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 16:15:49 +0000
Subject: Re: [PATCH] fbdev: remove object duplication in Makefile
Message-Id: <a5baddef-59d6-28f6-f882-90d8957089aa@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200106081436epcas5p3dc6a4023510ef179e9ce94a056c75fb8@epcas5p3.samsung.com>
 <20200106081352.27730-1-masahiroy@kernel.org>
In-Reply-To: <20200106081352.27730-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 1/6/20 9:13 AM, Masahiro Yamada wrote:
> The objects in $(fb-objs) $(fb-y) $(fb-m) are linked to fb.ko .
> 
> This line adds $(fb-y) to fb-objs, so the objects from $(fb-y) are
> listed twice as the dependency of the module.
> 
> It works because Kbuild trims the duplicated objects from linking,
> but there is no good reason to have this line.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Patch queued for v5.6, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> 
>  drivers/video/fbdev/core/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
> index 37710316a680..26cbc965497c 100644
> --- a/drivers/video/fbdev/core/Makefile
> +++ b/drivers/video/fbdev/core/Makefile
> @@ -16,7 +16,6 @@ fb-y				  += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
>  				     fbcon_ccw.o
>  endif
>  endif
> -fb-objs                           := $(fb-y)
>  
>  obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
>  obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
> 
