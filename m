From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: S3Virge fb on PPC?
Date: Thu, 8 Aug 2002 14:16:01 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0208081406410.28174-100000@vervain.sonytel.be>
References: <Pine.GSO.4.43.0208072005010.14939-100000@romulus.cs.ut.ee>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cmDP-0007Ty-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Aug 2002 05:16:32 -0700
In-Reply-To: <Pine.GSO.4.43.0208072005010.14939-100000@romulus.cs.ut.ee>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 7 Aug 2002, Meelis Roos wrote:
> I have a mac (powermac 7300/166 upgraded to G3/280) that has broken
> onboard video (probaly a half-working address bit in its video RAM). The
> computer also has a S3Virge PCI card with fcode so it can boot MacOS
> with it and see the picture.

  [...]

> Also, we seem to have a s3virge framebuffer for Amigas, how difficult
> would it be to port it to PPC+x86 (I have a virge DX on a PC too where I
> would like to see accelerated fb for faster scrolling). I would like to
> do it if I can.

Up to 2.4.18 virgefb relied on the AmigaOS driver to have initialized the card.
Since your ViRGE card has a F-code ROM, adopting virgefb to support it cannot
be very difficult.

In 2.4.19 (and 2.5.x) virgefb can do the initialization itself (that is, on
Amiga CyberVision64/3D cards). What this means for PC cards is unknown, since
they may have been `screwed up' by the VGA BIOS code. For your F-code card it's
probably harmless since OF uses a linear graphics mode.

Conclusion: I'd say it's not that much work. Good luck and enjoy ;-)

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
