From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10971] New: radeonfb :
 radeon X800 family support (atombios)
Date: Mon, 23 Jun 2008 14:49:26 -0700
Message-ID: <20080623144926.61b523e1.akpm@linux-foundation.org>
References: <bug-10971-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KAtvK-0005iR-KL for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Jun 2008 14:50:06 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KAtvJ-0007qR-8U
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Jun 2008 14:50:06 -0700
In-Reply-To: <bug-10971-10286@http.bugzilla.kernel.org/>
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
Cc: bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Mon, 23 Jun 2008 14:35:21 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10971
> 
>            Summary: radeonfb : radeon X800 family support (atombios)
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: stable branch 2.6.26-rc6
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: enhancement
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: Jimmy.Jazz@gmx.net
> 
> 
> Latest working kernel version:2.6.26
> Earliest failing kernel version:
> Distribution:
> Hardware Environment: Radeon X800 family PCIe videocard
> Software Environment:
> Problem Description:
> 
> Using the actual radeonfb kernel driver with a X800 videocard gives me a black
> screen of the death and will crash xorg. Worth, with the vesafb driver the card
> is not even working well.
> 
> Also, i gathered some patches that were published on the fbdev forum, and
> changed few easy things to make the driver understand the monid ddc type of the
> videocard and print better kernel messages. I tested the vga ddc and the monid
> ddc and both are working well.
> 
> The only difficulties are, first i need to deactivate some options in xorg.conf
> to be able to switch back and forth to the virtual ttys.
> 
> [code]
>         Option      "IgnoreEDID" "off" 
>         Option      "ReverseDDC" "off"
>         Option      "VGAAccess" "off"
> [/code]
> 
> Second, the driver needs to share the same resolution and color depth as xorg.
> 
> The following options are working with the radeonfb framebuffer. I have only
> tested them when the radeonfb driver was compiled like an optional module.
> 
> options radeonfb mode_option=1680x1050MR-32@60
> options radeonfb ignore_edid=0
> options radeonfb ignore_devlist=1 force_measure_pll=0 nomodeset=0 noaccel=0
> 
> I hope these patches will help radeon X800 owners to have a nice splash screen
> on their flat wide screen... but without guaranty. My knowledge in videocard
> logic is quite thin :)  
> 
> Steps to reproduce:
> 

A post-2.6.26 regression..

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
