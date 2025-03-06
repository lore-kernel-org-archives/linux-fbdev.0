Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4F156F5D
	for <linux-fbdev@vger.kernel.org>; Thu,  6 Mar 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270394; cv=none; b=SVly+4y21f6KzPxYlU4TtBNbiM21WmW7L1GWIKU6LukpIUbn2qIOz3ZBmFvLirLquFp0e1y4lHJ+8H41FJbhOxwJzfGoycyLc3fgY96TxCCBv0VDOF6FbifOAy1srQz8R7hgtWKKMgnT848361ByhiMknVmJChmmfTTr4gChwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270394; c=relaxed/simple;
	bh=MK3deRCClPKJMwnY3MZxzmHu0zeIe1KWhrUJmiP1gWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J95vH0ScDQfxD93ME1IQmj0BfZK7UCDBEUCGvLQ+BWd0wbQo1SIKRxYHxouYpX53i/Zm56NfpsbXw2UaHeIyVSHTG4XQ9s74434gf4VcY9E87D8E7D3afFyKUYL3FdcC8l+nbOqX/MXhIX99dmGmq+SPFmLh0f1rC54n8YDbEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=012yxRWX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ml+APova; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="012yxRWX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ml+APova"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB345211BF;
	Thu,  6 Mar 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741270389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ufj3f9HBl6Twcr7GMVSkl75ka6GAyq+kyVovQlCEnZk=;
	b=012yxRWXGeypHJ/56nEXQOdiGple0CkYlG2r+5ceVtmIu+4YXXrfeuW2FluwcX0k2YTHHb
	YkmGoM6KIh0T8NSJr1VrsJp0iVZ8Fg2ODrGjNQ0iumxHRBLa+xsoCled35/O7XgBUXTo+6
	HXe+m+GxNHXkSF9rdO+oSI8shElQ2sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741270389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ufj3f9HBl6Twcr7GMVSkl75ka6GAyq+kyVovQlCEnZk=;
	b=ml+APovaZLygVpNWk36TsZbmwB+snqkPQePqnh4nyTS71Zw42bbxEYrPRrh5IrlMuGsikD
	W+djwCtdtw2tnBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E19413A91;
	Thu,  6 Mar 2025 14:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UH9pIXWtyWeveQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 06 Mar 2025 14:13:09 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	pavel@ucw.cz,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	simona@ffwll.ch
Cc: linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 01/11] fbdev: Rework fb_blank()
Date: Thu,  6 Mar 2025 15:05:43 +0100
Message-ID: <20250306140947.580324-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306140947.580324-1-tzimmermann@suse.de>
References: <20250306140947.580324-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DB345211BF
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Reimplement fb_blank() to return early on errors. No functional
changes. Prepares the helper for tracking the blanking state in
struct fb_info.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 3c568cff2913..39e2b81473ad 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -339,11 +339,13 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 }
 EXPORT_SYMBOL(fb_set_var);
 
-int
-fb_blank(struct fb_info *info, int blank)
+int fb_blank(struct fb_info *info, int blank)
 {
 	struct fb_event event;
-	int ret = -EINVAL;
+	int ret;
+
+	if (!info->fbops->fb_blank)
+		return -EINVAL;
 
 	if (blank > FB_BLANK_POWERDOWN)
 		blank = FB_BLANK_POWERDOWN;
@@ -351,13 +353,13 @@ fb_blank(struct fb_info *info, int blank)
 	event.info = info;
 	event.data = &blank;
 
-	if (info->fbops->fb_blank)
-		ret = info->fbops->fb_blank(blank, info);
+	ret = info->fbops->fb_blank(blank, info);
+	if (ret)
+		return ret;
 
-	if (!ret)
-		fb_notifier_call_chain(FB_EVENT_BLANK, &event);
+	fb_notifier_call_chain(FB_EVENT_BLANK, &event);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(fb_blank);
 
-- 
2.48.1

