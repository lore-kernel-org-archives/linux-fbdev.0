From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Mon, 27 Nov 2017 17:11:45 +0000
Subject: Re: [PATCH 0/8] sa1100fb updates
Message-Id: <20171127171145.GI31757@n2100.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170929105024epcas5p336177e386c65b530c4cb5fac379cedfa@epcas5p3.samsung.com>
 <20170929105004.GY20805@n2100.armlinux.org.uk>
 <2590375.JKTUJ5JGIV@amdc3058>
In-Reply-To: <2590375.JKTUJ5JGIV@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 17, 2017 at 03:32:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday, September 29, 2017 11:50:04 AM Russell King - ARM Linux wrote:
> > Hi Bart,
> 
> Hi Russell,
> 
> > This series updates the sa1100fb fbdev driver's initialisation paths
> > to be more robust.  In doing these updates, I realised that we omitted
> > to free some memory which was allocated for the framebuffer if
> > initialisation fails - something that was hidden due to the complex
> > cleanup that the driver performs.  Switching to managed resources made
> > this more obvious.
> > 
> > Tested on H3600 iPAQ and Assabet.
> > 
> >  drivers/video/fbdev/sa1100fb.c | 75 +++++++++++++++---------------------------
> >  drivers/video/fbdev/sa1100fb.h |  2 ++
> >  2 files changed, 29 insertions(+), 48 deletions(-)
> 
> I queued all patches for 4.15, thanks!

Now that 4.15-rc1 is out, something tells me that was not actually
the case.  Any ideas what happened?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
