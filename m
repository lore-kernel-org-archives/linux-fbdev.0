From: David Lechner <david@lechnology.com>
Date: Sat, 29 Jul 2017 19:30:14 +0000
Subject: Re: [PATCH 3/6] drm/tinydrm: rename mi028qt module to mipi-panel
Message-Id: <cbee2b61-814b-0bd6-1458-53c81a914e31@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <1501355870-13960-4-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-4-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/29/2017 02:17 PM, David Lechner wrote:
> This renames the mi028qt module to mipi-panel so that it can be used for
> other types of panels as well. There is no reason to copy a bunch of
> boiler-plate code for each panel or controller.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>   .../devicetree/bindings/display/mipi-panel.txt     |  27 ++
>   .../bindings/display/multi-inno,mi0283qt.txt       |  27 --
>   MAINTAINERS                                        |   6 +-
>   drivers/gpu/drm/tinydrm/Kconfig                    |  12 +-
>   drivers/gpu/drm/tinydrm/Makefile                   |   2 +-
>   drivers/gpu/drm/tinydrm/mi0283qt.c                 | 283 --------------------
>   drivers/gpu/drm/tinydrm/mipi-panel.c               | 284 +++++++++++++++++++++
>   7 files changed, 323 insertions(+), 318 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/display/mipi-panel.txt
>   delete mode 100644 Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
>   delete mode 100644 drivers/gpu/drm/tinydrm/mi0283qt.c
>   create mode 100644 drivers/gpu/drm/tinydrm/mipi-panel.c
> 

Apparently, I missed an option on git format-patch. This diff should be 
easier to look at...

---

diff --git 
a/Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt 
b/Documentation/devicetree/bindings/display/mipi-panel.txt
similarity index 94%
rename from 
Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
rename to Documentation/devicetree/bindings/display/mipi-panel.txt
index eed48c3..01d6ea9 100644
--- a/Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
+++ b/Documentation/devicetree/bindings/display/mipi-panel.txt
@@ -1,4 +1,4 @@
-Multi-Inno MI0283QT display panel
+MIPI DBI compatible display panel

  Required properties:
  - compatible:  "multi-inno,mi0283qt".
@@ -17,7 +17,7 @@ Optional properties:
  - rotation:    panel rotation in degrees counter clockwise (0,90,180,270)

  Example:
-       mi0283qt@0{
+       display@0{
                 compatible = "multi-inno,mi0283qt";
                 reg = <0>;
                 spi-max-frequency = <32000000>;
diff --git a/MAINTAINERS b/MAINTAINERS
index f66488d..812ffd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4315,11 +4315,11 @@ M:      Dave Airlie <airlied@redhat.com>
  S:     Odd Fixes
  F:     drivers/gpu/drm/mgag200/

-DRM DRIVER FOR MI0283QT
+DRM DRIVER FOR MIPI DBI compatible panels
  M:     Noralf Trønnes <noralf@tronnes.org>
  S:     Maintained
-F:     drivers/gpu/drm/tinydrm/mi0283qt.c
-F:     Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
+F:     drivers/gpu/drm/tinydrm/mipi-panel.c
+F:     Documentation/devicetree/bindings/display/mipi-panel.txt

  DRM DRIVER FOR MSM ADRENO GPU
  M:     Rob Clark <robdclark@gmail.com>
diff --git a/drivers/gpu/drm/tinydrm/Kconfig 
b/drivers/gpu/drm/tinydrm/Kconfig
index 3504c53..0a0db7a 100644
--- a/drivers/gpu/drm/tinydrm/Kconfig
+++ b/drivers/gpu/drm/tinydrm/Kconfig
@@ -12,10 +12,14 @@ menuconfig DRM_TINYDRM
  config TINYDRM_MIPI_DBI
         tristate

-config TINYDRM_MI0283QT
-       tristate "DRM support for MI0283QT"
+config TINYDRM_MIPI_PANEL
+       tristate "DRM support for MIPI DBI compatible display panels"
         depends on DRM_TINYDRM && SPI
         select TINYDRM_MIPI_DBI
         help
-         DRM driver for the Multi-Inno MI0283QT display panel
-         If M is selected the module will be called mi0283qt.
+         DRM driver for the MIPI DBI compatible display panels.
+
+         Supported panels include:
+         * Multi-Inno MI0283QT
+
+         If M is selected the module will be called mipi-panel.
diff --git a/drivers/gpu/drm/tinydrm/Makefile 
b/drivers/gpu/drm/tinydrm/Makefile
index 7a3604c..7eae65e 100644
--- a/drivers/gpu/drm/tinydrm/Makefile
+++ b/drivers/gpu/drm/tinydrm/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_DRM_TINYDRM)               += core/
  obj-$(CONFIG_TINYDRM_MIPI_DBI)         += mipi-dbi.o

  # Displays
-obj-$(CONFIG_TINYDRM_MI0283QT)         += mi0283qt.o
+obj-$(CONFIG_TINYDRM_MIPI_PANEL)       += mipi-panel.o
diff --git a/drivers/gpu/drm/tinydrm/mi0283qt.c 
b/drivers/gpu/drm/tinydrm/mipi-panel.c
similarity index 76%
rename from drivers/gpu/drm/tinydrm/mi0283qt.c
rename to drivers/gpu/drm/tinydrm/mipi-panel.c
index 2680dab..64344f0 100644
--- a/drivers/gpu/drm/tinydrm/mi0283qt.c
+++ b/drivers/gpu/drm/tinydrm/mipi-panel.c
@@ -1,7 +1,8 @@
  /*
- * DRM driver for Multi-Inno MI0283QT panels
+ * DRM driver for MIPI DBI compatible panels
   *
   * Copyright 2016 Noralf Trønnes
+ * Copyright 2017 David Lechner <david@lechnology.com>
   *
   * This program is free software; you can redistribute it and/or modify
   * it under the terms of the GNU General Public License as published by
@@ -20,7 +21,7 @@
  #include <linux/spi/spi.h>
  #include <video/mipi_display.h>

-static int mi0283qt_init(struct mipi_dbi *mipi)
+static int mipi_panel_init(struct mipi_dbi *mipi)
  {
         struct tinydrm_device *tdev = &mipi->tinydrm;
         struct device *dev = tdev->drm->dev;
@@ -113,7 +114,7 @@ static int mi0283qt_init(struct mipi_dbi *mipi)
         return 0;
  }

-static void mi0283qt_fini(void *data)
+static void mipi_panel_fini(void *data)
  {
         struct mipi_dbi *mipi = data;

@@ -121,46 +122,46 @@ static void mi0283qt_fini(void *data)
         regulator_disable(mipi->regulator);
  }

-static const struct drm_simple_display_pipe_funcs mi0283qt_pipe_funcs = {
+static const struct drm_simple_display_pipe_funcs mipi_panel_pipe_funcs = {
         .enable = mipi_dbi_pipe_enable,
         .disable = mipi_dbi_pipe_disable,
         .update = tinydrm_display_pipe_update,
         .prepare_fb = tinydrm_display_pipe_prepare_fb,
  };

-static const struct drm_display_mode mi0283qt_mode = {
+static const struct drm_display_mode mipi_panel_mode = {
         TINYDRM_MODE(320, 240, 58, 43),
  };

-DEFINE_DRM_GEM_CMA_FOPS(mi0283qt_fops);
+DEFINE_DRM_GEM_CMA_FOPS(mipi_panel_fops);

-static struct drm_driver mi0283qt_driver = {
+static struct drm_driver mipi_panel_driver = {
         .driver_features        = DRIVER_GEM | DRIVER_MODESET | 
DRIVER_PRIME |
                                   DRIVER_ATOMIC,
-       .fops                   = &mi0283qt_fops,
+       .fops                   = &mipi_panel_fops,
         TINYDRM_GEM_DRIVER_OPS,
         .lastclose              = tinydrm_lastclose,
         .debugfs_init           = mipi_dbi_debugfs_init,
-       .name                   = "mi0283qt",
-       .desc                   = "Multi-Inno MI0283QT",
+       .name                   = "mipi-panel",
+       .desc                   = "MIPI DBI compatible panel",
         .date                   = "20160614",
         .major                  = 1,
         .minor                  = 0,
  };

-static const struct of_device_id mi0283qt_of_match[] = {
+static const struct of_device_id mipi_panel_of_match[] = {
         { .compatible = "multi-inno,mi0283qt" },
         {},
  };
-MODULE_DEVICE_TABLE(of, mi0283qt_of_match);
+MODULE_DEVICE_TABLE(of, mipi_panel_of_match);

-static const struct spi_device_id mi0283qt_id[] = {
+static const struct spi_device_id mipi_panel_id[] = {
         { "mi0283qt", 0 },
         { },
  };
-MODULE_DEVICE_TABLE(spi, mi0283qt_id);
+MODULE_DEVICE_TABLE(spi, mipi_panel_id);

-static int mi0283qt_probe(struct spi_device *spi)
+static int mipi_panel_probe(struct spi_device *spi)
  {
         struct device *dev = &spi->dev;
         struct tinydrm_device *tdev;
@@ -195,20 +196,20 @@ static int mi0283qt_probe(struct spi_device *spi)

         device_property_read_u32(dev, "rotation", &rotation);

-       ret = mipi_dbi_spi_init(spi, mipi, dc, &mi0283qt_pipe_funcs,
-                               &mi0283qt_driver, &mi0283qt_mode,
+       ret = mipi_dbi_spi_init(spi, mipi, dc, &mipi_panel_pipe_funcs,
+                               &mipi_panel_driver, &mipi_panel_mode,
                                 MIPI_DCS_PIXEL_FMT_16BIT, rotation);
         if (ret)
                 return ret;

-       ret = mi0283qt_init(mipi);
+       ret = mipi_panel_init(mipi);
         if (ret)
                 return ret;

         /* use devres to fini after drm unregister (drv->remove is 
before) */
-       ret = devm_add_action(dev, mi0283qt_fini, mipi);
+       ret = devm_add_action(dev, mipi_panel_fini, mipi);
         if (ret) {
-               mi0283qt_fini(mipi);
+               mipi_panel_fini(mipi);
                 return ret;
         }

@@ -228,14 +229,14 @@ static int mi0283qt_probe(struct spi_device *spi)
         return 0;
  }

-static void mi0283qt_shutdown(struct spi_device *spi)
+static void mipi_panel_shutdown(struct spi_device *spi)
  {
         struct mipi_dbi *mipi = spi_get_drvdata(spi);

         tinydrm_shutdown(&mipi->tinydrm);
  }

-static int __maybe_unused mi0283qt_pm_suspend(struct device *dev)
+static int __maybe_unused mipi_panel_pm_suspend(struct device *dev)
  {
         struct mipi_dbi *mipi = dev_get_drvdata(dev);
         int ret;
@@ -244,40 +245,40 @@ static int __maybe_unused 
mi0283qt_pm_suspend(struct device *dev)
         if (ret)
                 return ret;

-       mi0283qt_fini(mipi);
+       mipi_panel_fini(mipi);

         return 0;
  }

-static int __maybe_unused mi0283qt_pm_resume(struct device *dev)
+static int __maybe_unused mipi_panel_pm_resume(struct device *dev)
  {
         struct mipi_dbi *mipi = dev_get_drvdata(dev);
         int ret;

-       ret = mi0283qt_init(mipi);
+       ret = mipi_panel_init(mipi);
         if (ret)
                 return ret;

         return tinydrm_resume(&mipi->tinydrm);
  }

-static const struct dev_pm_ops mi0283qt_pm_ops = {
-       SET_SYSTEM_SLEEP_PM_OPS(mi0283qt_pm_suspend, mi0283qt_pm_resume)
+static const struct dev_pm_ops mipi_panel_pm_ops = {
+       SET_SYSTEM_SLEEP_PM_OPS(mipi_panel_pm_suspend, mipi_panel_pm_resume)
  };

-static struct spi_driver mi0283qt_spi_driver = {
+static struct spi_driver mipi_panel_spi_driver = {
         .driver = {
-               .name = "mi0283qt",
+               .name = "mipi-panel",
                 .owner = THIS_MODULE,
-               .of_match_table = mi0283qt_of_match,
-               .pm = &mi0283qt_pm_ops,
+               .of_match_table = mipi_panel_of_match,
+               .pm = &mipi_panel_pm_ops,
         },
-       .id_table = mi0283qt_id,
-       .probe = mi0283qt_probe,
-       .shutdown = mi0283qt_shutdown,
+       .id_table = mipi_panel_id,
+       .probe = mipi_panel_probe,
+       .shutdown = mipi_panel_shutdown,
  };
-module_spi_driver(mi0283qt_spi_driver);
+module_spi_driver(mipi_panel_spi_driver);

-MODULE_DESCRIPTION("Multi-Inno MI0283QT DRM driver");
+MODULE_DESCRIPTION("MIPI DBI panel DRM driver");
  MODULE_AUTHOR("Noralf Trønnes");
  MODULE_LICENSE("GPL");
--
2.7.4
