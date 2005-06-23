From: Jon Smirl <jonsmirl@gmail.com>
Subject: REPOST PATCH: radeon_del_edid.patch
Date: Thu, 23 Jun 2005 15:43:19 -0400
Message-ID: <9e4733910506231243191d7bd6@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlXbg-0005GA-Je
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 12:43:24 -0700
Received: from wproxy.gmail.com ([64.233.184.207])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DlXbe-0002kE-5h
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 12:43:24 -0700
Received: by wproxy.gmail.com with SMTP id 37so678339wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Jun 2005 12:43:21 -0700 (PDT)
Content-Disposition: inline
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

What is the status of this patch? It hasn't made it into linus' tree yet.

--
Jon Smirl
jonsmirl@gmail.com

#radeonfb does not clean up EDID sysfs attribute
#Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_bas=
e.c
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -2522,6 +2522,11 @@ static void __devexit radeonfb_pci_unreg
 =20
 =09radeonfb_pm_exit(rinfo);
=20
+=09if (rinfo->mon1_EDID)
+=09=09sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
+=09if (rinfo->mon2_EDID)
+=09=09sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+
 #if 0
 =09/* restore original state
 =09 *


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
