From: David Vrabel <dvrabel@arcom.com>
Subject: [patch] framebuffer Kconfig -- add option for building cfb*.o (0/2)
Date: Mon, 14 Feb 2005 12:17:10 +0000
Message-ID: <421096C6.3030105@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0fAI-0003Hh-1a
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 04:17:22 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D0fAF-0005sB-J7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 04:17:21 -0800
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
To: linux-fbdev-devel list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

This set of two patches add a new option (FB_SOFTWARE_CFB_OPS) to the
framebuffer Kconfig to enable building the generic software cfbfillrect,
cfbcopyarea and cfbimageblt objects.  This cuts out a lot of stuff from
the Makefile and allows drivers in their own directory to be more
self-contained.

1/2 -- add the FB_SOFTWARE_CFB_OPS option to Kconfig and Makefile
2/2 -- make all drivers (where appropriate) select FB_SOFTWARE_CFB_OPS

Please consider applying, thanks.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
