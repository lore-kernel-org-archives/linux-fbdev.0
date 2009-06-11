From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 13509] New: VT switch
	causes system to lockup
Date: Thu, 11 Jun 2009 16:04:24 -0700
Message-ID: <20090611160424.fd597dce.akpm@linux-foundation.org>
References: <bug-13509-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1MEtKZ-0006qi-Eg
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Jun 2009 23:05:11 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MEtKR-0004U6-UQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Jun 2009 23:05:06 +0000
In-Reply-To: <bug-13509-10286@http.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: bugzilla-daemon@bugzilla.kernel.org, liquid.acid@gmx.net, Michal Januszewski <spock@gentoo.org>, bugme-daemon@bugzilla.kernel.org, jb.faq@gmx.de


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Thu, 11 Jun 2009 18:42:30 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13509
> 
>            Summary: VT switch causes system to lockup
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.30-gentoo-r1
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: liquid.acid@gmx.net
>         Regression: Yes
> 
> 
> Hi there,
> 
> I just updated my amd64 system from a 2.6.27 kernel to a fresh 2.6.30-gentoo-r1
> one. The system boots fine, but as soon as I switch to another VT the whole
> system lockups.
> 
> The screen just freezes, still showing the old content of VT1. ACPI buttons
> don't work, and ctrl-alt-del doesn't cause a restart. I haven't tried remote
> ssh login yet, nor magic SysRq (going to do this next).
> 
> To emphasize this: Just doing work on the first console is perfectly fine - the
> system is rockstable this way. So it's not some instability that is triggered
> by the VT switch.
> 
> Anyway, I'm using uvesafb here (gfx card is a integrated Radeon HD 3200).
> More informations to follow.

hm, 2.6.27->2.6.30 is a large hop.

Perhaps you were using vesafb in 2.6.27 and you're now using uvesafb?

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
