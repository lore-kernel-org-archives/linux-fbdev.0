From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Wed, 24 Nov 2004 02:26:03 +0800
Message-ID: <200411240226.03203.adaplas@hotpop.com>
References: <200411191137.14649.andrew@walrond.org> <200411240107.13362.adaplas@hotpop.com> <200411231801.14328.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWfMm-0003hC-R6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 10:26:16 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWfMl-0006qP-B9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 10:26:16 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E59FE9F590B
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Nov 2004 18:26:04 +0000 (UTC)
In-Reply-To: <200411231801.14328.andrew@walrond.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>

On Wednesday 24 November 2004 02:01, Andrew Walrond wrote:
> On Tuesday 23 Nov 2004 17:07, Antonino A. Daplas wrote:
> > Okay, I think I this should fix the dvi misdetection, and I think it
> > should also fix the preferred timing of 1600x1200 even if both dsub and
> > dvi are attached.  Try the attached patch.
>
> Not quite, but close...
>
> With just dsub and no params, we get a perfect 1600x1200 (200x75) console

Great.

>
> With both dsub and dvi, another perfect 1600x1200 console. (first EDID

Great :-)

> truncated due to dmesg log not big enough; I can fix this if you need)

No need.  The first EDID block is for dvi, the second is for dsub.

>
> With dvi connection and no params, I get a fully working console, but at
> 1024x768 (128x48)

Okay, this is what I wanted to fix.  Note that the preferred timing when
dvi is attached is 1024x768. When dsub, it's 1600x1200.  You see this
in your dmesg "First DETAILED Timing is preferred", and without options
the first detailed timing block will be used.

>
> With DVI and video=nvidiafb:1600x1200-32@60 I get a kernel hang like this
> (copied by hand and shortened in places)

Okay, this is expected.  Since the panel size is only 1024x768, using a mode
of 1600x1200 failed.  So the framebuffer exited initialization with an error which
caused an oops.

Note, that you may not be able to force resolutions > panel size.  You can
try, all you need to do is remove this code in
drivers/video/nvidia/nvidia.c:nvidiafb_check_var:

	if (par->fpWidth && par->fpHeight && (par->fpWidth < var->xres ||
					      par->fpHeight < var->yres))
		return -EINVAL;

But I don't know if your display can tolerate that.

For now, I'll add checks during the initializatiion that will refuse modes
greater than the panel size.

Unfortunately, without any docs on how to adjust the default panel size,
you will be limited to this resolution only.

Does vesafb work in x86_64?  If it does you can add this in your
commandline:

vga=0x307 

0x306 is the code for 1280x1024, see Documentation/fb/vesafb.txt.

Then check your dmesg if the panel size also changed.  If it did, then
you can do this:

vga=0x307 video=nvidiafb:1280x1024@60.

>
> Decompressing linux
> Bootdata ok (command line is root=... video=nvidiafb:1600x1200-32@60)
> Linux version 2.6.10-rc2 ...
> BIOS-provided physical map
> Scanning NUMA topology in Northbridge 24
> Number of nodes 2 (10010)
> Node 0 using interleaving mode 1/0
> No NUMA configuration found
>
>
> and thats as far as it gets.
>
> Getting closer by the hour :)

Yes.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
