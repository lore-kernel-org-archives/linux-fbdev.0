From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Linux Intel FB Question
Date: Tue, 15 Apr 2003 13:29:47 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0304151329130.26578-100000@vervain.sonytel.be>
References: <20030415112000.GA6351@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 195Odx-0005ei-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Apr 2003 04:30:29 -0700
In-Reply-To: <20030415112000.GA6351@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Justin Ducote <justinduc@yahoo.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 15 Apr 2003, Sven Luther wrote:
> On Tue, Apr 15, 2003 at 01:09:12PM +0200, Geert Uytterhoeven wrote:
> > On Tue, 15 Apr 2003, Justin Ducote wrote:
> > > And is it possible to use vga= and video= together? 
> > > 
> > > video=radeonfb and then vga=792 
> > 
> > I don't think that's very useful.
> 
> Its not possible to have vesafb on one card and anothe fb on anther card
> then ?

Yes, that should be possible. As long as the vesafb one is the primary one.

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
