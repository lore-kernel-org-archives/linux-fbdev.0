From: Joe Perches <joe@perches.com>
Date: Fri, 13 Feb 2015 11:59:56 +0000
Subject: Re: [PATCH 1/2]Trivial patch: to solve indentation warnings in amba-clcd.c driver
Message-Id: <1423828796.2795.7.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150213112125.GA25078@linuxteamdev.amer.dell.com>
	 <20150213113515.GW8656@n2100.arm.linux.org.uk>
In-Reply-To: <20150213113515.GW8656@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Parmeshwr Prasad <parmeshwr_prasad@dell.com>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, trivial@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2015-02-13 at 11:35 +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 13, 2015 at 06:21:33AM -0500, Parmeshwr Prasad wrote:
> > @@ -288,7 +288,7 @@ static int clcdfb_set_par(struct fb_info *info)
> >         struct clcd_regs regs;
> > 
> >         fb->fb.fix.line_length = fb->fb.var.xres_virtual *
> > -                                fb->fb.var.bits_per_pixel / 8;
> > +           fb->fb.var.bits_per_pixel / 8;
> 
> NAK on this one.  The code as it stood before is much clearer since
> we align the expression with the start of it on the preceding line.

I agree with all of what Russell wrote, but maybe this;

> > @@ -717,7 +716,9 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb)
> >                 return -ENOMEM;
> > 
> >         fb->fb.fix.smem_start = of_translate_address(memory,
> > -                       of_get_address(memory, 0, &size, NULL));
> > +                                                    of_get_address(memory, 0,
> > +                                                                   &size,
> > +                                                                   NULL));
> 
> Thi sis the exception to the rule - where scrunching an expression so that
> it takes multiple lines because of lack of right-hand space is not on.
> The former version was a lot better.

Perhaps this could be better as:

	fb->fb.fix.smem_start 		 of_translate_address(memory,
				      of_get_address(memory, 0, &size, NULL));

But sometimes using multiple statements instead of
embedding function calls as arguments can be simpler
and more intelligible for the reader.

	__be32 addr;

	...

	addr = of_get_address(memory, 0, &size, NULL);
	fb->fb.fix.smem_start = of_translate_address(memory, addr);



