From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Thu, 17 Feb 2005 21:59:33 -0500
Message-ID: <9e473391050217185912a7d3d7@mail.gmail.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com>
	 <200502172150.16256.adaplas@hotpop.com>
	 <9e47339105021712494955212d@mail.gmail.com>
	 <200502180804.46005.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1yMi-0002ow-EF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 18:59:36 -0800
Received: from rproxy.gmail.com ([64.233.170.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D1yMh-0001jI-0o
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 18:59:36 -0800
Received: by rproxy.gmail.com with SMTP id z35so538584rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 18:59:33 -0800 (PST)
In-Reply-To: <200502180804.46005.adaplas@hotpop.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@www.infradead.org>

On Fri, 18 Feb 2005 08:04:46 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> This is dangerous.  For one, if the mode in info->var does not match any of
> the entries in the modelist, you can get a screwed up display.  Secondly,
> fbcon refers to info->modelist to store settings for each console.  Thus
> it is better to check first if the mode in the modelist is currently in use.
> 
> A safer way is to loop through each entries of the old modelist, call
> fb_set_var() with the FB_ACTIVATE_INV_MODE set in var->activate. This
> process will safely remove each mode from the modelist.  Not all entries
> will be deleted of course. After that, loop through each entries of the new
> modedb array, and use fb_add_videomode() to add each entry to the modelist.

Radeon hardware has an interrupt that is not hooked up in radeonfb
that can tell if the monitor has been switched. Hook a radeon to a KVM
switch and flip the switch. We should get an interrupt. Use the
interrupt to trigger a hotplug event. Hotplug event will set a new
list of modes into radeonfb. All of the old modes have to be deleted,
they probably don't exist in the new monitor.

At this point fbcon needs to get a modelist change event. It can then
find_mode() to find a new mode that is close to what it was using. So
the problem seems to be that disp->mode holds a pointer to the mode
instead of a copy of the mode. I'll try changing this to a copy. Does
fbcon really need to know the entire mode structure or could it work
with just the resolution?

I'd feel more comfortable if fbcon used a well defined interface to
fbdev instead of having access to all of fbdev's internal structures.
I tried modifying fbcon to use DRM but it is completely tied to fbdev.
Anyway, the current code is much better than it was in 2.4.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
