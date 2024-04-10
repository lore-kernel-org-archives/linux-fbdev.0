Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9015CD6B
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754370; cv=none; b=oopXR2COB6yWQLUpmeg8CRGYxhr+IIVG5xUccsICLVRmep+y6FW1pO2ga30/ikixpAGn1VLnqvSPsX1roJyKidVVrzmV0KCLB2tr0Dln+QL0GNPjv8YyIwtGEwBgtKJeBw0HtVAYZr24AKsZQDqzV3KP87GriiZOi+A/4hnaZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754370; c=relaxed/simple;
	bh=0smXXhIy3NJcqU3v5EnthaYWLqWMaxntvVZ9px27LJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJLi5w4Q5Ah2F2DzzgudEZVRBZy0CcmZ7unx3Y5zJ12jWeCn0/88ZTErpti5yZP/J2SgCN1ub3CejPc7RI+tgHAokOQ4WTScEar9jFJg99L+nkFH9vv8zH+em8SmKnDEEQxoTZ4i+VdhR2T06gIePBIs/tTx2SEsthIm0Jm/+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0681351F3;
	Wed, 10 Apr 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A983313A94;
	Wed, 10 Apr 2024 13:06:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UIU+KLyOFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:04 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v2 22/43] drm/arm/komeda: Use fbdev-dma
Date: Wed, 10 Apr 2024 15:02:18 +0200
Message-ID: <20240410130557.31572-23-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: E0681351F3

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by komeda. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
index cc57ea4e13ae6..ffdeec3b3f2ea 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -9,7 +9,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_module.h>
 #include <drm/drm_of.h>
 #include "komeda_dev.h"
@@ -80,7 +80,7 @@ static int komeda_platform_probe(struct platform_device *pdev)
 	}
 
 	dev_set_drvdata(dev, mdrv);
-	drm_fbdev_generic_setup(&mdrv->kms->base, 32);
+	drm_fbdev_dma_setup(&mdrv->kms->base, 32);
 
 	return 0;
 
-- 
2.44.0

