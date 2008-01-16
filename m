From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9762] New: radeonfb and
	Xpress 200m 5955
Date: Wed, 16 Jan 2008 01:57:07 -0800
Message-ID: <20080116015707.4d551245.akpm@linux-foundation.org>
References: <bug-9762-10286@http.bugzilla.kernel.org/>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JF51M-0007M8-Sk for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jan 2008 01:57:21 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JF51M-0000hT-Hc
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jan 2008 01:57:20 -0800
In-Reply-To: <bug-9762-10286@http.bugzilla.kernel.org/>
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
To: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@pol.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, alevkovich@tut.b
Cc: "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>

On Wed, 16 Jan 2008 01:33:25 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9762
> 
>            Summary: radeonfb and Xpress 200m 5955
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: >=2.6.23
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: alevkovich@tut.by
> 
> 
> Latest working kernel version: 2.6.23
> Earliest failing kernel version: any
> Distribution: gentoo
> Hardware Environment: Radeon XPress 200m 5955
> Software Environment: 
> Problem Description: framebuffer is ok only with default parameters only (it is
> 1280x800-8@60). If parameters are video=radeonfb:1280x800-32@60 then xres, yres
> and xres_virtual are ok but yres_virtual is 1024. It can be corrected by fbset
> utility so I think it can be corrected in the driver code also.
> 
> Steps to reproduce: video=radeonfb:1280x800-32@60 or
> video=radeonfb:1280x800-16@60
> 

damn, another post-2.6.2 regression.

Does anyone know whether this is likely to be a radeonfb problem or an
fbdev core problem?


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
