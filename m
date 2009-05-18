From: Werner LEMBERG <wl@gnu.org>
Subject: Re: bug #13249 - problem with intelfb on i845gm
Date: Mon, 18 May 2009 15:29:03 +0200 (CEST)
Message-ID: <20090518.152903.193209423.wl@gnu.org>
References: <20090517140249.d3a1888c.krzysztof.h1@poczta.fm>
	<20090518.124818.237161585.wl@gnu.org>
	<20090518145125.f975ae2b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <werner.lemberg@gmx.de>) id 1M62uE-0004UH-DX
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 May 2009 13:29:26 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M62u9-0003h5-U4 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 May 2009 13:29:26 +0000
In-Reply-To: <20090518145125.f975ae2b.krzysztof.h1@poczta.fm>
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


> What I see here is that for 2.6.27 you use the VESA framebuffer
> while you do not use it for the 2.6.28
> 
> Compare your configs:
> 2.6.27 : CONFIG_FB_VESA=y
> 2.6.28: # CONFIG_FB_VESA is not set

This is intentional.  Reason is that in 2.6.28 option
`CONFIG_FB_BOOT_VESA_SUPPORT' has been added, and it seems that this
change introduced a bug.

> My advice is try using the Intel framebuffer (change it to Y not 'M'
> like module).  It should be faster than VESA on your hardware.
> Unselect VESA.

I'm doing a git bisect right now to find out why
CONFIG_FB_BOOT_VESA_SUPPORT doesn't work as advertised.


    Werner

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
