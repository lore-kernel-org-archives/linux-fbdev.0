From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Tue, 9 Sep 2003 22:59:17 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309092258330.3869-100000@waterleaf.sonytel.be>
References: <1063136237.639.42.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wpdV-0001Dj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 14:02:53 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wpdU-0002pj-NY
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 14:02:53 -0700
In-Reply-To: <1063136237.639.42.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kronos <kronos@kronoz.cjb.net>, James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 9 Sep 2003, Benjamin Herrenschmidt wrote:
> On Tue, 2003-09-09 at 21:24, Kronos wrote:
> > +static struct class fb_class = {
> > +	.name		= "video",
> 
> I'd rather use "display" here. "video" is too broad and will cause
> confusion with multimedia stuff.

Exactly my comment. I was thinking about `graphics' instead of `video', but
indeed `display' sounds better.

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
