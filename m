From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9847] New: i810fb: module
 parameter 'mode_option' inconsistent with other framebuffer modules
Date: Tue, 29 Jan 2008 21:33:25 -0800
Message-ID: <20080129213325.0d19dd8d.akpm@linux-foundation.org>
References: <bug-9847-10286@http.bugzilla.kernel.org/>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JK5Zf-0004Vq-AF for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jan 2008 21:33:27 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JK5Zd-0001GC-Td
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jan 2008 21:33:27 -0800
In-Reply-To: <bug-9847-10286@http.bugzilla.kernel.org/>
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
Cc: miki@dds.nl, bugme-daemon@bugzilla.kernel.org

On Tue, 29 Jan 2008 21:02:39 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9847
> 
>            Summary: i810fb: module parameter 'mode_option' inconsistent with
>                     other framebuffer modules
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.22
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: miki@dds.nl
> 
> 
> Latest working kernel version: -
> Earliest failing kernel version:
> Distribution: Debian Release: lenny/sid
> Hardware Environment: Intel PIII / i815M
> Software Environment:
> Problem Description: While all other framebuffer modules use the option
> "mode=..." to specify a modedb-style video mode, i810fb uses the non-standard
> "mode_option=..." This breaks the use of "video=i810fb:<videomode>" boot
> parameter, such that for instance "video=i810fb:1024x768" doesn't work.
> The boot scripts parse the "<videomode>" parameter internally and pass 
> it to the correct module as 'mode=<videomode>'.
> 
> -Alain

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
