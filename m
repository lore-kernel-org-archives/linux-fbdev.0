From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Mon, 27 Nov 2017 17:40:28 +0000
Subject: Re: [PATCH 0/8] sa1100fb updates
Message-Id: <20171127174028.GJ31757@n2100.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170929105024epcas5p336177e386c65b530c4cb5fac379cedfa@epcas5p3.samsung.com>
 <2590375.JKTUJ5JGIV@amdc3058>
 <20171127171145.GI31757@n2100.armlinux.org.uk>
 <4330027.F5ASplytpk@amdc3058>
In-Reply-To: <4330027.F5ASplytpk@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 27, 2017 at 06:30:11PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Monday, November 27, 2017 05:11:45 PM Russell King - ARM Linux wrote:
> > On Tue, Oct 17, 2017 at 03:32:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > On Friday, September 29, 2017 11:50:04 AM Russell King - ARM Linux wrote:
> > > > Hi Bart,
> > > 
> > > Hi Russell,
> > > 
> > > > This series updates the sa1100fb fbdev driver's initialisation paths
> > > > to be more robust.  In doing these updates, I realised that we omitted
> > > > to free some memory which was allocated for the framebuffer if
> > > > initialisation fails - something that was hidden due to the complex
> > > > cleanup that the driver performs.  Switching to managed resources made
> > > > this more obvious.
> > > > 
> > > > Tested on H3600 iPAQ and Assabet.
> > > > 
> > > >  drivers/video/fbdev/sa1100fb.c | 75 +++++++++++++++---------------------------
> > > >  drivers/video/fbdev/sa1100fb.h |  2 ++
> > > >  2 files changed, 29 insertions(+), 48 deletions(-)
> > > 
> > > I queued all patches for 4.15, thanks!
> > 
> > Now that 4.15-rc1 is out, something tells me that was not actually
> > the case.  Any ideas what happened?
> 
> Could you please explain the issue that you are seeing a bit more?
> 
> For me it looks all fine:
> 
> $ git log --oneline v4.15-rc1 drivers/video/fbdev/sa1100fb.c
> cb6bc3f video: sa1100fb: move pseudo palette into sa1100fb_info structure
> 0ab7658 video: sa1100fb: fix video memory allocation leak
> c244f8e video: sa1100fb: clean up failure path
> 5634cba video: sa1100fb: use devm_gpio_request_one()
> f6fc8c9 video: sa1100fb: use devm_request_irq()
> df6b228 video: sa1100fb: use devm_ioremap_resource()
> e43064c video: sa1100fb: use devm_clk_get()
> ba1d36b video: sa1100fb: use devm_kzalloc()
> ...

Looks like I hadn't rebased that particular branch, so they were still
showing up in my origin.. git log.  Sorry about the false warning.

This is the problem of carrying close to 400 patches in separate
branches, and git log origin.. not able to show the commits that the
selection are based upon.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
