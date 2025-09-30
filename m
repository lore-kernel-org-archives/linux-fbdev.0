Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8AE1FC7C5
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Sep 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231782; cv=none; b=bV94+pLc1dToFICCu1oYDBnyXEYASjOug+Ly7W3FD0vAEiPv4XYGKJ81y8mwYO9PVnxXCOvttqEjEmlTNXFPF2BNShEBl9BeukpjQGgX77cyLX483/hElQsDR65CYUaFtX3t0rjlI2wnAWU93WEqPyIhy+Cq18Y23CknvvyE004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231782; c=relaxed/simple;
	bh=02rVs3StHsSsDHU3KSJXm9gRpm8SEWoMj3PlfZvRtNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tr0N+LMcJRDlGqY+mF0V0bK/1z+Bz9sTlmsaIwdW1SaVJiho9rxfFbawVDJ33w/mQjAvIIR5rvjrO1DhE62ODbtBVOvugxQc2/6pVprhFQs02EGhHKiopgrt5lAZfnirFShgwjeJYjhOtcrIF4MNQtLk3y3/92uqtkSKEwkyF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aQqG2ZTc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h9htynst; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aQqG2ZTc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h9htynst; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aQqG2ZTc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h9htynst";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aQqG2ZTc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h9htynst"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BABB1F7D0;
	Tue, 30 Sep 2025 11:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759231778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4HeLsqQkxYMFBGbd7yqW5+Knlu8wBpEGVr5F1LFIZYI=;
	b=aQqG2ZTccOS9YvnXvvrtflyE4UgwkjiTfDoaXd/w+Lfdvo2VgR4jBcSszyB8gAOdFPUea5
	EK0lePyDkt4L1lX6S3jHp1IijoPwqv937IuZ4zACBAf39aqmohoE2yiBSFaiZKrE4xyVBA
	JI1bOMR1iZjFyjhKOahP49WqYpKckUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759231778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4HeLsqQkxYMFBGbd7yqW5+Knlu8wBpEGVr5F1LFIZYI=;
	b=h9htynst4zxGPMTouXx/mRawmprWw4tjNrFYWD43AEoB1lVKrU4AAgIEk9gQWiPsmlevll
	9UnDnSs6rh3MDjDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aQqG2ZTc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=h9htynst
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759231778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4HeLsqQkxYMFBGbd7yqW5+Knlu8wBpEGVr5F1LFIZYI=;
	b=aQqG2ZTccOS9YvnXvvrtflyE4UgwkjiTfDoaXd/w+Lfdvo2VgR4jBcSszyB8gAOdFPUea5
	EK0lePyDkt4L1lX6S3jHp1IijoPwqv937IuZ4zACBAf39aqmohoE2yiBSFaiZKrE4xyVBA
	JI1bOMR1iZjFyjhKOahP49WqYpKckUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759231778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4HeLsqQkxYMFBGbd7yqW5+Knlu8wBpEGVr5F1LFIZYI=;
	b=h9htynst4zxGPMTouXx/mRawmprWw4tjNrFYWD43AEoB1lVKrU4AAgIEk9gQWiPsmlevll
	9UnDnSs6rh3MDjDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC9971342D;
	Tue, 30 Sep 2025 11:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SNH8NyG/22gzHQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 30 Sep 2025 11:29:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@zonque.org,
	haojian.zhuang@gmail.com,
	robert.jarzmik@free.fr,
	linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] ARM: spitz: Do not include <linux/fb.h>
Date: Tue, 30 Sep 2025 13:26:46 +0200
Message-ID: <20250930112651.87159-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4BABB1F7D0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[zonque.org,gmail.com,free.fr,armlinux.org.uk];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[free.fr,gmail.com]
X-Spam-Score: -1.51

This ARM architecture's source file does not require <linux/fb.h>.
Remove the include statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/arm/mach-pxa/spitz.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/spitz.h b/arch/arm/mach-pxa/spitz.h
index 04828d8918aa..873844194a31 100644
--- a/arch/arm/mach-pxa/spitz.h
+++ b/arch/arm/mach-pxa/spitz.h
@@ -12,7 +12,6 @@
 #endif
 
 #include "irqs.h" /* PXA_NR_BUILTIN_GPIO, PXA_GPIO_TO_IRQ */
-#include <linux/fb.h>
 
 /* Spitz/Akita GPIOs */
 
-- 
2.51.0

