Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072075;
	b=QKE+XEGDvAvjSJCJgUoFz2NbtN5ES9nLDZ4XR7Paa/NtMhAYJqAYymwL4mSn8JpcIVQO
	 XoKQVToga48GMiZWnMAjtkcFTDCWomKJstdgXu1LN9HBarYTyOcMld+EbeejuzfB978Wc
	 1nAPTMqGs1aWBjjdaIJLdJPKWWCARhXS2ApRrxDubeZ6wymPt22iAEraOxoNhPstKn7ym
	 bnlna8MA5XLfJMQ7JjPIDsugnRExDsv/pVfxdHAaLJpsUewjHL7Ym6Z0n3tUXOVSDzhhn
	 Xd2iElguDo+2Be/NBVQavmKgVX1hmpGviFYKa13vGeTz6YfTdLYCjJoJMJ7BYJHv8Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=waUlW0e7gDgmzI+AA1aqVFppIW+pExWUzgSe1N9AwE0=;
	b=BDWj8zyq+iFSS/KGQWlIQ0Wz1b53tdWGwAZ6t/94mdbX/1116+J/hfFfrF2CsXURnM1U
	 je2h8yg99KIzqEoM4ERUi/IY/bl9Drbf1uzmgeQplVLFQfvcNTjUkjVgqJ9Jhh+DW0enM
	 QyAq4HACidQLs18+c6DKvNqI3CdjNRXK00ftG6XtNX0hGKz+QHAzf0TNMLL45QFXpRxxJ
	 gxjVi4cdbvz1GJR92dklj4OCQsKNjvGcTjPwGDoQJajHb2gM15/YQ5wBojQ2M3g4j4C7T
	 UVDoIALo9Z3BcxrEPXzLYTQUNFf/3ENiUPkPJDVcry6/IjUEFfjnkrzzVH1n4/AojJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=psEq8aAO;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB61606A32E
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 03:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB61606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=psEq8aAO
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-19305bcb6d5so1148373c88.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 20:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793072074; x=1793676874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=waUlW0e7gDgmzI+AA1aqVFppIW+pExWUzgSe1N9AwE0=;
        b=psEq8aAOyXfGJ0hGmlqCLt55ggfY7SQsTu1QJ97BBrttIeuh7p1PR5bfeHqTeZTPMZ
         aserXw0meG33UyK7L2eAoWV/Okiw/W6S+qckn+RAG0vN6v7636xT/TjzcjOvBNDTFaJ3
         jb05W7VBzaqKzMeCMiGfRBfFAI1QZILSiQgc4xKZQHedeqnNH77qbnGuQPRuIGLkMC4G
         LX4/STPhgraMIGbaPrLoVOEEz3p16K93wtfqeY1Vb1TFQytDbmA7hlOX5IjFU+Dsos3/
         VWecE1TRrA4JyZfftdljCO0UGGdd1Sj5CQFiYEWazJfUyO3XW0NUhNC2ue++kXSn4civ
         nuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072074; x=1793676874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=waUlW0e7gDgmzI+AA1aqVFppIW+pExWUzgSe1N9AwE0=;
        b=O8sSfsfOVvykdN8iUB7cq1BNYAn5FoE81+ggos648vPjhjUjE8u9MGKZbb5Vpyc6bp
         bT/5ucvOesQj0tntTJxy2uhUCAW/RRcl4PK36fzRDr0T9k/4BR+RI1apZQ9t65W4PR9e
         BELL4F3+oEoXnrAzPf6lPKDv3RW6sARii/xXj3Z4r4xkh9RJD8mFe5+6xi7KPQJmmGaM
         Ln5r47V81k652sX5j6Q+7WQ7AuUl3Jil49v6ZRYQqaJ3xXldkArsEx3rtl2vTbM0gVkN
         1fgRJWqTd/229LW78a+n1ZGyLaZVhsuFuq/WSmSCaCmlxUiBvQDOb7ImZIldjsLCH5as
         VaKg==
X-Forwarded-Encrypted: i=1; AKwUvBzPPXTQttCTRZQffyqGS1rUu3JFkRrQClplPO/uA0MCj0PsA/IzaLbiqTAwJ7KLHj+kMV1MZkdlIzSUwg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJRrmntyohFGexhZjV5+OJbhIsJdN07xzdr8OUf8VdWwuqGKFVc
	onGYLZM8M679S32ujmHiO84NPoIxWlTpNNKGeeZImPcJonW9osWw5DMF
X-Gm-Gg: AYBFou1VIWNcpSiqRx2vkRQ9DGnTbfmc4TRT1/rdAuVMMig/bVHuCUPRYgk2mwi8uKc
	IG94XBAtdZVuA6R83s80ql2MsAia48Ke63ZoH/YuwExunR/+CV59XeftnGv6RYtwGuIfbQWTjRM
	SXOwhlplomf/ShlK6DWpwqAhbmHIyuCnexquVAju8qkRaXNRN499LMpkYinO2XeH06nidwJ/OsL
	XPikSGsZg7XSrKaCiHhGnjUN75vq6c8AUS+oX30k9nRImhyzkDXDikfc8Uh0aXcSTcZj8BUkEfI
	bcaepuHjooGOfXg1D5Bv3nEEubrVHI7BgkPfZ75fdlSYfZZsl+zubQituKaOCv40SaWx0Gz8FDa
	3gWB2IYBNstwUaEEOyN78Y/IXgHTFSgkpWwAeGJsyc0vyYBxp+Q0YvPYQyn3i7ErU3quT5LX5t2
	v955h/odaR0x4YVRV/RmizeAufI9JmagnfaxrSxmiG05TrEzCeWe/XOPp5gzCne9ppMgGBBzm5g
	Jj0mAPVq+2n+swneU9YIH8VKecVKEucsvoHvRZs+e/a46uVvUierp3C1fxsH+xYU/d+s0Yz6J9q
	q7g1mR/9dz92ndWIcaY3wBy0zxn9ji9mWujTNA==
X-Received: by 2002:a05:701b:428a:20b0:192:fd91:c567 with SMTP id a92af1059eb24-19935906f80mr13498312c88.11.1793072073779;
        Mon, 26 Oct 2026 20:34:33 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm54876624eec.23.2026.10.26.20.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:34:33 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 11:34:22 +0800
Message-ID: <20261027033422.585328-1-yyaqia@gmail.com>
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

