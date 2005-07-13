From: Jon Smirl <jonsmirl@gmail.com>
Subject: Third repost: radeon_del_edid.patch
Date: Wed, 13 Jul 2005 18:26:10 -0400
Message-ID: <9e47339105071315266b17e155@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dsph6-00066o-NM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Jul 2005 15:27:08 -0700
Received: from wproxy.gmail.com ([64.233.184.203])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1Dsph5-0002Tg-Gb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Jul 2005 15:27:08 -0700
Received: by wproxy.gmail.com with SMTP id 58so293238wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 13 Jul 2005 15:27:01 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Can we get this into the kernel?

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

      radeonfb_pm_exit(rinfo);

+       if (rinfo->mon1_EDID)
+               sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
+       if (rinfo->mon2_EDID)
+               sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+
 #if 0
      /* restore original state
       *


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
