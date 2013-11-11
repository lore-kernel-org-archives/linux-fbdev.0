From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Mon, 11 Nov 2013 10:08:44 +0000
Subject: Re: [PATCH] video: add OpenCores VGA/LCD framebuffer driver
Message-Id: <20131111100843.GA20337@chokladfabriken.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384088894-31920-1-git-send-email-stefan.kristiansson@saunalahti.fi>
 <52809FAA.6080107@monstr.eu>
In-Reply-To: <52809FAA.6080107@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com

On Mon, Nov 11, 2013 at 10:13:14AM +0100, Michal Simek wrote:
> On 11/10/2013 02:08 PM, Stefan Kristiansson wrote:
> > +config FB_OPENCORES
> > +	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
> > +	depends on FB
> > +	select FB_CFB_FILLRECT
> > +	select FB_CFB_COPYAREA
> > +	select FB_CFB_IMAGEBLIT
> > +	default n
> > +	help
> > +	  This enables support for the OpenCores VGA/LCD core.
> > +
> > +	  The OpenCores VGA/LCD core is typically used together with
> > +	  softcore CPUs (e.g. OpenRISC) or hard processor systems
> 
> I expect that here can be also Microblaze.

Yes, as would LM32, NiosII etc.
But, since none of those exists in the mainline kernel,
I suppose Microblaze along with OpenRISC is a sensible subset of examples.
I'll add that.

> 
> > +	  (e.g. Altera socfpga or Xilinx Zync) on FPGAs.
> 
> s/Zync/Zynq/
> 

Right, sorry. I'll fix that.

Stefan
