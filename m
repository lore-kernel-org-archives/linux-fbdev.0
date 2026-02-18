Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF632AAB1
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403999; cv=none; b=Pr4y+2q46McMkVS0d1H+ZnL1UglsNRXB3OGVC2B0/jcfGOeaVYYu5jND+X4rdGDzLWjOypAkO/UKL60+xQBg4/Jk2dkdTPbzDrgxmI+/x53yGoUKbMJ771g8urb9ZQ2Li+qhR5M+qoat/oJ21ggfMudiYvF8ILAJVelxt1icjzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403999; c=relaxed/simple;
	bh=K9cqzh3t4pfomNP2+voMY7ti5lZrcI1ouF4fKPkDIpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWe6H98Z0ft+WYd5g98hLdwvENlu9hi6BQnW9KQqjDy8gc4+CtcAloX9Owm/FE486LMwU4utckxemCzw3LtcEt+b3hpu8st7HVj3qt7IXc3VMs/xZS+x6lN3Q2333D37DprRSAddQc7er1/xvdA9SQH9udFe2/TxwIdDD5Vry4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h8LC+zyL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Fnkn6hY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tOwEDsWU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ep9tnNLM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h8LC+zyL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Fnkn6hY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tOwEDsWU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ep9tnNLM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF3733E70A;
	Wed, 18 Feb 2026 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWbN3XkbHkscdP0E7iQp4kH5azPVaqBQxyqSwFkqhuI=;
	b=h8LC+zyLSNWM3PdGueV2b4PXOiZHbnwr7Km5zUBIpYSblTaxX87W3fNRgoEjdxbDZkxUM7
	NfLaZyRAzqHcfkyOlAX/JF8KWv2M+mk3VEZ4OLrf4unCm9hbkwZ0Bjlq4NZ2Jmj5C/aTTr
	tQRkGZVeVuTD9ZgBAU69y5uM6u5BpEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWbN3XkbHkscdP0E7iQp4kH5azPVaqBQxyqSwFkqhuI=;
	b=6Fnkn6hYPmPK+M4tM0lawp20tpx539I6igeC9NyNU8Wt066QX1OAP96oTWhiw630KKW8Qe
	QfPrRreeAYu3DzCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWbN3XkbHkscdP0E7iQp4kH5azPVaqBQxyqSwFkqhuI=;
	b=tOwEDsWUZgJasXgDPU55cYYmRV2bRosN213Jws4oZbpdwPckRVr3K+0PYSXIAYBKBsEtTt
	SZrB6O8h1pGPFtYEjcf/EKOlRz/Jx+NkLx+DyxPBpt93Dncx9ApK9uJipSKWXxHOI1EOQd
	0rq2/9cTNRQwDORCvmxdH2sGie/qnv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWbN3XkbHkscdP0E7iQp4kH5azPVaqBQxyqSwFkqhuI=;
	b=Ep9tnNLMZWtinfnPMYAAC1ZsTbSMQEiXqma496OQrbe10ihvCjYzHU2fvX4WT4P7b+LtfF
	LxPyZyehrvxkoMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC2E33EA65;
	Wed, 18 Feb 2026 08:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SI6XKKp6lWn8LwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Feb 2026 08:39:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 13/13] lib/fonts: Remove internal symbols and macros from public header file
Date: Wed, 18 Feb 2026 09:16:04 +0100
Message-ID: <20260218083855.10743-14-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218083855.10743-1-tzimmermann@suse.de>
References: <20260218083855.10743-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL4936hw7dbgk3hb39jfn1xy19)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

Define access macros for font_data_t in fonts.c. Define struct font_data
and declare most of the font symbols in the internal header font.h, where
they can only be seen by the font code. Add config guards around font
symbols.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/font.h       | 32 +++++------------------
 lib/fonts/font.h           | 52 ++++++++++++++++++++++++++++++++++++++
 lib/fonts/font_10x18.c     |  2 +-
 lib/fonts/font_6x10.c      |  3 ++-
 lib/fonts/font_6x11.c      |  2 +-
 lib/fonts/font_6x8.c       |  3 ++-
 lib/fonts/font_7x14.c      |  2 +-
 lib/fonts/font_8x16.c      |  3 ++-
 lib/fonts/font_8x8.c       |  2 +-
 lib/fonts/font_acorn_8x8.c |  2 +-
 lib/fonts/font_mini_4x6.c  |  2 +-
 lib/fonts/font_pearl_8x8.c |  2 +-
 lib/fonts/font_sun12x22.c  |  3 ++-
 lib/fonts/font_sun8x16.c   |  3 ++-
 lib/fonts/font_ter10x18.c  |  4 ++-
 lib/fonts/font_ter16x32.c  |  4 ++-
 lib/fonts/fonts.c          |  8 +++++-
 17 files changed, 88 insertions(+), 41 deletions(-)
 create mode 100644 lib/fonts/font.h

diff --git a/include/linux/font.h b/include/linux/font.h
index 4ff956a1cd0a..6e9a4c93b47b 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -92,20 +92,12 @@ struct font_desc {
 #define FONT6x8_IDX	12
 #define TER10x18_IDX	13
 
-extern const struct font_desc	font_vga_8x8,
-			font_vga_8x16,
-			font_pearl_8x8,
-			font_vga_6x11,
-			font_7x14,
-			font_10x18,
-			font_sun_8x16,
-			font_sun_12x22,
-			font_acorn_8x8,
-			font_mini_4x6,
-			font_6x10,
-			font_ter_16x32,
-			font_6x8,
-			font_ter_10x18;
+#if defined(CONFIG_FONT_8x8)
+extern const struct font_desc font_vga_8x8;
+#endif
+#if defined(CONFIG_FONT_8x16)
+extern const struct font_desc font_vga_8x16;
+#endif
 
 /* Find a font with a specific name */
 
@@ -120,16 +112,4 @@ extern const struct font_desc *get_default_font(int xres, int yres,
 /* Max. length for the name of a predefined font */
 #define MAX_FONT_NAME	32
 
-/* Extra word getters */
-#define REFCOUNT(fd)	(((int *)(fd))[-1])
-#define FNTSIZE(fd)	(((int *)(fd))[-2])
-#define FNTSUM(fd)	(((int *)(fd))[-4])
-
-#define FONT_EXTRA_WORDS 4
-
-struct font_data {
-	unsigned int extra[FONT_EXTRA_WORDS];
-	unsigned char data[];
-} __packed;
-
 #endif /* _VIDEO_FONT_H */
diff --git a/lib/fonts/font.h b/lib/fonts/font.h
new file mode 100644
index 000000000000..00f65a3da5c2
--- /dev/null
+++ b/lib/fonts/font.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LIB_FONTS_FONT_H
+#define _LIB_FONTS_FONT_H
+
+#include <linux/font.h>
+
+#if defined(CONFIG_FONT_PEARL_8x8)
+extern const struct font_desc font_pearl_8x8;
+#endif
+#if defined(CONFIG_FONT_6x11)
+extern const struct font_desc font_vga_6x11;
+#endif
+#if defined(CONFIG_FONT_7x14)
+extern const struct font_desc font_7x14;
+#endif
+#if defined(CONFIG_FONT_10x18)
+extern const struct font_desc font_10x18;
+#endif
+#if defined(CONFIG_FONT_SUN8x16)
+extern const struct font_desc font_sun_8x16;
+#endif
+#if defined(CONFIG_FONT_SUN12x22)
+extern const struct font_desc font_sun_12x22;
+#endif
+#if defined(CONFIG_FONT_ACORN_8x8)
+extern const struct font_desc font_acorn_8x8;
+#endif
+#if defined(CONFIG_FONT_MINI_4x6)
+extern const struct font_desc font_mini_4x6;
+#endif
+#if defined(CONFIG_FONT_6x10)
+extern const struct font_desc font_6x10;
+#endif
+#if defined(CONFIG_FONT_TER16x32)
+extern const struct font_desc font_ter_16x32;
+#endif
+#if defined(CONFIG_FONT_6x8)
+extern const struct font_desc font_6x8;
+#endif
+#if defined(CONFIG_FONT_TER10x18)
+extern const struct font_desc font_ter_10x18;
+#endif
+
+#define FONT_EXTRA_WORDS 4
+
+struct font_data {
+	unsigned int extra[FONT_EXTRA_WORDS];
+	unsigned char data[];
+} __packed;
+
+#endif
diff --git a/lib/fonts/font_10x18.c b/lib/fonts/font_10x18.c
index 5d940db626e7..10edebc4bb74 100644
--- a/lib/fonts/font_10x18.c
+++ b/lib/fonts/font_10x18.c
@@ -4,7 +4,7 @@
  * by Jurriaan Kalkman 06-2005  *
  ********************************/
 
-#include <linux/font.h>
+#include "font.h"
 
 #define FONTDATAMAX 9216
 
diff --git a/lib/fonts/font_6x10.c b/lib/fonts/font_6x10.c
index e65df019e0d2..660d3a371b30 100644
--- a/lib/fonts/font_6x10.c
+++ b/lib/fonts/font_6x10.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/font.h>
+
+#include "font.h"
 
 #define FONTDATAMAX 2560
 
diff --git a/lib/fonts/font_6x11.c b/lib/fonts/font_6x11.c
index bd76b3f6b635..671487ccc172 100644
--- a/lib/fonts/font_6x11.c
+++ b/lib/fonts/font_6x11.c
@@ -5,7 +5,7 @@
 /*                                            */
 /**********************************************/
 
-#include <linux/font.h>
+#include "font.h"
 
 #define FONTDATAMAX (11*256)
 
diff --git a/lib/fonts/font_6x8.c b/lib/fonts/font_6x8.c
index 06ace7792521..5811ee07f4d8 100644
--- a/lib/fonts/font_6x8.c
+++ b/lib/fonts/font_6x8.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/font.h>
+
+#include "font.h"
 
 #define FONTDATAMAX 2048
 
diff --git a/lib/fonts/font_7x14.c b/lib/fonts/font_7x14.c
index a2f561c9fa04..0c7475d643c8 100644
--- a/lib/fonts/font_7x14.c
+++ b/lib/fonts/font_7x14.c
@@ -4,7 +4,7 @@
 /* by Jurriaan Kalkman 05-2005        */
 /**************************************/
 
-#include <linux/font.h>
+#include "font.h"
 
 #define FONTDATAMAX 3584
 
diff --git a/lib/fonts/font_8x16.c b/lib/fonts/font_8x16.c
index 06ae14088514..523e95c75569 100644
--- a/lib/fonts/font_8x16.c
+++ b/lib/fonts/font_8x16.c
@@ -5,9 +5,10 @@
 /*                                            */
 /**********************************************/
 
-#include <linux/font.h>
 #include <linux/module.h>
 
+#include "font.h"
+
 #define FONTDATAMAX 4096
 
 static const struct font_data fontdata_8x16 = {
diff --git a/lib/fonts/font_8x8.c b/lib/fonts/font_8x8.c
index 69570b8c31af..e5b697fc9675 100644
--- a/lib/fonts/font_8x8.c
+++ b/lib/fonts/font_8x8.c
@@ -5,7 +5,7 @@
 /*                                            */
 /**********************************************/
 
-#include <linux/font.h>
+#include "font.h"
 
 #define FONTDATAMAX 2048
 
diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
index af5fa72aa8b7..36c51016769d 100644
--- a/lib/fonts/font_acorn_8x8.c
+++ b/lib/fonts/font_acorn_8x8.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Acorn-like font definition, with PC graphics characters */
 
-#include <linux/font.h>
+#include "font.h"
 
 #define FONTDATAMAX 2048
 
diff --git a/lib/fonts/font_mini_4x6.c b/lib/fonts/font_mini_4x6.c
index cc21dc70cfd1..dc919c160dde 100644
--- a/lib/fonts/font_mini_4x6.c
+++ b/lib/fonts/font_mini_4x6.c
@@ -39,7 +39,7 @@ __END__;
    MSBit to LSBit = left to right.
  */
 
-#include <linux/font.h>
+#include "font.h"
 
 #define FONTDATAMAX 1536
 
diff --git a/lib/fonts/font_pearl_8x8.c b/lib/fonts/font_pearl_8x8.c
index ae98ca17982e..2438b374acea 100644
--- a/lib/fonts/font_pearl_8x8.c
+++ b/lib/fonts/font_pearl_8x8.c
@@ -10,7 +10,7 @@
 /*                                            */
 /**********************************************/
 
-#include <linux/font.h>
+#include "font.h"
 
 #define FONTDATAMAX 2048
 
diff --git a/lib/fonts/font_sun12x22.c b/lib/fonts/font_sun12x22.c
index 91daf5ab8b6b..2afbc144bea8 100644
--- a/lib/fonts/font_sun12x22.c
+++ b/lib/fonts/font_sun12x22.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/font.h>
+
+#include "font.h"
 
 #define FONTDATAMAX 11264
 
diff --git a/lib/fonts/font_sun8x16.c b/lib/fonts/font_sun8x16.c
index 81bb4eeae04e..2b7b2d8e548a 100644
--- a/lib/fonts/font_sun8x16.c
+++ b/lib/fonts/font_sun8x16.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/font.h>
+
+#include "font.h"
 
 #define FONTDATAMAX 4096
 
diff --git a/lib/fonts/font_ter10x18.c b/lib/fonts/font_ter10x18.c
index 80356e9d56c7..3f30b4a211ab 100644
--- a/lib/fonts/font_ter10x18.c
+++ b/lib/fonts/font_ter10x18.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/font.h>
+
 #include <linux/module.h>
 
+#include "font.h"
+
 #define FONTDATAMAX 9216
 
 static const struct font_data fontdata_ter10x18 = {
diff --git a/lib/fonts/font_ter16x32.c b/lib/fonts/font_ter16x32.c
index 5baedc573dd6..93616cffe642 100644
--- a/lib/fonts/font_ter16x32.c
+++ b/lib/fonts/font_ter16x32.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/font.h>
+
 #include <linux/module.h>
 
+#include "font.h"
+
 #define FONTDATAMAX 16384
 
 static const struct font_data fontdata_ter16x32 = {
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 1830e6ae9c87..198aae869be2 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -13,7 +13,6 @@
  */
 
 #include <linux/container_of.h>
-#include <linux/font.h>
 #include <linux/kd.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -26,12 +25,19 @@
 #include <asm/setup.h>
 #endif
 
+#include "font.h"
+
 #define console_font_pitch(font) DIV_ROUND_UP((font)->width, 8)
 
 /*
  * Helpers for font_data_t
  */
 
+/* Extra word getters */
+#define REFCOUNT(fd)	(((int *)(fd))[-1])
+#define FNTSIZE(fd)	(((int *)(fd))[-2])
+#define FNTSUM(fd)	(((int *)(fd))[-4])
+
 static struct font_data *to_font_data_struct(font_data_t *fd)
 {
 	return container_of(fd, struct font_data, data[0]);
-- 
2.52.0

