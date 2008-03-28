From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10352] New: uvesafb does
 not find 1680x1050 resolution on my ati X1400
Date: Fri, 28 Mar 2008 16:51:49 -0700
Message-ID: <20080328165149.9b38a0cf.akpm@linux-foundation.org>
References: <bug-10352-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JfONE-0000sw-K6 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Mar 2008 16:52:40 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JfOND-0001y9-7B
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Mar 2008 16:52:40 -0700
In-Reply-To: <bug-10352-10286@http.bugzilla.kernel.org/>
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
Cc: sargentd@die-welt.net, bugme-daemon@bugzilla.kernel.org

(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Fri, 28 Mar 2008 16:14:37 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10352
> 
>            Summary: uvesafb does not find 1680x1050 resolution on my ati
>                     X1400
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.25-rc6
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: sargentd@die-welt.net
> 
> 
> Latest working kernel version: none
> Earliest failing kernel version: 2.6.25-rc6
> Distribution: Debian Sid
> Hardware Environment: ThinkPad Z61m, ATI Mobility Radeon X1400, 15.2" 1680x1050
> LCD
> Problem Description:
> 
> I'm trying to get the native resolution (1680x1050) of my LCD running in the
> console. However, the maximum I can get is 1400x1050 (that is the maximum
> displayed by `hwinfo --vbe` and in /sys/devices/platform/uvesafb.0/vbe_modes).
> As the LCD supports 1680x1050 
> (hwinfo says:
>      Resolution: 1680x1050
>      Horizontal: 1680 1712 1776 1904 (+32 +96 +224) -hsync
>        Vertical: 1050 1051 1054 1066 (+1 +4 +16) -vsync
>     Frequencies: 101.67 MHz, 53.40 kHz, 50.09 Hz
> )
> and I can get this resolution in Xorg, I wonder how one could get this in the
> console too.
> 
> 
> -- 
> Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
