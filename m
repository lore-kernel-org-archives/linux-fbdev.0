From: <evt@texelsoft.com>
Subject: problem with modular asiliant driver
Date: Tue, 5 Apr 2005 16:21:55 -0400
Message-ID: <200504052021.CZG39831@ms3.netsolmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DIuYo-0002ma-U3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 05 Apr 2005 13:22:06 -0700
Received: from omr1.netsolmail.com ([216.168.230.162])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DIuYn-00060L-DF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 05 Apr 2005 13:22:06 -0700
Received: from ms3.netsolmail.com (IDENT:mirapoint@[216.168.230.176])
	by omr1.netsolmail.com (8.12.10/8.12.10) with ESMTP id j35KLwTh001314
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 5 Apr 2005 16:21:59 -0400 (EDT)
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

I'm trying to build the asiliantfb driver from 2.6.8.1 as a
module but when I do that, since fb_console_init() and
reset_vc() have long since run, the fb_setcolreg member
function (asiliantfb_setcolreg)is not getting called. Hence I
wind up with a black screen. Can anybody point me at a driver
that works as a module and/or advise me on how to fix this?
Thanks.

-evt


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
