From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] Correct monochrome selection (fwd)
Date: Wed, 23 Oct 2002 16:15:20 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0210231615110.2882-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 184MIC-0004h7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 23 Oct 2002 07:15:28 -0700
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Martin Schulze <joey@infodrom.org>

---------- Forwarded message ----------
Date: Wed, 23 Oct 2002 16:12:39 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Schulze <joey@infodrom.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
     Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Correct monochrome selection

On Sat, 19 Oct 2002, Martin Schulze wrote:
> please apply the patch below which will add proper handling for
> monochrome graphic cards.
> 
> Both changes are required since there are graphic cards out in the
> voi^Wwild that are monochrome but have bits_per_pixel set to something
> else than 1, e.g. PMAG-AA which uses 8 bits per pixel but ignores 7 of
> it.
> 
> Since currently no such card is supported, this change wasn't
> required.  However, we developed support for the PMAG-AA card and we
> would like to add support for it to the Linux kernel, of course.

HP300 TopCat uses a similar scheme, and is supported by Linux/m68k.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds




-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
