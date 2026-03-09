Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17783D3485
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Mar 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065889; cv=none; b=heeq3XSjq6+FILWKsgXiqU/tquiWJyRt6AD8J6i4MgM5QmfiWVQ3MaHWo6IWdfczXUWA4W+MkCXw9ZW/fJ6NevSYRKmrZy2RkmGz/j2jJALOjCrAG9sUjCshLJJa98V+6w/fCglPOH7znwntJZhdmgiEPy5/jso4jmfRfTQfSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065889; c=relaxed/simple;
	bh=BVXc+0rxoH8qMxVFvqoXSuv4kay4n72quDCpBBAaxyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C00wDPTJ4cIeWwu0K3VYUNoQYap/9YNv+yQSgn9yjV0tWKWE339oZcAcIdV1uvJnIMvsWuSBMW6h0H5qJZka4rgUSAXe9eXRu3PoBDWDD2MroCKqayudZNiu7yzDR7kS0cALBvZ2DbK453vxVZ+cqnQG5fSJUH025d2MuCmel/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1pRIythK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UdWw7tGy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uNDjDGrq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zPDSsS6T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1pRIythK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UdWw7tGy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uNDjDGrq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zPDSsS6T"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0326B5BE4D;
	Mon,  9 Mar 2026 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w5uwEVSlmlGBAJYoqlWi7ELW6wprbGKGlE9Ql1y72I=;
	b=1pRIythKvWFSVdxDakfWRVJbDSncEOdW6GvZ40m1WjgcirPJi1sJgrKbv8VWEHmw7+Aq+h
	7bJ+VC0TXwQH6jN66F172bWA24sbyd5owpkgK6pInKmBpr0jD3GI3LK8DVzSEpKYmenyOV
	X9zA/tNH3w2GG3kyp9UAF8xaA2dBjRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w5uwEVSlmlGBAJYoqlWi7ELW6wprbGKGlE9Ql1y72I=;
	b=UdWw7tGy6vpBhkwlgpeP6kFw2yezd+2fOU0vX1axaAubsxzRiSPFnhwDa4qxkFcVIRUw+X
	OR760zUqFCKJzQCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uNDjDGrq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zPDSsS6T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w5uwEVSlmlGBAJYoqlWi7ELW6wprbGKGlE9Ql1y72I=;
	b=uNDjDGrqcilQXlIHYd7M53hm9ykSd4xnx3IBXp7QbKDkpjic24/PnPFP0AvkeUyM8TtSBv
	NCZCVbmrMP4fiNiMQq5tQCFPMYC7JqKLLTzp3Xf6qxxRp3cuFjAYu4+5QOmfTOHW4iR3fO
	mQiTlEpwyXf9IeN7fQjlLdpO8/j+cZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w5uwEVSlmlGBAJYoqlWi7ELW6wprbGKGlE9Ql1y72I=;
	b=zPDSsS6TVo9qPWp8RMGERynwsSKbeemn71kuHayeAuIoTS91bFDEKQEkH23kEvyvqOMHSR
	qMsNzE5MLaB4G+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB1763EF3C;
	Mon,  9 Mar 2026 14:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aPc8LHzWrmldPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 09 Mar 2026 14:17:32 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 13/13] lib/fonts: Remove internal symbols and macros from public header file
Date: Mon,  9 Mar 2026 15:14:55 +0100
Message-ID: <20260309141723.137364-14-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309141723.137364-1-tzimmermann@suse.de>
References: <20260309141723.137364-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_RATELIMIT(0.00)[to_ip_from(RLf7er7x8tqp4b41gsueb7z9k6)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Queue-Id: 0326B5BE4D
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Define access macros for font_data_t in fonts.c. Define struct font_data
and declare most of the font symbols in the internal header font.h, where
they can only be seen by the font code.

Also move font indices into internal font.h. They appear to be unused
though. There is m86k assembly code that operates on the idx field, so
leave them in place for now.

List all built-in fonts in a separate section in the public header file.

v2:
- do not add config guards around font symbols (Helge)
- keep declaration of built-in fonts in public header

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/font.h       | 57 ++++++++++++--------------------------
 lib/fonts/font.h           | 38 +++++++++++++++++++++++++
 lib/fonts/font_10x18.c     |  2 +-
 lib/fonts/font_6x10.c      |  3 +-
 lib/fonts/font_6x11.c      |  2 +-
 lib/fonts/font_6x8.c       |  3 +-
 lib/fonts/font_7x14.c      |  2 +-
 lib/fonts/font_8x16.c      |  3 +-
 lib/fonts/font_8x8.c       |  2 +-
 lib/fonts/font_acorn_8x8.c |  2 +-
 lib/fonts/font_mini_4x6.c  |  2 +-
 lib/fonts/font_pearl_8x8.c |  2 +-
 lib/fonts/font_sun12x22.c  |  3 +-
 lib/fonts/font_sun8x16.c   |  3 +-
 lib/fonts/font_ter10x18.c  |  4 ++-
 lib/fonts/font_ter16x32.c  |  4 ++-
 lib/fonts/fonts.c          |  8 +++++-
 17 files changed, 85 insertions(+), 55 deletions(-)
 create mode 100644 lib/fonts/font.h

diff --git a/include/linux/font.h b/include/linux/font.h
index d80db66a5c17..5401f07dd6ce 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -77,36 +77,6 @@ struct font_desc {
     int pref;
 };
 
-#define VGA8x8_IDX	0
-#define VGA8x16_IDX	1
-#define PEARL8x8_IDX	2
-#define VGA6x11_IDX	3
-#define FONT7x14_IDX	4
-#define	FONT10x18_IDX	5
-#define SUN8x16_IDX	6
-#define SUN12x22_IDX	7
-#define ACORN8x8_IDX	8
-#define	MINI4x6_IDX	9
-#define FONT6x10_IDX	10
-#define TER16x32_IDX	11
-#define FONT6x8_IDX	12
-#define TER10x18_IDX	13
-
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
-
 /* Find a font with a specific name */
 
 extern const struct font_desc *find_font(const char *name);
@@ -120,16 +90,23 @@ extern const struct font_desc *get_default_font(int xres, int yres,
 /* Max. length for the name of a predefined font */
 #define MAX_FONT_NAME	32
 
-/* Extra word getters */
-#define REFCOUNT(fd)	(((int *)(fd))[-1])
-#define FNTSIZE(fd)	(((int *)(fd))[-2])
-#define FNTSUM(fd)	(((int *)(fd))[-4])
-
-#define FONT_EXTRA_WORDS 4
+/*
+ * Built-in fonts
+ */
 
-struct font_data {
-	unsigned int extra[FONT_EXTRA_WORDS];
-	unsigned char data[];
-} __packed;
+extern const struct font_desc font_10x18;
+extern const struct font_desc font_6x10;
+extern const struct font_desc font_6x8;
+extern const struct font_desc font_7x14;
+extern const struct font_desc font_acorn_8x8;
+extern const struct font_desc font_mini_4x6;
+extern const struct font_desc font_pearl_8x8;
+extern const struct font_desc font_sun_12x22;
+extern const struct font_desc font_sun_8x16;
+extern const struct font_desc font_ter_10x18;
+extern const struct font_desc font_ter_16x32;
+extern const struct font_desc font_vga_6x11;
+extern const struct font_desc font_vga_8x16;
+extern const struct font_desc font_vga_8x8;
 
 #endif /* _VIDEO_FONT_H */
diff --git a/lib/fonts/font.h b/lib/fonts/font.h
new file mode 100644
index 000000000000..4f1adf0b6b54
--- /dev/null
+++ b/lib/fonts/font.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LIB_FONTS_FONT_H
+#define _LIB_FONTS_FONT_H
+
+#include <linux/font.h>
+
+/*
+ * Font data
+ */
+
+#define FONT_EXTRA_WORDS 4
+
+struct font_data {
+	unsigned int extra[FONT_EXTRA_WORDS];
+	unsigned char data[];
+} __packed;
+
+/*
+ * Built-in fonts
+ */
+
+#define VGA8x8_IDX	0
+#define VGA8x16_IDX	1
+#define PEARL8x8_IDX	2
+#define VGA6x11_IDX	3
+#define FONT7x14_IDX	4
+#define	FONT10x18_IDX	5
+#define SUN8x16_IDX	6
+#define SUN12x22_IDX	7
+#define ACORN8x8_IDX	8
+#define	MINI4x6_IDX	9
+#define FONT6x10_IDX	10
+#define TER16x32_IDX	11
+#define FONT6x8_IDX	12
+#define TER10x18_IDX	13
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
index a861b375e35d..5938f542906b 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -13,7 +13,6 @@
  */
 
 #include <linux/container_of.h>
-#include <linux/font.h>
 #include <linux/kd.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -25,12 +24,19 @@
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
2.53.0

