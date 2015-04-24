From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 24 Apr 2015 13:31:24 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <20150424133124.GB11729@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd>
 <552660C7.4020805@ti.com>
 <552663C2.70308@ti.com>
 <2137270.OOdtDiT2H4@wuerfel>
In-Reply-To: <2137270.OOdtDiT2H4@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, shc_work-JGs/UdohzUI@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org, Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>


> > The difference is probably caused by memcpy() vs memcpy_fromio(). The
> > comment above memcpy_fromio() says "This needs to be optimized". I think
> > generally speaking memcpy_fromio() is correct for a framebuffer.
> > 
> > That said, if the fb is in RAM, and is only written by the CPU, I think
> > a normal memcpy() for fb_memcpy_fromfb() should be fine...
> 
> Could memcpy() cause alignment traps here if the fb pointer is unaligned
> and uncached?

Original commit did not comment on any failure, so I expect that is
not a problem here...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
