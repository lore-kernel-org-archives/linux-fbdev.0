Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319253;
	b=nP3nGZEHO25G5drn+1oiC6Vu8FgE9WVp6y/FBt5BKiWJwqNTu1xy2viLAqfZ+CX/5WOf
	 /B4kazDiaP+dt6owdyHbhaUtiuuMjMJARujrRvSMTwXiG1o+EFsKcLZE6eHW17qgqzMtw
	 HZW+3uZ5pmn48WNl36Pw2MPp41lc8H5GqMlTeI6wq5hIqhqUFGa8BOQ6yY5kCFURbVEEh
	 DVHYkf0pzSzmjF3wUTbJXRZkpfGia7QO5knUeIEkeCXvYmyIGgbwvG3ntCSBQ1m78T2+r
	 UssiLWoCZN6hAlQdefrk74B3rvglPsQ5QgLwVxW2Z+0yPaJTSz8I2tiQLiU+e4D9tww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+T9D/kB7BW8AzSh/iiHsnXz7kQX8FAMQaVA4PKYbVfM=;
	b=45dMk+Xa7TJNmRTeSwXSXMf9fbAQMmcCQvei8i5Nanxa8VGixDSl+MnXtS5YlEdQzNR5
	 3OvZtXiHIyDTxpyX6/qOGsSCXOk36vVQBDCICAjL4XlLawulTSTz2PSiTcmYkWZqfkSoN
	 mBfKC5/t/Clklk2jwNQtXnRHzo7UADYeQNhhm71qHGINNt7Ek7ZVBKCPRJu0Eb5tQwBJQ
	 vqKfz/6KbLKtMiRZzXF8+2nf7HPprMI/djU7GrWms1dw9XicN6vpLJnPDxc+pNajT/T10
	 l8RsHVFSY34uhZ3f/nT5X6NJdwDVom0+xgfGPHIE/FwlcALgtLHJI8pVfN/QywGQucw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RnMLGhBj;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A62606A325
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2026 14:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98A62606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RnMLGhBj
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-19305bcb6d5so706992c88.0
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2026 06:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794319252; x=1794924052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+T9D/kB7BW8AzSh/iiHsnXz7kQX8FAMQaVA4PKYbVfM=;
        b=RnMLGhBjuhZFM6YZcEhT7gshDGngPZEtr95ajejwaPDX8AwjmBLL0BQxg/VUCMPZ4t
         HYuaJBJjm8cAyVTajAP0vgUS3Z0Nbxi9GExlPgpVA2NAYaW8ol5pmoe8sCZojc+9mqaj
         yzVpyX+G6qXsTMNkEtZBFw8Mqjra0Tnv/pASFPka2STtRsz4gdh4s8izbdIw+zRHHppB
         L+tCKdToXQbjMhMDTGmSxGbnyoAABYPvUKfZy4CqYtvU5h224YG0IF2QOBGJMm84uuDz
         tOAzQ6DiKEQoBfrUg9aEjh9nklrYM1cWk03gpEmehHCjbhPyaTVqyEM7puyCxjTk2/7e
         T7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319252; x=1794924052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+T9D/kB7BW8AzSh/iiHsnXz7kQX8FAMQaVA4PKYbVfM=;
        b=22SPp8pWrMiHcIkB+wJJs7Hecmrx2JV+t5IELwFCDTSdaeDjMUE8rBiX8U6kLZGXUP
         lvVrRCcaWIC6jWcluyGYCu/tx4FBMjjj/mDtzvJdgFHacQ2K/KWbeaHB6AEouFQBpk7q
         mrFE5421QInD6L/cxOLyy0n24kcfN5xJvsRhiUi+gZ2198SsjN5+da08sYJZEOVtOz2P
         VhJew/fd6v2IYzGCge2+eocMstylIyCL/7qjodSR3cfVV3b9yzHNHcMhOqSSMN1ry63G
         svkQ6BhxhIEVznOCMGd4Bnl8RNLWnJzgyo0PZM8cDHaPt/yU+c2tVS33Ei9P7+BR4w8o
         8uvw==
X-Forwarded-Encrypted: i=1; AL+hErESzCQvGseLCF1EBY0zpe5igLjgo6kVpQ8yDNbGEOCTSBOqHZ3HitGSKyNiIKRRTp3fyGcEXCX7xTAQ+A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8IhiuZfaKrAhB58BRL+RJ+WMsr6vrycQSf3CbXFLKpd8CQxwer
	gbTqskzvJNGFndxkv4b7J86AY0wHlOnvyPV3CGFRMaq2xidy6v2tlz23YqTjMaI4yocl6g==
X-Gm-Gg: AYBFou3gExEdgNZWsSTOmCADNrimH6YIgjng/R+lxpdyDoJzRaJ8g5GkSq2R0nxM4Lk
	JzRup4BKrcUMKMzVKoSNKdJag2KYqM7qwU2zHM+/PHDE+BNzLK8ZkzLzbUUHvavEwTXuSSkIJdx
	2grQzC+QawXSTDIPyReT300Q5sye3TbErqmWM7yC/KKfjlftCZA5yfjKgFN64MJBwc1XN6Olfs+
	v9yiUi7hK2c8B4McdbsMj5VnPKsP/w/1/zms9sxksFUwMG8S0yTCmh4tY5n0PHkRjVDDCpcP8aj
	fHDafMLdKFsfwrV4WbBqKVm2JBn5u6o5tAnmovpPGFzlxo98xOn+GuijpNlTfIQkm3Y1OTk+0cK
	811i7zE/mUUJNSnXGW7S+/0itSyq39nrnMq9vqZoa0YKb0nrMxJtWeFWOBjJBy/KCspNyPxsRlf
	Smk3XnFTLymv6Ri3wsUoN3ZT3CpDPy5ShCfAORXDsd0/QyauCFNfFFKJmdQ8wQKS/tMEBJhPt94
	EbAN5GadclU2kkPSwSNnNVLGzJfXBRIkwRAv0hPijWVco0LaKcju0AjGC7H9J7+Yerrf+mcD7fd
	tqaSJD+LYeiy+rV7QSffatC+Qf/+XHFfBmNPddQTWA==
X-Received: by 2002:a05:701b:455a:10b0:1a3:dfb6:e593 with SMTP id a92af1059eb24-1b3b6185203mr3440708c88.27.1794319251406;
        Tue, 10 Nov 2026 06:00:51 -0800 (PST)
Received: from blue (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b85d22sm7594328c88.19.2026.11.10.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:00:51 -0800 (PST)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: javierm@redhat.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Yiqi <yaoyiqi3@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH V3 RESEND] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Tue, 10 Nov 2026 21:59:59 +0800
Message-ID: <20261110135959.232798-1-yyaqia@gmail.com>
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

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_cursor() can be reached from the console printing path, which runs
in atomic context. When the VT software cursor is enabled
(vc_cursor_type & CUR_SW), it calls fbcon_del_cursor_work(), which uses
cancel_delayed_work_sync() and therefore may sleep.

With CONFIG_DEBUG_ATOMIC_SLEEP enabled, the following is reported:

  BUG: sleeping function called from invalid context at kernel/workqueue.c:4722
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0
  ...
  __cancel_work_sync
  fbcon_del_cursor_work
  fbcon_cursor
  hide_cursor
  vt_console_print
  console_unlock
  ...

Make the default helper safe: fbcon_del_cursor_work() only stops
blinking, using cancel_delayed_work(), which is allowed in any context.
Every "stop blinking" call site keeps using it, including fbcon_cursor().
Only fbcon_release(), which is about to free @par and must ensure that no
callback is still using it, calls the separate
fbcon_del_cursor_work_sync(). New call sites therefore get the safe
variant by default.

cancel_delayed_work() does not wait for a callback that is already
running. Since fb_flashcursor() re-arms itself, a callback that has
already been dequeued by process_one_work() can queue the work again
after fbcon_del_cursor_work() returns. Add a cursor_blink_on flag to
struct fbcon_par: fbcon_add_cursor_work() sets it, fbcon_del_cursor_work()
clears it, and fb_flashcursor() checks it after taking console_lock and
returns without drawing or re-arming once blinking has been stopped.
Keep the requeue inside the console_lock section so that the flag check
and the requeue are not split by a concurrent stop.

Fixes: 3b0fb6ab25dd ("fbcon: Use delayed work for cursor")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:deepseek-v4.1-flash
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon.c | 41 +++++++++++++++++++++++++++-----
 drivers/video/fbdev/core/fbcon.h |  1 +
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 94abbb5ac766..0847dcf18416 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -410,7 +410,8 @@ static void fb_flashcursor(struct work_struct *work)
 	if (par->currcon != -1)
 		vc = vc_cons[par->currcon].d;
 
-	if (!vc || !con_is_visible(vc) ||
+	if (!par->cursor_blink_on ||
+	    !vc || !con_is_visible(vc) ||
 	    fbcon_info_from_console(vc->vc_num) != info ||
 	    vc->vc_deccm != 1) {
 		console_unlock();
@@ -422,25 +423,53 @@ static void fb_flashcursor(struct work_struct *work)
 	par->bitops->cursor(vc, info, enable,
 			    get_fg_color(vc, info, c),
 			    get_bg_color(vc, info, c));
-	console_unlock();
 
+	/*
+	 * Re-arm under console_lock so that a concurrent
+	 * fbcon_del_cursor_work() cannot race with this requeue.
+	 */
 	queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
 			   par->cur_blink_jiffies);
+	console_unlock();
 }
 
 static void fbcon_add_cursor_work(struct fb_info *info)
 {
 	struct fbcon_par *par = info->fbcon_par;
 
-	if (fbcon_cursor_blink)
-		queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
-				   par->cur_blink_jiffies);
+	if (!fbcon_cursor_blink)
+		return;
+
+	par->cursor_blink_on = true;
+	queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
+			   par->cur_blink_jiffies);
 }
 
+/*
+ * Stop the cursor blink.
+ *
+ * Does not wait for a callback that is already running, so it is safe to
+ * call from any context.
+ *
+ * console_lock serializes this with the requeue in fb_flashcursor();
+ * otherwise a running callback could re-arm the work.
+ */
 static void fbcon_del_cursor_work(struct fb_info *info)
 {
 	struct fbcon_par *par = info->fbcon_par;
 
+	par->cursor_blink_on = false;
+	cancel_delayed_work(&par->cursor_work);
+}
+
+/*
+ * Stop the cursor blink and wait for a running callback to finish before
+ * @par is freed.  May sleep, only for teardown paths.
+ */
+static void fbcon_del_cursor_work_sync(struct fb_info *info)
+{
+	struct fbcon_par *par = info->fbcon_par;
+
 	cancel_delayed_work_sync(&par->cursor_work);
 }
 
@@ -765,7 +794,7 @@ static void fbcon_release(struct fb_info *info)
 	if (info->fbcon_par) {
 		struct fbcon_par *par = info->fbcon_par;
 
-		fbcon_del_cursor_work(info);
+		fbcon_del_cursor_work_sync(info);
 		kfree(par->cursor_state.mask);
 		kfree(par->cursor_data);
 		kfree(par->cursor_src);
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index d93a89877d04..6a2f7f6e5a8c 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -97,6 +97,7 @@ struct fbcon_par {
 	int    blank_state;
 	int    graphics;
 	bool   initialized;
+	bool   cursor_blink_on;
 	int    rotate;
 	char  *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-- 
2.56.0

