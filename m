From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 17 Sep 2015 05:16:44 +0000
Subject: Re: omapdss: Division by zero in kernel
Message-Id: <20150917051644.GA6665@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201507241803.42891@pali>
 <CAHnt0GX6442mtZ=J6CS_60TyTeUu==oROcf4Y=upHGSr71X3EA@mail.gmail.com>
 <20150819081139.GB15712@pali>
In-Reply-To: <20150819081139.GB15712@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Peter Teoh <htmldeveloper@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>, omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>


> >         if (image->depth = 1) {
> >                 if (p->fix.visual = FB_VISUAL_TRUECOLOR ||
> >                     p->fix.visual = FB_VISUAL_DIRECTCOLOR) {
> >                         fgcolor = ((u32*)(p->pseudo_palette))[image->fg_color];
> >                         bgcolor = ((u32*)(p->pseudo_palette))[image->bg_color];
> >                 } else {
> >                         fgcolor = image->fg_color;
> >                         bgcolor = image->bg_color;
> >                 }
> > 
> >                 if (32 % bpp = 0 && !start_index && !pitch_index &&
> >                     ((width & (32/bpp-1)) = 0) &&
> >                     bpp >= 8 && bpp <= 32)
> >                         fast_imageblit(image, p, dst1, fgcolor, bgcolor);
> >                 else
> >                         slow_imageblit(image, p, dst1, fgcolor, bgcolor,
> >                                         start_index, pitch_index);
> >         } else
> >                 color_imageblit(image, p, dst1, start_index, pitch_i
> > 
> > 
> > Notice that bpp is not checked for zero, and thus bpp=0 is totally
> > feasible?   resulting in 32/bpp crashing the kernel?
> > 
> 
> Hm... this could really be a problem! But how to patch it? Which branch
> should be called (fast_ or slow_ function) if bpp is zero?
> 
> And is there some way to force kernel to dump backtrace into dmesg when
> division by zero occur?

You can do WARN_ON(bpp=1) ... and should probably return in that
case.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
