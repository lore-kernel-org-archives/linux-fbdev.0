From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10766] New: ceased to work
 framebuffer with videocard NVIDIA GeForce MX 440
Date: Wed, 21 May 2008 19:05:25 -0700
Message-ID: <20080521190525.eb2a9a9b.akpm@linux-foundation.org>
References: <bug-10766-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jz0BV-0000oZ-JA for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 May 2008 19:05:37 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jz0BS-0005X2-57
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 May 2008 19:05:37 -0700
In-Reply-To: <bug-10766-10286@http.bugzilla.kernel.org/>
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
Cc: ashirapov.denis@mail.ru, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Tue, 20 May 2008 22:55:43 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10766
> 
>            Summary: ceased to work framebuffer with videocard NVIDIA GeForce
>                     MX 440
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.25
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: ashirapov.denis@mail.ru
> 
> 
> Latest working kernel version:2.6.25.4
> Earliest failing kernel version:2.6.25 and up
> Distribution: Slackware GNU/Linux 12.0 
> Hardware Environment:
>  Processors: AMD Athlon XP 1800(Thunderbird)
>  Video card: Nvidia GeForce MX 440 agp 8x
>  Mother board: Biostar M7NCD (nForce2)
> Software Environment:
> Problem Description: 
>  In kernels >= 2.6.25 loading kernel with append patameters in boot
> loaders(grub) as "vga=317" etc. can't enable requred video mode.
> 
> Steps to reproduce: 
> Compile ketnel 2.6.25 with config:
> http://slackware.perespim.ru/pub/slackware-current/kernels/huge.s/config
> 

Can anyone think of anything we might have done between 2.6.24 and
2.6.25 to break the nvidia driver's boot-command-line handling?

Thanks.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
