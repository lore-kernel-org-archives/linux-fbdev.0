From: Harald Welte <HaraldWelte@viatech.com>
Subject: Re: [PATCH 3/3] viafb: Add support for
	the	VX855 chipset
Date: Tue, 19 May 2009 17:23:56 +0800
Message-ID: <20090519092356.GM19746@prithivi.gnumonks.org>
References: <20090519035254.GZ19746@prithivi.gnumonks.org>
	<20090519100748.e471ea6d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1M6LeZ-0008DY-3I
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 09:30:31 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6LeK-0004Hb-LN
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 09:30:31 +0000
Content-Disposition: inline
In-Reply-To: <20090519100748.e471ea6d.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: JosephChan@via.com.tw, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net

On Tue, May 19, 2009 at 10:07:48AM +0200, Krzysztof Helt wrote:

> I believe it is correct. I have no chance to test. 
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Thanks for your review.  Right now, nobody but VIA and OLPC has hardware to test,
as far as I know.  This is why I'm pushing for this code to get included now,
i.e. the kernel works on the hardware once it ships in quantity.

 
> > +/* For VT3409 */
> > +#define VX855_IGA1_FIFO_MAX_DEPTH               400
> > +#define VX855_IGA1_FIFO_THRESHOLD               320
> > +#define VX855_IGA1_FIFO_HIGH_THRESHOLD          320
> 
> Are these two values above always the same? If so you can use
> a single symbol. 

Well, as you can see, they are not the same on other chips than the VX855,
so I left the two separate #defines to be orthogonal.  I hope I find enough
time to clean this up and have all those values in a structure, indexed by
the chip variant at some point.

-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
