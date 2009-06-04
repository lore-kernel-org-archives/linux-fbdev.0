From: David Miller <davem@davemloft.net>
Subject: Re: [REPOST][PATCH 0/7] sparc32: use standard
 fields for framebuffer physical address and length
Date: Thu, 04 Jun 2009 01:44:16 -0700 (PDT)
Message-ID: <20090604.014416.100297774.davem@davemloft.net>
References: <20090517143000.b5021c5a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <davem@davemloft.net>) id 1MC8Yg-0005kE-K9
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Jun 2009 08:44:22 +0000
Received: from 74-93-104-97-washington.hfc.comcastbusiness.net ([74.93.104.97]
	helo=sunset.davemloft.net) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MC8Yd-0004j3-AO
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Jun 2009 08:44:22 +0000
In-Reply-To: <20090517143000.b5021c5a.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: krzysztof.h1@poczta.fm
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Sun, 17 May 2009 14:30:00 +0200

> This is a series of patches to convert some drivers to use standard
> smem_start and smem_len fields from the fb_info.fix structure.
> One of reasons to make these patches is to unify fbdev layer to
> use the smem_start and smem_len so it is easy to track where
> they are set.
> 
> The patches were already sent to the sparc-linux mailing list and
> the conclusion of discussion with David Miller was here:
> 
> http://marc.info/?l=linux-fbdev-devel&m=124172182126376&w=3
> 
> I assume he acked the whole series.

All applied to sparc-next-2.6, thanks!

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
