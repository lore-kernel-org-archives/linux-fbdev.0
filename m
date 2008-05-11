From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10666] New: cfag12864bfb
	messing up vc on load
Date: Sun, 11 May 2008 11:06:46 -0700
Message-ID: <20080511110646.ff5eca7b.akpm@linux-foundation.org>
References: <bug-10666-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JvFxJ-0005mx-CO for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 May 2008 11:07:29 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JvFxH-0001fP-UR
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 May 2008 11:07:29 -0700
In-Reply-To: <bug-10666-10286@http.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: devzero@web.de, bugme-daemon@bugzilla.kernel.org

(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sun, 11 May 2008 05:10:41 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10666
> 
>            Summary: cfag12864bfb messing up vc on load
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.21+
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: low
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: devzero@web.de
> 
> 
> Latest working kernel version: n/a
> 
> Earliest failing kernel version: at least 2.6.21
> 
> Distribution: opensuse 10.3
> 
> Hardware Environment: vmware
> 
> Software Environment: opensuse 10.3 + kernel 2.6.26rc1
> 
> Problem Description:
> when doing some module regression testing (load/unload most available modules),
> cfag12864bfb driver always kills the local console on load and locks you out.
> visible area of vc shrinks to 16x4 and output freezing. this happens if you
> don`t have appropriate hardware attached, cannot test with hw attached (don`t
> own such). no vc switching afterwards. cannot unload module from remote (ssh)
> either. need reboot.
> 
> Steps to reproduce:
> save all of your important data, switch to textconsole, modprobe cfag12864bfb 
> 
> dmesg shows:
> Console: switching to mono frame buffer device 16x8
> fb0: cfag12864b frame buffer device
> 
> contacted the author who confirmed the issue and tells that this didn`t happen
> initially. iirc, he thinks this is a regression due to change in framebuffer
> layer. didn`t get a response since then, maybe he`s lacking time.
> i`m putting it here so it`s being marked as a ToDo and won`t get lost.
> 
> 
> -- 
> Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
