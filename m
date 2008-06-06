From: Jean Delvare <khali@linux-fr.org>
Subject: radeonfb monid i2c bus
Date: Fri, 6 Jun 2008 12:01:51 +0200
Message-ID: <20080606120151.7976df45@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4Yls-0004MM-A1 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 03:02:08 -0700
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K4Ylq-000224-OF
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 03:02:08 -0700
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Ben,

Can you explain what is the "monid" i2c bus on Radeon adapters? I have
two Radeon chips here, an M6 in my old laptop and a 9200 in my desktop
system. On the M6 there is nothing on the monid bus. On the 9200, the
monid bus doesn't even work, every access results in timeout. The
radeonfb driver doesn't even look for EDID EEPROMs on that bus (except
in debug code.)

So I'm curious why you create this i2c bus if you don't need it.
Have you ever seen a Radeon adapter where there is something on that
bus?

Thanks,
-- 
Jean Delvare

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
