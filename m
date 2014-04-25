From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 25 Apr 2014 21:16:39 +0000
Subject: [PATCH RFC 01/17] ASoC: omap-pcm: Move omap-pcm under include/sound
Message-Id: <6b5197d4e9bc94bf617bc5e5add990fa6287089e.1398453425.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1398453425.git.jsarha@ti.com>
In-Reply-To: <cover.1398453425.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Make including the omap-pcm.h outside sound/soc/omap more convenient.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 include/sound/omap-pcm.h          |   30 ++++++++++++++++++++++++++++++
 sound/soc/davinci/davinci-mcasp.c |    2 +-
 sound/soc/omap/omap-dmic.c        |    2 +-
 sound/soc/omap/omap-hdmi.c        |    2 +-
 sound/soc/omap/omap-mcbsp.c       |    2 +-
 sound/soc/omap/omap-mcpdm.c       |    2 +-
 sound/soc/omap/omap-pcm.h         |   30 ------------------------------
 7 files changed, 35 insertions(+), 35 deletions(-)
 create mode 100644 include/sound/omap-pcm.h
 delete mode 100644 sound/soc/omap/omap-pcm.h

diff --git a/include/sound/omap-pcm.h b/include/sound/omap-pcm.h
new file mode 100644
index 0000000..c1d2f31
--- /dev/null
+++ b/include/sound/omap-pcm.h
@@ -0,0 +1,30 @@
+/*
+ * omap-pcm.h - OMAP PCM driver
+ *
+ * Copyright (C) 2014 Texas Instruments, Inc.
+ *
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef __OMAP_PCM_H__
+#define __OMAP_PCM_H__
+
+#if IS_ENABLED(CONFIG_SND_OMAP_SOC)
+int omap_pcm_platform_register(struct device *dev);
+#else
+static inline int omap_pcm_platform_register(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_SND_OMAP_SOC */
+
+#endif /* __OMAP_PCM_H__ */
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 14058dc..9afb146 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -33,10 +33,10 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
+#include <sound/omap-pcm.h>
 
 #include "davinci-pcm.h"
 #include "davinci-mcasp.h"
-#include "../omap/omap-pcm.h"
 
 #define MCASP_MAX_AFIFO_DEPTH	64
 
diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 53da041..6925d71 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -40,9 +40,9 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
+#include <sound/omap-pcm.h>
 
 #include "omap-dmic.h"
-#include "omap-pcm.h"
 
 struct omap_dmic {
 	struct device *dev;
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 537a1ec..eb9c392 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -34,9 +34,9 @@
 #include <sound/asoundef.h>
 #include <sound/dmaengine_pcm.h>
 #include <video/omapdss.h>
+#include <sound/omap-pcm.h>
 
 #include "omap-hdmi.h"
-#include "omap-pcm.h"
 
 #define DRV_NAME "omap-hdmi-audio-dai"
 
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index af2764a..10d6cec 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -34,11 +34,11 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
+#include <sound/omap-pcm.h>
 
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include "mcbsp.h"
 #include "omap-mcbsp.h"
-#include "omap-pcm.h"
 
 #define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
 
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index d8ebb52..f0e2ebe 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -40,9 +40,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
+#include <sound/omap-pcm.h>
 
 #include "omap-mcpdm.h"
-#include "omap-pcm.h"
 
 struct mcpdm_link_config {
 	u32 link_mask; /* channel mask for the direction */
diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
deleted file mode 100644
index c1d2f31..0000000
--- a/sound/soc/omap/omap-pcm.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * omap-pcm.h - OMAP PCM driver
- *
- * Copyright (C) 2014 Texas Instruments, Inc.
- *
- * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
-
-#ifndef __OMAP_PCM_H__
-#define __OMAP_PCM_H__
-
-#if IS_ENABLED(CONFIG_SND_OMAP_SOC)
-int omap_pcm_platform_register(struct device *dev);
-#else
-static inline int omap_pcm_platform_register(struct device *dev)
-{
-	return 0;
-}
-#endif /* CONFIG_SND_OMAP_SOC */
-
-#endif /* __OMAP_PCM_H__ */
-- 
1.7.9.5

