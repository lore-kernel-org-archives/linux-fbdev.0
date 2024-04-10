Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB115DBAF
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754367; cv=none; b=V6uoYXEi09nhhzDEMuKnnoL+tllqmLMOzOZdMYCGP+yWpDG3Na9TkHJ0Tj9VGl7Err55gekUxEU0+XzaebnOPLYsQXOo5FOoqchSepigFkGUQazmBW2s20N/f8KF90h2bOln99HCCtyWoFxCl3hp3SgOBFk0Xa0r4AqipOZ7qgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754367; c=relaxed/simple;
	bh=mgfXAa4608Ett7jGtwD/UvIeQMG79OASEu2Si0V2mbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWY6Ixio63OtM03KfX1NAKfbSgb88OoLkdYuR9eJeke22YMxiJgljRiAeM20twlZJn7eM08zFKtvRbZ71OHo2eEuy2KKeHCTMEhNKLStj9ZlzEJf1uF59yJR2K4r5zxKUBLu1zak5rLQE+S7AAJcTT97RVHk94KNlQzdI0LUbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xYQ9AL37; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EfmDrTBN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xYQ9AL37; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EfmDrTBN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xYQ9AL37";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EfmDrTBN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xYQ9AL37";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EfmDrTBN"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8557351EA;
	Wed, 10 Apr 2024 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOubkzI8Ti2SXQMPzwTAhH3X+dqEqfDNmzI/jxTmhJo=;
	b=xYQ9AL37Ptr2FHy+oH2HNKlhcHu+NbGh9Ygki5aTX+M4wcfHMuVBPBwk34K2g9M7JawLUo
	rzNoAeMqyzV6enfyFyujmgQ0cSk19F9meCMaSIbGIhRpqmo8Hlt6QdSu9pKxhIiG2nJDym
	XLSgYKi1Nij1GrsCaMqn+Vi1juwnyP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOubkzI8Ti2SXQMPzwTAhH3X+dqEqfDNmzI/jxTmhJo=;
	b=EfmDrTBNoa6vRpHp1yVd+wsXQLWwSgGRKWL3Wv3+dRGGRmj5IaOftCMjXWneP0mRnFgw72
	hA2Uxfe5QbK5giAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOubkzI8Ti2SXQMPzwTAhH3X+dqEqfDNmzI/jxTmhJo=;
	b=xYQ9AL37Ptr2FHy+oH2HNKlhcHu+NbGh9Ygki5aTX+M4wcfHMuVBPBwk34K2g9M7JawLUo
	rzNoAeMqyzV6enfyFyujmgQ0cSk19F9meCMaSIbGIhRpqmo8Hlt6QdSu9pKxhIiG2nJDym
	XLSgYKi1Nij1GrsCaMqn+Vi1juwnyP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOubkzI8Ti2SXQMPzwTAhH3X+dqEqfDNmzI/jxTmhJo=;
	b=EfmDrTBNoa6vRpHp1yVd+wsXQLWwSgGRKWL3Wv3+dRGGRmj5IaOftCMjXWneP0mRnFgw72
	hA2Uxfe5QbK5giAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 912C413A94;
	Wed, 10 Apr 2024 13:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oCBAIrmOFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v2 10/43] drm/gud: Use fbdev-shmem
Date: Wed, 10 Apr 2024 15:02:06 +0200
Message-ID: <20240410130557.31572-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410130557.31572-1-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.55 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-1.25)[89.66%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email]
X-Spam-Score: -5.55
X-Spam-Flag: NO

Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/gud/gud_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 9d7bf8ee45f13..4f5aa2e5cb890 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -18,7 +18,7 @@
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -622,7 +622,7 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	drm_kms_helper_poll_init(drm);
 
-	drm_fbdev_generic_setup(drm, 0);
+	drm_fbdev_shmem_setup(drm, 0);
 
 	return 0;
 }
-- 
2.44.0

