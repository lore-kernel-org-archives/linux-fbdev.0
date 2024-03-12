Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABB7CF04
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258524; cv=none; b=p3T0tWNXKI/Zxf9xavyvmslX2XHwGuGn7Ex6lkLXrXupgnOjYeogFz9FfBAgXm7LoTJVHKLs8mLrsE5jZ+ksM4wxtCfx1K9+qPBnWgGhP4Ps1jtXi0k6vByQi8GCrOdoWhFZXTRZ1oop5+O+1ARyv5DFpEgyjUaO0IK9RzyIiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258524; c=relaxed/simple;
	bh=VcMkmFXqnVqPd25gl3a0CAAKd6Hy9Bwy3YHFctEtOIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X63dU1k+BifNPYdXD8YdA4ApwwPvxe0iKNKgmSJIpL42PsKAO93AvmAmzXIT7MR/wiwwKHUg5D9y7IoPLjGkRzl87qgz/fmVED+KfqCzwzy5nwDTOe5bhvyAKGk4hwXx+Syh0LEVZkK4VZiVCBiIMR2S7UDbyctHTXq1csnoQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YL3wCg5b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IiOeHyTm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YL3wCg5b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IiOeHyTm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YL3wCg5b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IiOeHyTm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YL3wCg5b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IiOeHyTm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 437723787A;
	Tue, 12 Mar 2024 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGsnbHzQTxnFyzkJxQEpu2EHVFpt2lm73V/1q6sAXVc=;
	b=YL3wCg5bYwg9hL3WaScXDa1BI7B7UMDhdp6WuAavYxilXMOUAy+4pTy9CbwhaMO5r7Gv0A
	WJQiv32mLZq49ViKBwa9NhTcLXqFeBsc6nfM5VLsNwJBDLNKQnT4/7mUoL/uS8tFNzwD46
	L+RxAtr3WoZSAEiL3p6hCtxzANo5wFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGsnbHzQTxnFyzkJxQEpu2EHVFpt2lm73V/1q6sAXVc=;
	b=IiOeHyTm80XPS5YRDg+cRtLFtrJ9dV0ZuXizJwOkRYJj55BDaiPHs41QWsCog98sw5MJOa
	x/8xvCjaCp3RYsCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGsnbHzQTxnFyzkJxQEpu2EHVFpt2lm73V/1q6sAXVc=;
	b=YL3wCg5bYwg9hL3WaScXDa1BI7B7UMDhdp6WuAavYxilXMOUAy+4pTy9CbwhaMO5r7Gv0A
	WJQiv32mLZq49ViKBwa9NhTcLXqFeBsc6nfM5VLsNwJBDLNKQnT4/7mUoL/uS8tFNzwD46
	L+RxAtr3WoZSAEiL3p6hCtxzANo5wFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGsnbHzQTxnFyzkJxQEpu2EHVFpt2lm73V/1q6sAXVc=;
	b=IiOeHyTm80XPS5YRDg+cRtLFtrJ9dV0ZuXizJwOkRYJj55BDaiPHs41QWsCog98sw5MJOa
	x/8xvCjaCp3RYsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04A8C1364F;
	Tue, 12 Mar 2024 15:48:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EMtNO1d58GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH 11/43] drm/hyperv: Use fbdev-shmem
Date: Tue, 12 Mar 2024 16:45:06 +0100
Message-ID: <20240312154834.26178-12-tzimmermann@suse.de>
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
X-Spam-Level: *
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[30.32%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,suse.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Deepak Rawat <drawat.floss@gmail.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index cff85086f2d66..ff93e08d5036d 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -11,7 +11,7 @@
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
@@ -149,7 +149,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 		goto err_free_mmio;
 	}
 
-	drm_fbdev_generic_setup(dev, 0);
+	drm_fbdev_shmem_setup(dev, 0);
 
 	return 0;
 
-- 
2.44.0

