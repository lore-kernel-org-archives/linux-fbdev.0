From: Pavel Machek <pavel@ucw.cz>
Date: Sun, 26 Apr 2015 19:31:46 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <20150426193146.GA4539@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd>
 <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com>
 <20150409110634.GA27407@amd>
 <552660C7.4020805@ti.com>
 <552663C2.70308@ti.com>
 <55277650.8070607@codeaurora.org>
 <20150424132923.GA11729@amd>
 <553A47D3.2070107@ti.com>
 <CAMuHMdV+-VcZD5TMswUjwW0fk=-76oYimeKJ_P9QC5Md4De-JA@mail.gmail.com>
In-Reply-To: <CAMuHMdV+-VcZD5TMswUjwW0fk=-76oYimeKJ_P9QC5Md4De-JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Russell King <rmk@arm.linux.org.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <architt@codeaurora.org>, Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Russell King <linux@arm.linux.org.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>

On Fri 2015-04-24 15:46:56, Geert Uytterhoeven wrote:
> On Fri, Apr 24, 2015 at 3:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On 24/04/15 16:29, Pavel Machek wrote:
> >> On Fri 2015-04-10 12:35:52, Archit Taneja wrote:
> >>>> That said, if the fb is in RAM, and is only written by the CPU, I think
> >>>> a normal memcpy() for fb_memcpy_fromfb() should be fine...
> >>>
> >>> I didn't test for performance regressions when I posted this patch.
> >>>
> >>> A look at _memcpy_fromio in arch/arm/kernel/io.c shows that readb() is used
> >>> all the time, even when the source and destination addresses are aligned for
> >>> larger reads to be possible. Other archs seem to use readl() or readq() when
> >>> they can. Maybe that makes memcpy_fromio slower than the implementation of
> >>> memcpy on arm?
> >>
> >> Ok, can you prepare a patch for me to try? Or should we just revert
> >> the original commit?
> >
> > The old way worked fine, afaik, so maybe we can revert. But still, isn't
> > it more correct to use memcpy_fromio? It's (possibly) io memory we have
> > here.
> 
> Yes it is.
> 
> So please optimize ARM's _memcpy_fromio(), _memcpy_toio(), and _memset_io().
> That will benefit other drivers on ARM, too.

No, sorry. Yes, I could "optimize" memcpy_toio... just by sticking
memcpy there, as for example asm-generic/io.h suggests.

Maybe it would break something. Maybe not, but potential for that
clearly is there... since this is very seldom used function. Or do you
know drivers that would benefit from this?

void _memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
{
        const unsigned char *f = from;
	while (count) {
	      count--;
	      writeb(*f, to);
	      f++;
	      to++;
 	}
}

We have a regression, we have a patch that causes the
regression. Right fix at this point is to revert a "cleanup" that
causes this, not try to "optimize" otherwise unused piece of code.

commit 981409b25e2a99409b26daa67293ca1cfd5ea0a0
Author: Archit Taneja <archit@ti.com>
Date:   Fri Nov 16 14:46:04 2012 +0530

    fbdev: arm has __raw I/O accessors, use them in fb.h

    This removes the sparse warnings on arm platforms:

    warning: cast removes address space of expression

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: H Hartley Sweeten <hsweeten at visionengravers.com>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Russell King <linux@arm.linux.org.uk>

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
