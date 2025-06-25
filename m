Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537B155C82;
	Wed, 25 Jun 2025 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857318; cv=none; b=uMsEwRVPiImw/RgSNxbc2+lrrx6yadpeCOl/Triz0almwtXZ6aj6zDHsPONnMFQzii/a40uypw2Y/laRv17Wgyx1+sBE+zcaAC9M6J5V7Sb1t9fVGiP1CcUkEJPyTmgs6rt4P1P25LDvpgfrDNVSnuClht/IkqeM4QwA/finlqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857318; c=relaxed/simple;
	bh=2piF3483Pz4JDdFUQw6HgD2GVTOG3rmk2pWQMFIJEqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q4zPdbCWRwB8jJ/BdpB0XKUtp0uWI3oIuovt7///Ge+qefr2qdn9tFaKF28/O+xOMLnUZAgwtGtVaZHCjS9ho4EwRTN7Dr8BAvq1I0zRY6Yha9r77UuLu3ACURvioKsl/86K6gyS367UQSMDdiV3npfn1a+p7xZc89V+WOq95LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZirtRzj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZirtRzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6A7C4CEEA;
	Wed, 25 Jun 2025 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857318;
	bh=2piF3483Pz4JDdFUQw6HgD2GVTOG3rmk2pWQMFIJEqU=;
	h=From:To:Cc:Subject:Date:From;
	b=nZirtRzj9JTpn1p5W94ReFTFR8aiBBfnf1QCvvu4lEv274VM0D2/phl5Ou5XseR+k
	 6ayvzpOmRu5x7dPOlIfYOeCSFhDai8CKV7QfGqjZR2bgSNNwT0jFGt8scFtK3EY9Y7
	 esGxANr+IuEqqxkT9FpNyUMpHb65MguGH6gjM/0qGYOf3SHUp4jLk6wvLZja4TIisT
	 KAqt5XAKYEec/ZZU4q0C0odSWg5spOHD2+NaKvSw8Wr2ppJ9OF3wQqimXZ7Ffl6WGX
	 HJSZ8h8nZIGnIlmK5IbNwKlCVet60O1ihKcqhE0Em3qzZJSDwE2619PPFx9Xl4eBVs
	 DjnGZr7rErhyg==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] fbdev: remove fb_notify support
Date: Wed, 25 Jun 2025 15:12:22 +0200
Message-Id: <20250625131511.3366522-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Commit dc2139c0aa32 ("leds: backlight trigger: Replace fb events with a
dedicated function call") removed the FB_EVENT_BLANK notifier, and now
the only remaining user of the FB notifier is the metronomefb driver on
the PXA/AM200EPD board.

This was introduced in commit 922613436ae5 ("[ARM] 5200/1: am200epd: use
fb notifiers and gpio api"), which converted it from an earlier version,
but as far as I can tell this can never have worked because the notifier
is called after the data it passes down is accessed.

Commit 867187821e5e ("fbdev/metronomefb: Use struct fb_info.screen_buffer")
broke this further, and there are likely other parts of the driver that
no longer work.

The am200epd board support itself should have also been removed long ago,
as there are no users and it was never converted to devicetree format.

Mark the board as broken to prevent build failures and remove the now
unused notifiers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Kconfig            |  1 +
 drivers/video/fbdev/core/Makefile    |  1 -
 drivers/video/fbdev/core/fb_notify.c | 54 ----------------------------
 drivers/video/fbdev/core/fbmem.c     | 15 --------
 include/linux/fb.h                   | 21 -----------
 5 files changed, 1 insertion(+), 91 deletions(-)
 delete mode 100644 drivers/video/fbdev/core/fb_notify.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 10e472f4fa43..edefc953e4f9 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -69,6 +69,7 @@ choice
 
 config GUMSTIX_AM200EPD
 	bool "Enable AM200EPD board support"
+	depends on BROKEN
 
 config GUMSTIX_AM300EPD
 	bool "Enable AM300EPD board support"
diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index d15974759086..ac8036209501 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
 obj-$(CONFIG_FB_CORE)             += fb.o
 fb-y                              := fb_info.o \
                                      fbmem.o fbcmap.o \
diff --git a/drivers/video/fbdev/core/fb_notify.c b/drivers/video/fbdev/core/fb_notify.c
deleted file mode 100644
index 10e3b9a74adc..000000000000
--- a/drivers/video/fbdev/core/fb_notify.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- *  linux/drivers/video/fb_notify.c
- *
- *  Copyright (C) 2006 Antonino Daplas <adaplas@pol.net>
- *
- *	2001 - Documented with DocBook
- *	- Brad Douglas <brad@neruo.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- */
-#include <linux/fb.h>
-#include <linux/notifier.h>
-#include <linux/export.h>
-
-static BLOCKING_NOTIFIER_HEAD(fb_notifier_list);
-
-/**
- *	fb_register_client - register a client notifier
- *	@nb: notifier block to callback on events
- *
- *	Return: 0 on success, negative error code on failure.
- */
-int fb_register_client(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&fb_notifier_list, nb);
-}
-EXPORT_SYMBOL(fb_register_client);
-
-/**
- *	fb_unregister_client - unregister a client notifier
- *	@nb: notifier block to callback on events
- *
- *	Return: 0 on success, negative error code on failure.
- */
-int fb_unregister_client(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&fb_notifier_list, nb);
-}
-EXPORT_SYMBOL(fb_unregister_client);
-
-/**
- * fb_notifier_call_chain - notify clients of fb_events
- * @val: value passed to callback
- * @v: pointer passed to callback
- *
- * Return: The return value of the last notifier function
- */
-int fb_notifier_call_chain(unsigned long val, void *v)
-{
-	return blocking_notifier_call_chain(&fb_notifier_list, val, v);
-}
-EXPORT_SYMBOL_GPL(fb_notifier_call_chain);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index dfcf5e4d1d4c..82ec7351e7da 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -498,14 +498,6 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	num_registered_fb++;
 	registered_fb[i] = fb_info;
 
-#ifdef CONFIG_GUMSTIX_AM200EPD
-	{
-		struct fb_event event;
-		event.info = fb_info;
-		fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
-	}
-#endif
-
 	return fbcon_fb_registered(fb_info);
 }
 
@@ -544,13 +536,6 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[fb_info->node] = NULL;
 	num_registered_fb--;
-#ifdef CONFIG_GUMSTIX_AM200EPD
-	{
-		struct fb_event event;
-		event.info = fb_info;
-		fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
-	}
-#endif
 	fbcon_fb_unregistered(fb_info);
 
 	/* this may free fb info */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 05cc251035da..520ad870b8b2 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -151,27 +151,6 @@ struct fb_blit_caps {
 	u32 flags;
 };
 
-#ifdef CONFIG_FB_NOTIFY
-extern int fb_register_client(struct notifier_block *nb);
-extern int fb_unregister_client(struct notifier_block *nb);
-extern int fb_notifier_call_chain(unsigned long val, void *v);
-#else
-static inline int fb_register_client(struct notifier_block *nb)
-{
-	return 0;
-};
-
-static inline int fb_unregister_client(struct notifier_block *nb)
-{
-	return 0;
-};
-
-static inline int fb_notifier_call_chain(unsigned long val, void *v)
-{
-	return 0;
-};
-#endif
-
 /*
  * Pixmap structure definition
  *
-- 
2.39.5

