From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Tue, 28 Apr 2015 15:28:53 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <alpine.LFD.2.11.1504281127200.1582@knanqh.ubzr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd> <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com> <20150409110634.GA27407@amd> <552660C7.4020805@ti.com> <552663C2.70308@ti.com> <55277650.8070607@codeaurora.org> <20150424132923.GA11729@amd>
 <553A47D3.2070107@ti.com> <CAMuHMdV+-VcZD5TMswUjwW0fk=-76oYimeKJ_P9QC5Md4De-JA@mail.gmail.com> <20150428134848.GC12732@n2100.arm.linux.org.uk>
In-Reply-To: <20150428134848.GC12732-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>

On Tue, 28 Apr 2015, Russell King - ARM Linux wrote:

> On Fri, Apr 24, 2015 at 03:46:56PM +0200, Geert Uytterhoeven wrote:
> > So please optimize ARM's _memcpy_fromio(), _memcpy_toio(), and _memset_io().
> > That will benefit other drivers on ARM, too.
> 
> That's not going to happen.
> 
> I've had a patch which does that, but people are concerned that it changes
> the behaviour of the functions by changing the access size, which could
> cause regressions.  It seems people are far too worried about that to even
> consider trying. :(

What about making the optimized implementation available via kconfig?


Nicolas
