From: Werner LEMBERG <wl@gnu.org>
Subject: Re: bug #13249 - problem with intelfb on i845gm
Date: Wed, 20 May 2009 11:26:06 +0200 (CEST)
Message-ID: <20090520.112606.49874447.wl@gnu.org>
References: <20090520075138.c8c7d84d.krzysztof.h1@poczta.fm>
	<20090520.082548.01295500.wl@gnu.org>
	<20090520104440.3cd8a0ec.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <werner.lemberg@gmx.de>) id 1M6i5c-0004f4-P9
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 09:27:56 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M6i5P-0005WX-E9 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 09:27:56 +0000
In-Reply-To: <20090520104440.3cd8a0ec.krzysztof.h1@poczta.fm>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

>> Well, I use the intelfb driver (CONFIG_FB_INTEL=m), but I get a black
>> screen for any VESA mode...
> 
> You have to compile it into the kernel image (CONFIG_FB_INTEL=y) 
> otherwise no VESA mode is used.

Aaah.  Will try soon, thanks.


   Werner

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
