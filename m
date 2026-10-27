Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108216;
	b=WWMHghvy8uUPDO70zrsqNCMzg7FKV9gVofF1HoDGDDIeuvpK0Zn4ux2RjwNNRejI4/To
	 P1Dttkmi9/lc0C1u8vEutzbZ0w4SESFwzEV1Fa22l+POfOSPxi8qQNnvt4iWpYWE/cvdy
	 xETPIkflLZuVQod0HdyNeiUPbmzS19Vn2QIyJva35S3mQI+oItmf/4YygOdO+CbZsf2Dn
	 EMddpY1hvoxucYK0PQH6ujt3AOHfuW78Oh5zPoEZhMEnnH2cuiOisSN4BYtXfww1IV2qb
	 1/sD3CpWJrX+6ZMK1GgVerDDGVcE0gaqsH8CtHHzWa8FAZuTR8TeGrWLOqWFZ8a97GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108216;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=WImkfxqEQGNeYfAHj0WE2CtADgBK8HXMO/5PqrE+/AA=;
	b=dSQdflID1JWu7vaKBRdyMev6jcD5Q80hLw7JRAqKoWNQ/PL0leL7fnaC1DTqFzl6NIvy
	 ql7irahpmLTzUL8Dw60Wa5ePF3wFfXTBFXDpG9nse4WJFfhcsvwoFNKtLkN9Ywx9m0aSg
	 y26V/RwaTe/UqdG5zYI5FAy7Gn/H/nLgjnYlIygw0sSEAM1MKeskkpZI7edRV0yol/IIJ
	 l1iJvkrOwpzCGbWzK3ViuDNTF+amlsGCAnCvPlNUgAVnWJS+0R/BFd1zJ0owO9Cj0pzx6
	 GSIZi49q9GibzQVTysVfnE6VN+hIOoh9/jVGABaQ0AZv+GpIoWr0CiylZnSzZLcEUNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3FF606A31F
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 13:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B3FF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09D9821F1C;
	Tue, 27 Oct 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6E6213319;
	Tue, 27 Oct 2026 13:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wbs7OfSo4GoWVAAAD6G6ig:T3
	(envelope-from <tzimmermann@suse.de>); Tue, 27 Oct 2026 13:36:53 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/6] lib/fonts: Provide internal helpers for allocating font_data_t
Date: Tue, 27 Oct 2026 14:27:17 +0100
Message-ID: <20261027133646.297856-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027133646.297856-1-tzimmermann@suse.de>
References: <20261027133646.297856-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 09D9821F1C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

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
2.56.0

