From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12012] New: This is a
 request for a kernel-feature of setting a margin of X chars to console
 contents.
Date: Tue, 11 Nov 2008 13:10:01 -0800
Message-ID: <20081111131001.5b59675a.akpm@linux-foundation.org>
References: <bug-12012-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1L00VS-0001lp-6w
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 21:10:38 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L00VP-00024o-GW
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 21:10:38 +0000
In-Reply-To: <bug-12012-10286@http.bugzilla.kernel.org/>
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
Cc: jesperjacobsson@yahoo.se, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

(Mailing lists are much more appropriate for this sort of thing than
kernel bugzilla)

On Tue, 11 Nov 2008 12:46:44 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12012
> 
>            Summary: This is a request for a kernel-feature of setting a
>                     margin of X chars to console contents.
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: All
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: jesperjacobsson@yahoo.se
> 
> 
> Best bugzilla.kernel.org readers,
> 
> First I want to apologise if I have misused the kernel bugzilla system, but I
> post here in lack of knowing where else to request a kernel feature.
> 
> I (and many other users also I believe, one verified in freenode #kernel chat)
> would like to be able to set a margin of X characters wide on either just left
> or right side, or preferably also top and bottom, of the linux text console. 
> 
> The reason for wanting the feature is that we feel that it will increase
> readability since we can find it hard to read when the characters goes to the
> very edges of the screen. Of course this is a personal preference but I think
> many others would also want the posibility. On the old CRT monitors it was easy
> to change this to personal preference with adjusting the monitors visible area,
> but on for example a laptop it is not possible.
> 
> It doesn't look like framebuffer modules can do this (been looking at i810fb
> which I am using atm, or vesafb). I have also been thinking about the "screen"
> program if it could be hacked up to accomplish this, but I thought the best
> thing would be if this could be set in the kernel.
> 
> I hereby request this feature and hope it will be implemented, and I apologise
> if I have posted this request in the wrong forum.
> 
> Any thoughts about this are welcome.
> 
> Best regards,
> 
> Jesper J


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
