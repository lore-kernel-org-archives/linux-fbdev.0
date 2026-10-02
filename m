Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A846F483;
	Fri,  2 Oct 2026 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945139; cv=none; b=eCOPY52aqJQZWj1/K3LuhW17RDMOQbLnWAFvtD0bsXCJ0RXLd6tvvJGYomVdhYE81QIWSRtTeV/iRySRz+QNp7kfFxBQ9M9YkHFOtve7j8NQiTCq0HEmYWYAjQRGv43UN5IGdY9tT5CGx+keeE/jEAsPQZse8anX7emC56PIi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945139; c=relaxed/simple;
	bh=aQwnbNNdnA6ESPiwaIskVeJ2HR5tOCJXkI/gvzy5VOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuqdR2BUImXlzxPWjX20iGlFJwTft3oCEWuK+ymHgmWieK4MkkW87NHcQJnwGxiqDTKtzCNUZtcMuBtR9brIZEVD7V+i3r9A7RodayIrDankWjS0MrsVB/zJTSv2b0avL5bGGeYpW5w/tjeZsj4vYuNHQ7JSXJE+7VsAmX+1N/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tc+mSZtF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2aIrGMzI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IAgq9ScD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ioc/k14u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tc+mSZtF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2aIrGMzI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IAgq9ScD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ioc/k14u"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30A7A21D63;
	Fri,  2 Oct 2026 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790945107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV0g1V+SQVwheY8YK5/iGD2kfKY2xrRvXyiVMofniW4=;
	b=tc+mSZtFWn1sXROKi/w7iQ+ORI2g3GUC4w/UMs5qbCWzMWpQvRjYhcE7CumFz7GTN9kiLZ
	DV97RFlZ1x6X61dpPhtPK5NyTnZNz03fw18AzBp1quW2dqCML8Fk+i39NrMED/UwYAG7X8
	S+Fz8VK38EuEdPLYIfDzc4gcXzJisXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790945107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV0g1V+SQVwheY8YK5/iGD2kfKY2xrRvXyiVMofniW4=;
	b=2aIrGMzIZr8TW5hJjNPj26h99TJTfC0abXV1XPlXbJfYG5yranv7ET0qmie2u9fY16Pb/z
	1T0nf/eXvjcNLDDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790945103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV0g1V+SQVwheY8YK5/iGD2kfKY2xrRvXyiVMofniW4=;
	b=IAgq9ScDOvIDzLUasDLjmQsTHziMXmhBp8PvbFiMCBr8A9bFbX1Kd1afNSojzJt4nQ02ml
	hn4VFo68kzgUiBgMdKFFqQy1JhlHmJskDc6sIG/wJ060gYY+Sz8M5ouqnT6XmvLcAQCR0Y
	gA9/kym5+XYIC78Fk8DyIK2ZnMnRTWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790945103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV0g1V+SQVwheY8YK5/iGD2kfKY2xrRvXyiVMofniW4=;
	b=Ioc/k14uvfN24WdpaAyS3NTzVe6/bak+Z4+JpA2AEBgc9WLrdQNs+Unxkb34KNYs0EM7eq
	Aw6NksGPEgsu10CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F1F513C96;
	Fri,  2 Oct 2026 12:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V/hJI0ynv2rNTwAAD6G6ig:T5
	(envelope-from <tzimmermann@suse.de>); Fri, 02 Oct 2026 12:45:02 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 4/7] drm/hisilicon/hibmc: Do not include <drm/drm_simple_kms_helper.h>
Date: Fri,  2 Oct 2026 14:41:54 +0200
Message-ID: <20261002124456.741011-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124456.741011-1-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,linuxfoundation.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

The hibmc driver does not require anything from the simple-kms
header. Do not include it.

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c   | 1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 2e9403b8bf3c..7bf6befa0440 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -4,7 +4,6 @@
 #include <linux/io.h>
 
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_drv.h>
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index b9bd6d33fb0f..0b72509f7a69 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -17,7 +17,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
-- 
2.55.0

