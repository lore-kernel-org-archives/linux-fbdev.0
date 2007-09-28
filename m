From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9093] New: Framebuffer
 breakage with vesafb on x86_64
Date: Thu, 27 Sep 2007 17:19:41 -0700
Message-ID: <20070927171941.01d504a7.akpm@linux-foundation.org>
References: <bug-9093-10286@http.bugzilla.kernel.org/>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ib3aH-0007nL-3n for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 17:19:57 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ib3aG-00074G-Nk
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 17:19:57 -0700
In-Reply-To: <bug-9093-10286@http.bugzilla.kernel.org/>
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
Cc: bug.hunter@gmx.net, bugme-daemon@bugzilla.kernel.org

On Thu, 27 Sep 2007 17:04:55 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9093
> 
>            Summary: Framebuffer breakage with vesafb on x86_64
>            Product: Other
>            Version: 2.5
>      KernelVersion: 2.6.22.7
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: other_other@kernel-bugs.osdl.org
>         ReportedBy: bug.hunter@gmx.net
> 
> 
> Most recent kernel where this bug did not occur: Don't recall!
> 
> Distribution: Gentoo-Linux
> 
> Hardware Environment: AMD Athlon 64 X2 5600+, Asus Crosshair MB, 4GB Kingston
> Sli-Ready Hyper-X RAM, 2 x XFX nVidia GeForce 7900 GS (sli-setup) etc.
> 
> Software Environment: Asus Crosshair Bios Rev. 702 (stable) ... first running
> terminal, then xorg-server build (on gentoo)
> 
> Problem Description: `vesafb' module is compiled into the kernel. No problems
> with current or virtual terminals. First run of `startx' command is also fine.
> After shutdown and restart of x-server problem appears in form of a blinking
> cursor image on top of the `desktop' area in the upper left corner (I'll attach
> a snapshot). It makes no difference if same or other user with a new login
> restarts X. It makes no difference if binary-nvidia driver, nv or whatever else
> is used. It makes no difference if kde, gnome, xfce or plain old twm
> environment is used to build a workspace. It has nothing to do with resolution,
> monitor, cables ... neither with my current sli-setup, I've had the same
> symptom on a previous x86_64 single video card box. This broken framebuffer
> image goes away if during an open X session any `ctrl+alt+Fx' sequence is
> called to switch to a virtual terminal and back.
> 
> Interestingly it differs when `vga16fb' is used instead?! No breakage, nothing!
> Besides that this out-dated module is ugly on the terminal, it also tends to
> mess up with current xorg-server builds ... my 11 year old son lost the video
> signal when he tried to quit an old DOS game running under `scummvm' ... which
> never happened with `vesafb' or a kernel build without any framebuffer device
> ... but that's another story, sigh!
> 
> Please ask for any further information you might need to investigate this
> problem...
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
