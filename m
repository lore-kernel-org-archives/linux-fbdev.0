From: <evt@texelsoft.com>
Subject: Re: Fw: [Bugme-new] [Bug 4768] New: Screen appears at mid-right section
Date: Thu, 23 Jun 2005 10:57:12 -0400
Message-ID: <200506231457.DPG00170@ms3.netsolmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlT8n-0000xk-Ph
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 07:57:17 -0700
Received: from omr1.netsolmail.com ([216.168.230.162])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DlT8l-00073g-Hj
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 07:57:18 -0700
Received: from ms3.netsolmail.com (IDENT:mirapoint@[216.168.230.176])
	by omr1.netsolmail.com (8.12.10/8.12.10) with ESMTP id j5NEvCTj015137
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Jun 2005 10:57:13 -0400 (EDT)
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

I saw this same effect using the chips 69000 framebuffer. The
issue, in my case, was that the asiliantfb driver did not set
the start address registers in the ct69K. HTH.

- Eric van Tassell

---- Original message ----
>Date: Mon, 20 Jun 2005 19:14:25 -0700
>From: Andrew Morton <akpm@osdl.org>  
>Subject: [Linux-fbdev-devel] Fw: [Bugme-new] [Bug 4768] New:
Screen appears at mid-right section  
>To: linux-fbdev-devel@lists.sourceforge.net
>
>
>
>Begin forwarded message:
>
>Date: Mon, 20 Jun 2005 18:49:06 -0700
>From: bugme-daemon@kernel-bugs.osdl.org
>To: bugme-new@lists.osdl.org
>Subject: [Bugme-new] [Bug 4768] New: Screen appears at
mid-right section
>
>
>http://bugzilla.kernel.org/show_bug.cgi?id=4768
>
>            Summary: Screen appears at mid-right section
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by: Discover Easy Linux Migration
Strategies
>from IBM. Find simple to follow Roadmaps, straightforward
articles,
>informative Webcasts and more! Get everything you need to get
up to
>speed, fast.
http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>_______________________________________________
>Linux-fbdev-devel mailing list
>Linux-fbdev-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
