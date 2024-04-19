Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F46A8A6
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515624; cv=none; b=mjjNonTIZdgJVFXAj9+EvVxuuUJXCr2OFq/dhMlXoXPBn6l1vI2m73396bv++oX1CoMR3+QYGj+yWoKXNNxxaZto9UBJ6QeI9GnJz4Mv9B8/Y/lcMC00NOT8FTvWe8OKhXKFNpzL1ryz3jcbVGBfqMc5/kGjqVDdxYljEH2FNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515624; c=relaxed/simple;
	bh=I6Ghdqo807nDw/c1rM3fI8ZYRSJwjMylucMyk64Hgyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc/PHm3Kec1OZXMGwyaMd35CWiLAywKCQd8+9IiQWdHXB+0JgJtUl8YCDfAPUuNxZr969FdhbI50sJDUNQ7oTzy3p3ghTNBrkH6f5U6HETgOhlcIg5c7zYmv4swW1lZJmdATairKR0Nu00xj1669+TWbpYbAZOOh8dTkF/HxSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JFWcdSxQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/gWbfX32; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JFWcdSxQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/gWbfX32; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JFWcdSxQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gWbfX32";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JFWcdSxQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gWbfX32"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 282835D488;
	Fri, 19 Apr 2024 08:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9kP91tdGNhKAC328CN3lwrlaDPNz2PDvnM4NyGlv8o=;
	b=JFWcdSxQJx8qnfjgKt085NkdqLbpP3bsVoF2tXcYTvEmge1wAQHzzKghecDIAIf2paL+qY
	xB9A/SO5fTX5lCuaeHAXLq9WKFg3SlxNVMpabkPakDmBuHgX7BZjf//ZMrRA4pSrm9aU3b
	LWAAozBZyhJGJGdBihoVTIXjimefFD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9kP91tdGNhKAC328CN3lwrlaDPNz2PDvnM4NyGlv8o=;
	b=/gWbfX32ijOPyEBDawHKJrA6rMxwTCYg24ScI9+CldSGfUQapk52EtubpKZ16L3PQ8zpKk
	Boa67ywrzqXvlsDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9kP91tdGNhKAC328CN3lwrlaDPNz2PDvnM4NyGlv8o=;
	b=JFWcdSxQJx8qnfjgKt085NkdqLbpP3bsVoF2tXcYTvEmge1wAQHzzKghecDIAIf2paL+qY
	xB9A/SO5fTX5lCuaeHAXLq9WKFg3SlxNVMpabkPakDmBuHgX7BZjf//ZMrRA4pSrm9aU3b
	LWAAozBZyhJGJGdBihoVTIXjimefFD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9kP91tdGNhKAC328CN3lwrlaDPNz2PDvnM4NyGlv8o=;
	b=/gWbfX32ijOPyEBDawHKJrA6rMxwTCYg24ScI9+CldSGfUQapk52EtubpKZ16L3PQ8zpKk
	Boa67ywrzqXvlsDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E311E1395B;
	Fri, 19 Apr 2024 08:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OPVVNmIsImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dave Airlie <airlied@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v3 12/43] drm/mgag200: Use fbdev-shmem
Date: Fri, 19 Apr 2024 10:29:05 +0200
Message-ID: <20240419083331.7761-13-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[9];
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
Cc: Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/mgag200/mgag200_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 573dbe256aa8b..65f2ed18b31c5 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -12,7 +12,7 @@
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_file.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_managed.h>
@@ -285,7 +285,7 @@ mgag200_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * FIXME: A 24-bit color depth does not work with 24 bpp on
 	 * G200ER. Force 32 bpp.
 	 */
-	drm_fbdev_generic_setup(dev, 32);
+	drm_fbdev_shmem_setup(dev, 32);
 
 	return 0;
 }
-- 
2.44.0

