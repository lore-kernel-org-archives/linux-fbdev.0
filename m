From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:13 +0000
Subject: [PATCH v2 12/15] drm/fbconv: Add helper documentation
Message-Id: <20191014140416.28517-13-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

There's now a tutorial on how to create a DRM driver on top of fbconv
helpers. The DRM TODO list contains an entry for converting fbdev
drivers over to DRM.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 Documentation/gpu/drm-kms-helpers.rst |  12 ++
 Documentation/gpu/todo.rst            |  15 +++
 drivers/gpu/drm/drm_fbconv_helper.c   | 181 ++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index 9668a7fe2408..1232a3ef24ff 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -411,3 +411,15 @@ SHMEM GEM Helper Reference
 
 .. kernel-doc:: drivers/gpu/drm/drm_gem_shmem_helper.c
    :export:
+
+fbdev Conversion Helper Reference
+================+
+.. kernel-doc:: drivers/gpu/drm/drm_fbconv_helper.c
+   :doc: fbconv helpers
+
+.. kernel-doc:: include/drm/drm_fbconv_helper.h
+   :internal:
+
+.. kernel-doc:: drivers/gpu/drm/drm_fbconv_helper.c
+   :export:
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 79785559d711..1be44a17f3e8 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -462,3 +462,18 @@ Contact: Sam Ravnborg
 
 Outside DRM
 =====+
+Convert fbdev drivers to DRM
+----------------------------
+
+There are plenty of fbdev drivers for old hardware. With fbconv helpers, we
+have a simple and clean way of transitioning fbdev drivers to DRM. Set up a
+simple DRM driver that builds onto the fbconv helpers, copy over the fbdev
+driver and connect both. This should result in a basic DRM driver that can
+run X11 and Weston.  There's a tutorial for this process with example source
+code in the fbconv documentation.
+
+From there, refactor the driver source code into a clean DRM driver that
+requires neither fbdev nor fbconv helpers.
+
+Contact: Thomas Zimmermann
diff --git a/drivers/gpu/drm/drm_fbconv_helper.c b/drivers/gpu/drm/drm_fbconv_helper.c
index 7d7e4da2a29e..1fa240a4789f 100644
--- a/drivers/gpu/drm/drm_fbconv_helper.c
+++ b/drivers/gpu/drm/drm_fbconv_helper.c
@@ -18,6 +18,187 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
+/**
+ * DOC: fbconv helpers
+ *
+ * The Linux kernel's fbdev subsystem provides a wide range of drivers for
+ * older graphics hardware. Except for these existng drivers, fbdev is
+ * deprecated and expected to be removed at some point in the future. All new
+ * development happens in DRM. Some of the fbdev drivers are worth carrying
+ * forward. The fbconv helper functions provide a framework for porting fbdev
+ * drivers to DRM.
+ *
+ * When porting over fbdev drivers to DRM, the most significant problem is the
+ * difference in how the internal driver interfaces work. Fbdev has a single
+ * function, struct fb_ops.fb_set_par(), to set video mode and framebuffer
+ * format. DRM use a much more fine-grained interface. In fbdev, framebuffer
+ * memory is managed by a single client, while in DRM multiple clients can
+ * hold buffers with framebuffer data.
+ *
+ * The fbconv helper library provides a set of data structures and functions
+ * that connect DRM and fbdev. The resulting DRM driver maps DRM operations
+ * to fbdev interfaces and uses an fbdev driver for its hardware operations.
+ * Such a driver is not intended to be merged into DRM as-is. It does,
+ * however, provide a starting point for refactoring the fbdev driver's
+ * implementation into first-class DRM code.
+ *
+ * As an example, we create a DRM driver from vesafb, fbdev's generic
+ * vesa driver. We begin by creating a DRM stub driver vesadrm. Please keep
+ * in mind that the provided code is for illustrative purposes and requires
+ * error handling.
+ *
+ * .. code-block:: c
+ *
+ *	DEFINE_DRM_GEM_SHMEM_FOPS(vesadrm_file_operations);
+ *
+ *	static struct drm_driver vesadrm_driver = {
+ *		.major = 1,
+ *		.minor = 0,
+ *		.patchlevel = 0,
+ *		.name = "vesadrm",
+ *		.desc = "DRM VESA driver",
+ *		.date = "01/01/1970",
+ *		.driver_features = DRIVER_ATOMIC |
+ *				   DRIVER_GEM |
+ *				   DRIVER_MODESET,
+ *		.fops = &vesadrm_file_operations,
+ *		DRM_GEM_SHMEM_DRIVER_OPS,
+ *	};
+ *
+ * Fbconv uses SHMEM, so we set up the structures accordingly.
+ *
+ * The fbdev code usually calls register_framebuffer() and
+ * unregister_framebuffer() to connect and disconnect itself to the fbdev
+ * core code. In our case, we replace these calls with
+ * vesadrm_register_framebuffer() and vesadrm_unregister_framebuffer(), which
+ * serve as entry points for vesafb.
+ *
+ * .. code-block:: c
+ *
+ *	#include <drm/drm/fbconv_helper.h>
+ *
+ *	struct vesadrm_device {
+ *		struct drm_device dev;
+ *		struct fb_info *fb_info;
+ *
+ *		struct drm_fbconv_modeset modeset;
+ *	};
+ *
+ *	struct vesadrm_device* vesadrm_register_framebuffer(struct fb_info *fb_info)
+ *	{
+ *		struct vesadrm *vdev;
+ *
+ *		drm_fbconv_fill_fb_info(fb_info);
+ *
+ *		vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+ *		vesadrm_device_init(vdev, &vesadrm_driver, fb_info)
+ *
+ *		drm_dev_register(&vdev->dev, 0);
+ *
+ *		return vdev;
+ *	}
+ *
+ * Here, we have the first references to fbconf helpers. The instance
+ * of struct drm_fbconv_modeset is the central data structure for fbconv.
+ * Built upon struct drm_simple_display_pipe, it stores most state for the
+ * DRM driver.
+ *
+ * The function vesadrm_register_framebuffer() will later be called by
+ * vesafb code with the fbdev driver's fb_info structure. In core fbdev,
+ * register_framebuffer() would fill fb_info with general state and complete
+ * registration. With fbconv helpers, drm_fbconv_fill_fb_info() does this.
+ * It's a simplified version of the fbdev setup process, without device file
+ * creation, registration, or events. No console is created either.
+ * Finally vesadrm_register_framebuffer() initializes the vesadrm device and
+ * registers the DRM device. At this point, vesadrm is completely initialized.
+ *
+ * For completeness, here's the implementation of
+ * vesadrm_unregister_framebuffer(), which shuts the device down.
+ *
+ * .. code-block:: c
+ *
+ *	void vesadrm_unregister_framebuffer(struct vesadrm_device *vdev)
+ *	{
+ *		struct fb_info *fb_info = vdev->fb_info;
+ *
+ *		vesadrm_device_cleanup(vdev);
+ *		kfree(vdev);
+ *		drm_fbconv_cleanup_fb_info(fb_info);
+ *	}
+ *
+ * Next we need an implementation of vesadrm_device_init() and
+ * vesadrm_device_cleanup(). These functions handle the details of
+ * device configuration and console setup. As all this functionality
+ * is provided by helpers, the actual implementation is fairly small.
+ *
+ * .. code-block:: c
+ *
+ *	static int vesadrm_device_init(struct vesadrm_device *vdev,
+ *				       struct drm_driver *drv,
+ *				       struct fb_info *fb_info)
+ *	{
+ *		static const uint32_t formats[] = {
+ *			DRM_FORMAT_XRGB8888,
+ *			DRM_FORMAT_RGB565
+ *		};
+ *		static unsigned int max_width = 1600;
+ *		static unsigned int max_height = 1200;
+ *		static unsigned int preferred_depth = 32;
+ *
+ *		drm_dev_init(&vdev->dev, drv, fb_info->device);
+ *
+ *		vdev->dev.dev_private = vdev;
+ *		vdev->dev.pdev = container_of(fb_info->device, struct pci_dev, dev);
+ *		vdev->fb_info = fb_info;
+ *
+ *		drm_fbconv_modeset_init(&vdev->modeset, &vdev->dev, fb_info,
+ *					max_width, max_height, preferred_depth);
+ *
+ *		drm_fbconv_modeset_setup_pipe(&vdev->modeset, NULL, formats,
+ *					      ARRAY_SIZE(formats), NULL, NULL);
+ *
+ *		drm_fbdev_generic_setup(&vdev->dev, 0);
+ *
+ *		return 0;
+ *	}
+ *
+ *	static void vesadrm_device_cleanup(struct vesadrm_device *vdev)
+ *	{
+ *		struct drm_device *dev = &vdev->dev;
+ *
+ *		drm_fbconv_modeset_cleanup(&vdev->modeset);
+ *
+ *		drm_dev_fini(dev);
+ *		dev->dev_private = NULL;
+ *	}
+ *
+ * In vesadrm_device_init(), several device-specific constants are declared.
+ * Depending on the hardware, drivers should set them accordingly.
+ * The call to drm_fbconv_modeset_init() initializes fbconv modesetting
+ * helpers with these device constants.
+ *
+ * The drm_fbconv_modeset_setup_pipe() creates the simple display pipe with
+ * the specified color formats. By default, everything is set up
+ * automatically. But the function also accepts format modifiers, a DRM
+ * connector, and call-back functions for struct drm_simple_display_pipe.
+ * So each of these can be refactored individually later on.
+ *
+ * After setting up the fbconv helpers, there's is a call to
+ * drm_fbdev_generic_setup(), which set an initial mode and creates a
+ * framebuffer console.
+ *
+ * The implementation of vesadrm_device_cleanup() is the inverse of the
+ * init function. It cleans up the fbconv modesetting helper and releases
+ * the DRM device.
+ *
+ * What is left is connecting vesafb to vesadrm. As a first step, we need a
+ * copy the vesafb source files into the vesadrm driver and make them compile.
+ * Once this is done, we have to replace the call to register_framebuffer()
+ * with a call to vesadrm_register_framebuffer(), and unregister_framebuffer()
+ * with vesadrm_unregister_framebuffer(). We have now disconnected vesafb from
+ * the fbdev core and run it as part of DRM.
+ */
+
 /*
  * Format conversion helpers
  */
-- 
2.23.0
