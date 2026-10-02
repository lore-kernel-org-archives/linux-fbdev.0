Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8A4825B8;
	Fri,  2 Oct 2026 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945122; cv=none; b=GPiODIvoI6R7cMxcoZt2QS5QkprMwiPxXjhUTniJxVBUMY1cocbRRNl2cNluqczMVQs8NXE4GztOUhHBCcmfMXHHZWLWs1CUVZ82vcqfPYh2wf9ebiYf2eDIC96jDIKEDPa5/EWAZTx1J7Jj0qH6VbDhwu3uWA2iUOWPFFhDhaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945122; c=relaxed/simple;
	bh=Pw7NSXaw2plcewyhyUuiVIjUzeKpADPJxKRliRF2E78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbztwpwGJPEgimIBNZ0SZI+P5bzMEdfcLTcYqU/C2AhxmeX3NtbMJS+yndswkTwlJCY9F5GQEjTMgvG85QobROZc5SzURoyNwS5NyKUGNWA4LIyxG0F8MpApGBIZqZJHFudAp2VGyG22mKuNg7pX8j1XbMCv/J5A2PyX7NxvMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LDBwTKYo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y4DXtH0m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZZ7Ou3K1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=daIcgdlb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LDBwTKYo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y4DXtH0m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZZ7Ou3K1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="daIcgdlb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2CC01FE30;
	Fri,  2 Oct 2026 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790945114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXWxgt/+T6EawkGg3VdFUQ+mAO0nvOFNgvmkjsVlwzc=;
	b=LDBwTKYoL0Dz4d99Iw+Q8s3fLdKFWJTSBfFZFmODoGpcggc+K+6imCAYCGTb7iqdSYMGD5
	nx/KT524qMx4CfmSIVkfJC+bCrrdHm9/sorbirecljFHxRvu/asbIRClFHwSxh2qMLQklU
	pjsOZwRlKdSnQQxJkXCNRAL28QstVPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790945114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXWxgt/+T6EawkGg3VdFUQ+mAO0nvOFNgvmkjsVlwzc=;
	b=y4DXtH0myOJ5OGf/TQndFQ7hP5CHhsOXuUmYVtEM63DIbfOcpYrYvPfrca8E6ezz9OPPL8
	cgxIi6oCwv3DEPCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790945109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXWxgt/+T6EawkGg3VdFUQ+mAO0nvOFNgvmkjsVlwzc=;
	b=ZZ7Ou3K190EuJQ16KFa3fAr4v6ux0pBRY7uj5tekEHY/MMDVB1FugTsuELdnMy+8t15gqk
	7d2wUy6E7r/n6mFlvzqcjvqEb/dx2z5k3YnQgMi1Wa2JUcqBkDupYTEyUOKsLrGDlUxwio
	Y0962PYyPake4YgH9WK5RYuX+ecmy3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790945109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXWxgt/+T6EawkGg3VdFUQ+mAO0nvOFNgvmkjsVlwzc=;
	b=daIcgdlb+p9V71ScQu2aRH9xlygmkpW519X7BYSq5vaxDOaEWtrFe+67xxhjoAoxugyMgR
	LeYONBKZJ8tfcAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6293B13C95;
	Fri,  2 Oct 2026 12:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V/hJI0ynv2rNTwAAD6G6ig:T7
	(envelope-from <tzimmermann@suse.de>); Fri, 02 Oct 2026 12:45:03 +0000
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
Subject: [PATCH v2 6/7] drm/verisilicon: Do not include <drm/drm_simple_kms_helper.h>
Date: Fri,  2 Oct 2026 14:41:56 +0200
Message-ID: <20261002124456.741011-7-tzimmermann@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.975];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,linuxfoundation.org];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

The verisilicon driver does not require anything from the simple-kms
header. Do not include it.

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/verisilicon/vs_bridge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c b/drivers/gpu/drm/verisilicon/vs_bridge.c
index dc7c85b07fe3..b0c221f5bfa7 100644
--- a/drivers/gpu/drm/verisilicon/vs_bridge.c
+++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
@@ -16,7 +16,6 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "vs_bridge.h"
 #include "vs_bridge_regs.h"
-- 
2.55.0

