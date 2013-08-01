From: Darren Etheridge <detheridge@ti.com>
Date: Thu, 01 Aug 2013 13:36:02 +0000
Subject: Re: [PATCH v2 18/24] video: da8xx-fb: minimal dt support
Message-Id: <20130801133602.GA27598@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-19-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-19-git-send-email-detheridge@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> wrote on Wed [2013-Jul-31 13:19:01 +0300]:
> > +Required properties:
> > +- compatible:
> > +	DA830 - "ti,da830-lcdc"
> > +	AM335x SoC's - "ti,am3352-lcdc", "ti,da830-lcdc"
> 
> I'm not totally sure about this, but how I understand the compatible
> property, the above reads as: "this device is ti,am3352-lcdc and it's
> fully compatible with ti,da830-lcdc". I.e. if the kernel has a driver
> for da830-lcdc, it should work with AM335x also (without any of the new
> features in AM335x, obviously). Which I believe is not the case, as the
> point of this series is to add the AM335x support.
> 
> Or should the current da830-lcdc work with AM335x also, but it just
> didn't because there were bugs in da830-lcdc?
> 
>  Tomi
> 
> 
OK I agree there is something wrong here, for one I don't think setting
ti,am3352-lcdc would do anything anyway given the driver only reports
.compatible with ti,da830-lcdc so at the very least the document is
wrong.  I will look into this and decide what is the best way of
resolving this.  I will go ahead and submit the series without the DT
support anyway and then I will look into this.

Darren
