Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED51CEAB2;
	Mon, 25 Aug 2025 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089126; cv=none; b=pR5W4AZ+bs+xcQomQsdwhayXB0/7QkFWJDrBHpodHDbNVf2BwGuPtuQzpA2k2FXlUQ2GtDiVQc81x+6YsXYJU19eY7L7yT1S9NukgXHE/zm1agyv9SSbzcpZdFOORJ1DdZAqPlMjyQ//dyJFeyR2ZC/Pg9XvyzpBEfhUunGO3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089126; c=relaxed/simple;
	bh=8w+Va6M4jsubK7hSQ4EV51F40ANmqzPbE3g+V8Rdxvc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9UnYAr5S/XB/tSqodzQwyiTob14zM977yf1js12ISBG4hFVHOXAoTO/FxCCZ9pJLoUtHvvIuKyO71YXbpf+UfeEdkPK8Jg0EA4viUTlgpKAI1eDyswtxq28xdODjMEt/B7AJPWaO4QIxNCZ5fZ145E14x+TY4hU0WMUodmzV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5cZ1oPZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5cZ1oPZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so36350635ad.3;
        Sun, 24 Aug 2025 19:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089124; x=1756693924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O10Bl4oetUFVZeVcIyFTPuGNIUEAVGF7F9sLfkbwSS4=;
        b=N5cZ1oPZdztFGINcAHDODig49X5faudKEq/6mYZ39STs/S51OUqWwNnwRSau+FWI1J
         P8nHCOxbEgX6wOo3pHQOiLLfSOCL6xVRjCbiL00m1u/vhokYGkOxIRN0mQmoT+shhEC2
         VgOZb7LwEff+owTsP9Ku8l+iu/XLysQByVSi0x6i6IBw7xtsrceUx/M6psG19KZS2g/C
         o7A2le41vY88uEuZ0yf6ycer5aRfRINmy1OzztLkgAnHkwfXHn9H7Cu76CB6XgZ/urGh
         INBv7Vr67Q1Exr88DMCUsa/pxBjTJPWb9ObLyhK4goPO9yzfm+yfzVpb4xs3A9bX4BT4
         QQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089124; x=1756693924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O10Bl4oetUFVZeVcIyFTPuGNIUEAVGF7F9sLfkbwSS4=;
        b=t0emYk5H9kwG/Gv+kxbyTm1xiaveiB5YO33mrN1YaGu0stzRQDQY2AmCO9fZiH/fD/
         sJ1au5fEeMUFol4bQuibRvJYxxAs4VQiOVYg1S2TQJWqTycmrNCDMZrGnLKEwn7TNpXp
         6ZYQuwzHx2lSJ/gT8oN7RsAftPxkYewlNUhYrNNJjL+irHjDS4MPBpImP/N6dkjxSpGq
         Ubq41UOFv70syaQia70SwgM0zqfbp3JNW7TEBnZI4/2Ijyjpxr1qx4HdykWiCllA8YnR
         SiR5aEJMeH6bNsPU7LtJfx+JREnUsD4jkPn87IAnJJCOggDY18JBmHdpdgdaK9seE0Ow
         BRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2L+7vx6dDVyU9yhNON7T1ky1Fj1+pPBXd3FsBpa8cKsoJ9p7PqS+Ds5Qo044V5G5Rguywu8IDVJWArw==@vger.kernel.org, AJvYcCU8GbPoWSkkjsfyVVqnh0XDE4WbxEGtjXVld45cmSPT4wLfr9ipPH4PJqafH6Dg22CZ+TW2/GU40lYharzNEMBm@vger.kernel.org, AJvYcCXvi1Id32xzH+q6vtbSYysx1gkv18OvJXD7e/MGbsfatlyaQ/S/1bBnhICQZLDNXaLsHp+HcrrMU5wtQZ9j@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlsdd69B5HnL9kwznURI/KDJIChd6ueLc9/UQazFeLQxQDM0Fz
	hURbtM1qgIPJq3rsC7v8Pvk8ubmwjbhWMN2pOcyvxFlzoSgDq79ZRtWt
X-Gm-Gg: ASbGncuAdhRz4NctxDiMh6z1yUDSKpXB3CODzvZuv4FGR1/KOVv0dinD7NljqYXvRdc
	Phd/qL0st1G9Vyaf6osQBFBoUbhckMo4se8cGAJdovqFHTTb0s24nUgzBLPeP1OpVsdqQ//KCcD
	cKs7oVEAAjKJofwV135zTnFMHDpRnX3qHYevVStPPNQmNuxqHc+wD/cbIfYQ6h783iwNN9TnPmG
	ONS5DZ8rYA0knt+8s8PuCq4uVLqzRXmTcFz58GU51HPx+nX4qn+/KPhbUdHX5ojkNXSlrwv1jRT
	DnbtMHJZpGLlnCOeS8sxEN86Jk5vaBaRhYH/PdsOgIA+n6GTsBhfy7OCAnBQWRjD+ZkcWYYfQB5
	SuNLbkrW3Mr5pUF/nX/W+llQTLyCXtun0GX/noC3ORFUofAxpaBTI/l8YduotpvJbaHiMNNKwDA
	Y=
X-Google-Smtp-Source: AGHT+IHiK6ZNzGbxD1aVZDdpEIJSJdRVCIVYu6qhCycor6e6tzkhdDgkg9nCBYkly1FiN66XhTD6Bw==
X-Received: by 2002:a17:903:38c4:b0:240:5bde:532d with SMTP id d9443c01a7336-2462ef4c8eemr131114705ad.38.1756089123935;
        Sun, 24 Aug 2025 19:32:03 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:32:03 -0700 (PDT)
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
Subject: [PATCH v2 9/9] watchdog: skip checks when panic is in progress
Date: Mon, 25 Aug 2025 10:29:37 +0800
Message-ID: <20250825022947.1596226-10-wangjinchao600@gmail.com>
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

This issue was found when an EFI pstore was configured for kdump
logging with the NMI hard lockup detector enabled. The efi-pstore
write operation was slow, and with a large number of logs, the
pstore dump callback within kmsg_dump() took a long time.

This delay triggered the NMI watchdog, leading to a nested panic.
The call flow demonstrates how the secondary panic caused an
emergency_restart() to be triggered before the initial pstore
operation could finish, leading to a failure to dump the logs:

  real panic() {
	kmsg_dump() {
		...
		pstore_dump() {
			start_dump();
			... // long time operation triggers NMI watchdog
			nmi panic() {
				...
				emergency_restart(); // pstore unfinished
			}
			...
			finish_dump(); // never reached
		}
	}
  }

Both watchdog_buddy_check_hardlockup() and watchdog_overflow_callback() may
trigger during a panic. This can lead to recursive panic handling.

Add panic_in_progress() checks so watchdog activity is skipped once a panic
has begun.

This prevents recursive panic and keeps the panic path more reliable.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/watchdog.c      | 6 ++++++
 kernel/watchdog_perf.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 80b56c002c7f..597c0d947c93 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -740,6 +740,12 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	if (!watchdog_enabled)
 		return HRTIMER_NORESTART;
 
+	/*
+	 * pass the buddy check if a panic is in process
+	 */
+	if (panic_in_progress())
+		return HRTIMER_NORESTART;
+
 	watchdog_hardlockup_kick();
 
 	/* kick the softlockup detector */
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 9c58f5b4381d..d3ca70e3c256 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt) "NMI watchdog: " fmt
 
+#include <linux/panic.h>
 #include <linux/nmi.h>
 #include <linux/atomic.h>
 #include <linux/module.h>
@@ -108,6 +109,9 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	/* Ensure the watchdog never gets throttled */
 	event->hw.interrupts = 0;
 
+	if (panic_in_progress())
+		return;
+
 	if (!watchdog_check_timestamp())
 		return;
 
-- 
2.43.0

