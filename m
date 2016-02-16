From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Feb 2016 11:35:26 +0000
Subject: Re: [PATCH] xen kconfig: clarify INPUT_XEN_KBDDEV_FRONTEND select
Message-Id: <2801550.oZPkqjv8nW@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455278707-2008263-1-git-send-email-arnd@arndb.de>
 <alpine.DEB.2.02.1602151643150.27008@kaball.uk.xensource.com>
In-Reply-To: <alpine.DEB.2.02.1602151643150.27008@kaball.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 15 February 2016 16:51:08 Stefano Stabellini wrote:
> > 
> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index 8ea45a5cd806..fd3d6fd290a9 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -2241,6 +2241,7 @@ config FB_VIRTUAL
> >  config XEN_FBDEV_FRONTEND
> >       tristate "Xen virtual frame buffer support"
> >       depends on FB && XEN
> > +     depends on INPUT || !INPUT_MISC
> >       select FB_SYS_FILLRECT
> >       select FB_SYS_COPYAREA
> >       select FB_SYS_IMAGEBLIT
> 
> This looks very hackish. Couldn't we just do the following?
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 8ea45a5..3c15f6d 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2246,7 +2246,7 @@ config XEN_FBDEV_FRONTEND
>         select FB_SYS_IMAGEBLIT
>         select FB_SYS_FOPS
>         select FB_DEFERRED_IO
> -       select INPUT_XEN_KBDDEV_FRONTEND if INPUT_MISC
> +       select INPUT_XEN_KBDDEV_FRONTEND if (INPUT && INPUT_MISC)
>         select XEN_XENBUS_FRONTEND
>         default y
>         help
> 

No, that doesn't solve the problem:

If XEN_FBDEV_FRONTEND=y, INPUT=m and INPUT_MISC=y, we would still
get INPUT_XEN_KBDDEV_FRONTEND=y, which cannot work because of INPUT=m.

INPUT_MISC already depends on INPUT, so your change has no effect
at all.

	Arnd
