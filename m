From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Sun, 12 Jun 2005 09:43:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0506120942100.11197@numbat.sonytel.be>
References: <9e47339105061021571f479b10@mail.gmail.com> 
 <Pine.LNX.4.62.0506112234430.22598@numbat.sonytel.be>
 <9e4733910506111501199d172f@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DhN8G-0000SF-4Q
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Jun 2005 00:43:48 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DhN8E-0006aE-Gq
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Jun 2005 00:43:48 -0700
In-Reply-To: <9e4733910506111501199d172f@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@pentafluge.infradead.org>

On Sat, 11 Jun 2005, Jon Smirl wrote:
> On 6/11/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > This patch corrupts some comments in drivers/video/amifb.c.
> 
> This should fix it. I touched up a few other places with unintended

Thx!

> changes. I don't think all of the fbdev files have been authored using
> the same codepage.

The original ones were ISO-8859-1 or -15 (anyone who puts EURO-signs in GPLed
source code? :-). But these days the preferred encoding is UTF-8.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
