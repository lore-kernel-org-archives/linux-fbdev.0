From: John Zielinski <grim@undead.cc>
Subject: Re: fbdev upstream
Date: Wed, 24 Dec 2003 19:45:27 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FEA3327.6050507@undead.cc>
References: <3FD6C52C.7090906@undead.cc>  <3FDBB97F.4070207@undead.cc>	 <1072254049.739.61.camel@gaston>  <3FE9F9C3.20605@undead.cc> <1072305777.15461.13.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZJdK-0001Se-8l
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 16:45:46 -0800
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZJdJ-00027q-P8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 16:45:45 -0800
In-Reply-To: <1072305777.15461.13.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>The idea is that fbcon will use FB_ACTIVATE_FIND instead of
>FB_ACTIVATE_TEST, which I defined to be "pick a mode suitable for the
>display based solely on xres/yres). In radeonfb, when you enable the
>DDC2/EDID support, I use the modedb I build from the monitor datas
>and I fallback to VESA modes (along with dealing with the fact that an
>LCD with a scaler can do pretty much anything).
>  
>

That's my ultimate goal.  There's a couple of things I'm working on to 
make that more robust.   The DDC2/EDID works great, as long as my KVM is 
selecting that machine while it boots.   There's also three seperate 
lists of video modes.  Two in the kernel which are the regular and vesa 
lists and the modedb that fbset uses.  What I want to eventually do is 
consolidate all that information along with custom timing modes and 
corrections to the DDC2 info based on monitor model and move that all to 
userspace.   Then a script called on startup/shutdown/manually can take 
that database along with the current EDID and archive it into a 
intiramfs file fragment (you can concatenate a bunch together and the 
kernel will unpack them all).  When the kernel boots it can access this 
information and pull in what it needs for the current card & monitor 
combo.  Then it can delete the file from the initramfs to free memory or 
we can use my patch that makes initramfs swappable.

>It sort-of work (except for stty at this point), you can play with it,
>I pushed to my bk tree (using my earlier fb_client stuff, not the new
>gfx_client, which is the smae thing renamed in a way I don't like and
>I prefer individual functions in "ops" structure rather than one with
>a selector).
>  
>

I'll grab a copy and take a look.

>Heh, come back to what we had in 2.4 ? :)
>
>That do make some sense though, provided those are hosted entirely by
>fbcon and aren't visible to fbdev's themselves.
>  
>

Yes.  I'm putting this into fbcon.  I agree that having the common stuff 
concentrated in one spot is better that having it scattered amongst all 
the drivers.  Much cleaner and less maintenance problems.

>I don't know about that one. It would be interesting to redo some
>comparison between XFree CVS "nv" driver and rivafb.
>

I though I read on the list somewhere that someone already fixed the 
nvidia hw cursor problem.  I'll have to do a search for it.

>Something else I noticed: After playing with resize & console switches
>for a while, I had the kernel oops somewhere with this code path:
>
>sys_write -> vfs_write -> pipe_write -> __wake_up -> __wake_up_common
>then jumping to random place.
>  
>

I noticed some strangeness like that as well depending how it took to do 
the video mode switch.  The radeonfb driver does a yield call or 
something (can't remember at the top of my head) and if a timer kicks in 
it complains about "schedule while atomic".  The resize loop problem 
also triggered various oops.  A lot of stuff went away with that call to 
do_blank_screen(1) I put in as it shuts down the cursor timer and puts a 
few other things on hold.  I think a mechanism that would replace that 
do_blank_screen(1) functionality between the vt code, fbcon and fbdev 
layers that can be initiated from any of the three is needed.  That way 
if any one of the three layers needs to do something it can tell the 
other two to suspend operations until it's finished.

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
