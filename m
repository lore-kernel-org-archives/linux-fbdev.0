From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: stack trace from matrox fb on 2.5.50
Date: Sun, 1 Dec 2002 21:35:40 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212012134540.9729-100000@vervain.sonytel.be>
References: <20021128234024.GA2632@rushmore>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18IapD-0006C8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 01 Dec 2002 12:36:24 -0800
In-Reply-To: <20021128234024.GA2632@rushmore>
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
To: rwhron@earthlink.net
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 28 Nov 2002 rwhron@earthlink.net wrote:
> I saw the call trace below during 2.5.50 boot, but not on:
> 2.5.44-mm5
> 2.5.46-mm1
> 2.5.47-mm1
> 2.5.47-mm2
> 2.5.48-mm1
> 2.5.49
> 2.5.49-mm1
> 
> Invalid vesa mode 0x0000
> matroxfb: Matrox G400 (AGP) detected
> matroxfb: MTRR's turned on
> matroxfb: 1920x1440x8bpp (virtual: 1920x8736)
> matroxfb: framebuffer at 0xD4000000, mapped to 0xf8805000, size 33554432
> Uninitialised timer!
> This is just a warning.  Your computer is OK
> function=0xc01c9050, data=0x0
> Call Trace:
>  [<c011c340>] check_timer_failed+0x40/0x50
>  [<c01c9050>] cursor_timer_handler+0x0/0x30

Yes, the timer initialization was reverted in 2.5.50. Please apply the patch
Mathijs Mohlmann send to this list.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
