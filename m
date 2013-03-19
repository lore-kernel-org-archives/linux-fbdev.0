From: Shawn Guo <shawn.guo@linaro.org>
Date: Tue, 19 Mar 2013 05:48:47 +0000
Subject: Re: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
Message-Id: <20130319054846.GI12462@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
 <201303181518.14171.marex@denx.de>
 <20130318143129.GG12462@S2101-09.ap.freescale.net>
 <201303181619.52377.marex@denx.de>
In-Reply-To: <201303181619.52377.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 18, 2013 at 04:19:52PM +0100, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On Mon, Mar 18, 2013 at 03:18:13PM +0100, Marek Vasut wrote:
> > > Did you manage to test it please?
> > 
> > I do not have X11 environment handy to test, but framework console
> > seems still working.
> 
> Even after me poking in it, lol :-)
> 
> You can grab [1], extract it onto card or NFS and just use it as root 
> filesystem, the X11 will come up automagically.
> 
Thanks, Marek.  Yeah, now I can see the problem and your patch does fix
it.

Shawn

> [1] ftp://ftp.denx.de/pub/eldk/5.3/targets/armv5te/core-image-sato-sdk-generic-
> armv5te.tar.gz

