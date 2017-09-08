From: Sean Paul <seanpaul@chromium.org>
Date: Fri, 08 Sep 2017 15:39:44 +0000
Subject: Re: [PATCH] MAINTAINERS: Add dri-devel as a mailing list for anything fbdev
Message-Id: <CAOw6vbJs7OmZLRhhYXjO1ruSutO7U5E71ZF=WpYa+WhG+D629Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170908153528.17528-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20170908153528.17528-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>

On Fri, Sep 8, 2017 at 11:35 AM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> fbdev is in maintenance only, except that it's still used by drm
> through the drm fbdev emulation, to be able to use fbcon. And people
> might want to sometimes extend fbcon to enable new features for drm
> drivers, e.g. Hans' panel orientation work.
>
> The problem is that when those patches only touch fbdev code they'll
> never show up on drm developer's radar, which means we end up with
> designs that don't really fit whell into the full stack. That happened
> a bit with the panel orientation work, where an fbcon patch made it
> into 4.14, implementing a design that won't really work on the drm
> side. Which means we now have to redo things, and on top coordinate 2
> subsystem trees.
>
> Since fbdev is super low-volume we can prevent this in the future by
> simply adding the dri-devel mailing list to the fbdev subsystem.
>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Sean Paul <seanpaul@chromium.org>

Acked-by: Sean Paul <seanpaul@chromium.org>

> Cc: David Airlie <airlied@linux.ie>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba51d0906955..af9766a32949 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5391,6 +5391,7 @@ F:        drivers/net/wan/sdla.c
>
>  FRAMEBUFFER LAYER
>  M:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> +L:     dri-devel@lists.freedesktop.org
>  L:     linux-fbdev@vger.kernel.org
>  T:     git git://github.com/bzolnier/linux.git
>  Q:     http://patchwork.kernel.org/project/linux-fbdev/list/
> --
> 2.14.1
>
