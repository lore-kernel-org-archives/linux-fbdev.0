Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072849;
	b=yzhmrqs8da5L7j/ZkQZNL8xR1rSKqQvQirdS0vYaI088S3Hjmi5Q8pBzWfIbS2s47Wll
	 ZrPbfWPV3NZNfhl4gU9J+uYcLldsjvTY4G7htTGX5VyEiXvMDBXv6FetHVkzvsuGLdnhL
	 K15LBRBjpwNyDnQyc+uQxaFSh9lQEk4NsgqAJmHUlJZ2v/Dkb5COjvoCuOL8swZaMRZc6
	 OlGzjA03LBj0wTbal02y23KWgj6cDvd/W6OnXEZ5ec0LSdnWEBGZUHvZE2e7Qwl5NF0Gu
	 h8fYmVoll0AwPVREmH7DxUiMdL45BpnHWmkfCtptW8wtfSAsMRoYmK7ieM4qjVEKEkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d5xPE7zkAisWNP1/3IMkS+loLJJfjfdBEUGlcoiM7g0=;
	b=KPxSnciBcgilgFu0zHY/6+gwMnPs1gQY6nDLPWtI20NPiZcJFKe29nWRbuHzy27wm9AO
	 /BR8g5piT+JS5InfmExjMSLwzD7XW4ctUtsjG5nKfDfSNursaTGKj6H6cOrsatbqUeQ5o
	 AZWR4HinIZnNqm4CMHCnxF26XyH3pPsTGT6DRBXuUr3VUgwVczNFNJQz3K86KzAsPtZwj
	 ZFjFVb37gk+npIQ1HUfJa35Rk6sf26eSLa4JKlWEGfzW497iFNqoTp30um1QmWIQdVLIv
	 Tn2DBRFkT+LOdLR8kH7I+EXXb8oxtXVyQEU7J1jc21S7eq3UeJiua08vcmI1isgCKhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e983Zow8;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F46606A31A
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 03:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05F46606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e983Zow8
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-369f126a526so705129eec.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 20:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793072848; x=1793677648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5xPE7zkAisWNP1/3IMkS+loLJJfjfdBEUGlcoiM7g0=;
        b=e983Zow8bqjcKnPpbeo0bbx7KS7wIeUh39gAOhDmf2Re+Zkktq3fgnJC41tfL3GREe
         5c6sMBCH2D4WNBCK52FND3Xet7GOvnwn13zfbYx7WoOVAzxFGimRlBBT7Y07ZzNEEktP
         7WXk+Yi/UJL42KfR3Di5c6WFqo5Tvb/ND7+pWcYoSSHGN6Xhi6Bl7CypCbWewPd3QNUT
         k5mohsSecJcBa+nCksrsh0AVnrGG/oWPJl9JesGIU1/9WNuYcQbYO1xjz+ZNXnwBd8tf
         JdeFa+FyY3QE6XfKiASyPEKdUp1zMj78IG9LZPrLQSMz0xSnnywEzz5NhGHDOWOQTzl3
         OHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072848; x=1793677648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5xPE7zkAisWNP1/3IMkS+loLJJfjfdBEUGlcoiM7g0=;
        b=hCdIym7typHRHePGsU806bLJFvuAX0s9w77APwVCxJILFW0no86SQzwoxahj/JJ3Yh
         Bc3CwaaMZkCcEAjJGZCB6aUOxNAEoS2T38GhRoqqEC42yIFlf1ICXZz+SFYvqjRb2aBX
         BysODtxii28HScgXiBxQ6Vw4qzrOSFdfl6INdWjRvg/Q2nIf/jDXU/7HA6a5tGIRuOAa
         GyyrTYKVyOoK97/MQ/FND7PlbU9AjEJdv6GzKs/8SW1A9g6LONy+qPLVwjLJYy7XvzGh
         ff572hU8EeId5fqlsb/K01iuSrrJeu2LYda9Ewu77Jx6KCoSp0Gim1zqv+JAYYn9v8JN
         2kbg==
X-Forwarded-Encrypted: i=1; AKwUvBykuXxyILatEFC7IeKzfugWCfLPkT3nKZkEH8M7mBJDbOKPeXUWIWWEdnKBXCJ7yelrrDK7ZKCbt+ip4w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIQ0AXVwZE0otPfF6bG4lhJeea+8xU7tGTxHnEpLGgwSKZeYf3V
	5A3ATQ7rK2MltVSfExLawl2iaKXQlN5oAED1pxx6Wcf0AjZ/WLdoj9Ar
X-Gm-Gg: AYBFou2QNAseRM08HBoVf6LceLJVfm3xheWsWCpKeVC0D9ZPF1eW/Y9Yst9KqrtE2hC
	anvxdtKOJk+paQCuUqKGfCamtZ7131lVQuQm+vq9+NTkV0LZFdMM5s/0AjDPkOj9sM52V2ZOF3p
	iw/kASpMhF6YzQpeXHoS1FCuM7waSDAiWrB/d2QBZPRel8ZwrxB6jzEMALF803GKsoIztfpe0uf
	MOaUhSESFsY2sMHb1LWkB5TSKGk93hTxNuNTxnNGJNeC/6Re18ipxsxQlNIrhjfaEgIaXpGCXRV
	zu+G5FPFpztOmvwT+GISIOPHgyqSjeVxsEMwCyovemPHp6loApJz0N9q7c1Zm4wIsQPj+d5ErH4
	T32BQdX2tvkK1Zu4olnsceV7rjQG3kt7nukr+35j9g0ZsP+a9okakJKQ2xT+ahWAPFi540Fr9is
	hNcdxMb2o4JDuAiLfVwWDLGibdUjg7IKo9/C5IvNlJI1r0zcTdGDCHh8FCabR/kUq2fHpDFR28O
	5TVvADsQleLA2T3784QG/dtZZL8FK9kLXgHpwNqBP9S43v33taiSazSFYnq6v4OQadDX+jYi6aP
	fNltc58CiaVNgI+S
X-Received: by 2002:a05:7301:7d01:b0:366:c497:610c with SMTP id 5a478bee46e88-369e8610133mr11168504eec.33.1793072847986;
        Mon, 26 Oct 2026 20:47:27 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a026e04a0sm11349777eec.1.2026.10.26.20.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:47:27 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v2] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Tue, 27 Oct 2026 11:47:16 +0800
Message-ID: <20261027034716.588174-1-yyaqia@gmail.com>
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

cancel_delayed_work() does not wait for a running callback, and
fb_flashcursor() re-arms itself, so also move the requeue into the
console_lock section. fbcon_del_cursor_work() callers hold
console_lock, which serializes them with the requeue and keeps the
non-synchronizing cancel effective.

Fixes: 3b0fb6ab25dd ("fbcon: Use delayed work for cursor")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:deepseek-v4.1-flash
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Sorry for the last email, I forgot to write changelog. This email has no
code modification, it just adds the changelog.

Changes in v2:
- Reworked per review (sashiko-AI): do not guess the context with
  in_interrupt()/irqs_disabled().  fbcon_del_cursor_work() is now
  non-synchronizing by default and therefore safe from any context;
  fbcon_del_cursor_work_sync() is added for fbcon_release(), the only
  path that frees @par and needs to drain the work.
- Move the requeue in fb_flashcursor() under console_lock so a running
  callback cannot re-arm the work after the non-synchronizing cancel.

 drivers/video/fbdev/core/fbcon.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 94abbb5ac766..917ce9d641a1 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -422,10 +422,14 @@ static void fb_flashcursor(struct work_struct *work)
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
@@ -437,10 +441,30 @@ static void fbcon_add_cursor_work(struct fb_info *info)
 				   par->cur_blink_jiffies);
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
 
@@ -765,7 +789,7 @@ static void fbcon_release(struct fb_info *info)
 	if (info->fbcon_par) {
 		struct fbcon_par *par = info->fbcon_par;
 
-		fbcon_del_cursor_work(info);
+		fbcon_del_cursor_work_sync(info);
 		kfree(par->cursor_state.mask);
 		kfree(par->cursor_data);
 		kfree(par->cursor_src);
-- 
2.56.0

