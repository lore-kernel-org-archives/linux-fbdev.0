From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: fbcon woes with closed source framebuffer
 kernel module
Date: Mon, 19 Sep 2005 08:31:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0509190830180.10300@numbat.sonytel.be>
References: <196b7d3105091606241b4d2ba4@mail.gmail.com>
 <196b7d310509160927584f8130@mail.gmail.com> <432DF228.8080206@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHFBy-0005E5-HS
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Sep 2005 23:31:54 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EHFBx-0002CE-39
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Sep 2005 23:31:54 -0700
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j8J6Vhva008640
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Sep 2005 08:31:44 +0200 (MEST)
In-Reply-To: <432DF228.8080206@gmail.com>
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

On Mon, 19 Sep 2005, Antonino A. Daplas wrote:
> Lior Balkohen wrote:
> > /tmp > ./fbset -i
> > 
> > mode "720x576-171"
> >     # D: 50.000 MHz, H: 54.825 kHz, V: 170.793 Hz
> >     geometry 720 576 720 576 8
> >     timings 20000 64 64 32 32 64 2
> >     laced true
> >     rgba 8/16,8/8,8/0,8/24
> > endmode
> > 
> > Frame buffer device information:
> >     Name        : Pallas FB
> >     Address     : 0xa0901000
> >     Size        : 2093056
> >     Type        : PACKED PIXELS
> >     Visual      : PSEUDOCOLOR
> >     XPanStep    : 1
> >     YPanStep    : 1
> >     YWrapStep   : 1
> >     LineLength  : 720
> >     Accelerator : No
> 
> I don't think this is correct.  It describes RGBA8888 as
> pseudocolor (indexed palette).  Try doing an fbset -depth 8
> and check the fbset -i output again.  

But the depth is already 8. And this matches with the LineLength and
xres_virtual.

Probably only the rgba bitfields are incorrect.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
