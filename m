Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69A15B98E
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754371; cv=none; b=QlgilLSZRyeh1Ydyp3N4ndCjYBjXWWOFDhjMQNaGn9xZNPW9v2PYjSuPlO2cGdmepO4cJXOkJ5Iylg9zPEaDxpaYHEmunY4CVluH9kgjiPE9+VHOlIcU/vGB7/61XLeEsXmaYpzsSeXbjmfg0GW+AatgX9DssThcEXgfj/qZ9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754371; c=relaxed/simple;
	bh=qNbKEytXJ+IhbsAo5SgDNCPh+f7dQlZyyRhiHUeJILM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPe7n9V1D3nN2TbN2dqnM4UA3URPSogjh3Xjdx4bL3e4AhkxUq7Uy4x5DatwtxXRXnex4WqMNoWVxNvizdyh5BwrZh43TZu3BXbcmX9d7Zaoyny4pHYgX6rmU0lOwY3ndgUjRQku5R4FrAJKKBiMZ6QgfuayHqCEIOcltjJpaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2APu2Jpf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ebhAJ5g4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=11SYoyi9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4qbm/kNz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2APu2Jpf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ebhAJ5g4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="11SYoyi9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4qbm/kNz"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 364A75CDAE;
	Wed, 10 Apr 2024 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxtM9EGFKof+2MSMayumyZlc+pAqpsWmDmP4OaUOuDc=;
	b=2APu2Jpf4Qbvbb1YJhAJCE6gn0gGh6J3N9byJWblWwQXHOMDq6lTr6XFOh8bvWaGsiTDpG
	PUKdTcwyuwKmAVG1IP0H8OGDAz1BGB1Gan8Hx/1v23EfkXOc4FTuheLo4UmmnLVoUXg9Q4
	nKtOkVJUGBlEMBtr6lHgKCL4oQ80yN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxtM9EGFKof+2MSMayumyZlc+pAqpsWmDmP4OaUOuDc=;
	b=ebhAJ5g4wqgPZm3al+0fDPHups2m1/2ycWRw/RvzJlvfg/hzTELccRRrUacXmrrgEss4Sq
	W/rMyjOKNu1jo/Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxtM9EGFKof+2MSMayumyZlc+pAqpsWmDmP4OaUOuDc=;
	b=11SYoyi9G0clO73+f6D+wl0uk+ncsCV2paGB7neww0NQQ7OpirYe2wAYQ4p2lcZfPH2bBv
	YlaiTmuzzqEhHXzcd+Pl1sEfCE+KHIMJr952B5W2olsxoqz7SyshUskNSwg9Es6ISh8u9u
	RwCPUv5Q1rVMkFLKiENpVzm2tTRGrsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxtM9EGFKof+2MSMayumyZlc+pAqpsWmDmP4OaUOuDc=;
	b=4qbm/kNzaIwNeLi/QC0voGMAB9kQj6s7r/roIgHzAFBxW8RWzKHdZk/oaQBMuC3Ncixko8
	7diTQhFof+b/krAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EBF551390D;
	Wed, 10 Apr 2024 13:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6MxEOL6OFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 30/43] drm/renesas/shmobile: Use fbdev-dma
Date: Wed, 10 Apr 2024 15:02:26 +0200
Message-ID: <20240410130557.31572-31-tzimmermann@suse.de>
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
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,ideasonboard.com:email,glider.be:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by shmobile. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index e83c3e52251de..890cc2f6408d6 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -19,7 +19,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_module.h>
@@ -250,7 +250,7 @@ static int shmob_drm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_modeset_cleanup;
 
-	drm_fbdev_generic_setup(ddev, 16);
+	drm_fbdev_dma_setup(ddev, 16);
 
 	return 0;
 
-- 
2.44.0

