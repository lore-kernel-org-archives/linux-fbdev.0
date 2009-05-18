From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: bug #13249 - problem with intelfb on i845gm
Date: Mon, 18 May 2009 14:51:25 +0200
Message-ID: <20090518145125.f975ae2b.krzysztof.h1@poczta.fm>
References: <20090517140249.d3a1888c.krzysztof.h1@poczta.fm>
	<20090518.124818.237161585.wl@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M62Da-00068v-1h
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 May 2009 12:45:22 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M62DW-0005jz-2J for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 May 2009 12:45:22 +0000
In-Reply-To: <20090518.124818.237161585.wl@gnu.org>
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
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 18 May 2009 12:48:18 +0200 (CEST)
Werner LEMBERG <wl@gnu.org> wrote:

> 
> > Could you send to me (or attach to the bugzilla report) output of
> > the dmesg command on the system with the bug?
> 
> Done.
> 

What I see here is that for 2.6.27 you use the VESA framebuffer
while you do not use it for the 2.6.28

Compare your configs:
2.6.27 : CONFIG_FB_VESA=y
2.6.28: # CONFIG_FB_VESA is not set

and messages from the 2.6.27:
<6>vesafb: framebuffer at 0xd0000000, mapped to 0xf8880000, using 5120k, total 7872k
<6>vesafb: mode is 1280x1024x16, linelength=2560, pages=2
<6>vesafb: scrolling: redraw
<6>vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
<4>Console: switching to colour frame buffer device 160x64
<6>fb0: VESA VGA frame buffer device

and nothing like that from the 2.6.28.

My advice is try using the Intel framebuffer (change it to Y not 'M' like module). It should
be faster than VESA on your hardware. Unselect VESA. 

Please report if it works for you after the config change.

Kind regards,
Krzysztof


----------------------------------------------------------------------
Oryginalne przepisy na grilla. Zaskocz swoich gosci!
Sprawdz >>> http://link.interia.pl/f217c





------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
