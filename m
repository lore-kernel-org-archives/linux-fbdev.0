Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1FF54673
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515621; cv=none; b=l2NSSvncXKEpYu6Ezeuf2TGuB4hXtXiSFZtACfY366e0OhN9zl6W0JDEXQM22PAI8snaaZVcdqtGOD/497k13JOm2oVKvJOQtwfV/JjiJwYZ7+KA0/Ib3DimvPrjBVyIr593tp9VKa1sPDsRnLkQ/n1mtfJKmaod660rKzwVSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515621; c=relaxed/simple;
	bh=hCrzEOjI0OAO5DVUT4+7MLnXx3u6Z+QHvbRz3Sn2CT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gx7fisD4JTQsfguwDz8Z84+7l5AEdCt+ymZF6R4a0w/4Lw4yuCIMKcRn5py6jbVJOOT+BWAf4EmaJNK6YirX7oVh49i6r0AxBJiJ+KOntMKpIyTWyukG0R+JhTWeor4SbtVR/R7NGGO7QW6q9IYNe9J4NaBePbW+fuMYNONf3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0E2E5BFE6;
	Fri, 19 Apr 2024 08:33:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A8CA13990;
	Fri, 19 Apr 2024 08:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oGgdEWEsImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 05/43] fbdev/deferred-io: Test smem_start for I/O memory
Date: Fri, 19 Apr 2024 10:28:58 +0200
Message-ID: <20240419083331.7761-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419083331.7761-1-tzimmermann@suse.de>
References: <20240419083331.7761-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A0E2E5BFE6

Test smem_start before looking up pages from its value. Return
NULL if it is unset. This will result in a SIGBUS signal.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/core/fb_defio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index b38f775cd39dd..fe84218ded457 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -26,11 +26,11 @@
 static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs)
 {
 	const void *screen_buffer = info->screen_buffer;
-	struct page *page;
+	struct page *page = NULL;
 
 	if (is_vmalloc_addr(screen_buffer + offs))
 		page = vmalloc_to_page(screen_buffer + offs);
-	else
+	else if (info->fix.smem_start)
 		page = pfn_to_page((info->fix.smem_start + offs) >> PAGE_SHIFT);
 
 	return page;
-- 
2.44.0

