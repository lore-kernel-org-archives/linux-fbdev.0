From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/4] [ARM] s3c-fb: Add support for display panning
Date: Thu, 9 Jul 2009 19:02:28 +0100
Message-ID: <20090709180228.GG1875@n2100.arm.linux.org.uk>
References: <E4D3F24EA6C9E54F817833EAE0D912AC076E71C7EE@bssrvexch01.BS.local>
	<20090709194912.5e3fcc8e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20090709194912.5e3fcc8e.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Pawel Osciak <p.osciak@samsung.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "adaplas@gmail.com" <adaplas@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Thu, Jul 09, 2009 at 07:49:12PM +0200, Krzysztof Helt wrote:
> On Thu, 09 Jul 2009 17:09:00 +0200
> Pawel Osciak <p.osciak@samsung.com> wrote:
> > diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> > index ff0b1a3..77b77a2 100644
> > --- a/drivers/video/s3c-fb.c
> > +++ b/drivers/video/s3c-fb.c
> > @@ -294,6 +294,8 @@ static int s3c_fb_set_par(struct fb_info *info)
> >  	}
> >  
> >  	info->fix.line_length = (var->xres_virtual * var->bits_per_pixel) / 8;
> > +	info->fix.xpanstep = info->var.xres_virtual > info->var.xres ? 1 : 0;
> > +	info->fix.ypanstep = info->var.yres_virtual > info->var.yres ? 1 : 0;
> >  
> 
> These two lines are not need. If the xres_virtual > xres  there is no 
> panning possible (the same is true for yres and yres_virtual).

Erm, I think you have that backwards.

xres,yres is the visibly displayed dimentions.
xres_virtual,yres_virtual is the size of the underlying framebuffer.

If the underlying framebuffer is larger than the visible display, you can
pan the visible display around within the underlying framebuffer.

It is common for unaccelerated framebuffers used in text mode to have
xres_virtual = xres, yres_virtual >> yres so that Y panning (or if your
video driver supports it, wrapping) can occur to speed line scrolling.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
