From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 24 Jul 2019 11:49:13 +0000
Subject: Re: [PATCH] MAINTAINERS: handle fbdev changes through drm-misc tree
Message-Id: <20190724114913.GZ15868@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190723143329eucas1p211688de2902dbac72998fda9e694083d@eucas1p2.samsung.com>
 <d449f697-ed25-8a3f-16d5-b981f1a52217@samsung.com>
In-Reply-To: <d449f697-ed25-8a3f-16d5-b981f1a52217@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tue, Jul 23, 2019 at 04:33:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
> fbdev patches will now go to upstream through drm-misc tree (IOW
> starting with v5.4 merge window fbdev changes will be included in
> DRM pull request) for improved maintainership and better integration
> testing. Update MAINTAINERS file accordingly.
> 
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  MAINTAINERS |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/MAINTAINERS
> =================================> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6389,7 +6389,7 @@ FRAMEBUFFER LAYER
>  M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>  L:	dri-devel@lists.freedesktop.org
>  L:	linux-fbdev@vger.kernel.org
> -T:	git git://github.com/bzolnier/linux.git
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
>  Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
>  S:	Maintained
>  F:	Documentation/fb/

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
