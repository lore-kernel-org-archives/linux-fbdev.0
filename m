From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: aty support
Date: Wed, 4 Dec 2002 10:00:38 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212040958220.3195-100000@vervain.sonytel.be>
References: <20021201213508.GJ338@schottelius.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18JVPH-0003Pl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 04 Dec 2002 01:01:24 -0800
In-Reply-To: <20021201213508.GJ338@schottelius.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 1 Dec 2002, Nico Schottelius wrote:
> I tried to get my notebook running with a framebuffer device,but
> after hours trying around I got only vesa-fb running.

    [...]

> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mob=
ility AGP 2x (rev 64)
> 01:00.0 Class 0300: 1002:4c4d (rev 64)

You may want to try the atyfb patches from Dani=EBl Mantione
<daniel@deadlock.et.tudelft.nl>,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
