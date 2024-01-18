Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C85F125A4
	for <linux-fbdev@vger.kernel.org>; Thu, 18 Jan 2024 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568846; cv=none; b=bo1TncSJatMhLLy/Y1aLqmiIrKj1owgusiv05Ej8CIWjVwkfNCk2P2fSjcG7SwoSEXtIonATol/Q1sAHCmq3D5mZvfF/kq6TdX04eJV8QS55rRlYSIAJG+FmfkxsxP3aE4fPVpci7Ui9TGSPOpNPd8l4p4KencMgQylx9eB1on4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568846; c=relaxed/simple;
	bh=GJcCFJ5jVCQ9LwdzM1fkSLGo/MuhnV2B9VGnpla1aEw=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Spam-Score:X-Spamd-Result:
	 X-Spam-Flag; b=mj9zT7XQkhWzF8tXVZwkAP97HRAHYxdPU0GsTc9mYmWjnNNnGbeU2sRf+QY0RteHfVLcrArF2xUUH9Z0FZat6ZE18vlq37M6LYU/dhRav9qntorlGaFGq3aWs9+qu5MuF25AKk2Zdy/jGn0e9QRjvcdejnSb9Ri1uRx9rsKeaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XvygUUlr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uI6loTc1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XvygUUlr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uI6loTc1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XvygUUlr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uI6loTc1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XvygUUlr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uI6loTc1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91CD01F76E;
	Thu, 18 Jan 2024 09:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705568843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQaqcr5hH6CH51DZABXoX3g9p53ULCPq1i1ADmCWCX0=;
	b=XvygUUlrmdfrEKFOb8kLOotF0lelcMsN7S2oZSlHu6QcfhSWXLOYCti5orgC1J8oadKs4e
	iXzpvK6EzWNfV4EDHb64ZFGUKhLCTPD7eymhgYD454CqscE4iwzCdmwPwEGvjvKCkauaEW
	1Dk+ST9SDoKc7YvnnxjwI/JRB9kdgrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705568843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQaqcr5hH6CH51DZABXoX3g9p53ULCPq1i1ADmCWCX0=;
	b=uI6loTc10od7FviretdP8mPHK7bplrWZi+60jj2X0Lk8knDGwT0OSVrr8z+6V3HEyApsF4
	MieCJtC1oGfhY7Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705568843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQaqcr5hH6CH51DZABXoX3g9p53ULCPq1i1ADmCWCX0=;
	b=XvygUUlrmdfrEKFOb8kLOotF0lelcMsN7S2oZSlHu6QcfhSWXLOYCti5orgC1J8oadKs4e
	iXzpvK6EzWNfV4EDHb64ZFGUKhLCTPD7eymhgYD454CqscE4iwzCdmwPwEGvjvKCkauaEW
	1Dk+ST9SDoKc7YvnnxjwI/JRB9kdgrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705568843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQaqcr5hH6CH51DZABXoX3g9p53ULCPq1i1ADmCWCX0=;
	b=uI6loTc10od7FviretdP8mPHK7bplrWZi+60jj2X0Lk8knDGwT0OSVrr8z+6V3HEyApsF4
	MieCJtC1oGfhY7Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60A5E13874;
	Thu, 18 Jan 2024 09:07:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sK13FkvqqGWIMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 18 Jan 2024 09:07:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	daniel@ffwll.ch,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/3] video/cmdline: Hide __video_get_options() behind CONFIG_FB_CORE
Date: Thu, 18 Jan 2024 10:05:27 +0100
Message-ID: <20240118090721.7995-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118090721.7995-1-tzimmermann@suse.de>
References: <20240118090721.7995-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de,ffwll.ch,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

The function __video_get_options() only exists for compatibility
with old fbdev drivers that cannot be refactored easily. Hide it
behind CONFIG_FB_CORE.

v2:
	* support CONFIG_FB_CORE=m via IS_ENABLED() (kernel test robot)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/cmdline.c | 2 ++
 include/video/cmdline.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/video/cmdline.c b/drivers/video/cmdline.c
index d3d257489c3d..49ee3fb4951a 100644
--- a/drivers/video/cmdline.c
+++ b/drivers/video/cmdline.c
@@ -80,6 +80,7 @@ const char *video_get_options(const char *name)
 }
 EXPORT_SYMBOL(video_get_options);
 
+#if IS_ENABLED(CONFIG_FB_CORE)
 bool __video_get_options(const char *name, const char **options, bool is_of)
 {
 	bool enabled = true;
@@ -96,6 +97,7 @@ bool __video_get_options(const char *name, const char **options, bool is_of)
 	return enabled;
 }
 EXPORT_SYMBOL(__video_get_options);
+#endif
 
 /*
  * Process command line options for video adapters. This function is
diff --git a/include/video/cmdline.h b/include/video/cmdline.h
index 77292d1d6173..76649465bb08 100644
--- a/include/video/cmdline.h
+++ b/include/video/cmdline.h
@@ -3,11 +3,14 @@
 #ifndef VIDEO_CMDLINE_H
 #define VIDEO_CMDLINE_H
 
+#include <linux/kconfig.h>
 #include <linux/types.h>
 
 const char *video_get_options(const char *name);
 
+#if IS_ENABLED(CONFIG_FB_CORE)
 /* exported for compatibility with fbdev; don't use in new code */
 bool __video_get_options(const char *name, const char **option, bool is_of);
+#endif
 
 #endif
-- 
2.43.0

