From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: ioremap problem on highmem
Date: Tue, 14 Oct 2003 10:30:49 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310141028200.8202-100000@waterleaf.sonytel.be>
References: <20031014015656.GE454@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9KZz-0004rO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Oct 2003 01:30:55 -0700
Received: from [80.88.36.193] (helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9KZy-0003At-UK
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Oct 2003 01:30:55 -0700
In-Reply-To: <20031014015656.GE454@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 13 Oct 2003, Otto Solares wrote:
> On Mon, Oct 13, 2003 at 05:46:51PM -0700, Jon Smirl wrote:
> > Right now I am exploring this alternative:
> > 1) System boots using VGA mode or whatever BIOS provides.

Which may be nothing, or a frame buffer...

> I think you are talking x86 specific, i currently use sparc and powerpc too,
> for sparc i use dummycon and works nicely, i have not tried dummycon in
> powerpc but i assume it should work, so i assume you are talking something
> so simple and dumb like dummycon in this point.

dummycon is used on all architectures that don't have VGA, since the console
subsystem is initialized before the fbdev subsystem, so we need a dummy console
driver to keep the console subsystem happy, until we have a real console
driver.

BTW, changing the initialization order is not acceptable, since VGA people want
to see output as early as possible.

I'm afraid this reasoning also speaks against your proposition, since we would
need userspace to see any kernel messages, which is quite inconvenient if
anything goes wrong...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
