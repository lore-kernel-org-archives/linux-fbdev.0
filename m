Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E015DBA5
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754373; cv=none; b=mJMlrG86iGPhHgQHjWvA6d3TgVVYjur8XmRFJSzl9HOKVXR/VtKtexEoKqb8IdJymdbTnHp6DVFjuu8K0DU9ko9nLuKz9fLnr0D0VrUt1TScQRiG/PrOjaRusfYbYA4jLlr5jb8KMHF5QIG1HH5yeAfyQ6+Q7GOWvbco3YNe+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754373; c=relaxed/simple;
	bh=dbLGq0amDMWAm3yjJ23vOrw2sU4uUHOE+sMhKC4s55Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+t9g2fztiDS9ABj/QOrBjbME+0T6icQKZt8uPzFcr3YQujq5hnfcmrnz7vaCFfgEwSRf9yqzDdVFfNzqEs6stmyu3iJnZ/WHW/AvlGDptG7AWw3JokDI6LgNxC94rCN+XB1Zr2D+cqfEoJ0HgB+juCOQsUvsRRm5HsGaa8DOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA503351EC;
	Wed, 10 Apr 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A4B3D1390D;
	Wed, 10 Apr 2024 13:06:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gMcOJ8GOFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:09 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Lechner <david@lechnology.com>
Subject: [PATCH v2 41/43] drm/tiny/st7735r: Use fbdev-dma
Date: Wed, 10 Apr 2024 15:02:37 +0200
Message-ID: <20240410130557.31572-42-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410130557.31572-1-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: DA503351EC

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by st7735r. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Lechner <david@lechnology.com>
Acked-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/tiny/st7735r.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/st7735r.c b/drivers/gpu/drm/tiny/st7735r.c
index 477eb36fbb70d..1676da00883d3 100644
--- a/drivers/gpu/drm/tiny/st7735r.c
+++ b/drivers/gpu/drm/tiny/st7735r.c
@@ -18,7 +18,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_managed.h>
@@ -241,7 +241,7 @@ static int st7735r_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, drm);
 
-	drm_fbdev_generic_setup(drm, 0);
+	drm_fbdev_dma_setup(drm, 0);
 
 	return 0;
 }
-- 
2.44.0

