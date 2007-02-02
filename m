From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 7920] New: platinumfb -
	video display problem
Date: Thu, 1 Feb 2007 17:20:34 -0800
Message-ID: <20070201172034.19859305.akpm@osdl.org>
References: <200702020045.l120jFpw013553@fire-2.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCn6n-0004DZ-Tc for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Feb 2007 17:20:57 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HCn6l-00009M-C7
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Feb 2007 17:20:57 -0800
In-Reply-To: <200702020045.l120jFpw013553@fire-2.osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, tomasz89@gmail.com, James Simmons <jsimmons@infradead.org>, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>

On Thu, 1 Feb 2007 16:45:15 -0800
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=7920
> 
>            Summary: platinumfb - video display problem
>     Kernel Version: 2.6.17-rc4, 2.6.16, 2.6.15, 2.6.14
>             Status: NEW
>           Severity: blocking
>              Owner: jsimmons@infradead.org
>          Submitter: tomasz89@gmail.com
> 
> 
> Hi all,
> 
> I managed to get my hands on a PowerMac 7200 and am
> trying to boot. I (cross) compiled a kernel of
> 2.6.16.16 from a gentoo x86 box, and serially connected
> the machine to view the console output results. I have
> stripped out basically everything (no IDE, SCSI, USB)
> except serial, framebuffer, console and ADB.
> 
> The framebuffer won't enable using the platinumfb for
> the life of me when using BootX from a MacOS 7.6.1
> installation on another hard drive. I've dropped a new
> AHA2940 (bios flashed to OpenFirmware) SCSI card with
> another attached hard drive to it (8GB of SCSI
> goodness) so I can hack away to my hearts
> content.
> 
> I have a successful installation of Debian 3.1 on this
> HDD from a previously successful attempt some months
> ago using the miboot boot/root install set from:
> http://people.debian.org/~luther/d-i/sid/images/daily/
> The daily builds I tried were 18-20 May 2006, and while
> I believe the kernel has booted okay (since I can
> insert the root floppy and hit enter and it does
> something) I can't see anything on the screen.
> 
> I have a native mac monitor, MacOS runs at 640x480
> happily. I can boot the debian/woody kernel (2.2)
> series with the platinumfb driver, and zapola
> everything is okay. I get screen output. I can boot off
> one of my custom built 2.6.x kernels, specifying the
> serial console as a the console=... parameter and sure
> enough the system comes up without a hitch except that
> the monitor is in 'off' mode. I have tried kernels
> 2.6.17-rc4, 2.6.16, 2.6.15, 2.6.14 (cross-)compiled
> from sources without any luck.
> 
> Using
> http://www.jonh.net/lppcfom-serve/cache/1043.html, I
> have tried to give also several boot paramters
> (thankfully I'm using BootX to try this stuff out now,
> because trying to recreate the miboot debian floppies
> would not have made for easy testing), also without
> luck. Some examples of failed boots follow:
> video=platinumfb
> video=platinumfb:vmode:6,cmode:8
> video=platinumfb:vmode:13,cmode:8
> .. all with the same end result: no video.
> 
> Can I work with anyone on fixing this? It would be nice
> to have some working miboots again, but unfortunately I
> can't remember which daily build I downloaded when I
> actually installed sarge some months ago. I *think* it
> was 2.6.15, but I can't follow the same steps now
> because the other modules can't be downloaded from
> package repositories as sid is in 2.6.16-land now. I
> have also tried the video=ofonly options when that
> option is compiled in to the kernel (by the way, I am
> always statically compiling the fb devices in), the
> ofonlyboot image from the miboot series, also without
> any joy. In my own compilations, I only ever use either
> the platinumfb or the ofonly framebuffer devices
> compiled in, not both at once.
> 
> I know (specifically) with the 2.6.17-rc4 kernel, the output
> is there (sorta), but kind of skewed. So a line is kind of
> skewed across the screen, and you can see dots coming up but
> they're all with a very deep slant.
> So a normal line would look like this:
> ..................................
> What I get is this:
>                       ..........
>                   ...........
>           ...............
>        ..............
> I didn't think to mention it before because its darn hard to
> explain =)
> 
> -Tomasz
> 
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
