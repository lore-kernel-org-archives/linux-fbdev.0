From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Fri, 18 Feb 2005 15:31:04 +0800
Message-ID: <200502181531.05517.adaplas@hotpop.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com> <200502180804.46005.adaplas@hotpop.com> <9e473391050217185912a7d3d7@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D22bk-0007b4-Vy
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 23:31:24 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D22bj-0001h0-97
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 23:31:24 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id EAE9DE6A64B
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Feb 2005 07:31:08 +0000 (UTC)
In-Reply-To: <9e473391050217185912a7d3d7@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@www.infradead.org>

On Friday 18 February 2005 10:59, Jon Smirl wrote:
> On Fri, 18 Feb 2005 08:04:46 +0800, Antonino A. Daplas
>
> <adaplas@hotpop.com> wrote:
> > This is dangerous.  For one, if the mode in info->var does not match any
> > of the entries in the modelist, you can get a screwed up display. 
> > Secondly, fbcon refers to info->modelist to store settings for each
> > console.  Thus it is better to check first if the mode in the modelist is
> > currently in use.
> >
> > A safer way is to loop through each entries of the old modelist, call
> > fb_set_var() with the FB_ACTIVATE_INV_MODE set in var->activate. This
> > process will safely remove each mode from the modelist.  Not all entries
> > will be deleted of course. After that, loop through each entries of the
> > new modedb array, and use fb_add_videomode() to add each entry to the
> > modelist.
>
> Radeon hardware has an interrupt that is not hooked up in radeonfb
> that can tell if the monitor has been switched. Hook a radeon to a KVM
> switch and flip the switch. We should get an interrupt. Use the
> interrupt to trigger a hotplug event. Hotplug event will set a new
> list of modes into radeonfb. All of the old modes have to be deleted,
> they probably don't exist in the new monitor.
>

Just trying to point out that destroying the modelist is not entirely safe.

> At this point fbcon needs to get a modelist change event. It can then
> find_mode() to find a new mode that is close to what it was using. So
> the problem seems to be that disp->mode holds a pointer to the mode
> instead of a copy of the mode. I'll try changing this to a copy. Does

Whether it's a copy or a pointer does not matter anyway, because fbcon
still need to resize each console using the new modelist.

> fbcon really need to know the entire mode structure or could it work
> with just the resolution?

fbcon only needs xres, yres, vxres and vyres.  But in order to preserve
the graphics state per console, everything in var is required.

>
> I'd feel more comfortable if fbcon used a well defined interface to
> fbdev instead of having access to all of fbdev's internal structures.

The 2.6 code is already a big step compared to 2.4, and most of the bugs
plaguing fbcon/fbcore has been ironed out.  I don't want a new interface
again until after things settle down a bit more and drivers get updated to
the new core.

Anyway, you can code the part where a new modelist is to be created.  Then
send an event that the entire modelist is to be changed, passing the fb_info
structure and the new modelist.  fbcon captures the event (and I'll code
this part where fbcon starts using the new modelist and resizes each
console).  After which, the old modelist can be destroyed. 

Sample code:

struct fb_event event;

/* create new_modelist */
event.info = info;
event.data = new_modelist;
notifier_call_chain(&fb_notifier_list, FB_EVENT_NEW_MODELIST, &event);
/*destroy old_modelist */

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
