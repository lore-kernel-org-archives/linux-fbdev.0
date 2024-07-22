Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F9FC02
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jul 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721648895; cv=none; b=FQi4f5nq64mYOLpuu8MiY7ZU8BIJnJjiFIl7wuaVQk8BMHgmTi0CVyx3ym61fwkFodUfTu0VaK8vqxlGRHlEQ/mVZFhKypgqS+XW8UePRbwmRs8fTbCUfNzn2HFXecfIKtFMD3mSDyF1Ndi1GqHqWZvrATcfK87OEEyQ8fvrn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721648895; c=relaxed/simple;
	bh=BiNUUYs8aLEXVgndG3m9OwhMyGi2nYqPOYqiKzbAqzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osh1TOHh9jUSO32WBmFfNi2u8/vDkuO4L3SDX2ZkNSTt25sb21RJLmUHtcKcQCJcu9G7xq0/stU0GbXzO1Z1AHy0G1jWNIHHlBQKoEUXlyGWfMyzbu4kcijVmU6zlJNvi44qjpVS2pf4vzk7ShsXXHhltdCrM+TFQ+of9AHFBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcYxTg11; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcYxTg11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721648892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mON0Gx7FVFtPkP0kLOreGdHs3og1l5iGH3FHLInhhao=;
	b=GcYxTg11WbKZt6sUymdpyRBJSVVD3DNh4RvynzV7MKSMPfNX1NT4yuPDTez/9dgde+GaQh
	64if2BkmzuK5k+D7YvyFiv17sna7pKJ40eQCpXGfua2Ng3mFukSNoBU/5ahoZPsDYCbo03
	A+byGZSI2ncxO2SsnV6QFJPM/K/WSDU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-V5fsc56OOI-XBxKw3Dy7Ww-1; Mon,
 22 Jul 2024 07:48:10 -0400
X-MC-Unique: V5fsc56OOI-XBxKw3Dy7Ww-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96DFE19560AA;
	Mon, 22 Jul 2024 11:48:07 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.104])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50B453000188;
	Mon, 22 Jul 2024 11:48:03 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: lkp@intel.com
Cc: Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	oe-kbuild-all@lists.linux.dev,
	Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH] fbcon: Use oops_in_progress instead of panic_cpu
Date: Mon, 22 Jul 2024 13:47:51 +0200
Message-ID: <20240722114800.174558-1-jfalempe@redhat.com>
In-Reply-To: <202407210203.2ISiIC9m-lkp@intel.com>
References: <202407210203.2ISiIC9m-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Panic_cpu is not exported, so it can't be used if fbcon is used as
a module. Use oops_in_progress in this case, but non-fatal oops won't
be printed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407210203.2ISiIC9m-lkp@intel.com/
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 498d9c07df80..2e093535884b 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -64,6 +64,8 @@
 #include <linux/console.h>
 #include <linux/string.h>
 #include <linux/kd.h>
+#include <linux/panic.h>
+#include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
 #include <linux/fbcon.h>
@@ -272,7 +274,14 @@ static int fbcon_get_rotate(struct fb_info *info)
 
 static bool fbcon_skip_panic(struct fb_info *info)
 {
+/* panic_cpu is not exported, and can't be used if built as module. Use
+ * oops_in_progress instead, but non-fatal oops won't be printed.
+ */
+#if defined(MODULE)
+	return (info->skip_panic && unlikely(oops_in_progress));
+#else
 	return (info->skip_panic && unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID));
+#endif
 }
 
 static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)

base-commit: 7e33fc2ff6754b5ff39b11297f713cd0841d9962
-- 
2.45.2

