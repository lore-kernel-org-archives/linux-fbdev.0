From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 11 Jan 2017 13:01:42 +0000
Subject: Re: [PATCH] video: fbdev: maxinefb: add __initdata to maxinefb_fix
Message-Id: <4219319.xeK5mDBmEi@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1483288577-17122-1-git-send-email-bhumirks@gmail.com>
 <CGME20170111130145epcas1p395eef0ab42ede2c67604aa5a86c63618@epcas1p3.samsung.com>
In-Reply-To: <1483288577-17122-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, julia.lawall@lip6.fr, tomi.valkeinen@ti.com


Hi,

On Sunday, January 01, 2017 10:06:17 PM Bhumika Goyal wrote:
> The object maxinefb_fix of type fb_fix_screeninfo is never referenced
> after initialization by maxinefb_init. In the init function, the object
> and one of its fields is only stored into another variable. So, the
> object and its fields are never referenced anywhere after initialization
> and therefore add __initdata to its declaration.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Thanks, queued fpr 4.11.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/maxinefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/maxinefb.c b/drivers/video/fbdev/maxinefb.c
> index 5cf52d3..cab7333 100644
> --- a/drivers/video/fbdev/maxinefb.c
> +++ b/drivers/video/fbdev/maxinefb.c
> @@ -51,7 +51,7 @@
>  	.vmode =	FB_VMODE_NONINTERLACED,
>  };
>  
> -static struct fb_fix_screeninfo maxinefb_fix = {
> +static struct fb_fix_screeninfo maxinefb_fix __initdata = {
>  	.id =		"Maxine",
>  	.smem_len =	(1024*768),
>  	.type =		FB_TYPE_PACKED_PIXELS,

