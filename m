From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Restoring Screen when coming back from
	KD_GRAPHICS
Date: Wed, 24 Dec 2003 19:26:19 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1072254378.739.65.camel@gaston>
References: <3FC4603C.2000702@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ4M0-0002gR-BA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 00:26:52 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AZ4Lz-0002tO-Ni
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 00:26:52 -0800
In-Reply-To: <3FC4603C.2000702@undead.cc>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Wed, 2003-11-26 at 19:11, John Zielinski wrote:
> I was playing with the fbtest program and noticed some minor glitches.  
> You could see corruption in the graphics where the console was still 
> trying to output text from the program.  After exiting the program's 
> output would mix in with the saved screen.
> 
> So I modified the fbtest program to do ioctl to KD_GRAPHICS at startup 
> and KD_TEXT on exit and the graphics corruption went away.  I also 
> didn't save/restore the framebuffer if we started in KD_TEXT on entry.  
> This made things worse as now the graphics output was still plus the old 
> text and the programs output would now appear after scrolling one line.
> 
> I checked the kernel to see why the screen wasn't being refreshed when 
> switching back to KD_TEXT.   I found that if the fbdev driver has a 
> blanking routine the fbcon driver doesn't do a update_screen call.  And 
> the fbdev if it's using vesa blanking doesn't restore the screen nor 
> does it return 1 to tell the vt driver to redraw the screen.
>
>.../...

That's an old problem, I think your patch isn't enough though, we really
need to first callback into the fbdev layer with some sort of "restore state"
call so we have a chance to restore the palette and accel engine status
properly (and maybe even the mode).

Basically, when switching to KD_TEXT, we switch from userland having taken
control of the HW (either partially, that is only the accel engine, or
completely including mode setting) back to kernel control. At this point,
we need to restore the HW in a known state, we can't rely on userland to
do it properly (and that's not always possible) while it's very simple
for us to do it from the fbdev.

It's on my todolist of things to fix, but still I lack time, if you feel
like implementing the background (we can fix individual drivers later on)
support for that, go on :)

Regards,
Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
