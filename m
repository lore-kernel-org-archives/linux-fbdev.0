From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 10205] New: BUG: Display
	gets corrupted when using lxfb driver on a GeodeLX 5535 based
	chipset
Date: Sun, 9 Mar 2008 22:31:13 +0100
Message-ID: <200803092231.13945.rjw@sisk.pl>
References: <bug-10205-10286@http.bugzilla.kernel.org/>
	<20080309115427.2f39dc93.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYT8Q-00023c-TU for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Mar 2008 14:32:47 -0700
Received: from ogre.sisk.pl ([217.79.144.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JYT8P-0002mt-4n
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Mar 2008 14:32:46 -0700
In-Reply-To: <20080309115427.2f39dc93.akpm@linux-foundation.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nestorac@gmail.com, Jordan Crouse <jordan.crouse@amd.com>, linux-fbdev-devel@lists.sourceforge.net

On Sunday, 9 of March 2008, Andrew Morton wrote:
> On Sun,  9 Mar 2008 08:55:52 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=10205
> > 
> >            Summary: BUG: Display gets corrupted when using lxfb driver on a
> >                     GeodeLX 5535 based chipset
> >            Product: Drivers
> >            Version: 2.5
> >      KernelVersion: 2.6.24.2
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Console/Framebuffers
> >         AssignedTo: jsimmons@infradead.org
> >         ReportedBy: nestorac@gmail.com
> > 
> > 
> > Latest working kernel version:
> >  None or unknown
> > Earliest failing kernel version:
> >  Latest version
> > Distribution:
> >  Debian Stable (Etch)
> > Hardware Environment:
> >  AMD Geode 32 bit A830 board, 5536 chipset based embedded computer (TFT 10"
> >  800x600), with GeodeLX embedded GPU. It's webpage is at:
> >  http://www.winmatev.com.tw/PPc/PPcSpec.asp?Prod=03_0013&Typeid=03020101
> >  I own a cheaper version using GeodeGX 500 processor, 256MiB RAM, no
> >  touchscreen.
> > Software Environment:
> >  Debian 4.0 Stable (Etch), Kernel 2.4.22.2 vanilla + AUFS patch (it has nothing
> >  to do with graphics, but BTW...), all i386, kernel specifically compiled for
> >  Geode GX/LX Processor target (but also does not work for generic i386 target).
> > Problem Description:
> >  I get a blurry screen when trying to enable Framebuffer, vga=788
> >  option (800x600). Screen gets corrupted, but when I start X.org, it shows
> >  Ok, until I switch again to console. Everything works fine with Vesa FB,
> >  except that, of course, it's more CPU consuming and slower [supposedly].
> >  When blurry, screen looks like it was under a lake.
> > Steps to reproduce:
> >  1) Compile the kernel, include support for GeodeLX Framebuffer.
> >  2) Install the kernel on the machine
> >  3) Boot it up, adding vga=788 mode to bootloader.
> >  4) Screen gets completely blurry until X.org starts.
> > 
> 
> Guys, this is a post-2.6.24 regression

Hm, what exactly makes you think so?

The failing kernel version is 2.6.24.2, so most probably the problem is present
in 2.6.24 as well.

Moreover, the reporter didn't specify the last known good kernel, so it might
not be a regression at all.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
