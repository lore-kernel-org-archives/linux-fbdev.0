From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH 2/4 v4] i.MX31: Image Processing
	Unit DMA and IRQ	drivers
Date: Tue, 23 Dec 2008 14:32:08 +0300
Message-ID: <4950CC38.3090200__45148.86492766$1230036086$gmane$org@gmail.com>
References: <Pine.LNX.4.64.0812181406000.5510@axis700.grange>
	<Pine.LNX.4.64.0812181414280.5510@axis700.grange>
	<20081218225834.GJ20756@pengutronix.de>
	<Pine.LNX.4.64.0812221240210.5241@axis700.grange>
	<20081222183753.GD1614@pengutronix.de>
	<20081222200337.GD9472@pengutronix.de> <4950B8C6.30309@gmail.com>
	<20081223105246.GF1614@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmitry.krivoschekov@gmail.com>) id 1LF6We-0006DC-LV
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 12:38:16 +0000
Received: from nf-out-0910.google.com ([64.233.182.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LF6Wa-0002jv-Up for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 12:38:16 +0000
Received: by nf-out-0910.google.com with SMTP id g16so305462nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 23 Dec 2008 04:38:11 -0800 (PST)
In-Reply-To: <20081223105246.GF1614@pengutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>, Robert Schwebel <r.schwebel@pengutronix.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.orglinux-

Sascha Hauer wrote:
> On Tue, Dec 23, 2008 at 01:09:10PM +0300, Dmitry Krivoschekov wrote:
>> Robert Schwebel wrote:
>>> On Mon, Dec 22, 2008 at 07:37:53PM +0100, Sascha Hauer wrote:
>>>> Another thing is the overlay framebuffer. I think it's mainly useful
>>>> to display video streams.
>>> Right. The idea is that you can push a video stream into /dev/fb1 (for
>>> example by using the gstreamer fbdev sink) while displaying widgets from
>>> a GUI toolkit on /dev/fb0.
>>>
>>>> Maybe it's better to implement this as a v4l device as unlike the
>>>> framebuffer API the v4l API is designed to handle different image
>>>> buffers.
>>> Huh? v4l is image-frames-to-userspace, not vice versa.
>>>
>> ...and vice versa too, v4l2 is not about input devices only but it is
>> also related to output devices, v4l2 spec even has a special chapter
>> dedicated to overlays [1]. Moreover, you can find such a driver within
>> Freescale's BSP [2]. Another example is Omap's videoout driver [3].
>
> Are you aware of any application making use of this feature?

IIRC, mplayer is able to output on a v4l2 device. Also, Freescale's
i.MX31 ADS BSP contained a bunch of V4L2 unit tests, including v4l2 output.

Dmitry


[1]
http://www.freescale.com/webapp/sps/site/overview.jsp?code=CW_BSP_ARM&fsrch=1
>
> Sascha
>


------------------------------------------------------------------------------
