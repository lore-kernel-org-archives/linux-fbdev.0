From: Antonino Daplas <adaplas@pol.net>
Subject: Re: waitretrace available?
Date: 11 Jan 2003 19:57:47 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042286265.955.66.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301111316070.12383-100000@zenon.ceid.upatras.gr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XKR0-00079M-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 04:08:18 -0800
In-Reply-To: <Pine.GSO.4.21.0301111316070.12383-100000@zenon.ceid.upatras.gr>
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
To: Xanthakis Stelios <sxanth@ceid.upatras.gr>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-01-11 at 19:21, Xanthakis Stelios wrote:
> 
> Is there WAITRETRACE available in fb?
> 
> It seems that there used to be because svgalib sais:
> 
> 	static void fbdev_waitretrace(void)
> 	{
> 		/* This is from SDL */
> 	#ifdef FBIOWAITRETRACE
> 		ioctl(console_fd, FBIOWAITRETRACE, 0);
> 	#endif
> 	}
> 

There is an FBIO_GETVBLANK that gives information on the current status
of the display (such as if it's currently in hsync/vsync, the current
vsync count since boot etc).  However, only matroxfb implements this
ioctl.

There is an unofficial patch (also for matroxfb), FBIO_VSYNCIRQ, which
waits for the retrace by sleeping on a vsync interrupt.  

> But I can't find such a value in the headers.
> Seems like WAITRETRACE call is implemented in svga by:
> 
> 	while (!(inb(0x3da) & 8));
> 	while (inb(0x3da) & 8);
> 
> 
> *I know very little on how video hardware works*
>

It's a standard polling code for waiting for the retrace interval on VGA
hardware.  Most graphics hardware will still work.  However, it eats CPU
cycles.  The sleeping on an interrupt way is better.
 
> The goal is to attempt some smooth scrolling. 
> Back in the MS-DOS days there used to be a program
> called smooth editor which was amazing (so amazing that
> I used to do Page up/Down all the time w/o doing
> any work). I was thinking if I could have some similar
> smooth scrolling in my linux fb console.
> 

You can accomplish the same effect using the above code, provide the
hardware mode supports it, and provided you are not doing too many tasks
at one time, else you'll experience frame skips, sound stutters etc. 

> I recall that smooth editor explained that smooth scrolling
> was achieved by "synchronizing with the video refresh"
> (horizontal?, vertical? I don't remember). That's retrace yes?

Yes, it's vertical.

> 
> So, can we by some way do waitretrace at each \n?
> Should this be userland or kernelland?
> 

Depends.  The polling code can be done in userland.  However, newer
hardware has better ways of waiting for the retrace.  In these cases, it
has to be done within the driver.  See how the matroxfb patch does that.
It's in the DirectFB package (www.directfb.org).  Also, you may want to
check the DRI mailing list archives (dri.sourceforge.net).  They have
discussions on that.

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
