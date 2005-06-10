From: Jon Smirl <jonsmirl@gmail.com>
Subject: Typo in fbdev sysfs support, virtual_size
Date: Fri, 10 Jun 2005 19:21:44 -0400
Message-ID: <9e47339105061016213195fb86@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dgsox-0005rF-VI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 16:21:51 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dgsow-00021q-Cm
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 16:21:51 -0700
Received: by wproxy.gmail.com with SMTP id 69so622787wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jun 2005 16:21:44 -0700 (PDT)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>, lkml <linux-kernel@vger.kernel.org>

It prints out x,x instead of x,y.

Signed-off-by: jonsmirl@gmail.com <Jon Smirl>
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -241,7 +241,7 @@ static ssize_t show_virtual(struct class
 =09struct fb_info *fb_info =3D
 =09=09(struct fb_info *)class_get_devdata(class_device);
 =09return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xres_virtual,
-=09=09=09fb_info->var.xres_virtual);
+=09=09=09fb_info->var.yres_virtual);
 }
=20
 static ssize_t store_cmap(struct class_device *class_device, const char * =
buf,

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
