From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: bug #13249 - problem with intelfb on i845gm
Date: Wed, 20 May 2009 07:51:38 +0200
Message-ID: <20090520075138.c8c7d84d.krzysztof.h1@poczta.fm>
References: <20090517140249.d3a1888c.krzysztof.h1@poczta.fm>
	<20090518.124818.237161585.wl@gnu.org>
	<20090518145125.f975ae2b.krzysztof.h1@poczta.fm>
	<20090518.152903.193209423.wl@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M6ecM-0007Zu-NQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 05:45:30 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M6ecI-0007LF-0n for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 05:45:30 +0000
In-Reply-To: <20090518.152903.193209423.wl@gnu.org>
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

On Mon, 18 May 2009 15:29:03 +0200 (CEST)
Werner LEMBERG <wl@gnu.org> wrote:

> 
> > What I see here is that for 2.6.27 you use the VESA framebuffer
> > while you do not use it for the 2.6.28
> > 
> > Compare your configs:
> > 2.6.27 : CONFIG_FB_VESA=y
> > 2.6.28: # CONFIG_FB_VESA is not set
> 
> This is intentional.  Reason is that in 2.6.28 option
> `CONFIG_FB_BOOT_VESA_SUPPORT' has been added, and it seems that this
> change introduced a bug.
> 
> > My advice is try using the Intel framebuffer (change it to Y not 'M'
> > like module).  It should be faster than VESA on your hardware.
> > Unselect VESA.
> 
> I'm doing a git bisect right now to find out why
> CONFIG_FB_BOOT_VESA_SUPPORT doesn't work as advertised.
> 
> 

Probably, it does work as supposed to. The CONFIG_FB_BOOT_VESA_SUPPORT
tells Linux to allow VESA modes values for the "vga=" switch. It also switches
on the VESA graphics modes. However, without a framebuffer which makes 
use of the graphics display (vesafb, intelfb, sisfb) it only garbles screen.

Regards,
Krzysztof

----------------------------------------------------------------------
Fantastyczne nagrody do zgarniecia!
Zagraj >> http://link.interia.pl/f2177 



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
