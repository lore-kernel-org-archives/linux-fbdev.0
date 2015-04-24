From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 24 Apr 2015 13:29:23 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <20150424132923.GA11729@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd>
 <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com>
 <20150409110634.GA27407@amd>
 <552660C7.4020805@ti.com>
 <552663C2.70308@ti.com>
 <55277650.8070607@codeaurora.org>
In-Reply-To: <55277650.8070607@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <architt@codeaurora.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, shc_work@mail.ru, linux@arm.linux.org.uk, hsweeten@visionengravers.com

Hi!

On Fri 2015-04-10 12:35:52, Archit Taneja wrote:
> >That said, if the fb is in RAM, and is only written by the CPU, I think
> >a normal memcpy() for fb_memcpy_fromfb() should be fine...
> 
> I didn't test for performance regressions when I posted this patch.
> 
> A look at _memcpy_fromio in arch/arm/kernel/io.c shows that readb() is used
> all the time, even when the source and destination addresses are aligned for
> larger reads to be possible. Other archs seem to use readl() or readq() when
> they can. Maybe that makes memcpy_fromio slower than the implementation of
> memcpy on arm?

Ok, can you prepare a patch for me to try? Or should we just revert
the original commit?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
