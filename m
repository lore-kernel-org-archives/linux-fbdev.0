From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: radeonfb work (WAS: Merge of Luca and Ben's
	sysfs work for Radeon)
Date: Fri, 26 Sep 2003 20:23:48 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1064600628.631.17.camel@gaston>
References: <20030925060524.24191.qmail@web14909.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2yr4-0008Gp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 26 Sep 2003 13:06:18 -0700
Received: from panoramix.vasoftware.com
	([198.186.202.147] helo=externalmx.vasoftware.com ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A2yr3-0003x6-39
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Sep 2003 13:06:17 -0700
Received: from pentafluge.infradead.org ([213.86.99.235]:32977)
	by externalmx.vasoftware.com with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 4.22 #1 (Debian))
	id 1A2xH2-0002Mx-7P
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 26 Sep 2003 11:25:00 -0700
In-Reply-To: <20030925060524.24191.qmail@web14909.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>, James Simmons <jsimmons@infradead.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-09-25 at 08:05, Jon Smirl wrote:
> Here is a sample of what sysfs looks like with the new radeon driver. I have an
> Intel 875 chipset so there are three buses: 0 - system, 1 - AGP, 2 - PCI. Note
> that the EDID block is available.
> 
> I was thinking about adding these attributes to the fb device: geometry,
> timings, interlaced, hsync, vsync. and then writing a new fbset command.

Note that there are still missing things in this driver. I'm in the
process of reworking more of it, the goal is to make it much closer
to XFree current driver so we have a chance to better deal with
newer cards & some nasty corner cases, and so it becomes easier in
the future to re-integrate XFree originated changes.

James: I'm in bad need of notifying fbcon of resolution changes. For
example, I want to add a switch for mirror on/off that could easily
be tied to the common "mirror" key on laptops (for machines that don't
do that via BIOS horros of course). However, since a bunch of panels
now have resolutions unsuitable for the external CRT, I will probably
change the panel resolution based on the external monitor (using the
scaler) when this key is pressed. For example, titanium powerbooks
with 1152x768 resolutions would switch to 1024x768 when mirroring
to a CRT...
 
I'm not too sure yet in fact about how to deal with this whole API. The
current set_var doesn't seem to bad if we can add a few flags to it,
like indicating a mirrored mode... The best way may be to add such a flag
to the modes in a mode list indicating "mirrorable" modes (fitting both
displays). The user would see that flag when retreiving the mode list
via /sys or whatever and would pass "mirror" flag to set_var when picking
one of these 'mirrored' modes...

I also want to let the user go up in resolutions when disabling the internal
LCD etc... MacOS lets you diable the LCD if have the laptop lid closed when
waking the machine up from sleep (with an external kbd), though I'm not sure
what is the best way to deal with that with radeonfb.

All that means I'll have actions on ioctl and/or sysfs that will trigger
mode changes and we want fbcon to adapt.

However, we also need a way to notify userland client apps (and maybe a
way for those to "lock" changes, but I don't like that much). That must be
done, I think, in a way similar to console switch: First notify of a
pending event, then wait for the userland app to acknowledge the change.
Not doing so would cause a lot of problems with userland apps tapping the
engine.

Any ideas welcome, I'm still trying to figure out what would be the best
API for those things. We can think about it now, just defining new flags,
ioctls and/or /sys entries won't harm compatibility or stability regarding
current 2.6 "code freeze". Since most of these "features" would then be
implemented on a per-driver basis, it will be up to the various driver
maintainers to deal with avoiding regressions (rather easy with radeonfb
seeing how bad the older versions of this driver worked on most recent hw)

Ben.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
