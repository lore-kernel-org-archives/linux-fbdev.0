From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: s13d...fb fill_rect accel giving wrong color
Date: Mon, 20 Apr 2009 21:08:21 +0200
Message-ID: <10f740e80904201208g1df7623ex3c9383d84acf1ce1@mail.gmail.com>
References: <20090420202243.d1ad7cee.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1Lvyqx-0005L9-5E
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Apr 2009 19:08:27 +0000
Received: from mail-ew0-f169.google.com ([209.85.219.169])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lvyqt-0003xx-Mp for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Apr 2009 19:08:27 +0000
Received: by ewy17 with SMTP id 17so1927587ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 20 Apr 2009 12:08:21 -0700 (PDT)
In-Reply-To: <20090420202243.d1ad7cee.kristoffer.ericson@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Apr 20, 2009 at 20:22, Kristoffer Ericson
<kristoffer.ericson@gmail.com> wrote:
> My accelerated fill_rect is working nicely apart from the fact that its
> giving me the wrong colors. For instance mc has its empty spaces
> being black when they should be blue.Its doesnt show up
> in pure console but thats probably since its generally black :)
>
> Ive added some debugging code to both cfb_fillrect and my routine
> and its accessing the same pseudo_palette[x] color.
>
> cfb_fillrect uses pixel_to_pat() to get its color value. I havent
> completely understod whats the purpose of it. I cannot push
> an 32bit value into my color registers since its only 16bit.

As cfb_fillrect() tries to write using quantities of `unsigned long'
(either 32 or
64 bit), while your pixels are 16 bit, it uses pixel_to_pat() to
duplicate the 16 bit
pixel values to fill an `unsigned long' quantity.

For hardware accelerated fillrect, I'd expect you just have to write
the 16 bit pixel
value to your hardware's color register.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
