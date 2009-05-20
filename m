From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: bug #13249 - problem with intelfb on i845gm
Date: Wed, 20 May 2009 10:44:40 +0200
Message-ID: <20090520104440.3cd8a0ec.krzysztof.h1@poczta.fm>
References: <20090518145125.f975ae2b.krzysztof.h1@poczta.fm>
	<20090518.152903.193209423.wl@gnu.org>
	<20090520075138.c8c7d84d.krzysztof.h1@poczta.fm>
	<20090520.082548.01295500.wl@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M6hJm-0001da-SD
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 08:38:30 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M6hJk-0005os-Q6 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 08:38:30 +0000
In-Reply-To: <20090520.082548.01295500.wl@gnu.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Werner LEMBERG <wl@gnu.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 20 May 2009 08:25:48 +0200 (CEST)
Werner LEMBERG <wl@gnu.org> wrote:

> >> I'm doing a git bisect right now to find out why
> >> CONFIG_FB_BOOT_VESA_SUPPORT doesn't work as advertised.
> > 
> > Probably, it does work as supposed to.  The
> > CONFIG_FB_BOOT_VESA_SUPPORT tells Linux to allow VESA modes values
> > for the "vga=" switch.  It also switches on the VESA graphics modes.
> > However, without a framebuffer which makes use of the graphics
> > display (vesafb, intelfb, sisfb) it only garbles screen.
> 
> Well, I use the intelfb driver (CONFIG_FB_INTEL=m), but I get a black
> screen for any VESA mode...
> 

You have to compile it into the kernel image (CONFIG_FB_INTEL=y) 
otherwise no VESA mode is used.

Regards,
Krzysztof

----------------------------------------------------------------------
Zrob sobie prezent. Wygraj nagrode!
Sprawdz >>  http://link.interia.pl/f2176 



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
