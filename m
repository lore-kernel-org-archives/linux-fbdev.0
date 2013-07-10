From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Wed, 10 Jul 2013 13:08:59 +0000
Subject: =?UTF-8?q?=5BPATCH=5D=20omapfb=3A=20In=20omapfb=5Fprobe=20return=20-EPROBE=5FDEFER=20when=20display=
Message-Id: <1373461739-10168-1-git-send-email-pali.rohar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

* On RX-51 probing for acx565akm driver is later then for omapfb which caus=
e that omapfb probe fail and framebuffer is not working
* EPROBE_DEFER causing that kernel try to probe for omapfb later again whic=
h fixing this problem

* Without this patch display on Nokia RX-51 (N900) phone not working

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2=
/omapfb/omapfb-main.c
index 856917b..93e7c84 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2419,6 +2419,15 @@ static int omapfb_probe(struct platform_device *pdev)
 	if (omapdss_is_initialized() =3D false)
 		return -EPROBE_DEFER;
=20
+	dssdev =3D NULL;
+	for_each_dss_dev(dssdev) {
+		if (!dssdev->driver) {
+			dev_warn(&pdev->dev, "no driver for display: %s\n",
+				dssdev->name);
+			return -EPROBE_DEFER;
+		}
+	}
+
 	if (pdev->num_resources !=3D 0) {
 		dev_err(&pdev->dev, "probed for an unknown device\n");
 		r =3D -ENODEV;
--=20
1.7.10.4

