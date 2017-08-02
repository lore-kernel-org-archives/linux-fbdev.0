From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 02 Aug 2017 10:01:24 +0000
Subject: Re: [PATCH] fbdev: matrox: hide unused 'hotplug' variable
Message-Id: <20170802100124.bcr3ux6bt4hnlu6r@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170802093722.3666961-1-arnd@arndb.de>
In-Reply-To: <20170802093722.3666961-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dan Carpenter <dan.carpenter@oracle.com>, Sean Paul <seanpaul@chromium.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 02, 2017 at 11:36:47AM +0200, Arnd Bergmann wrote:
> The variable has become unused in modular configurations
> which triggers a harmless warning:
> 
> drivers/video/fbdev/matrox/matroxfb_base.c:1583:12: error: 'hotplug' defined but not used [-Werror=unused-variable]
> 
> This moves it into an #ifdef section of the file, matching
> all its references.
> 
> Fixes: 376b3ff54c9a ("fbdev: Nuke FBINFO_MODULE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
> index fd1589fcdf15..00ea4e4ab95a 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -1578,9 +1578,9 @@ static struct fb_videomode defaultmode = {
>  	NULL, 60, 640, 480, 39721, 40, 24, 32, 11, 96, 2,
>  	0, FB_VMODE_NONINTERLACED
>  };
> -#endif /* !MODULE */
>  
>  static int hotplug = 0;
> +#endif /* !MODULE */
>  
>  static void setDefaultOutputs(struct matrox_fb_info *minfo)
>  {
> -- 
> 2.9.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
