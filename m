From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/4 v4] i.MX31: Image Processing
	Unit DMA and IRQ	drivers
Date: Tue, 23 Dec 2008 18:14:37 +0100
Message-ID: <20081223171437.GK1614@pengutronix.de>
References: <20081222183753.GD1614@pengutronix.de>
	<Pine.LNX.4.64.0812221942480.7796@axis700.grange>
	<20081223105006.GE1614@pengutronix.de>
	<Pine.LNX.4.64.0812231157180.5188@axis700.grange>
	<20081223125015.GG1614@pengutronix.de>
	<Pine.LNX.4.64.0812231359030.5188@axis700.grange>
	<20081223140320.GH1614@pengutronix.de>
	<Pine.LNX.4.64.0812231529080.5188@axis700.grange>
	<20081223160942.GJ1614@pengutronix.de>
	<Pine.LNX.4.64.0812231727460.5188@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sha@pengutronix.de>) id 1LFAqE-0000uZ-Bs
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 17:14:46 +0000
Received: from metis.ext.pengutronix.de ([92.198.50.35])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LFAqB-0005pl-Hz
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 17:14:46 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0812231727460.5188@axis700.grange>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Dec 23, 2008 at 05:33:11PM +0100, Guennadi Liakhovetski wrote:
> 
> These all are just slightly different variations - with this one you'd 
> have to scan dma channels in your dma irq handler, which I currently don't 
> have to do.
> 
> > That said I'm not sure whether we need a chained interrupt handler at all.
> > Looking at the remaining interrupts it seems that for example the
> > CSI_EOF (IPU_INT_STAT3 bit 5) interrupt is redundant to the corresponding
> > channels interrupt. In the camera driver you already realized that it's
> > the dma end event you're interested in, not the CSI_EOF event. Not sure
> > if that holds for the other interrupts though.
> 
> I think the version with a lookup table is optimal - it uses standard 
> mechanisms for irq handling and doesn't waste RAM. The disadvantage - 
> every addition will need driver modification...
> 
> But ok, this is taking way too long. Just tell me which way you'd like to 
> have it and I'll do it.

Preferably a way which does not involve introducing 100+ unused
interrupts.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

------------------------------------------------------------------------------
