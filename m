From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Thu, 8 May 2003 07:33:26 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0305080731520.12135-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0305072107440.6566-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19De3A-0008Bt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 May 2003 22:34:36 -0700
In-Reply-To: <Pine.LNX.4.44.0305072107440.6566-100000@phoenix.infradead.org>
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
Cc: Christopher Hoover <ch@murgatroid.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 7 May 2003, James Simmons wrote:
> > Personally, I think it wouldn't harm to be make the cfb* routines generic, so
> > you can set some defines and #include them to tailer them to your card's
> > needs.
> > 
> > Even on some 64-bit platforms, you may not want to use 64-bit accesses, e.g.
> > because your graphic's card bus is still only 32-bit.
> > 
> > I can even think of some more sofistication: on older Amigas, the graphics RAM
> > is 16-bit wide and quite slow, while the CPU is 32-bit. So it may make sense to
> > always use 32-bit accesses (like is currently done), except for the first and
> > last unaligned accesses if they are less or equal than 16-bit.
> 
> I have put alot of though and even tested some raw code for this. The 
> issue with just replacing the FB_WRITE and FB_READ stuff is more than one 
> card could be present and each would require a different FB_WRITE. This 
> would conflict. So what do we do? Ah the answer is use struct pixmap to 

It would not conflict with multiple cards, since if you set some defines and
#include the cfb* sources, you would get routines with slightly different
names, cfr. Christopher's approach.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
