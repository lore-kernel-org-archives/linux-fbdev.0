From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 18 Feb 2011 12:07:17 +0000
Subject: Re: [PATCH 1/7] Add a mfd IPUv3 driver
Message-Id: <20110218120716.GC15832@sortiz-mobl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
	<1297865452-32181-2-git-send-email-s.hauer@pengutronix.de>
	<871v36pm5r.fsf@lechat.rtp-net.org>
	<20110218094949.GJ24426@pengutronix.de>
In-Reply-To: <20110218094949.GJ24426@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Sascha,

On Fri, Feb 18, 2011 at 10:49:49AM +0100, Sascha Hauer wrote:
> On Thu, Feb 17, 2011 at 07:10:24PM +0100, Arnaud Patard wrote:
> > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > index 6bafb51b..ffdb37a 100644
> > > --- a/drivers/video/Kconfig
> > > +++ b/drivers/video/Kconfig
> > > @@ -26,6 +26,8 @@ source "drivers/gpu/drm/Kconfig"
> > >  
> > >  source "drivers/gpu/stub/Kconfig"
> > >  
> > > +source "drivers/video/imx-ipu-v3/Kconfig"
> > > +
> > 
> > I don't see such a Kconfig file in this patch. Got lost while moving
> > from mfd to video ?
> 
> Oops, yes still untracked in my repository. Will add in the next series.
> 
> > 
> >  
> > >  config VGASTATE
> > >         tristate
> > >         default n
> > > diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> > > index 8c8fabd..f4921ab 100644
> > > --- a/drivers/video/Makefile
> > > +++ b/drivers/video/Makefile
> > > @@ -153,6 +153,7 @@ obj-$(CONFIG_FB_BFIN_T350MCQB)	  += bfin-t350mcqb-fb.o
> > >  obj-$(CONFIG_FB_BFIN_7393)        += bfin_adv7393fb.o
> > >  obj-$(CONFIG_FB_MX3)		  += mx3fb.o
> > >  obj-$(CONFIG_FB_DA8XX)		  += da8xx-fb.o
> > > +obj-$(CONFIG_MFD_IMX_IPU_V3)	  += imx-ipu-v3/
> > 
> > Now that files are in drivers/video, do we want to keep MFD in the name ?
> 
> I asked myself the same question and had no clear answer. Probably
> better to remove the MFD.
Definitely, yes.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
