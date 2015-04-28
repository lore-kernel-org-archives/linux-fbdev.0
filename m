From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 28 Apr 2015 13:48:49 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <20150428134848.GC12732@n2100.arm.linux.org.uk>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Pavel Machek <pavel@ucw.cz>, Archit Taneja <architt@codeaurora.org>, Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>, H Hartley Sweeten <hsweeten@visionengravers.com>

On Fri, Apr 24, 2015 at 03:46:56PM +0200, Geert Uytterhoeven wrote:
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

That's not going to happen.

I've had a patch which does that, but people are concerned that it changes
the behaviour of the functions by changing the access size, which could
cause regressions.  It seems people are far too worried about that to even
consider trying. :(

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
