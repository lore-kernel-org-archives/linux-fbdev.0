From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: how to activate X with famebuffer
Date: Mon, 27 Sep 2004 13:20:37 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0409271318500.15815@waterleaf.sonytel.be>
References: <4EE0CBA31942E547B99B3D4BFAB34811107FC2@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBtYg-0006Q5-E3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 04:20:42 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CBtYe-0007BT-ND
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 04:20:42 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i8RBKbMp008873
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Sep 2004 13:20:37 +0200 (MEST)
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811107FC2@mail.esn.co.in>
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

On Mon, 27 Sep 2004, Mukund JB. wrote:
> > which means that I have one framebuffer unit available.
> > 
> > Then, have a look at man fbdev. Specifically, the Driver line in your
> > device section should be
> > 
> > Driver "fbdev"
> This statement will load the default framebuffer driver which comes with
> XFree86 package. Xorg also provides a GENERIC framebuffer driver i.e.
> fbdev.
> This works on my system. I have no probelsm with this.
> But my requirement is to activate X on rivafb (Nvidia CARD SPECIFIC
> DRIVER) module.

Indeed, `Driver "fbdev"' gives you the generic (unaccelerated) fbdev driver in
X.

> > There should be another way. Set
> > 
> > Driver "nv"
> I think, saying so in XF86Config file will not activate X based on the
> framebuffer driver. This works on my system even when I have not loaded
> the rivafb (Nvidia card specific driver) module.
> Even if the rivafb module is loaded, it is not invoked at startx (debug
> message are not appearing ). I think, this edition of XF86Config file
> will activate a normal video driver but not framebuffer driver.
> 
> > (for nvidia cards, including riva ones) and set
> > 
> > Option "UseFBDev" "on"
> > 
> I don't why to use this? If u know please provide with the info

`Driver "nv"'  will give you the accelerated Nvidia driver. But by default `nv'
doesn't use the fbdev API. So in addition you have to set
`Option "UseFBDev" "on"', so `nv' knows it has to use the fbdev API for mode
switching.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
