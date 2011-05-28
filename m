From: Joe Perches <joe@perches.com>
Date: Sat, 28 May 2011 18:13:33 +0000
Subject: [TRIVIAL PATCH V2 next 12/15] video: Convert vmalloc/memset to
Message-Id: <1306606413.20336.9.camel@Joe-Laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1306603968.git.joe@perches.com>
	 <77538de911b8af99f68b7bcfbaaedce8e40db04f.1306603968.git.joe@perches.com>
	 <201105281948.12941.heiko@sntech.de>
In-Reply-To: <201105281948.12941.heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Jaya Kumar <jayalk@intworks.biz>, Paul Mundt <lethal@linux-sh.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jiri Kosina <trivial@kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org

Signed-off-by: Joe Perches <joe@perches.com>
---
Heiko St=C3=BCbner <heiko@sntech.de> pointed out I can't type...
s/vmalloc/vmalloc/ doesn't do much.

 drivers/video/arcfb.c        |    5 ++---
 drivers/video/broadsheetfb.c |    4 +---
 drivers/video/hecubafb.c     |    5 ++---
 drivers/video/metronomefb.c  |    4 +---
 drivers/video/xen-fbfront.c  |    3 +--
 5 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 3ec4923..86573e2 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -515,11 +515,10 @@ static int __devinit arcfb_probe(struct platform_devi=
ce *dev)
=20
 	/* We need a flat backing store for the Arc's
 	   less-flat actual paged framebuffer */
-	if (!(videomemory =3D vmalloc(videomemorysize)))
+	videomemory =3D vzalloc(videomemorysize);
+	if (!videomemory)
 		return retval;
=20
-	memset(videomemory, 0, videomemorysize);
-
 	info =3D framebuffer_alloc(sizeof(struct arcfb_par), &dev->dev);
 	if (!info)
 		goto err;
diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
index ebda687..377dde3 100644
--- a/drivers/video/broadsheetfb.c
+++ b/drivers/video/broadsheetfb.c
@@ -1101,12 +1101,10 @@ static int __devinit broadsheetfb_probe(struct plat=
form_device *dev)
=20
 	videomemorysize =3D roundup((dpyw*dpyh), PAGE_SIZE);
=20
-	videomemory =3D vmalloc(videomemorysize);
+	videomemory =3D vzalloc(videomemorysize);
 	if (!videomemory)
 		goto err_fb_rel;
=20
-	memset(videomemory, 0, videomemorysize);
-
 	info->screen_base =3D (char *)videomemory;
 	info->fbops =3D &broadsheetfb_ops;
=20
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index 1b94643..fbef15f 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -231,11 +231,10 @@ static int __devinit hecubafb_probe(struct platform_d=
evice *dev)
=20
 	videomemorysize =3D (DPY_W*DPY_H)/8;
=20
-	if (!(videomemory =3D vmalloc(videomemorysize)))
+	videomemory =3D vzalloc(videomemorysize);
+	if (!videomemory)
 		return retval;
=20
-	memset(videomemory, 0, videomemorysize);
-
 	info =3D framebuffer_alloc(sizeof(struct hecubafb_par), &dev->dev);
 	if (!info)
 		goto err_fballoc;
diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index ed64edf..97d45e5 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -628,12 +628,10 @@ static int __devinit metronomefb_probe(struct platfor=
m_device *dev)
 	/* we need to add a spare page because our csum caching scheme walks
 	 * to the end of the page */
 	videomemorysize =3D PAGE_SIZE + (fw * fh);
-	videomemory =3D vmalloc(videomemorysize);
+	videomemory =3D vzalloc(videomemorysize);
 	if (!videomemory)
 		goto err_fb_rel;
=20
-	memset(videomemory, 0, videomemorysize);
-
 	info->screen_base =3D (char __force __iomem *)videomemory;
 	info->fbops =3D &metronomefb_ops;
=20
diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index a20218c..beac52f 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -395,10 +395,9 @@ static int __devinit xenfb_probe(struct xenbus_device =
*dev,
 	spin_lock_init(&info->dirty_lock);
 	spin_lock_init(&info->resize_lock);
=20
-	info->fb =3D vmalloc(fb_size);
+	info->fb =3D vzalloc(fb_size);
 	if (info->fb =3D NULL)
 		goto error_nomem;
-	memset(info->fb, 0, fb_size);
=20
 	info->nr_pages =3D (fb_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
=20
--=20


