From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10213] New:
 /usr/src/linux/drivers/video/aty/ati_ids.h doesn't have my pci-id (needed
 for radeonfb)
Date: Sun, 9 Mar 2008 22:51:00 -0700
Message-ID: <20080309225100.a21963db.akpm@linux-foundation.org>
References: <bug-10213-10286@http.bugzilla.kernel.org/>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYavF-0003jD-85 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Mar 2008 22:51:43 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JYavD-0004nD-O5
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Mar 2008 22:51:41 -0700
In-Reply-To: <bug-10213-10286@http.bugzilla.kernel.org/>
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
To: GNUtoo@no-log.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org


(switched to email - please respond via emailed reply-to-all, not via the
bugzilla UI)

On Sun,  9 Mar 2008 19:27:02 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10213
> 
>            Summary: /usr/src/linux/drivers/video/aty/ati_ids.h doesn't have
>                     my pci-id (needed for radeonfb)
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.24.3
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: GNUtoo@no-log.org
> 
> 
> Latest working kernel version:none
> Earliest failing kernel version:none
> Distribution:Gentoo
> Hardware Environment:
> Software Environment:
> Problem Description:
> hello, i wanted to try radeonfb for several reasons(trying to have a 1920x1200
> resolution in tty ,bios-independant driver(cause i can't suspend for an unknow
> reason...pm_trace did not give me the reason))
> but it didn't want to start...using the video=radeonfb: or video=radeon:
> so i looked at the pci-id...and mine was absent
> #lspci
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility X700
> (PCIE)
> # lspci -s 00:00.0 -n
> 00:00.0 0600: 8086:2590 (rev 04)

OK.  Can you please try adding those IDs to the driver and if it works,
send us the patch?


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
