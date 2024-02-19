Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A80250F6
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Feb 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335594; cv=none; b=vFDYIun84T/fhgVLNUxjHui7kLahuHvDVNrBV1sKwaB7urJLe9c4eg0v5BagF9pVloscgiXi6fsHn36Kunomdf1R5KWCVznf3AegvxfQAoW6lIMlnK+pmf8sC6W8VCTRCectqp71isYSCggk0c5z4WJ7IWTm6s5mDRfMbpl8dAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335594; c=relaxed/simple;
	bh=Wi9mddzF8kVsCkdLpPuPTCHQNEkiRMzIBPtRRTxSRck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9bxMYyHMhaLgRidxkfx5QZjt5pUAsZLQHRd/NZ1Skox+/L6LOCdR3JNZLpLO+vPsvb5aggZWv1BLpr6IaIyYJ5goUMARVG4xJ1a71B74XsnJbIFlOKFHttUBcFhxjh1p/XHcPLUV3YcHFYrUfiQRulZ0jNna1XG8xvOXTqjX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vA4S2uYh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ql8C6o75; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vA4S2uYh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ql8C6o75; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vA4S2uYh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ql8C6o75";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vA4S2uYh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ql8C6o75"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFC63220F3;
	Mon, 19 Feb 2024 09:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPK+Rde+d6xq2HayIWWerCvybWygxXuUA3IqykRsWRs=;
	b=vA4S2uYhQexfj0b5yzRkyKzjkcoJMr9i+HzWhYATIL54NFKRnRO3sdTT0OcdrH1+fd3+6U
	v40+bex8GoXyb2RR9NBhpW0pfBOK2BLCQN1XSWHQUVBfwJ/+mZiHZQ01RTFadR3d3NZCM1
	1VlFmlEeID9TCSKb73297KdccEpmMwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPK+Rde+d6xq2HayIWWerCvybWygxXuUA3IqykRsWRs=;
	b=ql8C6o75oJulyLehnbP9A81vL75Ontmt7YuGkK4tW4QT/07YAHWSAkcSHZGn36YPyjJ7m3
	dG7B2DINSV/qqjCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPK+Rde+d6xq2HayIWWerCvybWygxXuUA3IqykRsWRs=;
	b=vA4S2uYhQexfj0b5yzRkyKzjkcoJMr9i+HzWhYATIL54NFKRnRO3sdTT0OcdrH1+fd3+6U
	v40+bex8GoXyb2RR9NBhpW0pfBOK2BLCQN1XSWHQUVBfwJ/+mZiHZQ01RTFadR3d3NZCM1
	1VlFmlEeID9TCSKb73297KdccEpmMwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPK+Rde+d6xq2HayIWWerCvybWygxXuUA3IqykRsWRs=;
	b=ql8C6o75oJulyLehnbP9A81vL75Ontmt7YuGkK4tW4QT/07YAHWSAkcSHZGn36YPyjJ7m3
	dG7B2DINSV/qqjCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A9F813585;
	Mon, 19 Feb 2024 09:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uDXIHOUh02XlUAAAn2gu4w
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
Subject: [PATCH v3 8/9] fbdev: Clean up forward declarations in header file
Date: Mon, 19 Feb 2024 10:37:33 +0100
Message-ID: <20240219093941.3684-9-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [4.90 / 50.00];
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
	 BAYES_HAM(-0.00)[37.48%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Add forward declarations for struct i2c_adapter and struct module, and
sort the list alphabetically.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Helge Deller <deller@gmx.de>
---
 include/linux/fb.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 42155898374b1..8f70ca727a30d 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -15,15 +15,17 @@
 #include <asm/fb.h>
 
 struct backlight_device;
-struct vm_area_struct;
-struct fb_info;
 struct device;
+struct device_node;
+struct fb_info;
 struct file;
+struct i2c_adapter;
 struct inode;
+struct module;
 struct notifier_block;
 struct page;
 struct videomode;
-struct device_node;
+struct vm_area_struct;
 
 /* Definitions below are used in the parsed monitor specs */
 #define FB_DPMS_ACTIVE_OFF	1
-- 
2.43.0

