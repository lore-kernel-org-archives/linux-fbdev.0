From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH, 2.4] Add logo drawing support for 8-bit mono
Date: Thu, 1 May 2003 15:19:57 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0305011518360.5297-100000@vervain.sonytel.be>
References: <20030426233557.GF31642@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19BDzo-0006Bi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 May 2003 06:21:09 -0700
In-Reply-To: <20030426233557.GF31642@rembrandt.csv.ica.uni-stuttgart.de>
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
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 27 Apr 2003, Thiemo Seufer wrote:
> this patch adds logo drawing support for mono visuals with 8 bits
> per pixel. The DECstation's PMAG-AA is such a card.
> 
> 2.4 only, the 2.5 logo code is very different.

BTW, does it also work if you write 0xff (i.e. (1<<var.bits_per_pixel)-1)
instead of 1 to the frame buffer? Since this is what 2.5 does/will do.

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
