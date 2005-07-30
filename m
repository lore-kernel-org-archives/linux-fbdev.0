From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 4971] New: dual head and 2.6.13rc4
Date: Sat, 30 Jul 2005 12:45:03 -0700
Message-ID: <20050730124503.56d028a5.akpm@osdl.org>
References: <200507301940.j6UJeAaQ003193@fire-1.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyxIK-0004M3-1q
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 12:46:52 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1DyxIJ-000751-Qv
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 12:46:52 -0700
In-Reply-To: <200507301940.j6UJeAaQ003193@fire-1.osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@kernel-bugs.osdl.org>, Dave Airlie <airlied@linux.ie>, Dave Jones <davej@codemonkey.org.uk>

bugme-daemon@kernel-bugs.osdl.org wrote:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=4971
> 
>            Summary: dual head and 2.6.13rc4
>     Kernel Version: 2.6.13rc4
>             Status: NEW
>           Severity: normal
>              Owner: other_other@kernel-bugs.osdl.org
>          Submitter: infos@aksels.de
> 
> 
> Distribution: slackware
> Hardware Environment: x86, athlon 2800
> Software Environment: xorg and dual head
> Problem Description: on kernel 2.6.12 the dual head xorg.conf works as used in
> kernel 2.4 and 2.6.12.3. with kernel 2.6.13rc4 the dual head screen location
> switched. what was left screen is now right screnn, changed nothing but kernel
> update. tried this version because many atapi cdwriter problems. 2-6.13rc4 did not
> eliminate the cdwriting problems, but added a unresolovable xserver problem.
> 
> 
> Steps to reproduce:
> see above
> if you need my xorg.conf just send me an email

A couple of people are reporting dusl head problems.  I'm not sure that it's
an fbdev problem though?


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
