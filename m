Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD245C6FB;
	Fri,  2 Oct 2026 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945113; cv=none; b=a/b7Eqf4gfHazMJ4ddsup2SZtAA3mN69Y4B2GZj8Rr3KL8flqKJh849pWz3RRWR9gChFVJnRYY8PvNN686jutC3sqi5ASoFrWDQU9VmAxNr+dl1niRWUJio1AMoRyGBBBnuyMxQVPRfVu5PvVELchdxPp3IHEM3nPZF2HBm+rx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945113; c=relaxed/simple;
	bh=YAvlDIH6ftSHWKAJ561EKmstiTQUB0grJz8gmwjP0AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/omAL0KpPO60TFvKVDlHqF9e1aGTjldDYuS+Yw6lnYHtdoKaPGCakikocMj0VQjO2cbWPD+0ZisIvn/I/4Belni/aO0RmBHw7YsJV7dfD+oET/DK49aB+TIOpGJhPOzcOQwZLqN09zADxeeEcdUUl6lrbmcFbpm5ZV1FSZ0Tso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VmXLNfPC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D+UDt5kQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GdS+Lnhg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cx3nW2AF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VmXLNfPC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D+UDt5kQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GdS+Lnhg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cx3nW2AF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 517E921A1C;
	Fri,  2 Oct 2026 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790945105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sLsOdwi1hUceimsVUFcOl/fguiWv2isWvjC4TvjZLVk=;
	b=VmXLNfPCxP77vO/nlyNXfoYG4SDZWYv+1M/U1DAnZ4vLKhXgenge8Xnj0L3nz+K5L9eBIu
	HnnFecqx2rFcypEO3m32uREZfj9SdIXG15rDl6b3VKE9IvaEPr/y7eFCJOdkgGF14btu2h
	cJ96iljm79UV7Ipo5GEhQAfqedHdo+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790945105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sLsOdwi1hUceimsVUFcOl/fguiWv2isWvjC4TvjZLVk=;
	b=D+UDt5kQYcoV+Bcq0bt+eyLj7UeLxMsSPyBZxmb8NRZBt2Mro9LizbWEXFvLFyeSqqviU2
	VHVks2qKRtuQbdCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GdS+Lnhg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cx3nW2AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790945101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sLsOdwi1hUceimsVUFcOl/fguiWv2isWvjC4TvjZLVk=;
	b=GdS+Lnhg96MlzI60D2n3vKFzCVBb3CSdXpdTsuPtYdcTtsCUGf0us1GPLBFza9j1ahFJRe
	ah0UYRQUG2lQsP/DRAYlTjD85D8CfLUjzjQb/iaLa9ZQ6f76KWwkbz/Ze4KlXAcnwDf65C
	CGQTcG6eRFsNcinzdUiIMWqVs9pbtY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790945101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sLsOdwi1hUceimsVUFcOl/fguiWv2isWvjC4TvjZLVk=;
	b=cx3nW2AF0y2nm5OZSYyMvG6loYQCJxdmRBP+bkXw8Pngrzy0nPM+PQzaCbhrOJxX3mQEIG
	v8apTFO9FvoBFbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C252D13C73;
	Fri,  2 Oct 2026 12:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V/hJI0ynv2rNTwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 02 Oct 2026 12:45:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	decui@microsoft.com,
	ssengar@linux.microsoft.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/7] drm: Remove simple-display pipe
Date: Fri,  2 Oct 2026 14:41:50 +0200
Message-ID: <20261002124456.741011-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,linuxfoundation.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 517E921A1C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

There are no drivers using struct drm_simple_display_pipe left. Remove
the related helpers from DRM and clear any TODO items. Hyperv-drm needs
a minor fix to include some additional headers.

Since we're at it, also remove include statements for the simple-kms
header that are no longer needed. Most of them are likely left over from
earlier usage of the simple-display pipe.

Thomas Zimmermann (7):
  drm/hyperv: Add missing include statements
  drm/kms-helper: Remove struct drm_simple_display_pipe and helpers
  drm/bridge: Do not include <drm/drm_simple_kms_helper.h>
  drm/hisilicon/hibmc: Do not include <drm/drm_simple_kms_helper.h>
  drm/tegra: Do not include <drm/drm_simple_kms_helper.h>
  drm/verisilicon: Do not include <drm/drm_simple_kms_helper.h>
  drm/vc4: Do not include <drm/drm_simple_kms_helper.h>

 Documentation/gpu/todo.rst                    |  17 -
 drivers/gpu/drm/bridge/inno-hdmi.c            |   1 -
 drivers/gpu/drm/bridge/microchip-lvds.c       |   1 -
 drivers/gpu/drm/bridge/synopsys/dw-dp.c       |   1 -
 drivers/gpu/drm/bridge/tda998x_drv.c          |   1 -
 drivers/gpu/drm/drm_gem_atomic_helper.c       |  92 -----
 drivers/gpu/drm/drm_simple_kms_helper.c       | 328 ------------------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |   1 -
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |   1 -
 drivers/gpu/drm/hyperv/hyperv_drm.h           |   5 +
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c       |   1 -
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c     |   1 -
 drivers/gpu/drm/tegra/output.c                |   1 -
 drivers/gpu/drm/vc4/vc4_dpi.c                 |   1 -
 drivers/gpu/drm/vc4/vc4_dsi.c                 |   1 -
 drivers/gpu/drm/vc4/vc4_hdmi.c                |   1 -
 drivers/gpu/drm/vc4/vc4_vec.c                 |   1 -
 drivers/gpu/drm/verisilicon/vs_bridge.c       |   1 -
 drivers/staging/fbtft/TODO                    |   4 +-
 include/drm/drm_gem_atomic_helper.h           |  28 --
 include/drm/drm_simple_kms_helper.h           |  56 +--
 21 files changed, 9 insertions(+), 535 deletions(-)


base-commit: 9ecc25f4cc83ac280099d6c39e044d911774018d
-- 
2.55.0

