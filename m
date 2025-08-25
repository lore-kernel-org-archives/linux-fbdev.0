Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE47233136;
	Mon, 25 Aug 2025 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089103; cv=none; b=VjOQfI4JaEVAeW2xna8UnuFbbc/0/KTds9OLr/BDAVR4zniRn3t1kqEJAqhhOpfS66LjwqlKu/Wx2q97vABUhCGXhH2KPIUmROSygKQZl3r8VjpPgGmijGqcejKPa5T93a5X0NxjQ/Dw7IoVVrfrJg5O1/Tnr6GGHlvVM83TZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089103; c=relaxed/simple;
	bh=9keaCwlo1nRU6PVMuHpxyQD3PQWcJROLr4j+vesuEEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIxGfHseS4WSZAMhqCLKuAVCNI6GdLDKMLgPSxbQqmQSB5XvHp6xhURo0p9SCRzHZEaTYTrpiVu8kbKZpallU72fZItC3/nML8Vfn28/QDdVu64FGGPuJlyfXcvCwMdKQBXNs1z9Y6Kiw9X+DfhyDgAE3SRtzB4EXzLvLxd4PvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/vEae0F; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/vEae0F"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445806e03cso45349295ad.1;
        Sun, 24 Aug 2025 19:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089101; x=1756693901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUEa4tYSS0p5DNjOCVeWcyYJH7ruf9/pefat3lfo8dQ=;
        b=G/vEae0FwZxnF1OGlOXFAGQ37c/PWIEjsbpVTkEYkJYK8ar6qhP58o/ANV+M7gpD7y
         KtfLixuB6tjj9drX1DSa6N6AMX35jTNfeZKtTF2zdAQnIMLeW9bN8wp6J4LEUrSJNwwE
         h8FdSjiSxAH4VCx2Gi5eriN07bxAu7Jj437H6bWk8W1EzmBMb/jbDv1noi9x8ESdXCbB
         cGNp6NHv7SC6cD37AVBI4Ubp+k52fTpdTe7j/PPYzgzS0NDxfoQMMbMqMVHFDZjZD+Yu
         RvLpq3zxXALndj3GUxLmfPV55qLSeSepAcA6rOuUa4p6txud1hyWnXgAs0ekIGAYDl2e
         l90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089101; x=1756693901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUEa4tYSS0p5DNjOCVeWcyYJH7ruf9/pefat3lfo8dQ=;
        b=USujAL0PuHs/ZDs+rbrsYkm1hHk+alf2cf9FEEdXl4fIji2fGiHlh/COJZZFGXnIpB
         pFOwTK6X10xgS62+eygFDVfC70+/+9L1w4lLdwdAiazTpb2VJcY3xFHTcedWkeoprgYJ
         wu7jFV7/6OlFeHZseL3bJH2ZB8JjPQzYmoOezxZY9TxjED2k+HqTeR6/EGjtGbTjLQlB
         FsDxtJiuFptzwAusiiPVnG2T/OY1MGqMGeHa+D3x9eCFfW8JSCoigOY3akzm7Cj6ZqxW
         opJXcZNEspEKYNWzrwFBo4LKe/S29MR2JKGwF0xN8qN+d2TKvZPqXaxtAQNO4EraeAQD
         KbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZH/64tpGZjvOKyWFWiDPPa6dO4cOg0Dmshpl+lk6R2sflv9sOgyToTyAXJ7TMjNwXL2+EWsk2+jfKL6D/@vger.kernel.org, AJvYcCXACDskGvlQ3yitFB6UtbyFm/dpEo943dj6B/XOr5g0eBLQqStXdkzy8DMNJobplWLVZMv2kAqzLj+3DQ==@vger.kernel.org, AJvYcCXE4N3rDwSlkqlIDmD3drAItyd+6rHz0QW+VOluIo2+N0bFCJhpDu1Al24lihkelxvM25gPtoigyXqhETTsEdgS@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4Lf3ha5R6u4vrR4wupojwtu8TmKVUYqei1Qep0zY5tEaFFrX
	pJC6HQWyVsrn62jgyk93RPMz4we36QcN+JA524/2YK6K5bdl3yfwMBQc
X-Gm-Gg: ASbGncvRveq02+uUfXJKQ/5eruNG2+BEuIONsCeXJagTagNGZvyQtCvFHCuCnYiizbf
	xJVfok3PmJ22ztMMojVMYonodMWwTCFCsiZMf0o4//GHy3XmKow97CVIOVIKviMcw3TobnW+2dH
	H0MN3p6ppS9VZ78jEp6hZz/+ybtYbLD1Tj+j7fswz2ps86JTvEYFtbxPYb9mKiD0+gydgB9YbJx
	yRBLRMYoUZMhCnu43t4xfrq3GB/Mr2AxWie8zWcpxTcKqGlX2sVa+XEYQe7qTF8gTtisueuuEWb
	m6jvGRteSJYt3VJPNHwIaX7wgAqpai/8RRGdp2tlB6b4Ttm9+Srk3U9zUCwiYMVHRvzcoUxiiyT
	Pp0zMrT7faUN65O9Vd/ginCKA5E9WykVHVXSyFesRRfQv7LEKkuVJXEm/PLUKeo1SZseKL/Ic6v
	M=
X-Google-Smtp-Source: AGHT+IEsHHne9AMztJo7a8IjD1y4loI/AihrgL9BB/L9e0AetCJaQuYxWX/l7xlWh7T6OVyIoYtcqA==
X-Received: by 2002:a17:903:283:b0:246:61c:a67e with SMTP id d9443c01a7336-2462efdd639mr124786615ad.61.1756089101128;
        Sun, 24 Aug 2025 19:31:41 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:31:40 -0700 (PDT)
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
Subject: [PATCH v2 7/9] panic/printk: replace this_cpu_in_panic() with panic_on_this_cpu()
Date: Mon, 25 Aug 2025 10:29:35 +0800
Message-ID: <20250825022947.1596226-8-wangjinchao600@gmail.com>
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

The helper this_cpu_in_panic() duplicated logic already provided by
panic_on_this_cpu().

Remove this_cpu_in_panic() and switch all users to panic_on_this_cpu().

This simplifies the code and avoids having two helpers for the same check.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/printk.h            |  2 --
 kernel/panic.c                    |  2 +-
 kernel/printk/nbcon.c             |  2 +-
 kernel/printk/printk.c            | 15 ++-------------
 kernel/printk/printk_ringbuffer.c |  2 +-
 lib/dump_stack.c                  |  2 +-
 6 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 5d22b803f51e..45c663124c9b 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -330,8 +330,6 @@ static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 
 #endif
 
-bool this_cpu_in_panic(void);
-
 #ifdef CONFIG_SMP
 extern int __printk_cpu_sync_try_get(void);
 extern void __printk_cpu_sync_wait(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index 5266e195f5ac..8415e4073da1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -343,7 +343,7 @@ EXPORT_SYMBOL(panic_on_this_cpu);
  */
 bool panic_on_other_cpu(void)
 {
-	return (panic_in_progress() && !this_cpu_in_panic());
+	return (panic_in_progress() && !panic_on_this_cpu());
 }
 EXPORT_SYMBOL(panic_on_other_cpu);
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 7490865e2f44..c6d1a4a747e9 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1394,7 +1394,7 @@ enum nbcon_prio nbcon_get_default_prio(void)
 {
 	unsigned int *cpu_emergency_nesting;
 
-	if (this_cpu_in_panic())
+	if (panic_on_this_cpu())
 		return NBCON_PRIO_PANIC;
 
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5fe35f377b79..faa8b1f0585b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -17,6 +17,7 @@
  *	01Mar01 Andrew Morton
  */
 
+#include "linux/panic.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
@@ -345,18 +346,6 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
-/* Return true if a panic is in progress on the current CPU. */
-bool this_cpu_in_panic(void)
-{
-	/*
-	 * We can use raw_smp_processor_id() here because it is impossible for
-	 * the task to be migrated to the panic_cpu, or away from it. If
-	 * panic_cpu has already been set, and we're not currently executing on
-	 * that CPU, then we never will be.
-	 */
-	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
-}
-
 /*
  * Return true if a panic is in progress on a remote CPU.
  *
@@ -365,7 +354,7 @@ bool this_cpu_in_panic(void)
  */
 bool other_cpu_in_panic(void)
 {
-	return (panic_in_progress() && !this_cpu_in_panic());
+	return (panic_in_progress() && !panic_on_this_cpu());
 }
 
 /*
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d9fb053cff67..e2a1b2d34d2b 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2143,7 +2143,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			 * But it would have the sequence number returned
 			 * by "prb_next_reserve_seq() - 1".
 			 */
-			if (this_cpu_in_panic() &&
+			if (panic_on_this_cpu() &&
 			    (!debug_non_panic_cpus || legacy_allow_panic_sync) &&
 			    ((*seq + 1) < prb_next_reserve_seq(rb))) {
 				(*seq)++;
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index b3a85fe8b673..f0c78b5b5324 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -102,7 +102,7 @@ static void __dump_stack(const char *log_lvl)
  */
 asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
-	bool in_panic = this_cpu_in_panic();
+	bool in_panic = panic_on_this_cpu();
 	unsigned long flags;
 
 	/*
-- 
2.43.0

