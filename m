From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ	drivers
Date: Fri, 23 Jan 2009 21:55:28 +0100
Message-ID: <20090123205528.GP29067@pengutronix.de>
References: <4978CD75.70203@epfl.ch>
	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>
	<49798E4A.4030709@epfl.ch>
	<Pine.LNX.4.64.0901231040420.4463@axis700.grange>
	<4979A88A.5010102@epfl.ch>
	<Pine.LNX.4.64.0901231308040.4463@axis700.grange>
	<4979BFC1.1070504@epfl.ch>
	<Pine.LNX.4.64.0901231407030.6497@axis700.grange>
	<20090123131804.GI26184@n2100.arm.linux.org.uk>
	<4979C472.10707@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rsc@pengutronix.de>) id 1LQT4M-0006Ic-RA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 20:56:02 +0000
Received: from metis.ext.pengutronix.de ([92.198.50.35])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LQT4H-0002GC-IU
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 20:56:02 +0000
Content-Disposition: inline
In-Reply-To: <4979C472.10707@epfl.ch>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Jan 23, 2009 at 02:21:54PM +0100, Valentin Longchamp wrote:
> OK this may be a problem: I use the toolchain that is built by
> OpeneEmbedded. I could give a try to another one. Where can I download
> the ones you use Guennadi or Russel ?

You can also try OSELAS.Toolchain-1.99.2 which is able to build a
gcc-4.3.2 compiler. It works fine here on several ARM boards, but
Russell mentioned problems with it...

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
