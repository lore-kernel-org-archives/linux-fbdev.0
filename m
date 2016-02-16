From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Date: Tue, 16 Feb 2016 12:14:14 +0000
Subject: Re: [PATCH] xen kconfig: clarify INPUT_XEN_KBDDEV_FRONTEND select
Message-Id: <alpine.DEB.2.02.1602161156160.27008@kaball.uk.xensource.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455278707-2008263-1-git-send-email-arnd@arndb.de>
 <alpine.DEB.2.02.1602151643150.27008@kaball.uk.xensource.com>
 <2801550.oZPkqjv8nW@wuerfel>
In-Reply-To: <2801550.oZPkqjv8nW@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 16 Feb 2016, Arnd Bergmann wrote:
> On Monday 15 February 2016 16:51:08 Stefano Stabellini wrote:
> > > 
> > > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > > index 8ea45a5cd806..fd3d6fd290a9 100644
> > > --- a/drivers/video/fbdev/Kconfig
> > > +++ b/drivers/video/fbdev/Kconfig
> > > @@ -2241,6 +2241,7 @@ config FB_VIRTUAL
> > >  config XEN_FBDEV_FRONTEND
> > >       tristate "Xen virtual frame buffer support"
> > >       depends on FB && XEN
> > > +     depends on INPUT || !INPUT_MISC
> > >       select FB_SYS_FILLRECT
> > >       select FB_SYS_COPYAREA
> > >       select FB_SYS_IMAGEBLIT
> > 
> > This looks very hackish. Couldn't we just do the following?
> > 
> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index 8ea45a5..3c15f6d 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -2246,7 +2246,7 @@ config XEN_FBDEV_FRONTEND
> >         select FB_SYS_IMAGEBLIT
> >         select FB_SYS_FOPS
> >         select FB_DEFERRED_IO
> > -       select INPUT_XEN_KBDDEV_FRONTEND if INPUT_MISC
> > +       select INPUT_XEN_KBDDEV_FRONTEND if (INPUT && INPUT_MISC)
> >         select XEN_XENBUS_FRONTEND
> >         default y
> >         help
> > 
> 
> No, that doesn't solve the problem:
> 
> If XEN_FBDEV_FRONTEND=y, INPUT=m and INPUT_MISC=y, we would still
> get INPUT_XEN_KBDDEV_FRONTEND=y, which cannot work because of INPUT=m.
> 
> INPUT_MISC already depends on INPUT, so your change has no effect
> at all.

Please correct me if I am wrong, but the difference is that with this
change if INPUT=m, then the build system would ask the user whether she
wants to select INPUT_XEN_KBDDEV_FRONTEND as m or y, instead of
unconditionally set INPUT_XEN_KBDDEV_FRONTEND=y.

However it is true that if the users chooses
INPUT_XEN_KBDDEV_FRONTEND=y, then the problem persists.
Maybe we also need:

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 1f2337a..303df24 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -721,7 +721,7 @@ config INPUT_CMA3000_I2C
 
 config INPUT_XEN_KBDDEV_FRONTEND
 	tristate "Xen virtual keyboard and mouse support"
-	depends on XEN
+	depends on XEN && INPUT
 	default y
 	select XEN_XENBUS_FRONTEND
 	help


Do you have a kernel config with INPUT=m that I can use to test with?
