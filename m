From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: Does FBDEV support dynamic
	configuration/selection of output device
Date: Wed, 11 Jun 2008 19:31:05 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C001DE5A2F4E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6QtC-0004BN-AP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jun 2008 07:01:27 -0700
Received: from arroyo.ext.ti.com ([192.94.94.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K6Qt7-0004Y3-Jd
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jun 2008 07:01:22 -0700
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5BE17NF010826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 11 Jun 2008 09:01:12 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5BE15l2024423
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 11 Jun 2008 09:01:06 -0500 (CDT)
Content-Language: en-US
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
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Hi all:

I am under an impression that FBDEV doesn't support dynamic selection/configuring of output devices.

The scenario is as below,

On many TI OMAP Platforms we have LCD, DVI, S-Video, as outputs to our OMAP FBDEV driver, basically the FBDEV driver is configured to render Framebuffer to one of these Panels.

But the requirement is to dynamically switch the framebuffer to S-Video or DVI or LCD and viceversa.

I would like to know if there is an ioctl that can be used from application layer to make this dynamic switch.

Any suggestion in handling this is appreciated.

Thanks

Regards,
Khasim

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
