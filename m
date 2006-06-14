From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 0/7 2.6.17-rc6-mm2] add preliminary i2c
	support to intelfb
Date: Wed, 14 Jun 2006 13:52:41 -0400
Message-ID: <03A6DAFF-D4B4-4806-8954-DCB12F8C2064@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqZVB-00017P-UB for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:01 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqZVA-0001Kb-Ng
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:01 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>

Hi,

here is another set of patches to the intelfb -- these require the  
vsync interrupt patch I sent out earlier today to apply cleanly, but  
it does not depend on it's functionality.

these patches add preliminary i2c support to the intelfb driver.   
Currently, they just register the i2c busses that the chipset  
provides.  I plan to use this support when I port over Dave's SDVO  
support from the X.org driver.

this code is based heavily on Dave's x.org driver and the aty driver.

dennis
