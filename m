From: Jon Smirl <jonsmirl@gmail.com>
Subject: REPOST PATCH: unregister_chrdev.patch
Date: Thu, 23 Jun 2005 15:27:17 -0400
Message-ID: <9e4733910506231227572e2dc8@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlXM7-00049X-ON
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 12:27:19 -0700
Received: from wproxy.gmail.com ([64.233.184.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DlXM6-00005z-7Y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 12:27:19 -0700
Received: by wproxy.gmail.com with SMTP id 69so202048wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Jun 2005 12:27:17 -0700 (PDT)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

This one has not made it to linus either.

--=20
Jon Smirl
jonsmirl@gmail.com

#fbdev is missing unregister_chrdev() on unload
#Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1164,6 +1164,7 @@ static void __exit
 fbmem_exit(void)
 {
 =09class_destroy(fb_class);
+=09unregister_chrdev(FB_MAJOR, "fb");
 }
=20
 module_exit(fbmem_exit);


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
