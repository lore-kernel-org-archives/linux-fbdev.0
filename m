From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10205] New: BUG: Display
 gets corrupted when using lxfb driver on a GeodeLX 5535 based chipset
Date: Sun, 9 Mar 2008 11:54:27 -0700
Message-ID: <20080309115427.2f39dc93.akpm@linux-foundation.org>
References: <bug-10205-10286@http.bugzilla.kernel.org/>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYQfw-0006yV-1a for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Mar 2008 11:55:12 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JYQft-00087G-J5
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Mar 2008 11:55:12 -0700
In-Reply-To: <bug-10205-10286@http.bugzilla.kernel.org/>
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
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: nestorac@gmail.com, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

On Sun,  9 Mar 2008 08:55:52 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10205
> 
>            Summary: BUG: Display gets corrupted when using lxfb driver on a
>                     GeodeLX 5535 based chipset
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.24.2
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: nestorac@gmail.com
> 
> 
> Latest working kernel version:
>  None or unknown
> Earliest failing kernel version:
>  Latest version
> Distribution:
>  Debian Stable (Etch)
> Hardware Environment:
>  AMD Geode 32 bit A830 board, 5536 chipset based embedded computer (TFT 10"
>  800x600), with GeodeLX embedded GPU. It's webpage is at:
>  http://www.winmatev.com.tw/PPc/PPcSpec.asp?Prod=03_0013&Typeid=03020101
>  I own a cheaper version using GeodeGX 500 processor, 256MiB RAM, no
>  touchscreen.
> Software Environment:
>  Debian 4.0 Stable (Etch), Kernel 2.4.22.2 vanilla + AUFS patch (it has nothing
>  to do with graphics, but BTW...), all i386, kernel specifically compiled for
>  Geode GX/LX Processor target (but also does not work for generic i386 target).
> Problem Description:
>  I get a blurry screen when trying to enable Framebuffer, vga=788
>  option (800x600). Screen gets corrupted, but when I start X.org, it shows
>  Ok, until I switch again to console. Everything works fine with Vesa FB,
>  except that, of course, it's more CPU consuming and slower [supposedly].
>  When blurry, screen looks like it was under a lake.
> Steps to reproduce:
>  1) Compile the kernel, include support for GeodeLX Framebuffer.
>  2) Install the kernel on the machine
>  3) Boot it up, adding vga=788 mode to bootloader.
>  4) Screen gets completely blurry until X.org starts.
> 

Guys, this is a post-2.6.24 regression hence needs
running-around-with-your-hair-on-fire priority please.

Can anyone think what we did to cause this?  Recent changes to
drivers/video/geode/ look pretty tame.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
