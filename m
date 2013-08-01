From: Darren Etheridge <detheridge@ti.com>
Date: Thu, 01 Aug 2013 20:21:27 +0000
Subject: Re: [PATCH v2 18/24] video: da8xx-fb: minimal dt support
Message-Id: <20130801202127.GB17271@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-19-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-19-git-send-email-detheridge@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Darren Etheridge <detheridge@ti.com> wrote on Thu [2013-Aug-01 08:36:02 -0500]:
> Tomi Valkeinen <tomi.valkeinen@ti.com> wrote on Wed [2013-Jul-31 13:19:01 +0300]:
> > > +Required properties:
> > > +- compatible:
> > > +	DA830 - "ti,da830-lcdc"
> > > +	AM335x SoC's - "ti,am3352-lcdc", "ti,da830-lcdc"
> > 
> > I'm not totally sure about this, but how I understand the compatible
> > property, the above reads as: "this device is ti,am3352-lcdc and it's
> > fully compatible with ti,da830-lcdc". I.e. if the kernel has a driver
> > for da830-lcdc, it should work with AM335x also (without any of the new
> > features in AM335x, obviously). Which I believe is not the case, as the
> > point of this series is to add the AM335x support.
> > 
> > Or should the current da830-lcdc work with AM335x also, but it just
> > didn't because there were bugs in da830-lcdc?
> > 
> >  Tomi
> > 
> > 
> OK I agree there is something wrong here, for one I don't think setting
> ti,am3352-lcdc would do anything anyway given the driver only reports
> .compatible with ti,da830-lcdc so at the very least the document is
> wrong.  I will look into this and decide what is the best way of
> resolving this.  I will go ahead and submit the series without the DT
> support anyway and then I will look into this.
> 
Reading the device tree documentation I think what is here in the
patch is actually correct so ignore my first response.

In answer to your original question in theory the da830 driver would
be fully compatible with the am335x - am335x implements a version 2 of
the lcd controller that adds some extra reg bits that support larger
horizontal and vertical resolutions and a sync loss interrupt.  
However the driver takes care of those differences internally.  I
think the main thing that was needed from this patch set to support
am335x were the dt changes, the Kconfig changes and the clock changes
- the rest of it are enhancements and bug fixes that are not strictly
needed for am335x support. 

Perhaps the correct thing to do and maybe what you are getting at is
really am3352 is the superset driver which we have now added complete
support for with these patches. However because we handle the
differences between the two IP's directly in the driver we should have
the driver provide both ti,am3352-lcdc and ti,da830-lcdc as
.compatible entries because really the driver supports both version 1 and
version 2 IP's.
