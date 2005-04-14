From: Francois <f.taiani@computer.org>
Subject: Re: [CONFIG_FB_NVIDIA] Mirrored characters on
	the console on a G5
Date: Thu, 14 Apr 2005 17:52:31 +0100
Message-ID: <1113497550.9779.13.camel@mac-francois>
References: <1113298311.5465.159.camel@mac-francois>
	 <200504141351.19243.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DM7as-00077Z-Fl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 09:53:30 -0700
Received: from mail.comp.lancs.ac.uk ([148.88.3.45])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DM7aq-0004Ew-Py
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 09:53:30 -0700
In-Reply-To: <200504141351.19243.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Hi Tony,

> Only characters are mirrored, and not the entire row (ie, row starts at the left
> side, and not at the right)?

Only the characters (so I can't look in a mirror and have a "normal" screen :-).

> Can you try fbset -accel false and see if it helps?

Right on the spot! I can now switch between mirrored and not mirrored.

> I think rivafb supports this particular chipset, but without acceleration.

Actually my X display is garbled with rivafb (with which console
characters are fine). With fb_nvidia, X seems to work fine independently
of whether the acceleration is switched on or off (some screen size and
frequency issues needs tuning though).

> If it does, this is a problem with nvidia's imageblit function which converts
> big-endian bitmaps to little endian?  Perhaps the help reverse_order() is not
> needed for your arch.  Can you comment out calls to reverse_order() in
> drivers/video/nvidia/nv_accel.c?

I'll try this and I'll get back to you this the results.

Thanks for your help!

Francois

On Thu, 2005-04-14 at 06:51, Antonino A. Daplas wrote:
> On Tuesday 12 April 2005 17:31, Francois wrote:
> > Dear linux-fbdev team,
> >
> > I've just compiled a new 2.6.12-rc2 kernel for my PowerMac G5. I've got
> > the following problem: I get "reversed" characters on the console if I
> > use CONFIG_FB_NVIDIA in the kernel. For instance, instead of an E, I get
> > a
> >
> > xxx
> >   x
> >  xx
> >   x
> > xxx
> >
> 
> Only characters are mirrored, and not the entire row (ie, row starts at the left
> side, and not at the right)?
> 
> Can you try fbset -accel false and see if it helps?
> 
> If it does, this is a problem with nvidia's imageblit function which converts
> big-endian bitmaps to little endian?  Perhaps the help reverse_order() is not
> needed for your arch.  Can you comment out calls to reverse_order() in
> drivers/video/nvidia/nv_accel.c?
> 
> 
> > Switching CONFIG_FB_NVIDIA off eliminates the problem. My G5 contains a
> > GeForce FX 5200 Nvidia Card.
> 
> I think rivafb supports this particular chipset, but without acceleration.
> 
> Tony



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
