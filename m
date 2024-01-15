Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654EF4F6
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Jan 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 990A221DBB;
	Mon, 15 Jan 2024 10:09:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68240132FA;
	Mon, 15 Jan 2024 10:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YBY6GGUEpWWeJAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 15 Jan 2024 10:09:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	daniel@ffwll.ch,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/3] video/cmdline: Hide __video_get_options() behind CONFIG_FB_CORE
Date: Mon, 15 Jan 2024 10:54:04 +0100
Message-ID: <20240115100939.21562-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115100939.21562-1-tzimmermann@suse.de>
References: <20240115100939.21562-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 990A221DBB
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

The function __video_get_options() only exists for compatibility
with old fbdev drivers that cannot be refactored easily. Hide it
behind CONFIG_FB_CORE.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/cmdline.c | 2 ++
 include/video/cmdline.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/video/cmdline.c b/drivers/video/cmdline.c
index d3d257489c3d..4eeafe7f5943 100644
--- a/drivers/video/cmdline.c
+++ b/drivers/video/cmdline.c
@@ -80,6 +80,7 @@ const char *video_get_options(const char *name)
 }
 EXPORT_SYMBOL(video_get_options);
 
+#if defined(CONFIG_FB_CORE)
 bool __video_get_options(const char *name, const char **options, bool is_of)
 {
 	bool enabled = true;
@@ -96,6 +97,7 @@ bool __video_get_options(const char *name, const char **options, bool is_of)
 	return enabled;
 }
 EXPORT_SYMBOL(__video_get_options);
+#endif
 
 /*
  * Process command line options for video adapters. This function is
diff --git a/include/video/cmdline.h b/include/video/cmdline.h
index 77292d1d6173..e0712deb842c 100644
--- a/include/video/cmdline.h
+++ b/include/video/cmdline.h
@@ -7,7 +7,9 @@
 
 const char *video_get_options(const char *name);
 
+#if defined(CONFIG_FB_CORE)
 /* exported for compatibility with fbdev; don't use in new code */
 bool __video_get_options(const char *name, const char **option, bool is_of);
+#endif
 
 #endif
-- 
2.43.0

