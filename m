Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA5226541;
	Mon, 25 Aug 2025 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089033; cv=none; b=TVmxyI+SgTRmujz3tPRZS5dlagfSJU926V/Cyttcfr9bEfGdGI0ve9Kp0FgJ+4vRObcw2Jtf7SBdHDN71ccPAEdVGuxPQYj5fT8qicrBCffvbOySkoMixGNaQoLv2hTpvXesOGw7dtjCaUs9tTVRzWtgJ2xVesOyAq9b7OCs6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089033; c=relaxed/simple;
	bh=2lakStH7b673PNcvcyv/2zOrSVlxevXvJhX9fOU/PM4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjrADs1fuHGQ/jZlKIsBTM0reU3l9AomyRv5+zsQGBU9vNGLKj2MG2OxPo6voyJ/5j+a0PYH+s8wrixmPnWJzXs4seJmoYD/o4mJNVaSl6Y3XqpU2+qt2KzTigrCCa2JZT1NjmQmFQzHN3/vRRLa/sy4E3JoXmGZTPWM7M6NRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpcPaO4K; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpcPaO4K"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2466443b37fso17229275ad.1;
        Sun, 24 Aug 2025 19:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089031; x=1756693831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D22H5WgHrRDr6Rs9uj/QpBbAQMcw3KfQsKqL222d6ec=;
        b=NpcPaO4K/1FgZI3BmblhiOo/+eLJMo1yzM1BhBTU0w9nlFdBc9PsSmxI6Z42Vq3drE
         n+Q6ESxqE2wBGOlgnNsYo6he2C+sN7axedeRGfdysUteNC0vgp3UV2cpKjFtNIaEp97L
         2ymWPgqfhPdAuNeupWeljQLawHwjRXPUOYvSIQZhORevJRZXmWUxSp9KOg88cns9I+BU
         qNLJR/Be4aThbsYVk1p/AXnRGXGESRQyH/isVvSwOwndRz51CLMd+Y3xz9pVncwx6mK9
         GtZTbtFhrbnZHmPAbO9RxFCenaPungZ16fCbD3rxAO8y3xHae5CIyHoWJ7aOE9VZxwM3
         ZWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089031; x=1756693831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D22H5WgHrRDr6Rs9uj/QpBbAQMcw3KfQsKqL222d6ec=;
        b=SWYkOilMRLErRFPZ+mMgdQmSd1nyCvzAcwTbhysjKLVW9IedD3lQe1nH+tvLwR2HZj
         jtNzxY2LGeQ797znNV1IM/MR0uWwsSGtpCCH3bsTgec9WLjbuK1lcRPG6APvVsoneQUI
         OfL+3j7QAKJXRLmxwB8Ha0hLL+xvhWBTU8npu0hkzsVIkpx3iFN+1/eAvyMyxXrk+COp
         +4j6NgAoOb1EATPtABmOnmGmI8kSi72aTAYzvkkw0YW56TXPFlPhUUMFMJHgMRkoJZTM
         cjeWCiprSz4wHhTHQR2o8JqDQzik5OgnJ1dyW4WNMRSvx8W6LrNWai9RqGP1KIZJou0A
         pbIw==
X-Forwarded-Encrypted: i=1; AJvYcCVQeeoGvZdkxcncsgTen2mIRq8niy2DuswLD7WKNDykV+k/nkqQFnEj/XI9iOiieMlRhjpiRQWvZvkfEyLyfbPr@vger.kernel.org, AJvYcCWR27+h05N4xJWVfFKWp33+EB5qzDSwwSYhv6dMG7gyZ7s2kuaQENNJKecoLEIDUOuRG4ueyb1cxZM0J/Sm@vger.kernel.org, AJvYcCXkZ+Ot6rd2MCREQaZC/9h/JB/RgnKRBuBVlk9uSy+XKkRZliJA3Effksd7Es6pVezZIsFsP+0ssUbFBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKQD9n9NEy819of7DcBFEOa050vgZ+/EFyvzSRVhYYve6kuWp
	9o/WcHoWW9Hpy2e5DnkR1Q7pI+WzX8lS8Yjt7AaK8sHoPymVInBcP6vu
X-Gm-Gg: ASbGncujjj+KpQhtoqdvh43ey+AAUirmUihTDYA5D4xszvIwLEcj/e4WVlKjq6OPVJ7
	44eHxkMHiqDzBj3UIC2YWjCAKiQziLBelHDsGzzYSFr/GW/vOfVcxW4rjwZ1qFJ+Gjj8Tegwygt
	I7ROW3TVu0dSHY+5pFlCjFwKdnxe94bfLpyk8DohmyJ7e4POF73Orp4x9NCcYkwf3Yzi7puzbLx
	MGnASSxGi8AJVnToFK35b4nkFiP04iVvfzWxyIO/Img0+c+JVxjTvWZxu7IcRixl+sCK5qkfBvj
	kkjg51o8pnBs96EN7bxoQ9h1w72YL6ZZrhFMOUYvTSp+jeG9kJ/V4QJ0t9WcMnPZGz8PuK9a5uu
	H2kuv5oSaJue75ChoukQJj+iE1MYsW3JaHYlSaADYQbEu3KbpfsB8mD3V8cU4dRjnSdWi1D20ct
	A=
X-Google-Smtp-Source: AGHT+IHvUbvFr57GAj/hQE8xfxiDlLg1TWgL+5HGU9dNUcnxRdGMO81pVBBt5RpnalyVwaK4Xtg7ig==
X-Received: by 2002:a17:903:1a2c:b0:234:a139:11f0 with SMTP id d9443c01a7336-2462edab80amr150747455ad.7.1756089031108;
        Sun, 24 Aug 2025 19:30:31 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:30:30 -0700 (PDT)
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
Subject: [PATCH v2 1/9] panic: Introduce helper functions for panic state
Date: Mon, 25 Aug 2025 10:29:29 +0800
Message-ID: <20250825022947.1596226-2-wangjinchao600@gmail.com>
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

This patch introduces four new helper functions to abstract the
management of the panic_cpu variable. These functions will be used in
subsequent patches to refactor existing code.

The direct use of panic_cpu can be error-prone and ambiguous, as it
requires manual checks to determine which CPU is handling the panic.
The new helpers clarify intent:

panic_try_start():
Atomically sets the current CPU as the panicking CPU.

panic_reset():
Reset panic_cpu to PANIC_CPU_INVALID.

panic_in_progress():
Checks if a panic has been triggered.

panic_on_this_cpu():
Returns true if the current CPU is the panic originator.

panic_on_other_cpu():
Returns true if a panic is on another CPU.

This change lays the groundwork for improved code readability
and robustness in the panic handling subsystem.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/panic.h  |  6 +++++
 kernel/panic.c         | 53 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c |  5 ----
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 7be742628c25..6f972a66c13e 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -43,6 +43,12 @@ void abort(void);
 extern atomic_t panic_cpu;
 #define PANIC_CPU_INVALID	-1
 
+bool panic_try_start(void);
+void panic_reset(void);
+bool panic_in_progress(void);
+bool panic_on_this_cpu(void);
+bool panic_on_other_cpu(void);
+
 /*
  * Only to be used by arch init code. If the user over-wrote the default
  * CONFIG_PANIC_TIMEOUT, honor it.
diff --git a/kernel/panic.c b/kernel/panic.c
index 72fcbb5a071b..eacb0c972110 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -294,6 +294,59 @@ void __weak crash_smp_send_stop(void)
 
 atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 
+bool panic_try_start(void)
+{
+	int old_cpu, this_cpu;
+
+	/*
+	 * Only one CPU is allowed to execute the crash_kexec() code as with
+	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
+	 * may stop each other.  To exclude them, we use panic_cpu here too.
+	 */
+	old_cpu = PANIC_CPU_INVALID;
+	this_cpu = raw_smp_processor_id();
+
+	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
+}
+EXPORT_SYMBOL(panic_try_start);
+
+void panic_reset(void)
+{
+	atomic_set(&panic_cpu, PANIC_CPU_INVALID);
+}
+EXPORT_SYMBOL(panic_reset);
+
+bool panic_in_progress(void)
+{
+	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
+}
+EXPORT_SYMBOL(panic_in_progress);
+
+/* Return true if a panic is in progress on the current CPU. */
+bool panic_on_this_cpu(void)
+{
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
+}
+EXPORT_SYMBOL(panic_on_this_cpu);
+
+/*
+ * Return true if a panic is in progress on a remote CPU.
+ *
+ * On true, the local CPU should immediately release any printing resources
+ * that may be needed by the panic CPU.
+ */
+bool panic_on_other_cpu(void)
+{
+	return (panic_in_progress() && !this_cpu_in_panic());
+}
+EXPORT_SYMBOL(panic_on_other_cpu);
+
 /*
  * A variant of panic() called from NMI context. We return if we've already
  * panicked on this CPU. If another CPU already panicked, loop in
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0efbcdda9aab..5fe35f377b79 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -345,11 +345,6 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
-static bool panic_in_progress(void)
-{
-	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
-}
-
 /* Return true if a panic is in progress on the current CPU. */
 bool this_cpu_in_panic(void)
 {
-- 
2.43.0

