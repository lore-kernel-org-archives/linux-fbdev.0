From: York Sun <yorksun@freescale.com>
Subject: [PATCH 0/2] Add virtual resolution and panning
	for Freescale DIU
Date: Wed, 13 Aug 2008 15:55:02 -0500
Message-ID: <12186609042933-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KTNO4-0004Nr-6F for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 13:56:08 -0700
Received: from az33egw02.freescale.net ([192.88.158.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KTNO2-0005H7-Uz
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 13:56:08 -0700
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
To: akpm@linux-foundation.org
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, galak@kernel.crashing.org


This patch set adds virtual resolutoin suppport for Freescale DIU driver.
Applications such as fbset can set visible resolution and virtual resoltuion.
X window can use the virtual resolution if xorg.conf has the following option.

option virtual <vxres> <vyres>


The second patch fixes a bug of AOI position.

Regards,

York


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
