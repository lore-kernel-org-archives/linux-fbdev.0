From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 29 Nov 2019 10:29:41 +0000
Subject: [PATCH v2 11/14] HID: picoLCD: constify fb ops
Message-Id: <8678a9a3566279c881bb4db944850eef35d0a4bb.1575022735.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org

Now that the fbops member of struct fb_info is const, we can start
making the ops const as well.

v2: fix	typo (Christophe de Dinechin)

Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/hid/hid-picolcd_fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index e162a668fb7e..a549c42e8c90 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -417,8 +417,7 @@ static int picolcd_set_par(struct fb_info *info)
 	return 0;
 }
=20
-/* Note this can't be const because of struct fb_info definition */
-static struct fb_ops picolcdfb_ops =3D {
+static const struct fb_ops picolcdfb_ops =3D {
 	.owner        =3D THIS_MODULE,
 	.fb_destroy   =3D picolcd_fb_destroy,
 	.fb_read      =3D fb_sys_read,
--=20
2.20.1
