From: Otto Solares <solca@guug.org>
Subject: Re: fbdv/fbcon pending problems
Date: Mon, 23 Feb 2004 20:37:59 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040224023759.GA16499@guug.org>
References: <1077497593.5960.28.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvSaE-0003ui-P1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 18:46:06 -0800
Received: from guug.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvSSH-0001ka-Lq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 18:37:53 -0800
Content-Disposition: inline
In-Reply-To: <1077497593.5960.28.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Mon, Feb 23, 2004 at 11:53:14AM +1100, Benjamin Herrenschmidt wrote:
> Hi !
> 
> Here's a list of pending issues with fbdev (either upstream or in the
> fbdev bk treee), I figured posting it here may help getting more people
> on those issues as my time is sparse and I suppose James too.
> 
>  - First one, I will deal with, just writing it for completeness: When
> switching from KD_GRAPHICS to KD_TEXT (either same console changing mode
> or switching to a different console), we need a callback so the fbdev
> has a chance to restore the accel engine setting (or even the whole
> mode, to be safe).
> 
>  - Memory corruption problems. There is still at least one identified
> when using stty. Just use crazy values, like flipping rows & cols (like
> stty rows 132 cols 30) and usually, you'll see the box blow up very soon
> with heavy memory corruption.
> 
>  - mach64 lockups on LT-G (I'll try on an LT-Pro soon) plus other
> mach64 bugs in the new version in the bk fbdev, I'll have a patch for
> some of the problems, but I didn't find a good explanation for the
> accel lockups yet
> 
>  - Logo problems. When booting with a logo, then going to getty, the
> logo doesn't get erased until we actually switch to another console (or
> reset the console). At this point, using things like vi & scrolling up
> doesn't work properly. Actually, last time I tried, I had to switch
> back & forth twice before my console that had the logo got fully working
> with vi.
> 
>  - Back buffer problem: maybe related to the logo ? After boot, doing
> shift-pageup to go back to the boot message, usually you get crap
> displayed at various places.
> 
>  - On x86, various junk displayed when the fbdev takes over. Reported
> by radeonfb users, I couldn't test myself, I don't have an x86 with
> radeon at hand for the moment. Apparently, the takeover from vgacon
> doesn't properly "convert" the previous VGA text buffer content
> 
>  - stty & mode picking. Currently, fbcon_resize() (called when stty is
> used to resize the console) will hack a "var" strcture by just putting
> new width/height in it and pass that to set_var. The way the various
> drivers react to that mostly broken "var" structure is rather random.
> We need to explicitely differenciate between a mode that is "complete"
> (like what fbset or X passes down the fbdev) or a mode that is just
> width/height and eventually a hint of frequency, like what fbcon passes
> in this case. I added FB_ACTIVATE_FIND for that purpose, but that needs
> better driver support to "pick" up a proper mode. The algorithm for
> that isn't trivial. Could be moved to common code.
> 
>  - fbset doesn't resize the console. I consider that a regression from
> 2.4. I have some code based on the notification mecanism to address
> that, but it tends to trigger the same memory corruption problem as
> reported with stty & bogus coordinates. There is something hairy going
> on with console resizes. That code is a bit foreign to me though.
> 
> Ok, that's all that comes to my mind right now, help is welcome :)

- bus_id for each fbdev, so from userland became posible to identify
  to which card we are controlling.  I know it should be exported via
  sysfs but an ioctl should be really handy as when you program for
  fbdev anyway you have to use ioctl's, just to get the bus_is will
  be a pain use sysfs.

-otto
  


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
