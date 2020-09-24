From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 24 Sep 2020 12:17:31 +0000
Subject: Re: [PATCH] MAINTAINERS: mark FRAMEBUFFER LAYER as Orphan
Message-Id: <CAKMK7uEMXdFQV3rO9fCMYbf52n3DOhyGi-9WBTreeHJkm1+n-Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200924112530eucas1p13af17d649767ed51c619d303392fa1e1@eucas1p1.samsung.com>
 <7b709254-9412-8473-250c-0c4e006259b3@samsung.com>
In-Reply-To: <7b709254-9412-8473-250c-0c4e006259b3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

On Thu, Sep 24, 2020 at 1:25 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> It has been a fun ride since 2017 but unfortunately I don't have
> enough time to look after it properly anymore.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks a lot for all the work you put in in picking up patches and
cleaning up drivers for compile testing! Very much appreciated.

I think for now we can just leave fbdev in drm-misc, with people
picking up patches ad-hoc (and maintainers serving as fallbacks).

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I guess you'll push this yourself as the last one, for closure and all :-)

Also drm-misc commit rights will stay around for you (except if you
want to hand that in) so if you have and display/gpu patches you can
still push them through the usual flow.

Cheers, Daniel
> ---
>  MAINTAINERS |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Index: b/MAINTAINERS
> =================================> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6894,10 +6894,9 @@ F:       drivers/net/wan/dlci.c
>  F:     drivers/net/wan/sdla.c
>
>  FRAMEBUFFER LAYER
> -M:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>  L:     dri-devel@lists.freedesktop.org
>  L:     linux-fbdev@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  Q:     http://patchwork.kernel.org/project/linux-fbdev/list/
>  T:     git git://anongit.freedesktop.org/drm/drm-misc
>  F:     Documentation/fb/
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
