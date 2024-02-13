Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0A20309
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Feb 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813852; cv=none; b=c8p1AnU3ZspVQmat1Sf68fFfQKoDvneSERkLLqZHRO1q8Vq7YOgQvMm3eIDATNFH9wZkKa3jOTIykHLmhqTrHDrRqZ876CvJ4I1G+/9DTcTMfBrqgGJBqra5A8hXNI3HaE69xjxxKqh96jWOwI3jnIVDUbJMPJQu+mSdgW2mIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813852; c=relaxed/simple;
	bh=cN+lcT7N8MxRb/OQTw9ViPg9nRteKmgAhWpKOdaCaQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi+S9MGMb2GKh4oMQ/ueV1kDomayHvsajmKskHGbBdhdLW9XuH8kgTKWQzKdeBRoTJsmkvNNDHx6kr3Uw/JhsNOjrSDR65w3Mi5MEOE6yH42R/kDtBRDvv2HhFL8uAu0enjtYli/HOBWPePWPEAkWdVs5f+WF0+VYHr4kvBt940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BEFA1FC31;
	Tue, 13 Feb 2024 08:44:09 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 225DD1329E;
	Tue, 13 Feb 2024 08:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OHYiB9kry2VOFwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 13 Feb 2024 08:44:09 +0000
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
Subject: [PATCH v2 8/8] fbdev: Clean up include statements in header file
Date: Tue, 13 Feb 2024 09:42:26 +0100
Message-ID: <20240213084403.20995-9-tzimmermann@suse.de>
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
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 7BEFA1FC31
X-Spam-Flag: NO

Include mutex.h, printk.h and types.h, remove several unnecessary
include statements, and sort the list alphabetically.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
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

