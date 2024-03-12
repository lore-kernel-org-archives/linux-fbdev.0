Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04FE7D091
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258529; cv=none; b=fz3xtPogqBNuqFYFdymFy8ly34pbo4sZZOE23WCbykqQDcynecPbR7bqWPb4xs468vnLEOuLI1dvj9HMc1E3etCv7wc1MR2pkJ+UB8SCauThDdAJBgtIc0QrmUoIRZ27NTjW3LcZEbtPiRYp2yCiYSX320xkb10RlI+t88L8ChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258529; c=relaxed/simple;
	bh=KSpsXhc8HSWTLy7TNnt4pXysKYK9OKbTPTcpeXtBPIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILHxNykGJy7NSk8LXcFM1cf30W66fPGP892ZZ7u+oQ8w4UEPMLwweMxdZaW+r/5hGoT0qwTcwvodG45hZPg3cCxcMZ8JnTE1F3I68x1KQHJzEuD3yNJRdoEQlig4h6fyGu2jB4XuQCrVdLuz9FjVRLj/46Q2qHQAJA+F80+FY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c/7iEvPb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HmWyrctT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cAXYjWBO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wjea6xvi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c/7iEvPb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HmWyrctT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cAXYjWBO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wjea6xvi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF04D37887;
	Tue, 12 Mar 2024 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLfiDuaxyQvQd+ibaXVSxSmnXJxwlxsmUuNH51aID50=;
	b=c/7iEvPbxkAOVopEg/3Em+xU5r97m6Fj3/z2fVBjHT21lTCjumcE+V/sFrvWBZbAfojaB6
	2JQvYZlxji8Kfw8fa5iKcLk/s2FqUrgd5zlg2edNLp6RPfRrk5jAn1X4WiTqfqfnESSsbM
	SZsOgpZSaBVXrCAP5gO+WH5yos7VEaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLfiDuaxyQvQd+ibaXVSxSmnXJxwlxsmUuNH51aID50=;
	b=HmWyrctT2p6XTKwI4NJedUIiKiUkI9ZTLat3ttB7VanZ+sF4RfBc1NR9VSLOIRWsGlJ+Ku
	maZdH/y+4hAf7FAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLfiDuaxyQvQd+ibaXVSxSmnXJxwlxsmUuNH51aID50=;
	b=cAXYjWBOdY1N4iDx4jF9K8mAlYVABwPksqjhT6aiHOeXRfruOJauvBprl7Q4FMrOaxYv7a
	HGkwjQLfrEvo9aeIvOXzF+2uznBObKXWgCUuWXLTdzWxhONi4dcMV54cPM2R1UeTUw5RZ6
	qhrCBrsNBpXnzLXTHQD+ORjSxJQfhp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLfiDuaxyQvQd+ibaXVSxSmnXJxwlxsmUuNH51aID50=;
	b=Wjea6xvit7qFL40ng7yOPk3JJadILIfe6DC1W06NFE8HFwckL9jUcqzuUyYFHxoHHoIT8y
	kQXagh6SfL6V1uBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A06AD1364F;
	Tue, 12 Mar 2024 15:48:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mNjSJV158GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:45 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 29/43] drm/renesas/rz-du: Use fbdev-dma
Date: Tue, 12 Mar 2024 16:45:24 +0100
Message-ID: <20240312154834.26178-30-tzimmermann@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.de:email,renesas.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.39%]
X-Spam-Score: 0.90
X-Spam-Flag: NO

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by rz-du. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 470d34da1d6c4..e5eca8691a331 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -14,7 +14,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_probe_helper.h>
 
@@ -149,7 +149,7 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 
 	drm_info(&rcdu->ddev, "Device %s probed\n", dev_name(&pdev->dev));
 
-	drm_fbdev_generic_setup(&rcdu->ddev, 32);
+	drm_fbdev_dma_setup(&rcdu->ddev, 32);
 
 	return 0;
 
-- 
2.44.0

