From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: s13d...fb fill_rect accel giving wrong color
Date: Tue, 21 Apr 2009 15:36:12 +0200
Message-ID: <20090421153612.22c15f60.kristoffer.ericson@gmail.com>
References: <20090420202243.d1ad7cee.kristoffer.ericson@gmail.com>
	<10f740e80904201208g1df7623ex3c9383d84acf1ce1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1LwGLh-0008F4-R3
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Apr 2009 13:49:21 +0000
Received: from mail-fx0-f177.google.com ([209.85.220.177])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LwGLY-0006Ki-NS for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Apr 2009 13:49:21 +0000
Received: by fxm25 with SMTP id 25so2606071fxm.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 21 Apr 2009 06:41:55 -0700 (PDT)
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

Ah, thats about what I guessed.

> 
> For hardware accelerated fillrect, I'd expect you just have to write
> the 16 bit pixel
> value to your hardware's color register.

I tried that, it works well in console (probably due because it always writes black),
in mc though instead of filling the "empty" spaces with blue it fills them with
black. cfb_fillrect does not have this issue. Got any idea where I could look?

Im basicly down to either rect->color being wrong or that Im writing
to the wrong location (which would be odd since everything looks okey
aside from the color). *shrug*

I also created an copyarea function which works perfectly fine.

Any guesses are helpful at this point.




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
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
