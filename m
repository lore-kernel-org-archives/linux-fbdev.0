Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4F15B54E
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754371; cv=none; b=hTRlZzRbHP+CG//MgZdJ6kp2gw0uRcRIsvJ1+CeBehxnHQ1hKp9JDisTrtmpwex8CKsTMSTDSGRf68NbH1AdN6Jcx+7AlApk21HaDa6fY9VPVLaCNovMnuxCBGyKeSK+zaY5Zx0p6DaGnOFPSQDgD7bdzCPkohY0zBsYn6CUw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754371; c=relaxed/simple;
	bh=k1vy5DtVc4cvjEz7Zm/Jbzzlv687UsaAtte755yeAow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fq2njghGTNcBoAtGY8XSYXcS056DXzXvLVgS0WPic1AkyeKPOn6AKoOzk+lHMJ6mZDb3cy39jpUB+hmzYMHEXzSYgcMl+q+wIAoYyaX2nmNpXTK9sIfeYX546z+Dnlak53saB/9XECvlDqoiIlBRAZH+SJx1jFUONTxbPMg1gn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ES4nVDti; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eyOs0TEs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ES4nVDti; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eyOs0TEs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ES4nVDti";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eyOs0TEs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ES4nVDti";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eyOs0TEs"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8CE7351EA;
	Wed, 10 Apr 2024 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7S25v5yiTOkgr0NdB0G0YkcSfVhgn+aBrT5pS0pWC6U=;
	b=ES4nVDtiBXzM6uBRtMi+wvc3WzaIdbdgEFnHa46iio25WHz07l3SRcobY3yQm9bRneiHq8
	ALLe5sNLsSL/sxoLfMhvHMUbSVu2fZULZQNHxga2/vHehQKoCDrLPFMVHvlH6m4ZLCot3T
	PORFIIn0l2T8MMAMy1DqqNHq828Pju0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7S25v5yiTOkgr0NdB0G0YkcSfVhgn+aBrT5pS0pWC6U=;
	b=eyOs0TEs5SgIEtiE/R6pFczllxCiulhYgX+uHC1kPUo2C9vYhOgAhD+9uQgPESSDiHMYvc
	dlHdG/i1rzVPoBAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7S25v5yiTOkgr0NdB0G0YkcSfVhgn+aBrT5pS0pWC6U=;
	b=ES4nVDtiBXzM6uBRtMi+wvc3WzaIdbdgEFnHa46iio25WHz07l3SRcobY3yQm9bRneiHq8
	ALLe5sNLsSL/sxoLfMhvHMUbSVu2fZULZQNHxga2/vHehQKoCDrLPFMVHvlH6m4ZLCot3T
	PORFIIn0l2T8MMAMy1DqqNHq828Pju0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7S25v5yiTOkgr0NdB0G0YkcSfVhgn+aBrT5pS0pWC6U=;
	b=eyOs0TEs5SgIEtiE/R6pFczllxCiulhYgX+uHC1kPUo2C9vYhOgAhD+9uQgPESSDiHMYvc
	dlHdG/i1rzVPoBAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B80A513AA4;
	Wed, 10 Apr 2024 13:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qF3JK7+OFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:07 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 33/43] drm/tiny/ili9163: Use fbdev-dma
Date: Wed, 10 Apr 2024 15:02:29 +0200
Message-ID: <20240410130557.31572-34-tzimmermann@suse.de>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by ili9163. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/ili9163.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ili9163.c b/drivers/gpu/drm/tiny/ili9163.c
index bc4384d410fcc..86f9d88349015 100644
--- a/drivers/gpu/drm/tiny/ili9163.c
+++ b/drivers/gpu/drm/tiny/ili9163.c
@@ -9,7 +9,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_mipi_dbi.h>
@@ -185,7 +185,7 @@ static int ili9163_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	drm_fbdev_generic_setup(drm, 0);
+	drm_fbdev_dma_setup(drm, 0);
 
 	return 0;
 }
-- 
2.44.0

