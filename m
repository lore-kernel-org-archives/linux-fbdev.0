From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] Fix colors in mach64 accelerator
Date: Wed, 17 Jun 2009 23:40:09 +0200
Message-ID: <20090617234009.b4d6df3c.krzysztof.h1@poczta.fm>
References: <Pine.LNX.4.64.0906170559040.30231@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MH2k0-0002dd-Fa
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 21:32:20 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH2jx-0001gp-5w for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 21:32:18 +0000
In-Reply-To: <Pine.LNX.4.64.0906170559040.30231@hs20-bc2-1.build.redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, paulus@samba.org

On Wed, 17 Jun 2009 06:00:53 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> Use the same color-calculating algorithm as in atyfb_imageblit in this driver
> or in generic cfb_fillrect.
> 
> This patch fixes bad colors when using an accelerator in 15-bit and 16-bit
> modes.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Masz juz dosc wysokich rachunkow? Wygraj nowa mozliwosc komunikacji!
Sprawdz >>> http://link.interia.pl/f21d2


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
