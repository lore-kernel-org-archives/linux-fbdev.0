From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Thu, 11 Sep 2003 08:03:17 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309110801220.1879-100000@vervain.sonytel.be>
References: <1063212505.642.77.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xKa5-0003vT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 23:05:25 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xKa4-0006Sj-HK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 23:05:25 -0700
In-Reply-To: <1063212505.642.77.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kronos <kronos@kronoz.cjb.net>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 10 Sep 2003, Benjamin Herrenschmidt wrote:
> > It  fails only  if  compiled  as module. I  see  that fb_find_mode  (and
> > my_atoi) are marked  as __init. Maybe they get discarded  after boot and
> > when  radeonfb module  tries  to call  them it  ends  up in  deallocated
> > memory...
> 
> Exactly, they should definitely not be marked __init

That doesn't harm. If MODULE is defined, fb_find_mode() is an inline function
that knows about 640x400@70 only, cfr. <linux/fb.h>.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
