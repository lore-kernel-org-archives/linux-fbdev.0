Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8466A8A3
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515624; cv=none; b=soCExBWH/luQVmr0wzu5K3j2xmCSuOVPlEGvJ45gbH7QQwu+baUMuC5YuCGxp+9MsrOgtD55hgLixNVMyKpWD4d/IFyo8iuWF3cMZ8K6DXBMZ6ciBMfzRCfbfK0/j43zGPdxx3L+qXH6TcGyfnL4oBOis9WRwv9/MU9pd9p+zWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515624; c=relaxed/simple;
	bh=PMaXfEJ31cOha3KWucnaK8NAys6QHfpGVnolewsL/rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkWvotT0f3GF1Ko2HW9J1vRgp0CujeLWPrGnqQOwD68aPci7td0ChiECkhtoWaKWtea1nTntOQrlF3Ph1DiYSfnCSxUfZqI2yRNP3F4ZI1ETHKBu1ClUVslF68MGVvXbmeouW3YMLD/rlpEaO1Utn1q1ZFabjxnkxaWeyRWr+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CQBbgGNX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QPRfHRGk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CQBbgGNX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QPRfHRGk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CQBbgGNX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QPRfHRGk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CQBbgGNX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QPRfHRGk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF8D737584;
	Fri, 19 Apr 2024 08:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9hYtMFbhq6fQ1WjYfnz27Em6Q+Mruq723U9xjEAy9o=;
	b=CQBbgGNXncA7FeKiPdmUwBdOWaUwyRQwZ6rgJ5JRkR/kRnW/IHCRYNwEguVClZivBG90XA
	98zznj2Jy1zyDWJmGzPPV7dB02DvuAZzMqq4POzg5Tft5uOwsodI+x/Q8/MMuy9wUIBBcG
	8J5a9WDDbkNJDxOEODiLrOP1MMbHi7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9hYtMFbhq6fQ1WjYfnz27Em6Q+Mruq723U9xjEAy9o=;
	b=QPRfHRGkogmZt2hwlux4KBB157BeNJUregCxDcChxEDBrRTTO/J4vZWR/1IvlDw5nGGR/5
	9Zysc7toyxvpe/Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9hYtMFbhq6fQ1WjYfnz27Em6Q+Mruq723U9xjEAy9o=;
	b=CQBbgGNXncA7FeKiPdmUwBdOWaUwyRQwZ6rgJ5JRkR/kRnW/IHCRYNwEguVClZivBG90XA
	98zznj2Jy1zyDWJmGzPPV7dB02DvuAZzMqq4POzg5Tft5uOwsodI+x/Q8/MMuy9wUIBBcG
	8J5a9WDDbkNJDxOEODiLrOP1MMbHi7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9hYtMFbhq6fQ1WjYfnz27Em6Q+Mruq723U9xjEAy9o=;
	b=QPRfHRGkogmZt2hwlux4KBB157BeNJUregCxDcChxEDBrRTTO/J4vZWR/1IvlDw5nGGR/5
	9Zysc7toyxvpe/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99AFF13687;
	Fri, 19 Apr 2024 08:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ML9pJGMsImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 15/43] drm/tiny/gm12u320: Use fbdev-shmem
Date: Fri, 19 Apr 2024 10:29:08 +0200
Message-ID: <20240419083331.7761-16-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/tiny/gm12u320.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 0187539ff5eaa..8b4efd39d7c41 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -13,7 +13,7 @@
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_file.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_fourcc.h>
@@ -699,7 +699,7 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
 	if (ret)
 		goto err_put_device;
 
-	drm_fbdev_generic_setup(dev, 0);
+	drm_fbdev_shmem_setup(dev, 0);
 
 	return 0;
 
-- 
2.44.0

