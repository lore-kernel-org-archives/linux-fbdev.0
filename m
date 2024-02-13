Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F5221104
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Feb 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813851; cv=none; b=QlIcOq1Lx7q1M1bRbpT3cisZnrd8JLJnEX37CZw2iK/BFHwU785Fg7KoR9548IOLCWJgIlRvRkf+zHabxxzeiIUey/z25JQh6PIuwg7VhU7Jb/AS41ZN9gJZePJp/3DgEXD01G+lAOHbCp2JUESNxhm07mjnhIaxXki6wuuXxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813851; c=relaxed/simple;
	bh=HQpyRK1Y7gx3XhGnBaATYmbjfVo5wtYa1bH58eTppro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odFNQi7AI5TTj5z1bubvg9dzxygOhCHPlnaUlQZuWVWkPzW800pRKK4fG6Z5p6IreS+BwCU4llaJR7sN8k9YiMnXCHjow/quyGZ5HOQf1cmydqMBWOJ+BWfAlJDgblQeXrcIoEbSgPVeONN8v0y7PO+Hnx2rdojqJVzOtxjNENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jc75PMk+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8xAxB9N4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jc75PMk+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8xAxB9N4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jc75PMk+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8xAxB9N4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jc75PMk+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8xAxB9N4"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 497CC220A4;
	Tue, 13 Feb 2024 08:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707813848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HMT+Jv5dcRljTBJrOnbebxxnSQyQpSFxDKzbYw6F+A=;
	b=Jc75PMk+Ygh2FJ6bEnwgb/pey5d8gcCsBxKgLvcJbr8Qrwhp4bpJ7G82yH19U8es4rqzzQ
	J4KQWcDm9O4nHwb1eHpuQAD5kXHNb7P9GaYtQAomfIH3yyy6qdynakiO3s424LgAxGrGm0
	gdGo1tOHjI+XYqX+fypKQEW92iN0XbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707813848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HMT+Jv5dcRljTBJrOnbebxxnSQyQpSFxDKzbYw6F+A=;
	b=8xAxB9N4m3f2MNMx/hQLAMx8f/im2fssGqIarCGE4r7rR5RN7V6C1wuvR3g7LnuzMNj1+8
	/gsXPUBoexozBaAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707813848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HMT+Jv5dcRljTBJrOnbebxxnSQyQpSFxDKzbYw6F+A=;
	b=Jc75PMk+Ygh2FJ6bEnwgb/pey5d8gcCsBxKgLvcJbr8Qrwhp4bpJ7G82yH19U8es4rqzzQ
	J4KQWcDm9O4nHwb1eHpuQAD5kXHNb7P9GaYtQAomfIH3yyy6qdynakiO3s424LgAxGrGm0
	gdGo1tOHjI+XYqX+fypKQEW92iN0XbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707813848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HMT+Jv5dcRljTBJrOnbebxxnSQyQpSFxDKzbYw6F+A=;
	b=8xAxB9N4m3f2MNMx/hQLAMx8f/im2fssGqIarCGE4r7rR5RN7V6C1wuvR3g7LnuzMNj1+8
	/gsXPUBoexozBaAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E741E13A2C;
	Tue, 13 Feb 2024 08:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iN4gN9cry2VOFwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 13 Feb 2024 08:44:07 +0000
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
Subject: [PATCH v2 5/8] fbdev: Do not include <linux/notifier.h> in header
Date: Tue, 13 Feb 2024 09:42:23 +0100
Message-ID: <20240213084403.20995-6-tzimmermann@suse.de>
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
	 R_RATELIMIT(0.00)[to_ip_from(RL9pqk354j4esf7wsagg6iyf8a)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,intel.com:email];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,linux.intel.com,ffwll.ch,gmail.com,linuxfoundation.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[15.05%]
X-Spam-Flag: NO

Forward declare struct notifier_block and remove the include
statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index f269ba5202809..90f348f14a490 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -10,7 +10,6 @@
 
 #include <linux/init.h>
 #include <linux/workqueue.h>
-#include <linux/notifier.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 
@@ -22,6 +21,7 @@ struct fb_info;
 struct device;
 struct file;
 struct inode;
+struct notifier_block;
 struct videomode;
 struct device_node;
 
-- 
2.43.0

