From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Bug 10766] ceased to work framebuffer with
 videocard NVIDIA GeForce MX 440
Date: Thu, 29 May 2008 06:58:38 +0200
Message-ID: <20080529065838.c0a842c9.krzysztof.h1@poczta.fm>
References: <bug-10766-27@http.bugzilla.kernel.org/>
	<20080529015006.88563108038@picon.linux-foundation.org>
	<20080528191526.b312559a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1aW8-0001uG-0M for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 22:17:36 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1aW6-00050s-CJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 22:17:35 -0700
In-Reply-To: <20080528191526.b312559a.akpm@linux-foundation.org>
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
Cc: ashirapov.denis@mail.ru, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

On Wed, 28 May 2008 19:15:26 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 28 May 2008 18:50:06 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=10766
> > 
> > 
> > 
> > 
> > 
> > ------- Comment #4 from ashirapov.denis@mail.ru  2008-05-28 18:50 -------
> > The Night to contribute little clarity in question.
> > Bag reveals itself in kernel 2.6.25 and above only.
> > If compiled "vanila" kernel with config including standard "vesafb" in kernel
> > and "nvidiafb module, that does not be fixed videomode vga=0x317 (and other
> > too).
> > But, sometimes after several reboot and shutdown "vesafb" is work. After like
> > boot in next time again does not work... With other testing me videocard as
> > GeForce2 MX 400 all work correctly. 
> > Change the files of source kernel:
> > arch/x86/boot/video-bios.c  
> > arch/x86/boot/video-vesa.c 
> > arch/x86/boot/video-vga.c  
> > arch/x86/boot/video.c  
> > arch/x86/boot/video.h
> > version from kernel 2.6.24 problem at all does not solve.
> > 
> > If compiled "vanila" kernel with config including "nvidiafb" in kernel and give
> > to the kernel addition parameters "video=nvidiafb:1024x768-16@75" then
> > framebuffer is work.
> 
> OK, thanks but please...
> 

I have handled this bug with Denis, so his additional findings are results from this.
I have tried to reproduce it but I do not have the hardware he has.
It is a bug in vesafb or VESA mode setting. 
I am not able to reproduce this bug on Trident card, 3dfx card, Permedia 2,
ATI on-board card (all using vesafb driver).

The current status is that I will try to find someone with 
the NVidia GeForce 4 MX 4x0 card and borrow it. I hope that
Denis' card has some kind of reference board BIOS and not 
BIOS modified by the card's vendor.

Regards,
Krzysztof

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f1e13  


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
