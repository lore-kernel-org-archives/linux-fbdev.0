From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: atyfb: 2.5.54
Date: Tue, 7 Jan 2003 23:15:59 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301072314240.21057-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301072205400.17129-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W225-00083Q-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 14:17:13 -0800
In-Reply-To: <Pine.LNX.4.44.0301072205400.17129-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Nico Schottelius <schottelius@wdt.de>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 7 Jan 2003, James Simmons wrote:
> > Atyfb is known not to work on some Rage Mobility P/M (incl. the one in my Vaio
> > :-(
> 
> A have a few patchs for atyfb that I haven't got around to applying just 
> yet. One is Popov non BIOS patch for some cards. I have another patch for 
> a new DAC for older MACH 64 cards. The big issue I like to see solved is 
> to us ethe hardware cursor. Right now I have it disabled, its using 
> soft_cursor. I haven't had the time to look at teh specs for how the data 
> is layed out for the cursor image. We have in atyfb.h
> 
> struct aty_cursor {
> 	u8 bits[8][64];
> 	u8 mask[8][64];
> 	u8 *ram;
> }
> 
> This is really weird. I like to translate to the new api.

Each pixel in the Mach64 cursor has 4 possible values: transparent, inverting,
color0, or color1. It's size is 64x64, i.e. 64 rows of 8 bits per plane.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
