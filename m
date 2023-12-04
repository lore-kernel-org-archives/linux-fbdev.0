Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D73F2
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Dec 2023 01:28:15 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A27C21FE60;
	Mon,  4 Dec 2023 09:28:14 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7172D13588;
	Mon,  4 Dec 2023 09:28:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qFtfGq6bbWWwLgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 04 Dec 2023 09:28:14 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	pjones@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/4] fbdev/efifb: Use screen_info pointer from device
Date: Mon,  4 Dec 2023 10:27:20 +0100
Message-ID: <20231204092812.2612-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204092812.2612-1-tzimmermann@suse.de>
References: <20231204092812.2612-1-tzimmermann@suse.de>
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
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A27C21FE60

Use the screen_info instance from the device instead of dereferencing
the global screen_info state. Decouples the driver from per-architecture
code. Duplicated the screen_info data, so that efifb can modify it at
will.

v2:
	* comment on devm_kmemdup() usage (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/efifb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 6cbb65bbe1110..4d7e899a1c853 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -358,7 +358,7 @@ static u64 bar_offset;
 
 static int efifb_probe(struct platform_device *dev)
 {
-	struct screen_info *si = &screen_info;
+	struct screen_info *si;
 	struct fb_info *info;
 	struct efifb_par *par;
 	int err, orientation;
@@ -368,6 +368,18 @@ static int efifb_probe(struct platform_device *dev)
 	char *option = NULL;
 	efi_memory_desc_t md;
 
+	/*
+	 * If we fail probing the device, the kernel might try a different
+	 * driver. We get a copy of the attached screen_info, so that we can
+	 * modify its values without affecting later drivers.
+	 */
+	si = dev_get_platdata(&dev->dev);
+	if (!si)
+		return -ENODEV;
+	si = devm_kmemdup(&dev->dev, si, sizeof(*si), GFP_KERNEL);
+	if (!si)
+		return -ENOMEM;
+
 	if (si->orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
 		return -ENODEV;
 
-- 
2.43.0

