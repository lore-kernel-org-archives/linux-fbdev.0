From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 11258] New: fbcon cursor
 disappered after switch to 512 consolefont
Date: Wed, 6 Aug 2008 09:12:04 -0700
Message-ID: <20080806091204.25045807.akpm@linux-foundation.org>
References: <bug-11258-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQlhe-0006p7-73 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 09:17:34 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQlcT-00033v-VG
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 09:12:14 -0700
In-Reply-To: <bug-11258-10286@http.bugzilla.kernel.org/>
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
Cc: hanzelpeter@gmail.com, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed,  6 Aug 2008 08:27:54 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11258
> 
>            Summary: fbcon cursor disappered after switch to 512 consolefont
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.26.1
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: hanzelpeter@gmail.com
> 
> 
> Latest working kernel version: 2.6.25.8
> Earliest failing kernel version: 2.6.26
> Distribution: LFS 6.3
> Hardware Environment: VMWare 5.5
> Software Environment: LFS, framebuffer console
> Problem Description: When I use setfont to change font to 512 chars font, than
> blinking cursor disappers.
> 
> Steps to reproduce: 
> 1) setfont LatArCyrHeb-16.psfu.gz
> 2) press enter (sometimes twice or more)
> 3) blinking cursor disappers
> 4) start typing (no cursor)
> 5) press "backspace" => cursor is back
> 

A regression.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
