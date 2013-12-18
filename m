From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 18 Dec 2013 07:42:35 +0000
Subject: cirrusdrmfb broken with simplefb
Message-Id: <s5hlhzik3kk.wl%tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, linux-fbdev@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

Hi,

with the recent enablement of simplefb on x86, cirrusdrmfb on QEMU/KVM
gets broken now, as reported at:
    https://bugzilla.novell.com/show_bug.cgi?id=855821

The cirrus VGA resource is reserved at first as "BOOTFB" in
arch/x86/kernel/sysfb_simplefb.c, which is taken by simplefb platform
device.  This resource is, however, never released until the platform
device is destroyed, and the framebuffer switching doesn't trigger
it.  It calls fb's destroy callback, at most.  Then, cirrus driver
tries to assign the resource, fails and gives up, resulting in a
complete blank screen.

The same problem should exist on other KMS drivers like mgag200 or
ast, not only cirrus.  Intel graphics doesn't hit this problem just
because the reserved iomem by BOOTFB isn't required by i915 driver.

The patch below is a quick attempt to solve the issue.  It adds a new
API function for releasing resources of platform_device, and call it
in destroy op of simplefb.  But, forcibly releasing resources of a
parent device doesn't sound like a correct design.  We may take such
as a band aid, but definitely need a more fundamental fix.

Any thoughts?


thanks,

Takashi

---
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3a94b79..f939236 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -267,6 +267,23 @@ int platform_device_add_data(struct platform_device *p=
dev, const void *data,
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
=20
+static void do_release_resources(struct platform_device *pdev, int nums)
+{
+	int i;
+
+	for (i =3D 0; i < nums; i++) {
+		struct resource *r =3D &pdev->resource[i];
+		unsigned long type =3D resource_type(r);
+
+		if (type =3D IORESOURCE_MEM || type =3D IORESOURCE_IO)
+			release_resource(r);
+	}
+
+	kfree(pdev->resource);
+	pdev->resource =3D NULL;
+	pdev->num_resources =3D 0;
+}
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
@@ -342,13 +359,7 @@ int platform_device_add(struct platform_device *pdev)
 		pdev->id =3D PLATFORM_DEVID_AUTO;
 	}
=20
-	while (--i >=3D 0) {
-		struct resource *r =3D &pdev->resource[i];
-		unsigned long type =3D resource_type(r);
-
-		if (type =3D IORESOURCE_MEM || type =3D IORESOURCE_IO)
-			release_resource(r);
-	}
+	do_release_resources(pdev, i - 1);
=20
  err_out:
 	return ret;
@@ -365,8 +376,6 @@ EXPORT_SYMBOL_GPL(platform_device_add);
  */
 void platform_device_del(struct platform_device *pdev)
 {
-	int i;
-
 	if (pdev) {
 		device_del(&pdev->dev);
=20
@@ -375,17 +384,17 @@ void platform_device_del(struct platform_device *pdev)
 			pdev->id =3D PLATFORM_DEVID_AUTO;
 		}
=20
-		for (i =3D 0; i < pdev->num_resources; i++) {
-			struct resource *r =3D &pdev->resource[i];
-			unsigned long type =3D resource_type(r);
-
-			if (type =3D IORESOURCE_MEM || type =3D IORESOURCE_IO)
-				release_resource(r);
-		}
+		do_release_resources(pdev, pdev->num_resources);
 	}
 }
 EXPORT_SYMBOL_GPL(platform_device_del);
=20
+void platform_device_release_resources(struct platform_device *pdev)
+{
+	do_release_resources(pdev, pdev->num_resources);
+}
+EXPORT_SYMBOL_GPL(platform_device_release_resources);
+
 /**
  * platform_device_register - add a platform-level device
  * @pdev: platform device we're adding
diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 210f3a0..fbf5e89 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -70,6 +70,7 @@ static void simplefb_destroy(struct fb_info *info)
 {
 	if (info->screen_base)
 		iounmap(info->screen_base);
+	platform_device_release_resources(to_platform_device(info->device));
 }
=20
 static struct fb_ops simplefb_ops =3D {
diff --git a/include/linux/platform_device.h b/include/linux/platform_devic=
e.h
index 16f6654..7cc1f54 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -42,6 +42,7 @@ struct platform_device {
=20
 extern int platform_device_register(struct platform_device *);
 extern void platform_device_unregister(struct platform_device *);
+extern void platform_device_release_resources(struct platform_device *pdev=
);
=20
 extern struct bus_type platform_bus_type;
 extern struct device platform_bus;
