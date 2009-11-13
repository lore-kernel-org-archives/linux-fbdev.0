From: Andres Salomon <dilinger-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH] lxfb: add copyright/license info
Date: Fri, 13 Nov 2009 12:41:19 -0500
Message-ID: <20091113124119.34ec8677@mycelium.queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-geode-bounces-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://bombadil.infradead.org/mailman/options/linux-geode>, 
	<mailto:linux-geode-request-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://bombadil.infradead.org/pipermail/linux-geode/>
List-Post: <mailto:linux-geode-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org>
List-Help: <mailto:linux-geode-request-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org?subject=help>
List-Subscribe: <http://bombadil.infradead.org/mailman/listinfo/linux-geode>, 
	<mailto:linux-geode-request-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org?subject=subscribe>
Sender: linux-geode-bounces-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org
Errors-To: linux-geode-bounces-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-geode-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org


The GRUB folks requested copyright/license info for lxfb.h, so here it is.

Signed-off-by: Andres Salomon <dilinger-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 drivers/video/geode/lxfb.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/geode/lxfb.h b/drivers/video/geode/lxfb.h
index 6a51448..67b26aa 100644
--- a/drivers/video/geode/lxfb.h
+++ b/drivers/video/geode/lxfb.h
@@ -1,3 +1,13 @@
+/* Geode LX framebuffer driver
+ *
+ * Copyright (C) 2006-2007, Advanced Micro Devices,Inc.
+ * Copyright (c) 2008  Andres Salomon <dilinger-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
 #ifndef _LXFB_H_
 #define _LXFB_H_
 
-- 
1.5.6.5
