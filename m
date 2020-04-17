From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 17 Apr 2020 20:29:07 +0000
Subject: Re: [PATCH 6/8] drm: decouple from CONFIG_FB
Message-Id: <20200417202907.GA5617@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
 <20200417155553.675905-7-arnd@arndb.de>
 <20200417165041.GA30483@ravnborg.org>
 <CAK8P3a14G=Mv3jpZRciTgsSDf4Bd3ZOAqFRN1cc2FLYbwZZcbw@mail.gmail.com>
In-Reply-To: <CAK8P3a14G=Mv3jpZRciTgsSDf4Bd3ZOAqFRN1cc2FLYbwZZcbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Marek Vasut <marex@denx.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dsd@laptop.org, Nicolas Pitre <nico@fluxnic.net>, David Airlie <airlied@linux.ie>, Masahiro Yamada <masahiroy@kernel.org>, jfrederich@gmail.com, Saeed Mahameed <saeedm@mellanox.com>, Thomas Hellstrom <thellstrom@vmware.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, dri-devel <dri-devel@lists.freedesktop.org>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jason Gunthorpe <jgg@ziepe.ca>, Daniel Mack <daniel@zonque.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>

Hi Arnd.

On Fri, Apr 17, 2020 at 10:03:23PM +0200, Arnd Bergmann wrote:
> On Fri, Apr 17, 2020 at 6:50 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> >
> > So what this try to say is that we cannot have FB a module while DRM is
> > built-in (marked N in the above).
> 
> Correct
> 
> >
> > Could you explain in the changelog why this combination is not good.
> > (Or tell me if my analysis was flawed).
> 
> I agree in hindsight this was less obvious than I thought ;-)
> 
> Added this text to the changelog:
> 
> |  When CONFIG_FB is a loadable module, DRM_KMS_FB_HELPER cannot be
> | part of the built-in subsystem, so add dependency to ensure this
> | can only be enabled if the DRM module can successfully be linked.
> 
> and this comment in the Kconfig file:
> 
> @@ -112,7 +112,7 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
>  config DRM_FBDEV_EMULATION
>         bool "Enable legacy fbdev support for your modesetting driver"
>         depends on DRM && FB
> -       depends on FB=y || DRM=m
> +       depends on FB=y || DRM=m # DRM_KMS_FB_HELPER links against FB
>         select DRM_KMS_HELPER
>         select DRM_KMS_FB_HELPER
>         default y
> 
> Let me know if you think those changes are sufficient
> 
> > With this fixed (assuming I am right):
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Yes, that explains it nicely - thanks.
But unless Daniel decides otherwise we do not get it applied.
He was not too happy with it.

	Sam
