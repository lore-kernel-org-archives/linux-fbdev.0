From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] new version ATI Mach64 for Linux-2.6.0-test5
Date: Mon, 22 Sep 2003 09:00:44 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309220859550.4957-100000@vervain.sonytel.be>
References: <200309212057.30272.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1Kh8-00043v-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 00:01:14 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1Kh7-0001uy-Ey
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 00:01:13 -0700
In-Reply-To: <200309212057.30272.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Adam Agnew <agnew@cs.umd.edu>, =?ISO-8859-15?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>, Nicolas Souchu <nsouch@free.fr>

On Sun, 21 Sep 2003, Alexander Kern wrote:
> what's size of LCD of testmachines, where you test? I think, that the my 
> troubles with your clean code is, that you test on notebook with 800x600 or 
> similar. Next smaller resolution is 640x480. It's approximately 80%. And with 
> 800x600, first double scan is 400x300, 50%. It's all simple values.

FYI, My Vaio PCG-Z600TEK has a 1024x768 TFT.

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
