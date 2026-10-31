Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417574;
	b=YKjjWh57j+ZO3VaIWGy+jX5F85iu2QAt25EYHLvUlr6SFtkyRVTsZHQoRm9G4ujlA9wV
	 hzeI0KrKPFrHklIY7yXfV2rHqdNChmYWu9DqAu07M2o7hjMS1o/zd6CHfUEKv0pERQv3E
	 f9bKJaigRp6h4lIpqXS+a5/KfykPZ8tZggfddkj6FZ2okvADeRvArcLPs5bAVTkghH9Cz
	 K1hgWPa56MEfF/CQfIt1fMczYpMpNmoSWk4LOVrFIItMHJ39MeqXtzaOkxP0n5nSvzROy
	 MNzjcvE+ywqy0TF/kLeYItZZzuDy3rjuP+/L/gN8H59dG9aty53tXQMPGpyB0H7iCJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yNBCcyYS48KOF7Z3SVlpQ1pq/HG3PypPDg7sc6kq5zE=;
	b=HRgt67yTGdYZRB63fNudQHz2qLHKYXUtgikjpl0JCp6MEcKEQCtQyErP+oyiDlPL+cl6
	 Ms07nQuJkUa+9zU3JINvAZlyEHKjcJjiPIYEaR+utOnWq51ZmgpokUZ9egofHdEOxtooz
	 6tKz9Kv9BP27Ms1JsHZSgo2+C1V4NkROiopcNovId2Gb+86dU7o8QXIVUVFFzcvo+Ynyv
	 /nrpcl+mqJF6/o8NPkRHP0OYydn5uHFuOCTBsy8BJwZkvLH5Kn71XtrKGrCd1BLB9jwOe
	 BFIvdzUupnau1wiGlK9PMaKEAlyIqA7bWxxXNRaJxRa9u0xjYuB4kRIEXyIwuVNj7NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BSGsgJ7R;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AD606A31D
	for <linux-fbdev@vger.kernel.org>; Sat, 31 Oct 2026 03:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B84AD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BSGsgJ7R
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-19305bcb72cso1089246c88.1
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Oct 2026 20:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793417573; x=1794022373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yNBCcyYS48KOF7Z3SVlpQ1pq/HG3PypPDg7sc6kq5zE=;
        b=BSGsgJ7RcTrehIg5BXsMqBpgIgZVJn6DvdLhe1XmYzIAfJFoYcAfKeo57i1+6Lb7XM
         05Bb+8zse6Y7zJXGhnxY5kT/TlVlok50MwP4TLdvKUAnEg/uAkA1vUcWFFN4V5AZe7XA
         eccHJTMXy3soVRWfRAw6H7+Kxjb0wZV+LR1FAvG2f5C2LCFcdXlTklir+7HVJV4MammI
         qRcgOTMQK+dnUorXJIx79GkEBCKpdfugnmi9VsILQ9GDm/LRHpT9rArl+NxPBgu989U0
         px4zEl5QCQHPemvwTXIX0nV0JjRXW6EtINh0w2abtJDfu7PRbZw5POHhASuXlfTi8kVF
         GSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417573; x=1794022373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yNBCcyYS48KOF7Z3SVlpQ1pq/HG3PypPDg7sc6kq5zE=;
        b=EjBsMKQN1jK8zo4j9y8JGeJQry1yNGHv0ptH32D/04MX+XMq+kGXPX4Mu9eRkdTzC5
         +3UDVu1Ex15dLeYOVySu/P/Jo46qdTlU8Yd4ZYT+WAcTh5TKvGaTlAeI4QIBsPDSHIRN
         mwg4mTSDhAfi4HnepxDnPL/nVjS7/1Ql0vTeIJ8+Kod/nTnXUzU+wI01XmMhai9KFQKB
         G0sw4PfeUUNkeQCqsJ2+7KryEduG0Z1MKtWJ5KqyJIh4wha+aFYxI/EKcPgWoGMGyleC
         lI9njbPqEL18WOrlCI7KXz6ag9rCCXTa2Z/dUUx8syM6O0AD/HXo7nBVGSl8koOvbuYM
         KeWw==
X-Gm-Message-State: AFq9FYKp4Nl+tArpLBjtesi5BPvdn1K6/iqTrWV7HSGIuUkFWovFs+AE
	PvVpk7p71wF05vf+PdPIuw55SZraReRT260OSLC+4ZBHlommlCN21Yxa
X-Gm-Gg: AYBFou1rwa8+LzPTfqulfnJGL5vbZ9xG6pbrcB+NMpeEDpVn35o2ql7rX+TZz6LoTuQ
	b+dDvcr5taidaJwsyeMLUy74q0bN0WdgyjYerlZ+gFMLYAbVlfLal+/U/W2cwtBNkj/0PHRE4lc
	0CBrff4G6euWByM00QAiAjeTWEc2lMgGIVX/xxwKo6GVmTqAjVmeOc2fAH4Fc3TCTBjGMgQ032M
	mmDqGvEFzSiFxSL6bCNx0InUPCsHIbaJTcOXDgvdQlO0IiI7RwlXQv+M95nfxQHyCYxRqjyjgPT
	wSC4WI+vP2s8DNWeJqnkAX2QsNANv/qOQiGSbOzZFGVjqGJObz/4Qa6tKPUrm1nwlDCLvYR4sbs
	UmpUW3V6nbM6bLf2KYsfNpRdhRaYgWtcJiOeUeqHgTlR1prmLiR3MlcJNvuN+CYnPaTq/To39EQ
	Z9YmRSQGBUlCqt0G/mVYc6X8tKku3rgr7RTIOKGPWOz4ZCV5EyE5v+vKNYX/vP2NI4FlnedOOCa
	YkyJYjVqIfS135MrOmTw3JBzO8k2M23CBe4knOYPg2X84M6vTHjZ3Jz6kKPWp0byn/BEW1PfMQ1
	Y7HF5UAECH0GxQcpBB77qco0HJnvrAlaeNd77x+8L0Hap+ji+KcXdOWrk85I/w1HxZjkfvYhHxL
	JQ3iyZk529U3ZmeGSFJpcR0DR+BXYziurZxebibtJowLhZsDZ/UceEd4hi6TdhG4ESxSAuJSpQe
	ZCX4p8tsrVYbYlyogYZ0uszv/70iaWTRRBUjQ=
X-Received: by 2002:a05:701b:42d4:10b0:143:2967:c0b1 with SMTP id a92af1059eb24-1ac5b7e1cdfmr5936493c88.25.1793417572110;
        Fri, 30 Oct 2026 20:32:52 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm12841651c88.11.2026.10.30.20.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:32:51 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: pxafb: stop smart-panel thread and notifier
Date: Sat, 31 Oct 2026 11:32:48 +0800
Message-ID: <20261031033248.2491098-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate smart_update before creating the smart-panel thread, so the
thread cannot exit independently before kthread_stop().  Use the
freezer-safe stop API and stop the thread on removal and every probe
error path after it has been created.  Unregister the cpufreq notifier
during removal.

Found by Sashiko AI review.

Link: https://lore.kernel.org/dri-devel/20260722075803.570532-1-panchuang@vivo.com
---
 drivers/video/fbdev/pxafb.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 1912cfce28d6..1b2a16590999 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -1248,20 +1248,10 @@ static int pxafb_smart_thread(void *arg)
 	struct pxafb_info *fbi = arg;
 	struct pxafb_mach_info *inf = fbi->inf;
 
-	if (!inf->smart_update) {
-		pr_err("%s: not properly initialized, thread terminated\n",
-				__func__);
-		return -EINVAL;
-	}
-
 	pr_debug("%s(): task starting\n", __func__);
 
 	set_freezable();
-	while (!kthread_should_stop()) {
-
-		if (try_to_freeze())
-			continue;
-
+	while (!kthread_freezable_should_stop(NULL)) {
 		mutex_lock(&fbi->ctrlr_lock);
 
 		if (fbi->state == C_ENABLE) {
@@ -1290,6 +1280,9 @@ static int pxafb_smart_init(struct pxafb_info *fbi)
 	init_completion(&fbi->command_done);
 	init_completion(&fbi->refresh_done);
 
+	if (!fbi->inf->smart_update)
+		return -EINVAL;
+
 	fbi->smart_thread = kthread_run(pxafb_smart_thread, fbi,
 					"lcd_refresh");
 	if (IS_ERR(fbi->smart_thread)) {
@@ -1299,8 +1292,15 @@ static int pxafb_smart_init(struct pxafb_info *fbi)
 
 	return 0;
 }
+
+static void pxafb_smart_exit(struct pxafb_info *fbi)
+{
+	if (!IS_ERR_OR_NULL(fbi->smart_thread))
+		kthread_stop(fbi->smart_thread);
+}
 #else
 static inline int pxafb_smart_init(struct pxafb_info *fbi) { return 0; }
+static inline void pxafb_smart_exit(struct pxafb_info *fbi) { }
 #endif /* CONFIG_FB_PXA_SMARTPANEL */
 
 static void setup_parallel_timing(struct pxafb_info *fbi,
@@ -2364,6 +2364,7 @@ static int pxafb_probe(struct platform_device *dev)
 	if (fbi->fb.cmap.len)
 		fb_dealloc_cmap(&fbi->fb.cmap);
 failed_free_mem:
+	pxafb_smart_exit(fbi);
 	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
 failed_free_dma:
 	dma_free_coherent(&dev->dev, fbi->dma_buff_size,
@@ -2382,6 +2383,11 @@ static void pxafb_remove(struct platform_device *dev)
 
 	info = &fbi->fb;
 
+#ifdef CONFIG_CPU_FREQ
+	cpufreq_unregister_notifier(&fbi->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+#endif
+	pxafb_smart_exit(fbi);
 	pxafb_overlay_exit(fbi);
 	cancel_work_sync(&fbi->task);
 	unregister_framebuffer(info);

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
prerequisite-patch-id: 44b1c2680cb029871e123eb11eab7764a807ef24
prerequisite-patch-id: f4dfbbaaec2d208ac255451cf032c22f0e7fed2d
prerequisite-patch-id: ff6a574f35399a0059df3a759cbd2a558d24300c
prerequisite-patch-id: 784ec68755ba9ffc1d5693e1baff1f59d574c331
-- 
2.56.0

