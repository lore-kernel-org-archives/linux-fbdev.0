From: syrjala@sci.fi
Subject: [PATCH 0/8] Some atyfb patches
Date: Thu, 17 Mar 2005 05:07:51 +0200 (EET)
Message-ID: <20050317030751.A77B67A@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBlMZ-00057u-Sp
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 19:07:55 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBlMW-0005vY-TQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 19:07:55 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id DBCE2BA39C
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Mar 2005 05:07:51 +0200 (EET)
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
MIME-Version: 1.0
Content-Type: text; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alex.kern@gmx.de

Here's a collection of patches for atyfb.

I'm pretty sure patches 1-5 are fine as is.

Patches 6 and 7 change some of the chip descriptions. I'm not 100% sure 
about the changes so I'd appreciate any comments.

Patch 8 changes the power management code so I really need some comments 
on it. I don't want to break any working setups.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
