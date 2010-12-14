From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 14 Dec 2010 12:44:22 +0000
Subject: Re: OMAP4 build error - omapfb
Message-Id: <1292330662.6893.115.camel@tubuntu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101202212541.GH10461@n2100.arm.linux.org.uk>
	<20101202220024.GX17222@atomide.com>
In-Reply-To: <20101202220024.GX17222@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 2010-12-02 at 14:00 -0800, ext Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [101202 13:15]:
> > drivers/built-in.o: In function `omapfb_do_probe':
> > drivers/video/omap/omapfb_main.c:1773: undefined reference to `omap2_int_ctrl'
> > 
> > Looks like there's a missing dependency for CONFIG_FB_OMAP.  As the
> > only place omap2_int_ctrl is defined is in drivers/video/omap/dispc.c,
> > and this isn't built for OMAP4, maybe FB_OMAP is missing a dependency
> > such that it's only available for OMAP1, OMAP2 and OMAP3 ?
> 
> This is something for Tomi, adding fbdev and Tomi to Cc.

Looks correct. The old omapfb will never work with OMAP4, so a
dependency to OMAP1/2/3 fixes the build problem. I'll add this fix to my
tree.

 Tomi

> 
> Tony
>  
> > diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
> > index 455c605..083c8fe 100644
> > --- a/drivers/video/omap/Kconfig
> > +++ b/drivers/video/omap/Kconfig
> > @@ -1,7 +1,7 @@
> >  config FB_OMAP
> >  	tristate "OMAP frame buffer support (EXPERIMENTAL)"
> > -	depends on FB && ARCH_OMAP && (OMAP2_DSS = "n")
> > -
> > +	depends on FB && (OMAP2_DSS = "n")
> > +	depends on ARCH_OMAP1 || ARCH_OMAP2 || ARCH_OMAP3
> >  	select FB_CFB_FILLRECT
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


