Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFE23769
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Feb 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335594; cv=none; b=ljkAvuRVszSEnhMD91w1zb4ebFD9dgf8wi4zwIADlfBtJMFLAt3135gGov8SzBoYxWO1BEXsky7vy0wj+R619EejRHBcAc7bBIOsjwKGCl/R69kvDDuUzXo+tZ9a2ouLKzesV3j5+kI6+xo2QHdgSPVIWDgY+nC2eZMAjpAn4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335594; c=relaxed/simple;
	bh=TIlZd7q4Z6tbEfuhrEfXDY6DdOUfqPjIVTQ5Xjw1w5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkzSOxCqDL8VJctFsM+Awf3H3aS+aq4U/yyokFp7NGlcmW+i/6dMNA1yl6pwiORDcQKEJj9waywYGrXFmhfqew4vZ+7Yzym97Pw1h8xrDOpZcOAggS9w0uIT1yXw2qICkoME0YJrdjpnNk8b/hrzAvSeV83AXx/yZFIdUmF575I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zR0z5HFB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fgl1fLWs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zR0z5HFB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fgl1fLWs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zR0z5HFB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fgl1fLWs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zR0z5HFB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fgl1fLWs"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34C642206A;
	Mon, 19 Feb 2024 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw8ihCA+TSshMjQKBUCRdVsaAOjufcWn1kWaOxuNW8c=;
	b=zR0z5HFBxtR/Mnlnephq2ZdvR1AB22iTjUfCMRHHgVW2GlxNJjHd/E7mf1bo41dy5l5Z7q
	BZcDEbKVSXweYAurVEke8urMPUv9Ukxh/4mnfILsYEh84GyWvg1qX2CaDVa02PP+A/IYFU
	/Q/KDO0kOHRSCha6tz83DX4oIQKD8jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw8ihCA+TSshMjQKBUCRdVsaAOjufcWn1kWaOxuNW8c=;
	b=fgl1fLWsnPgnu3BhcrwfCy8NATCwrmJhe0vbaJlmcovXRexB/JYnmuEIpj+96yT2WUMno8
	Uwe6oxJe8F3k+oDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw8ihCA+TSshMjQKBUCRdVsaAOjufcWn1kWaOxuNW8c=;
	b=zR0z5HFBxtR/Mnlnephq2ZdvR1AB22iTjUfCMRHHgVW2GlxNJjHd/E7mf1bo41dy5l5Z7q
	BZcDEbKVSXweYAurVEke8urMPUv9Ukxh/4mnfILsYEh84GyWvg1qX2CaDVa02PP+A/IYFU
	/Q/KDO0kOHRSCha6tz83DX4oIQKD8jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw8ihCA+TSshMjQKBUCRdVsaAOjufcWn1kWaOxuNW8c=;
	b=fgl1fLWsnPgnu3BhcrwfCy8NATCwrmJhe0vbaJlmcovXRexB/JYnmuEIpj+96yT2WUMno8
	Uwe6oxJe8F3k+oDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D5EEC139F7;
	Mon, 19 Feb 2024 09:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4GYSM+Uh02XlUAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Feb 2024 09:39:49 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	jani.nikula@linux.intel.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 9/9] fbdev: Clean up include statements in header file
Date: Mon, 19 Feb 2024 10:37:34 +0100
Message-ID: <20240219093941.3684-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219093941.3684-1-tzimmermann@suse.de>
References: <20240219093941.3684-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL9pqk354j4esf7wsagg6iyf8a)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,linux.intel.com,ffwll.ch,gmail.com,linuxfoundation.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.72%]
X-Spam-Level: ****
X-Spam-Score: 4.88
X-Spam-Flag: NO

Include mutex.h, printk.h and types.h, remove several unnecessary
include statements, and sort the list alphabetically.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Helge Deller <deller@gmx.de>
---
 include/linux/fb.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 8f70ca727a30d..708e6a177b1be 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -2,15 +2,15 @@
 #ifndef _LINUX_FB_H
 #define _LINUX_FB_H
 
-#include <linux/refcount.h>
-#include <linux/kgdb.h>
 #include <uapi/linux/fb.h>
 
 #define FBIO_CURSOR            _IOWR('F', 0x08, struct fb_cursor_user)
 
-#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
 #include <linux/workqueue.h>
-#include <linux/list.h>
 
 #include <asm/fb.h>
 
-- 
2.43.0

