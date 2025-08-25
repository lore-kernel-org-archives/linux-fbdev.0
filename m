Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA11F7575;
	Mon, 25 Aug 2025 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089057; cv=none; b=EaexxOpGsUcNuKQzGyw7UoEaU9JOdvZ/pe6Hw4s5UMmpXmHE5LjY57JP6CuGjkxxLQ80OQwoTBZmXzbn8mD7hBIUd5wt39+M7frV7rk85CFFnMRd4/edaeiRuuLw8xI2yApkynYrbbQF9FC1hOU1TWGexc4kWKlvFRFFwFX5Dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089057; c=relaxed/simple;
	bh=rotx+P4b7HEx0aZgPSk7AQPfYVAI7p0UBrUh5aeZU8E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ai03tpIep7ouFGElweQ8nmFbFbcuVQsuIYXFWstAxxjSM/1xUqFJCW6EEixjxWiicgCzwgaoiecPIganKIfRwyMu3BnnkCNsZIYaT2dW/jOd4BPvXIAo3Y45UK59CSdYSdHxdkeZ0sIfcjiZviVCAw3dmDr6PHrTsP7oY4V4lxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmlI6ExJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmlI6ExJ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49d46a8d05so1058004a12.0;
        Sun, 24 Aug 2025 19:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089054; x=1756693854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH8YhLChJO+46PfNNdyjwrwQJKBLxU7b8IaUufHISe4=;
        b=gmlI6ExJmqstcC1YRgn/PmipRAGa0T1V3CVu9pNKNrKUq5d5OrfG+eGxhoY1J3diDb
         6fAevfBrYFZ4PCfclConeCzpS48lgI2i9OWtr1TTyBfhPs4KXCCUkOZkuMsKxVHsxAQ8
         6+kQC6nHiecFoLtY2KaNuBKn0jdh4yCZFCWnzLVWZITcU8f2uCy+jXEtYIUAOwBgjfFG
         kc/iSm23yXDiI2z/yIfGjH1grGZOAn7wBW7+36MRhZwaE7wD/BJOTA00jug9UEv14WEn
         bp5yhMYiueF+G0OcL/fMHx6yrMEwZXOtsnb2gzIIuvjVDb9FCiV+dqY/Yskr+3JkIQU6
         6+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089055; x=1756693855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH8YhLChJO+46PfNNdyjwrwQJKBLxU7b8IaUufHISe4=;
        b=GmJp/f2jhn9KcXY57J7Ej6OC1SRnV90ZWpe616fdMnXsiipKXGqP+PR3vRpEwVRrCp
         OHNuecr1uyVYrJJtrFrZajuTI99ffHDQCsEtnw3ZlwasSRZpYOlnu5vFBct3cvfTdVUr
         lldkOwqp4bohVaVI0Mv6L1VBPVwzKQsShOKfDxGWe9NPAlQbmRWBCxqesS/YmEqb+qLv
         xP/cd05Nz+ygAhybgqwaf9Ho4fobF4amJdBpzLoufEJlHrHKrFrqID0a+TJ63q3Ft1tS
         Oc+niozDPVzZGqW4JZzeZjV06foZ9j7VeDkgm0vkHDcDpDZJtxQL74kGhC9XtapTaVsU
         8C+g==
X-Forwarded-Encrypted: i=1; AJvYcCUV2LJPdQgmY/Cvgw3aquf+j825VbheqwpLg9v145r4VJGBdogL7fBgdYINAMPLIXImDuPWgWQmkDSjsfIW@vger.kernel.org, AJvYcCV0beaxJwVnt4QBhtypbwy8cV3thw5ei+q1PWcj6VC2vN7KgbsfmwfLYfE8z2nLVztGBxykt/FoWXyVTlH+/BDy@vger.kernel.org, AJvYcCX0nMD7pA3YMw2dzuAEq6hG2DaCohdpSjyZ9RxJT5XXMYK2DzvpgMSF3m0zlhSL0MZAMEoi7V/gDw2AWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtiPCw0GiMNAwwfkpCU5bKmrVHxipk2h2BCLHqPGgZGSfdc20
	ZJ83SVm4EYsquaWZYO7KAHo5W1SOafDpRtTe9zdG7DIMWpwTvHguLXa5
X-Gm-Gg: ASbGncskm6ztyYAsLAsDDwbFRM2+Laz8G+gICbygiorgVr9NZR2AXaOtlG0iJSpJ3Hf
	dSjUuqZZ1BGU0vmn3xtYvDNy/4cMmWFjvalSFZ6amoML2Lvuq+qh1iNwnv+O8jqskPXutPGeMJA
	bsF+E3062t/ZrJ6Xyzt+MhB0m/t9wtQ5C2Mqf6cfIXNJ+kYmqaZzSm60OH9mm6gi1E5Wm6LhH4c
	HC73UDQLzz4x4gWJ8bli78NiSknghyYT3D1iYuPB9sYIq38PdmTN6G8QfpPdjqfUm9MkAQj2bj+
	3JXsPGPt5TJcIuiEcch7788RzkEN9nnddmGFEi5v+2ZNiphAl4ePhsm18i+XeYhrXQ6Z60Q5Zf4
	hCKi5wlC1f5OeS+z6FPYxcjRSOTXwESuL5SSwVIj9zOcP0BdhQI01WH7X5AsCsnMI6WnuC+0zjQ
	I=
X-Google-Smtp-Source: AGHT+IH6pBx05EUggFYxitz83mZVXTIxwPpm1bcXy5QtfKJU32rVyZCwSo5s5hfxiY5yh80orLgZOQ==
X-Received: by 2002:a17:902:dad1:b0:240:8262:1a46 with SMTP id d9443c01a7336-2462ee54512mr139147305ad.25.1756089054419;
        Sun, 24 Aug 2025 19:30:54 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:30:54 -0700 (PDT)
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
Subject: [PATCH v2 3/9] crash_core: use panic_try_start() in crash_kexec()
Date: Mon, 25 Aug 2025 10:29:31 +0800
Message-ID: <20250825022947.1596226-4-wangjinchao600@gmail.com>
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

crash_kexec() had its own code to exclude parallel execution by setting
panic_cpu. This is already handled by panic_try_start(). Switch to
panic_try_start() to remove the duplication and keep the logic consistent.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/crash_core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a4ef79591eb2..bb38bbaf3a26 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
  */
 
+#include "linux/panic.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/buildid.h>
@@ -143,17 +144,7 @@ STACK_FRAME_NON_STANDARD(__crash_kexec);
 
 __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 {
-	int old_cpu, this_cpu;
-
-	/*
-	 * Only one CPU is allowed to execute the crash_kexec() code as with
-	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
-	 * may stop each other.  To exclude them, we use panic_cpu here too.
-	 */
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
+	if (panic_try_start()) {
 		/* This is the 1st CPU which comes here, so go ahead. */
 		__crash_kexec(regs);
 
@@ -161,7 +152,7 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 		 * Reset panic_cpu to allow another panic()/crash_kexec()
 		 * call.
 		 */
-		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
+		panic_reset();
 	}
 }
 
-- 
2.43.0

