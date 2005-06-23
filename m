From: Jon Smirl <jonsmirl@gmail.com>
Subject: PATCH: virtual_printk.patch
Date: Thu, 23 Jun 2005 15:47:53 -0400
Message-ID: <9e47339105062312473e885387@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlXg6-0005do-DH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 12:47:58 -0700
Received: from wproxy.gmail.com ([64.233.184.196])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DlXg5-0004Un-0Y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 12:47:58 -0700
Received: by wproxy.gmail.com with SMTP id 69so213139wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Jun 2005 12:47:53 -0700 (PDT)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

Patch to remove unneeded fbsysfs printk.

--
Jon Smirl
jonsmirl@gmail.com

#Remove unneeded fbsysfs printk
#Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -228,8 +228,6 @@ static ssize_t store_virtual(struct clas
 =09if (last - buf >=3D count)
 =09=09return -EINVAL;
 =09var.yres_virtual =3D simple_strtoul(last, &last, 0);
-=09printk(KERN_ERR "fb: xres %d yres %d\n", var.xres_virtual,
-=09       var.yres_virtual);
=20
 =09if ((err =3D activate(fb_info, &var)))
 =09=09return err;
 }
=20
 static ssize_t store_cmap(struct class_device *class_device, const char * =
buf,


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
