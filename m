From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH 2/4 v4] i.MX31: Image Processing Unit DMA and IRQ	drivers
Date: Tue, 23 Dec 2008 13:09:10 +0300
Message-ID: <4950B8C6.30309@gmail.com>
References: <Pine.LNX.4.64.0812181406000.5510@axis700.grange> <Pine.LNX.4.64.0812181414280.5510@axis700.grange> <20081218225834.GJ20756@pengutronix.de> <Pine.LNX.4.64.0812221240210.5241@axis700.grange> <20081222183753.GD1614@pengutronix.de> <20081222200337.GD9472@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755555AbYLWKJe@vger.kernel.org>
In-Reply-To: <20081222200337.GD9472@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>

Robert Schwebel wrote:
> On Mon, Dec 22, 2008 at 07:37:53PM +0100, Sascha Hauer wrote:
>> Another thing is the overlay framebuffer. I think it's mainly useful
>> to display video streams.
>
> Right. The idea is that you can push a video stream into /dev/fb1 (for
> example by using the gstreamer fbdev sink) while displaying widgets from
> a GUI toolkit on /dev/fb0.
>
>> Maybe it's better to implement this as a v4l device as unlike the
>> framebuffer API the v4l API is designed to handle different image
>> buffers.
>
> Huh? v4l is image-frames-to-userspace, not vice versa.
>
...and vice versa too, v4l2 is not about input devices only but it is
also related to output devices, v4l2 spec even has a special chapter
dedicated to overlays [1]. Moreover, you can find such a driver within
Freescale's BSP [2]. Another example is Omap's videoout driver [3].


Dmitry

[1]http://v4l2spec.bytesex.org/spec-single/v4l2.html#OVERLAY
[2]http://opensource.freescale.com/git?p=linux-2.6-mx.git;a=blob;f=drivers/media/video/mxc/output/mxc_v4l2_output.c;h=309700bb9d1f3b3f9dcac8a48a16d0775b8ed93a;hb=refs/heads/bsp-imx31ads-rel5
[3]http://git.omapzoom.org/?p=omapkernel.git;a=blob;f=drivers/media/video/omap/omap24xxvout.c;h=25ac1319bae58751cd1a543aa0f320159e10a475;hb=HEAD
