From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Fri, 10 Jan 2014 16:16:10 +0000
Subject: Re: [PATCH v4] video: add OpenCores VGA/LCD framebuffer driver
Message-Id: <20140110161608.GA23774@chokladfabriken.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385739911-6541-1-git-send-email-stefan.kristiansson@saunalahti.fi>
 <52CFE2BB.8090004@ti.com>
In-Reply-To: <52CFE2BB.8090004@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com

On Fri, Jan 10, 2014 at 02:08:27PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 2013-11-29 17:45, Stefan Kristiansson wrote:
> > This adds support for the VGA/LCD core available from OpenCores:
> > http://opencores.org/project,vga_lcd
> > 
> > The driver have been tested together with both OpenRISC and
> > ARM (socfpga) processors.
> > 
> > Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> 
> If I'm not mistaken, this driver has been designed so that there can
> only be one VGA/LCD core device on the system.
> 
> It would be better to get rid of those static structs, and have the
> driver data per device as it should. That way the driver works even with
> multiple VGA/LCD cores (although the video mode module option is a bit
> odd in that case).
> 

You're right, it's a completely realistic scenario with several
VGA/LCD cores in the system, so the one device only restriction is bad.
And looking closer at the static structs, I see that the ocfb_var and ocfb_fix
doesn't surve any purpose at all, so they can just be removed.
And the information in ocfb_par can easily be obtained directly from ocfb_dev
instead, so by setting info.par to point at that, the ocfb_par struct can also
be removed completely.
Thanks, that suggestion makes the implementation cleaner as well.

I'll post an updated patch with the changes.

Stefan
