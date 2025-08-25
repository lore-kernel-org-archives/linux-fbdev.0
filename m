Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811723504B;
	Mon, 25 Aug 2025 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089080; cv=none; b=nXdn8LMA3UcR5hNA4/qGp0eNFT4tabTRmH67cD07zBtFQZfNFwxthTrsLf67v3lhji1BCZiHLFmhsi4AnNYj1h8vvAM/QXY1lnHYFaqPYuDJw2v0Z0cICRjh6Xs3nKAo0AOGPLnoC3S5aqSTHbQlywhAq9JHtCyEPRRPNMVNAOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089080; c=relaxed/simple;
	bh=NRMbYvlGW941kMEietS2rZxYzAjvsg56wuTDhUbjaPE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJiz2SVR3sGZI3p1Rhs+kB3gYMo7+xub3fDWNipVymI1XUxuxOoRRUda/8row5HNdaP8GweZfcJ4WEHlfTJcO0OM12HV0ObwrTIjxjoeV8oUx4LU6ceg8q2mxRhUxqHRBm/1l1T7byyxUDMjxSrCUT1FfaOb7HoybO5O5vrDXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTiBlNCq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTiBlNCq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so36346345ad.3;
        Sun, 24 Aug 2025 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089078; x=1756693878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7yKzJNb2rx6SiyelcSe/xXvw8ffKUxo6CoK3itAFgM=;
        b=gTiBlNCq/54tADIkumqgmrWdWUjbwz9mKFE1qPSQ7rlwd+gB0jvF8Aa5libp9AzXz4
         lS+G66TmLsxbZg0nprtjnXv1jCs8iLYcd/RTZweeEIzCxP4JwfdDzwm9Un78pGZZazWr
         MeO/uxmd0RbMjrkFRPX10UjM7z2o9PDnsGA6WqFrqUnYp933oNAt1XqF6rF8r41/mpYp
         /aODh8NVaJa5LhcmdAyCl5tviuZ4O/qThTKc4azWzR2AlStpw01+yC2hsIC0XBSz3jvP
         htSn7c8Z04CPk6EjlGIUT3Rog7iy6ErD+psAu7Lv0o6XzUlm5BX9luFndGWjqxYKWplz
         XaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089078; x=1756693878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7yKzJNb2rx6SiyelcSe/xXvw8ffKUxo6CoK3itAFgM=;
        b=rRKmchATgaLvgMHrKFh6r6Ge2qnk5137a+0eTXPq6gnIPjTWyeimPsnXou5lZ/5Idn
         VjCivb23xKe+8PrfyN2yJS4JH7ffE+2Ql4OMMXmLw0h8jldfC6SWv4gqskxIMZKQvm9r
         4mIwIjcNNS55molIfPU94uDYZX5wCYCJ2urRB9kpuEXeOyUmDNa+aTV+uOrAuAA/Eu9/
         j8SIyRq8Rj9uYQauybePDMEA9RIBmc38u4/2KQzFgRQt5ojfcvdm/YqonjqZ+BGKFvRt
         d1oL844PZLQOjFwf8ZOG+NUrtVp8IZfg2NQvOgVqpKApeSd6h00pDR0j1tmQ4YG5WOdV
         o19Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/zI9lmZ8ScV4iUuROzu4oI0fqFRSE4yT/DtgH+VyvAtcT+yQvEQpT2O+FJ9wRwCxS3HZVUC/uqmovZ094@vger.kernel.org, AJvYcCVjauU948bNEjIc4JgZfnDC25/6U5RLP3M/NnWtEeVCpSvlvnl1C3Zjye4mr7XFpBVwosXP7WnIp0kSgg==@vger.kernel.org, AJvYcCW0IrZ8CYUJ1I8FjKS6KDzp7GQNGZjfD6alGDDXv2o8SQxHEcj+2WmPRtueGzbAxMABSN6SooEPdl1k57rBW0l2@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBINqW9oAqzq8rIHH2ZOtU6AC9N9UASlTDEe/LsElgyjptmxf
	3W4BxiAIvnAi4MzfM5Xbyq23T7RF7kg5B9KXmCbw7IheAA/e03yMXxMn
X-Gm-Gg: ASbGnct/1KIajgZk3GWCUx7eqFXVZO4Nhqm3TZ7tbKiemPgaYMXJ50lSvIbeQrpDmy7
	mtAHNYD3/m9WUvvKb7RvF/+WnbpEG5gD28+7i9+DxNG8UwW0b6XLX5lQuFA9bVYoD/hyq1+SBZr
	8zXti8wMGDBc4d6y3aRo8RHuIAjUBIEGw6MBS8Gj9UlMtuvSeewm9BpbVA4KteCxq04TyQFvGeD
	2OOc55hCD6wkvb+0bTLVpRn1KZxljV9YoU9COmAUZ895ExCcV9ASAYoAq+IYnZu3dxliNtJVDoy
	lUaAnhPTn04OnwbGOgw+9Gl8p8r1kj8HVgZdy9/63ZhKdmZzs0iLIRUiHu6LT5ZdcDHkPjnsj3P
	oDcZIh6P45jBTqUb6LNtG43KER/+s5zV4VC5YqVQLYIAhL34QQJAzBPrC05SUr5O7XiXoxmEWzZ
	ITR1os15mDyg==
X-Google-Smtp-Source: AGHT+IGGk8nOO00I8QY6Ycp9jgs1ZyfKkaugn7N1DZdz8CRfy99hpUtZQbqKZx4/jp/Z5JOoCix/CQ==
X-Received: by 2002:a17:903:40ca:b0:246:ece3:de0b with SMTP id d9443c01a7336-246ed0267f5mr4431665ad.16.1756089078131;
        Sun, 24 Aug 2025 19:31:18 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:31:17 -0700 (PDT)
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
Subject: [PATCH v2 5/9] panic: use panic_try_start() in vpanic()
Date: Mon, 25 Aug 2025 10:29:33 +0800
Message-ID: <20250825022947.1596226-6-wangjinchao600@gmail.com>
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

vpanic() had open-coded logic to claim panic_cpu with atomic_try_cmpxchg.
This is already handled by panic_try_start().

Switch to panic_try_start() and use panic_on_other_cpu() for the fallback
path.

This removes duplicate code and makes panic handling consistent across
functions.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/panic.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index cd86d37d124c..5266e195f5ac 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -415,7 +415,6 @@ void vpanic(const char *fmt, va_list args)
 	static char buf[1024];
 	long i, i_next = 0, len;
 	int state = 0;
-	int old_cpu, this_cpu;
 	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
 
 	if (panic_on_warn) {
@@ -452,13 +451,10 @@ void vpanic(const char *fmt, va_list args)
 	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
 	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
 	 */
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
 	/* atomic_try_cmpxchg updates old_cpu on failure */
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
+	if (panic_try_start()) {
 		/* go ahead */
-	} else if (old_cpu != this_cpu)
+	} else if (panic_on_other_cpu())
 		panic_smp_self_stop();
 
 	console_verbose();
-- 
2.43.0

