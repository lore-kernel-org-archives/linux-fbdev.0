From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdev upstream
Date: Thu, 25 Dec 2003 09:42:58 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1072305777.15461.13.camel@gaston>
References: <3FD6C52C.7090906@undead.cc>  <3FDBB97F.4070207@undead.cc>
	 <1072254049.739.61.camel@gaston>  <3FE9F9C3.20605@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZHj6-0006wa-7E
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 14:43:36 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AZHj5-0007ou-Db
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 14:43:35 -0800
In-Reply-To: <3FE9F9C3.20605@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-12-25 at 07:40, John Zielinski wrote:
> Benjamin Herrenschmidt wrote:
> 
> >Good catch. I merged that in my tree (I use a different version of
> >the client notification mecanism though, I don't like much the
> >version that James pushed).
> >  
> >
> 
> Yeah.  That has caused a lot of headaches for me as well.  The fact that 
> a vt row/col change triggers a fb resolution change which calls the vt  
> resize routine again is just begging for an infinite loop.  Just one 
> calculation mistake of just one pixel in one of  a dozen equations will 
> trigger this loop.  That's what the above bug does as well.  The other 
> major problem with it is that it only changes var.xres and var.yres and 
> none of the other timings so the monitor won't sync anymore.

Yes, that's fucked up from the very beginning. I've started working on
a fix for that in my tree. stty doesn't work yet but fbset works again,
but that require proper support from the fbdev's.

The idea is that fbcon will use FB_ACTIVATE_FIND instead of
FB_ACTIVATE_TEST, which I defined to be "pick a mode suitable for the
display based solely on xres/yres). In radeonfb, when you enable the
DDC2/EDID support, I use the modedb I build from the monitor datas
and I fallback to VESA modes (along with dealing with the fact that an
LCD with a scaler can do pretty much anything).

It sort-of work (except for stty at this point), you can play with it,
I pushed to my bk tree (using my earlier fb_client stuff, not the new
gfx_client, which is the smae thing renamed in a way I don't like and
I prefer individual functions in "ops" structure rather than one with
a selector).

Of course, that means we'll have to update more drivers, and platforms
with fixed display, like embedded etc... will need some way to deal
with that properly in their drivers.

> One item on my to do list is to make a separate fb_var_screeninfo for 
> each vt so that we know what mode to switch back to when we switch vt's 
> or come back from X or a fb graphical program.

Heh, come back to what we had in 2.4 ? :)

That do make some sense though, provided those are hosted entirely by
fbcon and aren't visible to fbdev's themselves.

> >Since James vanished, I intend to take the most obvious bug fixes
> >and driver updates from his tree into mine, test them, and then
> >submit them one by one to Andrew Morton for 2.6.x inclusion.
> >  
> >
> 
> I'll keep posting any bugs I discover.  Maybe you can post a message 
> here whenever you've got a new version to test so that the other testers 
> on the list and myself can try it out.  I'm running fbcon on the radeon 
> machine but I went back to VGA for the nvidia machines as the hardware 
> cursor bug makes it unusable for any kind of text editing work.  I'll 
> switch back on those machines when that bug is squashed.

I don't know about that one. It would be interesting to redo some
comparison between XFree CVS "nv" driver and rivafb. I don't have any
nvidia HW at hand for now though. (I do have a GeForceIIMX AGP somewhere
in a box, but I don't have an AGP slot machine that can grok it, so far
I only have laptops, PCI-only old boxes and a G5 which wants 3.3V cards
only afaik)
 
> >I do not intend, at least in a first step, to take the sysfs
> >stuffs as the structure lifetime changes are fairly invasive and
> >happened to break a bunch of things. Once all the rest is merged
> >up, we can look into it again in more detail, isolated from the
> >other bunch of changes.
> >  
> >
> 
> Agreed.  Let's get what we have rock solid before we try to break it 
> again.  :)

Something else I noticed: After playing with resize & console switches
for a while, I had the kernel oops somewhere with this code path:

sys_write -> vfs_write -> pipe_write -> __wake_up -> __wake_up_common
then jumping to random place.

Not sure at this point what's up, it happened when switching back to
X gdm screen. I don't know if it's a latent 2.6.0 kernel bug, but it
happened fairly quickly after playing with fbdev, at this point I
wonder if there isn't some memory corruption going on. Part of the
problem is that we may do printk's in the middle of vc_resize among
other things, and I suppose that isn't totally safe.

Also, we just completely lack proper locking, we should at least take
the console semaphore around all these operations, which we don't do
and thus are racy as hell... the HW cursor and blanking timers are
by definition racy too, we need to fix that some way.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
