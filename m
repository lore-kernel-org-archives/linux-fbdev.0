From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/4 v6] i.MX31: dmaengine and framebuffer drivers
Date: Fri, 16 Jan 2009 10:39:08 -0700
Message-ID: <e9c3a7c20901160939y6b3906fp41531730d4b752a@mail.gmail.com>
References: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
	 <e9c3a7c20901051143m37c0d7c0x5779475ddc7c5dc2@mail.gmail.com>
	 <Pine.LNX.4.64.0901161106100.4940@axis700.grange>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936250AbZAPRja@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0901161106100.4940@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, Geert Uytterhoeven <geert@linux-m68k.org>

On Fri, Jan 16, 2009 at 3:09 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Ok, let's do it this way: Sascha has acked version 8 of patches 2 and 3.
> And there seems to be no active framebuffer maintainer ATM. So, maybe you
> could take patches 1-3 into your tree, so they are exposed to the public,
> people have easier access to them in case they want to test (I had several
> requests), and you update them in case you change async-tx API again:-) It
> would be good to try and push them in for 2.6.29 - these are new drivers,
> so, might still be possible to convince Andrew / Linus, if not, you could
> keep them in your tree (and in next) until 2.6.30, then we'd add platform
> bindings and the camera driver. What do you think?

It will be weird to see drivers/video/ in a dmaengine pull request, but:

1/ as you point out it appears to be a free-for-all in that directory,
so Sascha's ack seems to be all that is needed here.
2/ merging the driver without any in-tree users does not make much sense
3/ these are new drivers so the risk of causing a regression should be
close to zero especially since none of the existing dmaengine users
will pick up these private channels

Can you send me the series, off-list, in a .tar.gz with Sascha's ack
to make sure I am applying the latest.  I can not seem to find [PATCH
2/4 v8] in my inbox...

Thanks,
Dan
