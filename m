Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A8208C3
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Feb 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813851; cv=none; b=QlKrMeZuawfneyyawbyAF9xyFR0i4tzHQw19id8b0dfumQVjHz0JW7dgqeukAIieHJIzwiFMGMeVN7bY4ACTQuuaZAtcQf3yuggBMMh70PMMUQMTyaQaLOtD1tsZDNv853UfMSzInqxP+pA4s/HaOwJeu8gRNUxXbTzPNxUmtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813851; c=relaxed/simple;
	bh=Ab6W8JhLCEUv2AAVnfvZ1SRUragumWY+TxtuPwRUNfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ae4ZJzwCaDA7lPIO36dYo6xVGqfnqjk8pNYnb/GOELbn/8nzCdDMzAD5oKa/AXkkE2i1jcL69baDbmAHjw5buBR9RqZNsINOc3H2FBBuTYqSD7Xja31Rio6tNdee6IkqGecoR18F5AdT/f0T50v7/bxyAbWA7Pc1uk3xbZGnd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AAD681FC30;
	Tue, 13 Feb 2024 08:44:08 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 507E91329E;
	Tue, 13 Feb 2024 08:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kD9BEtgry2VOFwAAn2gu4w
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
Subject: [PATCH v2 6/8] fbdev: Do not include <linux/slab.h> in header
Date: Tue, 13 Feb 2024 09:42:24 +0100
Message-ID: <20240213084403.20995-7-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: AAD681FC30
X-Spam-Flag: NO

Forward declare struct page and remove the include statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 90f348f14a490..42155898374b1 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/workqueue.h>
 #include <linux/list.h>
-#include <linux/slab.h>
 
 #include <asm/fb.h>
 
@@ -22,6 +21,7 @@ struct device;
 struct file;
 struct inode;
 struct notifier_block;
+struct page;
 struct videomode;
 struct device_node;
 
-- 
2.43.0

