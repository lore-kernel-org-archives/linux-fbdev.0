From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bug 10766] ceased to work framebuffer with
 videocard NVIDIA GeForce MX 440
Date: Wed, 28 May 2008 19:15:26 -0700
Message-ID: <20080528191526.b312559a.akpm@linux-foundation.org>
References: <bug-10766-27@http.bugzilla.kernel.org/>
	<20080529015006.88563108038@picon.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1Xg0-0001UR-3N for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 19:15:36 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K1Xfy-0003ph-MK
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 19:15:36 -0700
In-Reply-To: <20080529015006.88563108038@picon.linux-foundation.org>
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

On Wed, 28 May 2008 18:50:06 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10766
> 
> 
> 
> 
> 
> ------- Comment #4 from ashirapov.denis@mail.ru  2008-05-28 18:50 -------
> The Night to contribute little clarity in question.
> Bag reveals itself in kernel 2.6.25 and above only.
> If compiled "vanila" kernel with config including standard "vesafb" in kernel
> and "nvidiafb module, that does not be fixed videomode vga=0x317 (and other
> too).
> But, sometimes after several reboot and shutdown "vesafb" is work. After like
> boot in next time again does not work... With other testing me videocard as
> GeForce2 MX 400 all work correctly. 
> Change the files of source kernel:
> arch/x86/boot/video-bios.c  
> arch/x86/boot/video-vesa.c 
> arch/x86/boot/video-vga.c  
> arch/x86/boot/video.c  
> arch/x86/boot/video.h
> version from kernel 2.6.24 problem at all does not solve.
> 
> If compiled "vanila" kernel with config including "nvidiafb" in kernel and give
> to the kernel addition parameters "video=nvidiafb:1024x768-16@75" then
> framebuffer is work.

OK, thanks but please...

: (switched to email.  Please respond via emailed reply-to-all, not via the
: bugzilla web interface).

Let's handle this bug via email from now on so the linux-fbdev-devel
people get to see it.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
