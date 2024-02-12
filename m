Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403717C71
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Feb 2024 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733041; cv=none; b=k17i3Tj0IlCyjLjy7jwfiY6Gm5yq11fils+rwdhzFqPhVj501d6MFAb2LsZCgG/Bb9hvsXDbyaioCbzv8A4ZdICH4CX7Agkkk/VG71FtXhOms5CqhIOJxzby8D63XF03QsSUUcV6aFqBgCcr7V8BfiCPelgUGhxNSUHqbCbgSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733041; c=relaxed/simple;
	bh=b3tf/EpDshEGu+t364bFLasypSw/P56OWncMkcCB478=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjZ0DHvqoOVCXjolHWErs0wYXCaQz4+r+zMOjJkvhbxT9QwvzajaGZcPCcN7c2K/EHYcu61fW7SboA0AxYZg4TqN663dU4ySyR6Em910Qm3uP5/7BuB5F7463r+7DmN6EjKi2teQeUjxH2WDfgY4qzr+T1bnBlcWTMcbcJalz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sQatehaD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oj71r/cf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sQatehaD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oj71r/cf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sQatehaD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oj71r/cf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sQatehaD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oj71r/cf"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64C8221FBB;
	Mon, 12 Feb 2024 10:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1qGWu88ZQRplSHiQwlJdBo6dbssBQGdSdbRYrTXT7Q=;
	b=sQatehaDKzG+l3DbQb/IPPjYJ9c7WiOigx7Pz0X7IlQ9TKxToJ793Z1Fsz6EVQZSaI6YCS
	XhdoYbX6U3NktVrdWN0NuHi1rdc/tDpEhZs9AD1uLkGgUrLkTfhq0D5xCsY7xeI589Ctnx
	IOPFnMh8V4Ia9/xKxsgyUY3f9xJnSkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1qGWu88ZQRplSHiQwlJdBo6dbssBQGdSdbRYrTXT7Q=;
	b=oj71r/cfTU5EMXok1Hei6Bb156yzKsx8Tc1cSB3krZTITI67YuPaVDwmWs43XMpxOyWXxC
	XxCNFZoGgRfUQEDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1qGWu88ZQRplSHiQwlJdBo6dbssBQGdSdbRYrTXT7Q=;
	b=sQatehaDKzG+l3DbQb/IPPjYJ9c7WiOigx7Pz0X7IlQ9TKxToJ793Z1Fsz6EVQZSaI6YCS
	XhdoYbX6U3NktVrdWN0NuHi1rdc/tDpEhZs9AD1uLkGgUrLkTfhq0D5xCsY7xeI589Ctnx
	IOPFnMh8V4Ia9/xKxsgyUY3f9xJnSkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1qGWu88ZQRplSHiQwlJdBo6dbssBQGdSdbRYrTXT7Q=;
	b=oj71r/cfTU5EMXok1Hei6Bb156yzKsx8Tc1cSB3krZTITI67YuPaVDwmWs43XMpxOyWXxC
	XxCNFZoGgRfUQEDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 18BEE13A0E;
	Mon, 12 Feb 2024 10:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qAjcBC7wyWVdBgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 10:17:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	daniel@ffwll.ch,
	airlied@gmail.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6/7] fbdev: Clean up forward declarations in header file
Date: Mon, 12 Feb 2024 11:13:18 +0100
Message-ID: <20240212101712.23675-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212101712.23675-1-tzimmermann@suse.de>
References: <20240212101712.23675-1-tzimmermann@suse.de>
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
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,ffwll.ch,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[31.90%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Add forward declarations for struct i2c_adapter and struct module, and
sort the list alphabetically.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
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

