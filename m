From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5]: logo fix
Date: Mon, 17 Feb 2003 23:02:04 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0302172301420.25406-100000@vervain.sonytel.be>
References: <1045393909.1214.2.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ktOr-0003xo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Feb 2003 14:06:09 -0800
In-Reply-To: <1045393909.1214.2.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 16 Feb 2003, Antonino Daplas wrote:
> On Sun, 2003-02-16 at 14:08, Antonino Daplas wrote:
> > The attached patch (linux-2.5.61 + James' fbdev.diff) fixes the following:
> > 
> > 1. compile error because of missing scripts/pmntologo.  
> > 
> > 2. Break up of fb_show_logo() to fb_prepare_logo()/fb_show_logo() to fix
> > weird "double drawing" or the "single draw, erase in a flash" of the
> > logo.
> > 
> > 3. Fixed all drivers affected by the (image.depth == 0) is color
> > expansion.
> > 
> 
> Here's an incremental diff to protect logo drawing code with an
> #ifdef CONFIG_FB_LOGO

Note that it's called CONFIG_LOGO now.

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
