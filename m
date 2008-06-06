From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10877] New: black screen
 when booting using vesafb
Date: Fri, 6 Jun 2008 14:09:07 -0700
Message-ID: <20080606140907.bb35fc27.akpm@linux-foundation.org>
References: <bug-10877-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4jBU-0008Ir-W4 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 14:09:17 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K4jBT-0005Yj-6S
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 14:09:16 -0700
In-Reply-To: <bug-10877-10286@http.bugzilla.kernel.org/>
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
To: "H. Peter Anvin" <hpa@zytor.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: born.into.silence@gmail.com, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Fri,  6 Jun 2008 13:54:30 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10877
> 
>            Summary: black screen when booting using vesafb
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.24 - 2.6.25-rc4 - 2.6.26.4 - 2.6.26.5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: born.into.silence@gmail.com
> 
> 
> Latest working kernel version: None
> Earliest failing kernel version: 2.6.24
> Distribution: gentoo
> Hardware Environment: Asus m51se laptop
> Software Environment:
> Problem Description: Screen goes black when using vga=xxx setting on boot, but
> the radeon HD 3470 is said to be vesa-compliant. Tested values : 791, 788, 791,
> 789. System keeps booting (I can ssh the box)
> 
> Steps to reproduce: boot with vga=xxx

istr we've seen other reports of recent problems with vga=, but I don't
recall the outcome?

Thanks.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
