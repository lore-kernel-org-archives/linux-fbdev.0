From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 11:39:24 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0207051138380.23857-100000@vervain.sonytel.be>
References: <20020705100937.C23355@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QPZY-0006df-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 02:40:16 -0700
In-Reply-To: <20020705100937.C23355@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: James Simmons <jsimmons@transvirtual.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 5 Jul 2002, Russell King wrote:
> On Fri, Jul 05, 2002 at 10:53:35AM +0200, Geert Uytterhoeven wrote:
> > If you have an `asymmetric' dual-head chipset (both heads are not independent,
> > and/or have different capabilities), you'll have 2 info structures, with one
> > shared par. So info and par cannot be combined.
> 
> That may be true for such systems.  I don't believe in imposing such
> restrictions on drivers that can _never ever_ fall into that category.

Then just store your par in your info.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
