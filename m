Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341622DFBA;
	Mon, 25 Aug 2025 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089114; cv=none; b=riNBaUqjj1/1dfiQTD4BZaVLdpzjol6iMuu4LP9eTZZl7mW2MLtQY2sytJdUyC77PawZaGtTPf9Ja7nwxkAYPX59MRRkrAFaJZqPSb/ZhXrtKsTAxrRx1zyiQuJVEHqgDdLs5WM+7AZN75E+j1Uo95VMkaTOeYT+ScT7XdXtqeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089114; c=relaxed/simple;
	bh=x+zpPC83ksQG9E0+OFpEShWdLPcZ9M4Kt6xZ7CcaWEc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cb+YxdfMpxXbeQKwDEd0tWmBTrQGntHbKQetPgxTkpdV4Tnds1hI3gY7wvCaLws3N1iAGYYFdkgwRj0hCtpsp23YqmNucL2t5o8kbakmXVCIkzAlze0y0+xJ/q3sa9k315aZHW01aOziDlz2DMjenPEUG7i3cT/QiPXwBlDpKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHislJqk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHislJqk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2461864f7f8so31149165ad.2;
        Sun, 24 Aug 2025 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089112; x=1756693912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEDXk3YI1ppq8XrZvysREbE40c1EqMSzH1Ycau0V0x0=;
        b=eHislJqkVIKnCPHmStUwdpfdCzOvq+/bNLthoobRtjdMpQgPt5Wd47/+dbRBI2t+o/
         NeSZGjI95/dPfDzII823q/YlzdnOHwniAAWNXkuEbsr4boE5gSsqj6gADje+7lzTBP+C
         oyBYe1str+7qgJbuxjOmN1bezGnsvTFtWAFvPsZbwVjt4GB5Rm93GH03/Rn5s5I7r0p7
         uQDrMQ6y4zmzsvlWwI660tX9+/QmOeEkpNGPJxjVwgc0nZxubL8MUWWqZurF3m4bidnE
         +NnvM1HiYJXVdxNPVjwyPROx8X/9d+2S9cwzuEvjrri81Rutos3rW7vHxHIeUs3VmCF6
         RSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089112; x=1756693912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEDXk3YI1ppq8XrZvysREbE40c1EqMSzH1Ycau0V0x0=;
        b=C3tElyumIBCHBFvn+Zu/8rAM4PUSCBy1BUK495/kW6UUfJdTP97WC8qtC0Hrix1kWa
         Jwrk2yfsU4aM/74sSpWSigd0A+2jZRqX3mZXsZaZTJuXqZdcCZbELwkePek+dVVlQpQn
         uDfGe6NdlS/Iarhq1rg5ObBBdbQ/pFoPqQbzRp9IfGSXAVy79g2FQ+7xvOrsCuwNEE0a
         mSfWiyj218x9ZS3gfN807nk1wC36XN5x8c7C8VK8IKYgam700b54qlTSU/CBGLJUkPt9
         JW0Y1q7wws3sKdM2LMRTtC9gS/03uvCiSDRGEaHv7K48c/g+AtczNMvjsWA473jdpTvs
         cyAw==
X-Forwarded-Encrypted: i=1; AJvYcCUxTL33QI9qUvj1pyltvt5tYFkcGJtXfRjla7QUZrsmU/DTxo5yrh2Oz94zNWv6BK+JCtHIXRj7xJjEdA==@vger.kernel.org, AJvYcCV6g9jAQdCto+dLr7kss6df97Kki3cgvomMYxxmVgBg9/AYW9e+O5uOIa6IPn4noqKjiUhJn5DD4wQpmOD5k9Zb@vger.kernel.org, AJvYcCXCXAZ33h10xSMo8+FLYrYNdH6rruMz21vUvOZ2+tF9ueBG75etfcQuzVo1fbZl2bj40zcogSk5X3BQytM7@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8iuOHkIk/iYa864UPRyIeoin8scPGOy23YB9650OIAZ+uavy
	7vwPXI0keRNF1HfHwXQVLJp+ppN95Haj5iHDFFeqesziK7srhJdYtxvq
X-Gm-Gg: ASbGncvbNmFQyqzqr3i578Ttu0DYOm2vDfi2ORyhXW/x55AdcferA9PRhu/2LW6oTsl
	H284KUZ8GmJGw6fa8Skr/oW00xatFa8DcR+/ELtJVrwW1oZ23ZKkGU2dXcQhZll+88UCjBRtkut
	gGLyLOgxe5wNZcUaAUvIC4UZTT2DkRxTdcFDBj5TJqLsMsBndCSs96Gh+bKN7vr7nq+KQ/VkvgE
	0JolrLqyCmdNCAewChQVGPoqRdKoBebj4Q2nFo+nQ52YFWpoZZLTs/HLI28ScbKmNL0qA9Fp3op
	5tydsTR/EzIhIn4mOUWJFr+AJDnxXGJm4D5j9VZVu0vfSwKj29hIsrEkjWWRw6Vw1dg9sroUis+
	LbT50lqm2vnpOGvVv1gjGctG19M43Bp72wW5Sthvnwy9xZvWci0Hkbm7kR45m4m5ZBeA0C1ZDwP
	U=
X-Google-Smtp-Source: AGHT+IGvyPlqdqig4mXFsHmtjBV9YF8gxzZSDkAdZlQGY1e3N0SakBpd1QLytsyfS5huP+/UcwJ3nw==
X-Received: by 2002:a17:903:238e:b0:240:50ef:2f00 with SMTP id d9443c01a7336-2462eea80fbmr165661135ad.26.1756089112460;
        Sun, 24 Aug 2025 19:31:52 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:31:51 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] panic/printk: replace other_cpu_in_panic() with panic_on_other_cpu()
Date: Mon, 25 Aug 2025 10:29:36 +0800
Message-ID: <20250825022947.1596226-9-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper other_cpu_in_panic() duplicated logic already provided by
panic_on_other_cpu().

Remove other_cpu_in_panic() and update all users to call
panic_on_other_cpu() instead.

This removes redundant code and makes panic handling consistent.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/printk/internal.h |  1 -
 kernel/printk/nbcon.c    |  8 ++++----
 kernel/printk/printk.c   | 19 ++++---------------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ef282001f200..f72bbfa266d6 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -332,7 +332,6 @@ struct printk_message {
 	unsigned long		dropped;
 };
 
-bool other_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c6d1a4a747e9..171480135830 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -255,7 +255,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 		 * opportunity to perform any necessary cleanup if they were
 		 * interrupted by the panic CPU while printing.
 		 */
-		if (other_cpu_in_panic() &&
+		if (panic_on_other_cpu() &&
 		    (!is_reacquire || cur->unsafe_takeover)) {
 			return -EPERM;
 		}
@@ -310,7 +310,7 @@ static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_prio)
 	 * Event #2 implies the new context is PANIC.
 	 * Event #3 occurs when panic() has flushed the console.
 	 * Event #4 occurs when a non-panic CPU reacquires.
-	 * Event #5 is not possible due to the other_cpu_in_panic() check
+	 * Event #5 is not possible due to the panic_on_other_cpu() check
 	 *          in nbcon_context_try_acquire_handover().
 	 */
 
@@ -349,7 +349,7 @@ static int nbcon_context_try_acquire_requested(struct nbcon_context *ctxt,
 	struct nbcon_state new;
 
 	/* Note that the caller must still remove the request! */
-	if (other_cpu_in_panic())
+	if (panic_on_other_cpu())
 		return -EPERM;
 
 	/*
@@ -447,7 +447,7 @@ static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
 	 * nbcon_waiter_matches(). In particular, the assumption that
 	 * lower priorities are ignored during panic.
 	 */
-	if (other_cpu_in_panic())
+	if (panic_on_other_cpu())
 		return -EPERM;
 
 	/* Handover is not possible on the same CPU. */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index faa8b1f0585b..236f03937107 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -346,17 +346,6 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
-/*
- * Return true if a panic is in progress on a remote CPU.
- *
- * On true, the local CPU should immediately release any printing resources
- * that may be needed by the panic CPU.
- */
-bool other_cpu_in_panic(void)
-{
-	return (panic_in_progress() && !panic_on_this_cpu());
-}
-
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
@@ -2391,7 +2380,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	 * non-panic CPUs are generating any messages, they will be
 	 * silently dropped.
 	 */
-	if (other_cpu_in_panic() &&
+	if (panic_on_other_cpu() &&
 	    !debug_non_panic_cpus &&
 	    !panic_triggering_all_cpu_backtrace)
 		return 0;
@@ -2827,7 +2816,7 @@ void console_lock(void)
 	might_sleep();
 
 	/* On panic, the console_lock must be left to the panic cpu. */
-	while (other_cpu_in_panic())
+	while (panic_on_other_cpu())
 		msleep(1000);
 
 	down_console_sem();
@@ -2847,7 +2836,7 @@ EXPORT_SYMBOL(console_lock);
 int console_trylock(void)
 {
 	/* On panic, the console_lock must be left to the panic cpu. */
-	if (other_cpu_in_panic())
+	if (panic_on_other_cpu())
 		return 0;
 	if (down_trylock_console_sem())
 		return 0;
@@ -3227,7 +3216,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			any_progress = true;
 
 			/* Allow panic_cpu to take over the consoles safely. */
-			if (other_cpu_in_panic())
+			if (panic_on_other_cpu())
 				goto abandon;
 
 			if (do_cond_resched)
-- 
2.43.0

