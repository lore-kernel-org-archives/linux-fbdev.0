From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Linux Intel FB Question
Date: Tue, 15 Apr 2003 10:20:38 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0304151018030.26578-100000@vervain.sonytel.be>
References: <20030415042104.88847.qmail@web41603.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 195LhP-0003fd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Apr 2003 01:21:51 -0700
In-Reply-To: <20030415042104.88847.qmail@web41603.mail.yahoo.com>
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
To: Justin Ducote <justinduc@yahoo.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 14 Apr 2003, Justin Ducote wrote:
> I would like to use the RADEON frame buffer, with
> that said I am restricting this senario to the VESA
> driver ONLY to try and clear up some of my confusion..
> 
> When I boot linux/grub (Redhat 9.0) with the following
> line:
> 
> vga=792
> 
> Everything works great, I get 1024x768x16m and it uses
> the VESA Framebuffer (I think) and everything is
> great. 
> 
> If I try and use this line instead:
> 
> video=vesa:mode:1024x768-24@60
> 
> NOTHING happens.. 
> 
> My understanding was that those two
> lines should yield the exact same result in theory. I
> thought they are doing the same thing but the video
> line does nothing so I am confused and I do not
> understand whats going on. 
> 
> Additionally, 
> I would like to know what is the relationship
> between VGA= and VIDEO= 

`vga=' is a way to tell the early boot code in the kernel (before the actual
Linux kernel is started) to change the video mode using the BIOS.

`video=' is a way to pass initialization parameters to a frame buffer device
driver, or to just specific the default video mode (yes, `video=1024x768-24@60'
is OK).

Since vesafb relies on the BIOS setting up the correct video mode, the second
method won't work with vesafb.

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
