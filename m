Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1322A1E1;
	Mon, 25 Aug 2025 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089022; cv=none; b=phOk8TC5kOuLgOfmzJ6EzTPXDJXboC1PZ2gugdV0L1jKOtFSFivj9Xy8P3p8/APj+07y9wANADnYtf+5x0zJA+u8+IkypVPO3VbVeyz/+biRI2QvWwf/MTTbN2T8386BXx04rLs1vuGdGuhHAGIAq7jZGdYEuLm1LHm+j6trWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089022; c=relaxed/simple;
	bh=RsMWfaOhha6pvgiCZ8f22x4IYWbxbPYgWGKz1vmy5vw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lK4T08ROlZ5SQwY2zC1xXH23aTzMReCLevVs3NJ+7gCXSNtJE93ZkDt790PH+ePkAAEcJ7aSvkyqRWrGzOvQo2Zclwn75kArQVFNahkNFJgFL9zdwQRozxbzQU4xS4YoIC8TpPa9G4MFrYVIrhROJgwT4Eh8Liv7vnAEtfVGeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xz+Gsm8N; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz+Gsm8N"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-325195d1b1bso1777242a91.2;
        Sun, 24 Aug 2025 19:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089020; x=1756693820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYO/YmS5jL3ZM2fX1JrJ0oWdxchh893vzLzAxL1PuNk=;
        b=Xz+Gsm8NHjPgLKRqUir8juluZX0Qad8EDZfY+bTue95fySvFDefcy0KWKJ/V50Vryi
         nE7dAjXI4NqNrCONMQOFMSolWfaOshr7M5kr17uXj0G20hTnYCpXANTRlVjeTJWR9iks
         p6h/uI2dwu8O7CAmYIY8EPXLlFo4tqycFTd0mNqYltnGYJ1kXR0/kZRjHZCx8270oJgf
         pxuVZhCNYm+ZY3F6ZcwLLgCfW4uaPOAeVJudAFuGhF3Q89oHgGCPiid4I6dO4YpvHFCY
         LOXUJ6T3e00tqj2YtqFKPkKcNDMXbNSW87eNm3XAAgb7D9jAZg7Zdis1WRoGiM3awEcO
         EPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089020; x=1756693820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYO/YmS5jL3ZM2fX1JrJ0oWdxchh893vzLzAxL1PuNk=;
        b=sC+tb9mTcbIU4qrBjOY2Rw93YbHkHizPDvq9IKTTQZ9ogRZXxz1s3u1S2TMmd1lNLI
         sOws0JMd/x/s3ojRWw58GV7hy2tJuEngFfhUWkbzWwMI0KtbURty7bwh4NqIZjzw1wco
         tfjLX75P4wNJBQArbr7dCQdgH+wGXP/TLLlG6e8rWc3drgDPnenBSzMU3gjbs2rzSArk
         4oeu7+KhUWwyOh+zwDuJlRzv9C7Dv2TNOXWTOa5tEo+Zg80kAx/74NvJ6IPhYJIzqBIf
         i+Nxj+tyxPlo9462uuS87weEZ6H1oVlEwHtuAfcWDB7tf+SImToePcIFYieCFlsPvUyc
         xV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUidRDR2sdEfdsAD8lNFvo1NAFuZmaT6IJaGs1eyNlt35ZlhZRll3n9MqPQHW252ag+17CuVTipMwKOQB3tYpxv@vger.kernel.org, AJvYcCUkyyaWiS1fQ6piNKLNp/nRbIl2cAEnLQXXt1MJG1q7lfoQD9/JEYXFlc5IXilmjXaaS8liv7um6tbfHg==@vger.kernel.org, AJvYcCW7guMgxi1cnBh2/jXN9BR3U8lM0XZDEt0HMBshYYK1OjYVGl4WgzjUiBSF3LYds0h5n9VLVqOH/RLOHN6n@vger.kernel.org
X-Gm-Message-State: AOJu0YwxY/SD0Vhy/er8tQnGD2SnBmZ0RpHeHzp/ENUHUsUij21wi7Jy
	ep5lGjIKNDsFksatAHdkNcS5g9/FqlNAt2GIXdI+E7RmDnjFoqX7DEjg
X-Gm-Gg: ASbGncsFXaEkRWQx7ADzYKOgfxeBtXhjoAcX5zym9qP7k9iKSAtwjQtmGKWezqYGTAK
	3ArznD5qBupm6psYkOaING1ZSUIAQGqAKOPRBsEo6b/7PTKzHrSDokx9JpBewO0J9GEuoID9SSU
	NYJ0JAKH5LGeqJPd3UCJaA4iaTmkon6xsH/AM2VjZMkpP4XLxHwbkUCTMyvxHdoKNH7TEFiNPkV
	AMaRUdmJ1tvmIdh/zBNWM3Xa3ZO4u4yzJArD73bIpRm7QzD0aPth1xarAgSit3c+xnyXO1EoNL8
	g/zPpGz5FZWP7nzTBrVkYma9aaaSFQyKTdwyHRH9PDnMR6/eDIi+1VPUd26hmQN5ZXCBN/v8zv2
	w24XWBnrmx0Ji8yOUmQwrgWoiC7hyiUbm7Kw5p2h3N16ICXKyjeR52gkKRcgsboAmTvMHAa3Chj
	4=
X-Google-Smtp-Source: AGHT+IGcXL928gw4jZtFeS2GjzwHFx9joFXeGHPpEdrU46U9OgXBCfZHOfrutnNUpiMm/H6uh+w8Yw==
X-Received: by 2002:a17:902:cec2:b0:236:9726:7264 with SMTP id d9443c01a7336-2462edc37a2mr159709745ad.5.1756089020026;
        Sun, 24 Aug 2025 19:30:20 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:30:19 -0700 (PDT)
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
Subject: [PATCH v2 0/9] panic: introduce panic status function family
Date: Mon, 25 Aug 2025 10:29:28 +0800
Message-ID: <20250825022947.1596226-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces a family of helper functions to manage panic state and
updates existing code to use them.

Before this series, panic state helpers were scattered and inconsistent. For
example, panic_in_progress() was defined in printk/printk.c, not in panic.c or
panic.h. As a result, developers had to look in unexpected places to understand
or re-use panic state logic. Other checks were open- coded, duplicating logic
across panic, crash, and watchdog paths.

The new helpers centralize the functionality in panic.c/panic.h:
  - panic_try_start()
  - panic_reset()
  - panic_in_progress()
  - panic_on_this_cpu()
  - panic_on_other_cpu()

Patches 1–8 add the helpers and convert panic/crash and printk/nbcon code to
use them.

Patch 9 fixes a bug in the watchdog subsystem by skipping checks when a panic
is in progress, avoiding interference with the panic CPU.

Together, this makes panic state handling simpler, more discoverable, and more
robust.

-- 

Changes from v1:

  - The commit messages have been re-formatted based on Baoquan He's suggestions.
  - The panic_in_progress() check has been moved to be the first check in
    watchdog_overflow_callback(), as suggested by Yury Norov.

Link to v1:
https://lore.kernel.org/all/20250820091702.512524-1-wangjinchao600@gmail.com/

Jinchao Wang (9):
  panic: Introduce helper functions for panic state
  fbdev: Use panic_in_progress() helper
  crash_core: use panic_try_start() in crash_kexec()
  panic: use panic_try_start() in nmi_panic()
  panic: use panic_try_start() in vpanic()
  printk/nbcon: use panic_on_this_cpu() helper
  panic/printk: replace this_cpu_in_panic() with panic_on_this_cpu()
  panic/printk: replace other_cpu_in_panic() with panic_on_other_cpu()
  watchdog: skip checks when panic is in progress

 drivers/video/fbdev/core/fbcon.c  |  9 +---
 include/linux/panic.h             |  6 +++
 include/linux/printk.h            |  2 -
 kernel/crash_core.c               | 15 ++-----
 kernel/panic.c                    | 71 +++++++++++++++++++++++++------
 kernel/printk/internal.h          |  1 -
 kernel/printk/nbcon.c             | 14 +++---
 kernel/printk/printk.c            | 37 +++-------------
 kernel/printk/printk_ringbuffer.c |  2 +-
 kernel/watchdog.c                 |  6 +++
 kernel/watchdog_perf.c            |  4 ++
 lib/dump_stack.c                  |  2 +-
 12 files changed, 91 insertions(+), 78 deletions(-)

-- 
2.43.0

