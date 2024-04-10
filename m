Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF515B99B
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754369; cv=none; b=FH6w+ROo5Sv9aO0kUo84BKBfEYmAvd3TJi/h7iLMgGP8I5AqvKAB39bPO5dHa880+oUccEUy7jWIsDWGfEEzDUXC4ws7QUIlkJrHQ8gSY5r1skBA3WcyatxKMCYBkClkWxnhT3ACrN+EFGUWqIqrNRNuYUMVOCzChQkKjacQWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754369; c=relaxed/simple;
	bh=6ZvoQx9bpgdjEXadweCDJNHa39R4vkXLTUEiUHN6WcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2y3RhehHngcgyDtyXBo+ibHkIr7AQNSBfOBO90GamWSILMrC4CsQ/J0ebXeVy5LXETOJU+ai6sF2GU8B1O0vTI9qw89JwrcaF8sUfotANWgMUVElT6uINNs0OT1YT/HSW8MDJ+TqpDDGoLE+hltY9oX8XdnUEsjB3hF+A+CA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E2NCkG8C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6ijHNHcR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E2NCkG8C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6ijHNHcR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E2NCkG8C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6ijHNHcR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E2NCkG8C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6ijHNHcR"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66D395CDAB;
	Wed, 10 Apr 2024 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zxmv5chRY7Plaid29FsmliXolIS3SgBUefYMN0cUyY4=;
	b=E2NCkG8CBv6jKdjrBvNUVJsh4i+VLe0ZTe4wQZGvNGV0PjMCo7HHGakOe+WQSh5n+7leTm
	gcSek1HqitBDaB5LLXGKsWXR3fa/K4DI+YPbEmE9I988tTRLuijTMy6lBmliGWjdkTzuWP
	C3gavCyYV7eY5uFjtnodsKpUQVwJoMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zxmv5chRY7Plaid29FsmliXolIS3SgBUefYMN0cUyY4=;
	b=6ijHNHcRWoSNQWZ2o15knAmgu8yItAeF373qUuGiMZX8aEIfLcaBwt7QwwyzeD3VcnM2Gy
	cF6qUDTxGs+7+iAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zxmv5chRY7Plaid29FsmliXolIS3SgBUefYMN0cUyY4=;
	b=E2NCkG8CBv6jKdjrBvNUVJsh4i+VLe0ZTe4wQZGvNGV0PjMCo7HHGakOe+WQSh5n+7leTm
	gcSek1HqitBDaB5LLXGKsWXR3fa/K4DI+YPbEmE9I988tTRLuijTMy6lBmliGWjdkTzuWP
	C3gavCyYV7eY5uFjtnodsKpUQVwJoMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zxmv5chRY7Plaid29FsmliXolIS3SgBUefYMN0cUyY4=;
	b=6ijHNHcRWoSNQWZ2o15knAmgu8yItAeF373qUuGiMZX8aEIfLcaBwt7QwwyzeD3VcnM2Gy
	cF6qUDTxGs+7+iAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 25F8613AA2;
	Wed, 10 Apr 2024 13:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4PLZB76OFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 27/43] drm/panel/panel-ilitek-9341: Use fbdev-dma
Date: Wed, 10 Apr 2024 15:02:23 +0200
Message-ID: <20240410130557.31572-28-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,quicinc.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by panel-ilitek-9341. Avoids
the overhead of fbdev-generic's additional shadow buffering. No
functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 3574681891e81..89830582b5d79 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -31,7 +31,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -650,7 +650,7 @@ static int ili9341_dbi_probe(struct spi_device *spi, struct gpio_desc *dc,
 
 	spi_set_drvdata(spi, drm);
 
-	drm_fbdev_generic_setup(drm, 0);
+	drm_fbdev_dma_setup(drm, 0);
 
 	return 0;
 }
-- 
2.44.0

