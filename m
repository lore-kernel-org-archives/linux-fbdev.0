From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: FB_MODE_HELPERS
Date: Tue, 24 Aug 2004 23:21:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408242321.46901.adaplas@hotpop.com>
References: <Pine.GSO.4.58.0408241603250.26345@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bzd7J-0002tg-VU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Aug 2004 08:21:45 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bzd7H-0005av-CN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Aug 2004 08:21:45 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BDFA4109857F
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 24 Aug 2004 15:21:34 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0408241603250.26345@waterleaf.sonytel.be>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

On Tuesday 24 August 2004 22:05, Geert Uytterhoeven wrote:
> Since drivers that depend on FB_MODE_HELPERS now select it automatically,
> shouldn't FB_MODE_HELPERS default to n in Kconfig?
>
> Or am I missing something?
>

Yes, it should default to 'n'.

Tony




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
