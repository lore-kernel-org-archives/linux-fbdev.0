From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Reworking sysfs attributes for fbdev
Date: Tue, 15 Mar 2005 09:55:20 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503150954500.30569@numbat.sonytel.be>
References: <200503111331.41352.ajax@nwnk.net> <9e473391050314091173cfbd0d@mail.gmail.com>
 <9e47339105031419437348829a@mail.gmail.com> <200503151449.59874.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DB7qL-0007Y1-8C
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 00:56:01 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DB7qK-000705-8f
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 00:56:00 -0800
In-Reply-To: <200503151449.59874.adaplas@hotpop.com>
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
Cc: Jon Smirl <jonsmirl@gmail.com>, dri-egl@lists.freedesktop.org

On Tue, 15 Mar 2005, Antonino A. Daplas wrote:
> On Tuesday 15 March 2005 11:43, Jon Smirl wrote:
> > Some discussion on the dri-egl list points out that the new mode
> > setting sysfs attributes for fbdev are too limited. Below is a
> > proposal I made on the dri-egl list.
> >
> > To implement this for fbdev I need to know the right set of of
> > attribute value pairs. Some obvious ones are:
> >
> > name=string
> > width=number
> > height=number
> > depth=number
> > refresh=number
> > interlace= yes | no | double
> > type = detailed|standard|vesa|user
> > sync = horizonatal_high | vertical_high | external | composite |
> > broadcast | green
> > left=number
> > right=number
> > lower=number
> > upper=number
> > hsync=number
> > vsync=number
> > pixclock=number
> >
> > Right now fb0/modes is set by passing in an array of fb_videomode
> > structs. To convert this to attribute value pair I needs the full set
> > so that no info is lost.
> >
> > If the mode and depth are independent variables we can end up with a
> > combo that exceeds monitor or hardware bandwidth. Would it be better
> > to combine the depth into the modes list? or if you try to set a
> 
> We can do that, vesa's mode id's are like that. Although I prefer that mode
> setting should be separated from the framebuffer format setting (ie, depth), it's
> currently difficult to make this work safely the reason being that not all
> check_var() functions can be relied upon.

So should we separate into geometry, timings, visual (cfr. fbutils)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
