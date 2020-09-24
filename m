From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 24 Sep 2020 20:34:46 +0000
Subject: Re: [PATCH] MAINTAINERS: mark FRAMEBUFFER LAYER as Orphan
Message-Id: <20200924203446.GL1223313@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200924112530eucas1p13af17d649767ed51c619d303392fa1e1@eucas1p1.samsung.com>
 <7b709254-9412-8473-250c-0c4e006259b3@samsung.com>
In-Reply-To: <7b709254-9412-8473-250c-0c4e006259b3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Bartlomiej

On Thu, Sep 24, 2020 at 01:25:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> It has been a fun ride since 2017 but unfortunately I don't have
> enough time to look after it properly anymore.

Thanks for all your work on fbdev, and other stuff.

I hope you have fun in the current job with whatever you do or
even better manage to find something else so we can get you back.

I could see that Daniel thinks we shall keep fbdev in drm-misc
but we shall no longer rely on you sweeping the mailing list
for all the pending patches :-( So I will likely start breaking
fbdev some more (read: applying a few more fbdev patches).

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Sam Ravnborg <sam@ravnborg.org>

Please consider a proper entry in CREDITS too!

	Sam

> ---
>  MAINTAINERS |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: b/MAINTAINERS
> =================================> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6894,10 +6894,9 @@ F:	drivers/net/wan/dlci.c
>  F:	drivers/net/wan/sdla.c
>  
>  FRAMEBUFFER LAYER
> -M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>  L:	dri-devel@lists.freedesktop.org
>  L:	linux-fbdev@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/fb/
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
