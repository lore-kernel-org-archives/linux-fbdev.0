From: Chad Daelhousen <cd9@cse.Buffalo.EDU>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 15:21:09 -0500
Message-ID: <20041123202109.GA29439@armstrong.cse.Buffalo.EDU>
References: <200411191137.14649.andrew@walrond.org> <200411231801.14328.andrew@walrond.org> <200411240226.03203.adaplas@hotpop.com> <200411231923.40572.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWhA3-0005RQ-QF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 12:21:15 -0800
Received: from armstrong.cse.buffalo.edu ([128.205.32.3] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWhA2-0003VQ-HB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 12:21:15 -0800
Received: from armstrong.cse.Buffalo.EDU (cd9@localhost [127.0.0.1])
	by armstrong.cse.Buffalo.EDU (8.12.10/8.12.10) with ESMTP id iANKLANb000162
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Nov 2004 15:21:10 -0500 (EST)
Received: (from cd9@localhost)
	by armstrong.cse.Buffalo.EDU (8.12.10/8.12.9/Submit) id iANKL9Zk000161
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 15:21:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200411231923.40572.andrew@walrond.org>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

At Tue, Nov 23, 2004 at 07:23:40PM +0000, Andrew Walrond wrote:
> On Tuesday 23 Nov 2004 18:26, Antonino A. Daplas wrote:
> >
> > For now, I'll add checks during the initializatiion that will refuse modes
> > greater than the panel size.
> >
> Even if they are listed in the list of supported modes and detailed modes in 
> the EDID?
> 
> My (dvi) edid lists valid modes of
> 
>       First DETAILED Timing is preferred
>    Supported VESA Modes
...
>    Detailed Timings
>       65 MHz 1024 1040 1104 1344 768 781 783 817 -HSync -VSync
> 
>       162 MHz 1600 1664 1856 2160 1200 1201 1204 1250 +HSync +VSync
> 
> Ok, the first detailed mode is preferred, but the second is equal;y supported.
> 
> > Unfortunately, without any docs on how to adjust the default panel size,
> > you will be limited to this resolution only.
> 
> I'm a bit confused now. On one hand you seem to be testing for and rejecting 
> modes > panel size in the driver; But here I infer that the hardware won't 
> accept these modes unless we can somehow reset the panel size first?
> 

It sounds to me like the driver is assuming that the preferred mode is
the maximum size that the panel can display. In your case, this is
wrong, since the panel is claiming 1024x768 as a preferred mode. If that
assumption were fixed, it should be able to pull 1600x1200 out of the
EDID block and run fine with it. You'd still need a video=1600x1200 to
override the "preferred" mode, but at least you'd have it.

AFAIK, when doing I2C and reading the EDID block, the driver is
bypassing any BIOS, so there should be no need to fiddle with vga=.

Someone else will have to write the patch, though, since I don't have an
nvidia card to test on.

-- 
...: Chad Daelhousen :.........
"The Soviet Union tried to restrict academic freedom along national
lines, and it didn't do the country any good. We should try not to
follow in those footsteps." --Bruce Schneier, CRYPTO-GRAM, Oct. 2004


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
