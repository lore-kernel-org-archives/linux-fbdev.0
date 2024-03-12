Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F57CF1C
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258525; cv=none; b=g4faexfAGWL49s8LS1+4y3hDGpDR/MIGLypNUWid6jimgyZqRQZjMnHz2aStlPB3lS5Ja1xkQNq5oeqtdS4dJQioLkfkV3A5Wbl1O5aXywJB5KDzZmtGMX1tLVMxiObBfi/28hJpjZPm+h5CHjuJHsRqpDJJi41LMmv5Wku30LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258525; c=relaxed/simple;
	bh=VwaUaMJOGwg2yCnEQYjkY1zMoLslW5h6Aae1KAKMKgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyrqplSqlS8ZLPcUBmEm6oePubgKzxOjypQyZiTpYoa/68u7J3WKpNPZ9EVI3o699LfnQX6o47h8k/8SEvI9JrdEBCErUDPaOq8sn2Mf+zDzPhbotstz/h5tMAe6K3q4i8uA7PdU5dHQSpgLiFdpk3s/deI49U/LO6kQXbiXaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xmtt0hA7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AXRWuDoR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xmtt0hA7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AXRWuDoR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xmtt0hA7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AXRWuDoR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xmtt0hA7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AXRWuDoR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48DF33787F;
	Tue, 12 Mar 2024 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7E+AmYYgvd1TshN4fyzja+mLJyBpAEdrCcSeB1p8hJI=;
	b=Xmtt0hA7yc7g78FrTyiYTEZ9lYlJO+GvV88sLh55LBhrFUuz08j5tVSFvLCncytLAEH21N
	Q9JY/+IHMyb3MDWkJyIWhZbp6iR/Yd8ybDfor/vkSkYUBUC9sWBLylmsCRiCKZU+KZ6/WS
	qMWrkmpZRR71O7szPDsrGmXJ5B7jkzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7E+AmYYgvd1TshN4fyzja+mLJyBpAEdrCcSeB1p8hJI=;
	b=AXRWuDoRotskieMnEMudrF5WVHOMZi8XxHDkaCGWRp5mDFT205YmDoshmwtElfWkT51utl
	ATgFN8SAfxMcwNBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7E+AmYYgvd1TshN4fyzja+mLJyBpAEdrCcSeB1p8hJI=;
	b=Xmtt0hA7yc7g78FrTyiYTEZ9lYlJO+GvV88sLh55LBhrFUuz08j5tVSFvLCncytLAEH21N
	Q9JY/+IHMyb3MDWkJyIWhZbp6iR/Yd8ybDfor/vkSkYUBUC9sWBLylmsCRiCKZU+KZ6/WS
	qMWrkmpZRR71O7szPDsrGmXJ5B7jkzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7E+AmYYgvd1TshN4fyzja+mLJyBpAEdrCcSeB1p8hJI=;
	b=AXRWuDoRotskieMnEMudrF5WVHOMZi8XxHDkaCGWRp5mDFT205YmDoshmwtElfWkT51utl
	ATgFN8SAfxMcwNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 036B31364F;
	Tue, 12 Mar 2024 15:48:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KC6rOll58GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dave Airlie <airlied@redhat.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH 18/43] drm/udl: Use fbdev-shmem
Date: Tue, 12 Mar 2024 16:45:13 +0100
Message-ID: <20240312154834.26178-19-tzimmermann@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.57
X-Spamd-Result: default: False [-0.57 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.27)[74.10%]
X-Spam-Flag: NO

Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 1506094a80098..9612e9af27a47 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -6,7 +6,7 @@
 #include <linux/module.h>
 
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_managed.h>
@@ -117,7 +117,7 @@ static int udl_usb_probe(struct usb_interface *interface,
 
 	DRM_INFO("Initialized udl on minor %d\n", udl->drm.primary->index);
 
-	drm_fbdev_generic_setup(&udl->drm, 0);
+	drm_fbdev_shmem_setup(&udl->drm, 0);
 
 	return 0;
 }
-- 
2.44.0

