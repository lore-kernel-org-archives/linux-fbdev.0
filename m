From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.5.60/atyfb
Date: Mon, 17 Feb 2003 11:43:45 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0302171142480.16817-100000@vervain.sonytel.be>
References: <20030215151128.GA478@schottelius.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kilO-00009a-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Feb 2003 02:44:43 -0800
In-Reply-To: <20030215151128.GA478@schottelius.org>
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
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 15 Feb 2003, Nico Schottelius wrote:
> I retried using atyfb with 2.5.60:
> Afterloading atyfb the only thing left is the cursor.
> i don't see anything else anymore..i see the cursor moving, but that's all.
> btw, i am using a laptop (means lcd)...
> 
> can somebody tell me whether playing around with fbset could make things
> working?
> 
> Nico
> 
> lspci:
> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobility AGP 2x (rev 64)
> 
> dmesg:
> atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL, 230 MHz PLL, 50 Mhz MCLK
> fb0: ATY Mach64 frame buffer device on PCI

Did older versions of atyfb work on this chip? I have the same one in my Vaio,
and so far it never worked with atyfb.

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
