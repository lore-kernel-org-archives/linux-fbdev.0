From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Reworking sysfs attributes for fbdev
Date: Tue, 15 Mar 2005 14:49:59 +0800
Message-ID: <200503151449.59874.adaplas@hotpop.com>
References: <200503111331.41352.ajax@nwnk.net> <9e473391050314091173cfbd0d@mail.gmail.com> <9e47339105031419437348829a@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DB5sb-0008IV-Do
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 22:50:13 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DB5sZ-0002fu-I9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 22:50:13 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A9E1814BB91C
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 06:49:59 +0000 (UTC)
In-Reply-To: <9e47339105031419437348829a@mail.gmail.com>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>, dri-egl@lists.freedesktop.org

On Tuesday 15 March 2005 11:43, Jon Smirl wrote:
> Some discussion on the dri-egl list points out that the new mode
> setting sysfs attributes for fbdev are too limited. Below is a
> proposal I made on the dri-egl list.
>
> To implement this for fbdev I need to know the right set of of
> attribute value pairs. Some obvious ones are:
>
> name=string
> width=number
> height=number
> depth=number
> refresh=number
> interlace= yes | no | double
> type = detailed|standard|vesa|user
> sync = horizonatal_high | vertical_high | external | composite |
> broadcast | green
> left=number
> right=number
> lower=number
> upper=number
> hsync=number
> vsync=number
> pixclock=number
>
> Right now fb0/modes is set by passing in an array of fb_videomode
> structs. To convert this to attribute value pair I needs the full set
> so that no info is lost.
>
> If the mode and depth are independent variables we can end up with a
> combo that exceeds monitor or hardware bandwidth. Would it be better
> to combine the depth into the modes list? or if you try to set a

We can do that, vesa's mode id's are like that. Although I prefer that mode
setting should be separated from the framebuffer format setting (ie, depth), it's
currently difficult to make this work safely the reason being that not all
check_var() functions can be relied upon.

> mode/depth that has too much bandwidth just select a lower bandwidth
> mode automatically?

It is hard to determine if the mode/depth combination is illegal unless
the check_var() function, as mentioned, can be relied upon.

> Adding the depth to the modelist will triple the
> number of entries.

That is the downside. Plus, combining parameters that describe the
display with those that describe the framebuffer seems ugly to me.

Also, depth might not be a good enough descriptor. We can have
ARGB1555/RGB565 (depth = 16),  ARGB8888/ARGB2101010 (depth 32).
Then you have directcolor, truecolor, pseudocolor.  To fully describe
a modeline, one just have to look at VESA's modeinfoblock structure to
see how complicated this can be.

>
> Now that an attribute/value pair scheme has been proposed I like it a
> lot better than what I implemented.
>
> ---------- Forwarded message ----------
> From: Jon Smirl <jonsmirl@gmail.com>
> Date: Mon, 14 Mar 2005 12:11:52 -0500
> Subject: Re: Native surface creation
> To: Brian Paul <brian.paul@tungstengraphics.com>
> Cc: dri-egl@lists.freedesktop.org
>
>
> On Mon, 14 Mar 2005 09:03:45 -0700, Brian Paul
>
> <brian.paul@tungstengraphics.com> wrote:
> > It's clear that you're working at a lower level of implementation
> > detail than I am in trying to specify an EGL API extension.
>
> I'm working right at the hardware implementing the modesetting.
>
> A major thing being fixed is to allow normal users to set modes
> without being root. Writing arbitrary modelines let you burn up
> monitors so it has to be a root operation. To get around the need to
> be root a fixed list of modes is exposed and you have to choose from
> the list.
>
> Right now the interface for this is very human readable in sysfs:
> cat /sys/class/graphics/fb0/modes  --- list of mode names in human readable
> form echo name >/sys/class/graphics/fb0/mode -- set one of the modes from
> the list
>
> This is in current linus bk and it works with fbcon but it isn't
> machine friendly, it relies on the human to know what the mode names
> mean.
>
> I could alter the attributes to work like this:
>
> echo "width=1000, height=800, depth=32" >/sys/class/graphics/fb0/mode
> would pick the closest mode and set it

The refresh rate can also be added.  If the refresh rate is not specified, choose
the highest refresh. We already have a function for this:

fb_find_nearest_mode()
 
>
> echo "HDTV 1080i" >/sys/class/graphics/fb0/mode
> would search the names since there is no equal sign.
>
> cat /sys/class/graphics/fb0/mode
> name="HDTV 720P", width=1024, height=720, depth=32, interlace=no,
> refresh=60

Yep, this is more descriptive.  Or just include the entire set of timings
(ala X modeline), but one may argue that this is too much data.
 
Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
