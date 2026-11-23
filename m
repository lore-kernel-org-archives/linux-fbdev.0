Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442762;
	b=Qi9QR5r5MT2gsA9IVH9gQAkXqOfYAzTR3/k7qmy9z4Rn/5GBeKNhhBKdN6DMaLxJkli5
	 O2xaj+mH3iX3cK6fvUSkjo06MdBVYdX+TKbkaXDrNJcCwHlFlxfQCW6rx0fVjPaVu/UWh
	 QxMmKdYtEJ+FN5v1PsrjmDT64nWTCFPJYj0qtq9fMBhcnbRNbWWxTeGuUY4NLbNH9jXmQ
	 4uFtesUWkCR77mP8qzAHCsNA9ukoJy6+qx4KwG5yj1GDEk3QALHIwpGB+2fX3a7ldDpCk
	 X9XTVZB5t5r7I6ZCS4aG/XnHxJZM5pndCldgVVUh9GB+6lXYUnNtTe8DwbI8IXiSeTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442762;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=B7JBNU6KNO/XvlnOGcpsJO/DTKSKPfPq15OplE1anXg=;
	b=qiH7zp1coZspYpxisSj7GX07w7ZBnBSViTSQta/nXQE5vgYHlgqX9q1pxXvaxAIlWzyf
	 wCFQ1sxwmRcvL4Tyud+0xIIZVdTaXzrDsmjtHO/LquPRsHpkXnud9kLkOU6kefiKaCcOL
	 tJDlwrgBkjib2cr4QKoewM0/7ABKFKldb4zobxCiCl1Rr0o2qs+pQjhkvU2F1y8Seqcuz
	 tCiuu2KLt6KvudHv+J62UJNr10Bftpw86B3ELSGir0HibYiyBtpgzb4GmZHvBCk4txECJ
	 HchWQjFnJFZLzttd6WCOaN1ra4oUWHvciI9U+MVU51okjDi7iSiXNCsAD3KcVzpK7kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DBB606A327
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Nov 2026 14:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71DBB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEFEC220A9;
	Mon, 23 Nov 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91EDE136CB;
	Mon, 23 Nov 2026 14:05:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oQeBOkZIBGvqQwAAD6G6ig:T3
	(envelope-from <tzimmermann@suse.de>); Mon, 23 Nov 2026 14:05:59 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 2/6] lib/fonts: Provide internal helpers for allocating font_data_t
Date: Mon, 23 Nov 2026 15:03:35 +0100
Message-ID: <20261123140554.1129792-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123140554.1129792-1-tzimmermann@suse.de>
References: <20261123140554.1129792-1-tzimmermann@suse.de>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: DEFEC220A9
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

Factor out the allocation code for font_data_t from font import in
font_data_import(). Retrieve a writable glyph buffer from the new
helper __font_data_wrbuf().

Having the allocation code in separate functions makes it available
for font rotation and maybe other font utilities. The _wrbuf() helper
returns a writable glyph buffer. Font data is only readable in general.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 lib/fonts/font.h  | 12 +++++++++
 lib/fonts/fonts.c | 63 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/lib/fonts/font.h b/lib/fonts/font.h
index 4f1adf0b6b54..eae8c563f148 100644
--- a/lib/fonts/font.h
+++ b/lib/fonts/font.h
@@ -4,6 +4,7 @@
 #define _LIB_FONTS_FONT_H
 
 #include <linux/font.h>
+#include <linux/types.h>
 
 /*
  * Font data
@@ -16,6 +17,17 @@ struct font_data {
 	unsigned char data[];
 } __packed;
 
+/*
+ * font_data_t and helpers
+ */
+
+static inline unsigned char *__font_data_wrbuf(font_data_t *fd)
+{
+	return (unsigned char *)fd;
+}
+
+font_data_t *__font_data_alloc(unsigned int size, gfp_t flags);
+
 /*
  * Built-in fonts
  */
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 4fc66722d00d..e66a5b6fc3bb 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -47,6 +47,39 @@ static bool font_data_is_internal(font_data_t *fd)
 	return !REFCOUNT(fd); /* internal fonts have no reference counting */
 }
 
+font_data_t *__font_data_alloc(unsigned int size, gfp_t flags)
+{
+	unsigned int alloc_size;
+	struct font_data *font_data;
+	font_data_t *fd;
+
+	/* Check for overflow in allocation size calculation */
+	if (check_add_overflow(sizeof(*font_data), size, &alloc_size))
+		return ERR_PTR(-EINVAL);
+
+	font_data = kzalloc(alloc_size, flags);
+	if (!font_data)
+		return ERR_PTR(-ENOMEM);
+
+	fd = font_data->data;
+	REFCOUNT(fd) = 1; /* start with reference acquired */
+	FNTSIZE(fd) = size;
+
+	return fd;
+}
+
+static font_data_t *font_data_alloc(unsigned int pitch, unsigned int h, unsigned int charcount)
+{
+	unsigned int size;
+
+	/* Check for integer overflow in font-size calculation */
+	if (check_mul_overflow(h, pitch, &size) ||
+	    check_mul_overflow(size, charcount, &size))
+		return ERR_PTR(-EINVAL);
+
+	return __font_data_alloc(size, GFP_USER);
+}
+
 static void font_data_free(font_data_t *fd)
 {
 	kfree(to_font_data_struct(fd));
@@ -75,36 +108,20 @@ font_data_t *font_data_import(const struct console_font *font, unsigned int vpit
 	unsigned int h = font->height;
 	unsigned int charcount = font->charcount;
 	const unsigned char *data = font->data;
-	u32 csum = 0;
-	struct font_data *font_data;
-	int size, alloc_size;
+	unsigned char *font_data;
 	unsigned int i;
 	font_data_t *fd;
 
-	/* Check for integer overflow in font-size calculation */
-	if (check_mul_overflow(h, pitch, &size) ||
-	    check_mul_overflow(size, charcount, &size))
-		return ERR_PTR(-EINVAL);
-
-	/* Check for overflow in allocation size calculation */
-	if (check_add_overflow(sizeof(*font_data), size, &alloc_size))
-		return ERR_PTR(-EINVAL);
-
-	font_data = kmalloc(alloc_size, GFP_USER);
-	if (!font_data)
-		return ERR_PTR(-ENOMEM);
-	memset(font_data->extra, 0, sizeof(font_data->extra));
+	fd = font_data_alloc(pitch, h, charcount);
+	if (IS_ERR(fd))
+		return fd;
+	font_data = __font_data_wrbuf(fd);
 
 	for (i = 0; i < charcount; ++i)
-		memcpy(font_data->data + i * h * pitch, data + i * vpitch * pitch, h * pitch);
+		memcpy(font_data + i * h * pitch, data + i * vpitch * pitch, h * pitch);
 
 	if (calc_csum)
-		csum = calc_csum(0, font_data->data, size);
-
-	fd = font_data->data;
-	REFCOUNT(fd) = 1; /* start with reference acquired */
-	FNTSIZE(fd) = size;
-	FNTSUM(fd) = csum;
+		FNTSUM(fd) = calc_csum(0, font_data, FNTSIZE(fd));
 
 	return fd;
 }
-- 
2.56.1

