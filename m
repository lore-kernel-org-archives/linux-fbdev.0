Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED21657CE
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515625; cv=none; b=TsiqabqSi4J6u8kPT5bePm3eJbw7nHi4nkEKcoJ+H56WmQLFA6sbKjlV/Al6eg21XIT8Z7CbLp9k9JRLe/+CR5m432LoPyZ67AchYZ0+aZGzDPGpEvz2nBMb24vcXYAEHh9FrDVR/v93yiYR6j0+kqeLzoowO/aIEuQQeNkq8+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515625; c=relaxed/simple;
	bh=eoH6m6ZcWpFewZ0lipecVKhS1DNNt5yza+iCDXmNCqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYUEosZC/L3QgpbETCVuVumc2eA2fG9KbvNHRA6+zG+5j4qcXL33iaFu7xjaYVYShAOCyFdsyv852O1BEo6NEzMAt61j6a7XK/+IHUchu+IkwurY9EEEuP4bkc0Gg3RLhtheOmUp2CSNCW16W6jhcBJ0lc5kXd8U2D9OmHybwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85FEA3758A;
	Fri, 19 Apr 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52D7113687;
	Fri, 19 Apr 2024 08:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +LgdE2YsImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 25/43] drm/ingenic: Use fbdev-dma
Date: Fri, 19 Apr 2024 10:29:18 +0200
Message-ID: <20240419083331.7761-26-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 85FEA3758A

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by ingenic. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Paul Cercueil <paul@crapouillou.net>
Acked-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 0751235007a7e..39fa291f43dd1 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -31,7 +31,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_fb_dma_helper.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -1399,7 +1399,7 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 		goto err_clk_notifier_unregister;
 	}
 
-	drm_fbdev_generic_setup(drm, 32);
+	drm_fbdev_dma_setup(drm, 32);
 
 	return 0;
 
-- 
2.44.0

