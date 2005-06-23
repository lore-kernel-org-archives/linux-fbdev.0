From: Jon Smirl <jonsmirl@gmail.com>
Subject: REPOST PATCH: freq_rounding.patch
Date: Thu, 23 Jun 2005 15:22:40 -0400
Message-ID: <9e473391050623122258f26080@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlXHf-0003mM-88
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 12:22:43 -0700
Received: from wproxy.gmail.com ([64.233.184.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DlXHd-0007v5-Sr
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 12:22:43 -0700
Received: by wproxy.gmail.com with SMTP id 69so199886wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Jun 2005 12:22:40 -0700 (PDT)
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

What is the status of this patch? It hasn't made it into linus' tree yet.

--=20
Jon Smirl
jonsmirl@gmail.com

#Fix rounding error when mode frequency is very close to monitor limit
#Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1241,6 +1241,8 @@ int fb_validate_mode(const struct fb_var
 =09=09vtotal *=3D 2;
=20
 =09hfreq =3D pixclock/htotal;
+=09hfreq =3D (hfreq + 500) / 1000 * 1000;
+=09
 =09vfreq =3D hfreq/vtotal;
=20
 =09return (vfreq < vfmin || vfreq > vfmax ||


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
