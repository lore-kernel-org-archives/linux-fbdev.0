From: Harald Welte <HaraldWelte@viatech.com>
Subject: Re: [PATCH 1/2] viafb: make viafb a	first-class
	citizen using pci_driver
Date: Wed, 20 May 2009 09:45:33 +0800
Message-ID: <20090520014533.GY19746@prithivi.gnumonks.org>
References: <20090519083418.GH19746@prithivi.gnumonks.org>
	<20090519231628.e4e149be.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1M6bXM-0004TD-4L
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 02:28:08 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6bXJ-00026g-Ni
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 02:28:08 +0000
Content-Disposition: inline
In-Reply-To: <20090519231628.e4e149be.krzysztof.h1@poczta.fm>
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

On Tue, May 19, 2009 at 11:16:28PM +0200, Krzysztof Helt wrote:
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Thanks.

> > -	viafb_get_mmio_info(&viaparinfo->mmio_base, &viaparinfo->mmio_len);
> > +	viaparinfo->mmio_base = pci_resource_start(pdev, 1);
> > +	viaparinfo->mmio_len = pci_resource_len(pdev, 1);
> 
> Again, there are standard fields which have the same meaning:
> viafbinfo->mmio_start and viafbinfo->mmio_len.

I know, and I have some patches coming up for that, they're already in my tree.
I'm still doing some testing and will resubmit an entire series of about 10
patches today or tomorrow.

Regards,
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
