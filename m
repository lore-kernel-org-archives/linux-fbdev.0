From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH 2/4 v4] i.MX31: Image Processing Unit DMA and IRQ
	drivers
Date: Mon, 22 Dec 2008 21:03:37 +0100
Message-ID: <20081222200337.GD9472@pengutronix.de>
References: <Pine.LNX.4.64.0812181406000.5510@axis700.grange> <Pine.LNX.4.64.0812181414280.5510@axis700.grange> <20081218225834.GJ20756@pengutronix.de> <Pine.LNX.4.64.0812221240210.5241@axis700.grange> <20081222183753.GD1614@pengutronix.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755260AbYLVUDu@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081222183753.GD1614@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, Dan

On Mon, Dec 22, 2008 at 07:37:53PM +0100, Sascha Hauer wrote:
> Another thing is the overlay framebuffer. I think it's mainly useful
> to display video streams.

Right. The idea is that you can push a video stream into /dev/fb1 (for
example by using the gstreamer fbdev sink) while displaying widgets from
a GUI toolkit on /dev/fb0.

> Maybe it's better to implement this as a v4l device as unlike the
> framebuffer API the v4l API is designed to handle different image
> buffers.

Huh? v4l is image-frames-to-userspace, not vice versa.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
