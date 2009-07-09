From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Framebuffer support for HTC Dream
Date: Thu, 9 Jul 2009 11:48:00 +0200
Message-ID: <20090709094755.GA10937@elf.ucw.cz>
References: <20090629111029.GA15514@elf.ucw.cz> <20090629123840.1e20f17d.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759861AbZGIJuK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090629123840.1e20f17d.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, swetland@google.com

> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index fb19803..4a7873b 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -2119,6 +2119,14 @@ config FB_PRE_INIT_FB
> >  	  Select this option if display contents should be inherited as set by
> >  	  the bootloader.
> >  
> > +config FB_MSM
> > +	tristate
> > +	depends on FB && ARCH_MSM
> > +	select FB_CFB_FILLRECT
> > +	select FB_CFB_COPYAREA
> > +	select FB_CFB_IMAGEBLIT
> > +	default y
> 
> I'm seeing gpio calls in there.  Do we need a gpio dependency, or did
> ARCH_MSM give us gpio anyway?

AFAICT, ARCH_MSM needs GENERIC_GPIO, so we are ok.

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
