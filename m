Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699A1B7F5
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Feb 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813853; cv=none; b=Vvwa6rvQ9g6YUxM0Mr5Mkt3wjKMulZ6e4GNuJ+6JUYCAO2NhyXOd4Pg3mEcmZxrrC7mnZhEFWDXnymUKPoSPcTOuafVTVE3p9qYacTv7ZTl0oEMamxoRp9Ttt5FG+MYMxwVrb+EhXno+AXWsfhou/3HGOR5r1kwvUlBOYx9F9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813853; c=relaxed/simple;
	bh=Tjx89INZk4ph24H67Nn3nyzflf39Bl7CzNwfrO79E0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJRSKPMWd0quM//WBCdSH67S5TpFdF/QV96IqzS5B+wCKF2LYHlX4Y8uW5XHxjWxfSCsh5olYeTxs1NzMh46lrb9q9JZTAsKvyjUGvCgmeIVSjVXq2ya1ZRG4La86bvx9ToFK+383Gv8+hpvSiKLYLQVJ+/O/PvuTXC3JQL5/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gTibdIYV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YicdfEIy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gTibdIYV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YicdfEIy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gTibdIYV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YicdfEIy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gTibdIYV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YicdfEIy"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E1392219F;
	Tue, 13 Feb 2024 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707813849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2GLT5Ur1C4c5LTkjDjPIftfGSpg/zb/1mTpFX8ItyU=;
	b=gTibdIYV5ojo+v3gHHrYAfUeiMwz27Y1sJqJeuQxDvEc7tMcimenxl7/v3t9b39CyfTB9D
	mOwDkIY4IwMKgyuIL7ll+9SWi60gcqTOm1px/k2XU0oa//8uzp0H1UPpumSwkmGQ+TBeZO
	5NU61026Rf1TohH1RWNjVvbhsUtPNeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707813849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2GLT5Ur1C4c5LTkjDjPIftfGSpg/zb/1mTpFX8ItyU=;
	b=YicdfEIykKjp42IL4Ne9ka4MoRcH/pO9hQ1ERP58hqtnEsoCKKiOjvrHmgo7Y7ftmKc1cK
	JuKQT+sR+1c16KDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707813849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2GLT5Ur1C4c5LTkjDjPIftfGSpg/zb/1mTpFX8ItyU=;
	b=gTibdIYV5ojo+v3gHHrYAfUeiMwz27Y1sJqJeuQxDvEc7tMcimenxl7/v3t9b39CyfTB9D
	mOwDkIY4IwMKgyuIL7ll+9SWi60gcqTOm1px/k2XU0oa//8uzp0H1UPpumSwkmGQ+TBeZO
	5NU61026Rf1TohH1RWNjVvbhsUtPNeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707813849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2GLT5Ur1C4c5LTkjDjPIftfGSpg/zb/1mTpFX8ItyU=;
	b=YicdfEIykKjp42IL4Ne9ka4MoRcH/pO9hQ1ERP58hqtnEsoCKKiOjvrHmgo7Y7ftmKc1cK
	JuKQT+sR+1c16KDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B0F9C13A2C;
	Tue, 13 Feb 2024 08:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qLvvKdgry2VOFwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 13 Feb 2024 08:44:08 +0000
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
Subject: [PATCH v2 7/8] fbdev: Clean up forward declarations in header file
Date: Tue, 13 Feb 2024 09:42:25 +0100
Message-ID: <20240213084403.20995-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213084403.20995-1-tzimmermann@suse.de>
References: <20240213084403.20995-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL9pqk354j4esf7wsagg6iyf8a)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,intel.com:email];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,linux.intel.com,ffwll.ch,gmail.com,linuxfoundation.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[25.89%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

Add forward declarations for struct i2c_adapter and struct module, and
sort the list alphabetically.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
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

