From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12271] New: kernel crash
 during startup with intelfb compiled into kernel
Date: Mon, 22 Dec 2008 10:06:55 -0800
Message-ID: <20081222100655.361b808d.akpm@linux-foundation.org>
References: <bug-12271-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1LEpBG-0003Az-Lb
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Dec 2008 18:07:02 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LEpBD-0008Fs-TD
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Dec 2008 18:07:02 +0000
In-Reply-To: <bug-12271-10286@http.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: dennis.jansen@web.de
Cc: linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Mon, 22 Dec 2008 03:46:45 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12271
> 
>            Summary: kernel crash during startup with intelfb compiled into
>                     kernel
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.28-rc9-git
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Video(Other)
>         AssignedTo: drivers_video-other@kernel-bugs.osdl.org
>         ReportedBy: dennis.jansen@web.de
> 
> 
> Distribution: Ubuntu 8.10
> Hardware Environment: Acer Extensa 5220
> Software Environment: N/A
> Problem Description: 
> 
> When I boot with the intelfb and vesafb modules compiled into the kernel, the
> kernel crashes quickly during boot (probably during intelfb initialization -
> the timing seems fit). The displays goes completely blank / off, the keyboard
> does no longer respond at all (even reisub). I have to power off hard by
> pressing the power button for a few seconds.
> 
> I can avoid the crash by having vesafb switch the display resolution
> (vga=0x0362).
> 

Sorry, I don't know of anyone who can work on this :( If there's any
earlier kenrel which worked OK then performing a bisection search would
be most valuable.  http://www.kernel.org/doc/local/git-quick.html has
some tips.


------------------------------------------------------------------------------
