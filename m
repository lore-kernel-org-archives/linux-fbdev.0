From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH 2/4 v4] i.MX31: Image Processing Unit DMA and IRQ
	drivers
Date: Tue, 23 Dec 2008 13:13:00 +0100
Message-ID: <20081223121300.GL9472@pengutronix.de>
References: <Pine.LNX.4.64.0812181406000.5510@axis700.grange> <Pine.LNX.4.64.0812181414280.5510@axis700.grange> <20081218225834.GJ20756@pengutronix.de> <Pine.LNX.4.64.0812221240210.5241@axis700.grange> <20081222183753.GD1614@pengutronix.de> <Pine.LNX.4.64.0812221942480.7796@axis700.grange> <20081223105006.GE1614@pengutronix.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751836AbYLWMNV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081223105006.GE1614@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, Dan

On Tue, Dec 23, 2008 at 11:50:06AM +0100, Sascha Hauer wrote:
> > You mean an output v4l device? I think overlays are handled by framebuffer 
> > drivers... But I'm also not quite sure about it, however, handling overlay 
> > as another framebuffer seems logical to me.
>
> Well the DMA engine seems to suggest that frames should be passed around
> whereas the framebuffer API only has a single frame. That would fit
> better into the v4l API. Also the IPU can do things like colourspace
> conversion and hw scaling which would fit into the V4L API.

Looks like a candidate for gstreamer on the userspace end. Can it be
decoupled enough to make proper plugins out of it?

> BTW is the overlay framebuffer useful in it's current implementation?
> There seems to be no way to adjust the x/y offset or the blending
> modes.

The API Eric Miao just posted for the PXA looks sane to me.

> > If there are no other problems with v5, could we maybe take it as a
> > basis and then I would submit a patch to reduce the number of IRQs?
>
> Please understand my concerns with this driver. It's a quite complex
> beast and experience shows that once a driver is in the kernel it is
> far more complicated to change it than to do it right the first way.

Especially when it comes to userspace visible things.

> You know that I'm also interested in having a MX31 framebuffer (and
> camera) driver in kernel but I want to make sure that it works
> properly and leaves room for feature enhancements without having to
> refactor the whole driver.

Yup, looks like it would be better to cook it another round instead of
trying to bring in a half-tested driver with brute-force.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
