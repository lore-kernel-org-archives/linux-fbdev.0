From: Jon Smirl <jonsmirl@gmail.com>
Subject: Third repost: freq_rounding.patch
Date: Wed, 13 Jul 2005 18:22:03 -0400
Message-ID: <9e47339105071315225ebfe20b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DspdH-0005rG-7T
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Jul 2005 15:23:11 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DspdG-0001pm-0A
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Jul 2005 15:23:11 -0700
Received: by wproxy.gmail.com with SMTP id 36so293637wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 13 Jul 2005 15:23:03 -0700 (PDT)
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

Can we get this into the kernel?=20

--
Jon Smirl
jonsmirl@gmail.com

#Fix rounding error when mode frequency is very close to monitor limit
#Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1241,6 +1241,8 @@ int fb_validate_mode(const struct fb_var
               vtotal *=3D 2;

       hfreq =3D pixclock/htotal;
+       hfreq =3D (hfreq + 500) / 1000 * 1000;
+
       vfreq =3D hfreq/vtotal;

       return (vfreq < vfmin || vfreq > vfmax ||


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
