Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6A97CF00
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258522; cv=none; b=FJOl2EcZ6ZlRIG9K7M0bEYbdefxih297xx991SEshHYvZ1FnJbVnpuL2RGBAy1bm4S/pTHN8EvGWiYAW3b5GN2//JNFOJlsEiLxYp4Dkj3RrLofI9RIebnad96+/STKwS35bQhYqlRXCIjyaNqQ6ybsCNXxRafli9W81OYqWk2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258522; c=relaxed/simple;
	bh=l4kGS5LGN+6ICO8Kl67wsjt9HxO2rbZt5ahmpRds/HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8gg5Ivs4z+LTdYubQasE7w62ZmSpzKKLmXPCxUkvbzI5XWo4HNKP+8EErZeCLECNGknWRSKkAIvbf4OulWb09CxlVCMWD9oiX6FNQLDeNw8pvJ4w5rx1jHJzKMyXUebGtqaduzp9KSDiiORQ4GVVvddxj6fkPlTAUlLDX7uAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 179315D6C9;
	Tue, 12 Mar 2024 15:48:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D22831364F;
	Tue, 12 Mar 2024 15:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6FXqMVZ58GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 07/43] fbdev/deferred-io: Provide get_page hook in struct fb_deferred_io
Date: Tue, 12 Mar 2024 16:45:02 +0100
Message-ID: <20240312154834.26178-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312154834.26178-1-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 179315D6C9
X-Spam-Flag: NO

Add a callback for drivers to provide framebuffer pages to fbdev's
deferred-I/O helpers. Implementations need to acquire a reference on
the page before returning it. Returning NULL generates a SIGBUS
signal.

This will be useful for DRM's fbdev emulation with GEM-shemem buffer
objects.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fb_defio.c | 4 ++++
 include/linux/fb.h                  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 6e0bbcfdb01b5..51928ff7961a5 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -25,9 +25,13 @@
 
 static struct page *fb_deferred_io_get_page(struct fb_info *info, unsigned long offs)
 {
+	struct fb_deferred_io *fbdefio = info->fbdefio;
 	const void *screen_buffer = info->screen_buffer;
 	struct page *page = NULL;
 
+	if (fbdefio->get_page)
+		return fbdefio->get_page(info, offs);
+
 	if (is_vmalloc_addr(screen_buffer + offs))
 		page = vmalloc_to_page(screen_buffer + offs);
 	else if (info->fix.smem_start)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 708e6a177b1be..bbb0805c0ab1e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -219,6 +219,7 @@ struct fb_deferred_io {
 	struct mutex lock; /* mutex that protects the pageref list */
 	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
+	struct page *(*get_page)(struct fb_info *info, unsigned long offset);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
 #endif
-- 
2.44.0

