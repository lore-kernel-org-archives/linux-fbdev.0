From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: s13d...fb fill_rect accel giving wrong color
Date: Sat, 16 May 2009 20:03:57 +0200
Message-ID: <20090516200357.c5b1e27f.kristoffer.ericson@gmail.com>
References: <20090420202243.d1ad7cee.kristoffer.ericson@gmail.com>
	<10f740e80904201208g1df7623ex3c9383d84acf1ce1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1M5O9k-000588-VX
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 16 May 2009 17:58:44 +0000
Received: from fk-out-0910.google.com ([209.85.128.187])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5O9X-0007of-0i for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 16 May 2009 17:58:39 +0000
Received: by fk-out-0910.google.com with SMTP id z23so1117039fkz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 16 May 2009 10:58:29 -0700 (PDT)
In-Reply-To: <10f740e80904201208g1df7623ex3c9383d84acf1ce1@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 20 Apr 2009 21:08:21 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, Apr 20, 2009 at 20:22, Kristoffer Ericson
> <kristoffer.ericson@gmail.com> wrote:
> > My accelerated fill_rect is working nicely apart from the fact that its
> > giving me the wrong colors. For instance mc has its empty spaces
> > being black when they should be blue.Its doesnt show up
> > in pure console but thats probably since its generally black :)
> >
> > Ive added some debugging code to both cfb_fillrect and my routine
> > and its accessing the same pseudo_palette[x] color.
> >
> > cfb_fillrect uses pixel_to_pat() to get its color value. I havent
> > completely understod whats the purpose of it. I cannot push
> > an 32bit value into my color registers since its only 16bit.
> 
> As cfb_fillrect() tries to write using quantities of `unsigned long'
> (either 32 or
> 64 bit), while your pixels are 16 bit, it uses pixel_to_pat() to
> duplicate the 16 bit
> pixel values to fill an `unsigned long' quantity.
> 
> For hardware accelerated fillrect, I'd expect you just have to write
> the 16 bit pixel
> value to your hardware's color register.

Just for future reference. My error was a stupid, I split up the color
into 2 bytes and sent them off individually (color >> 8) && 0xff and
(color && 0xff). As you can see the correct way would have been
(color >> 8) & 0xff and (color & 0xff).

Explains why I got the strange colors I got. I had looked
at it for so long that I was looking in all the wrong
areas.
Works like a charm now.

> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
