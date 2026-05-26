Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2703D1CA5
	for <linux-fbdev@vger.kernel.org>; Tue, 26 May 2026 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786921; cv=none; b=CXtvT7DUHHb2Aqn2AbC+PgQvnkAWzBELMaS0p0QlRAQikJxU4BC8TloKl+TNxBrVnezkEypYF48KTUnrZ9KXoIrDEo/dTF1NZK3A/lqSISfK1FiPKJ/550bxOX4yKa9kUtFuCFAAgfZySoDA5u2LO6QRrO2wy83MBX7wn8XunLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786921; c=relaxed/simple;
	bh=CiLQjT1Qr58oChrYxcBkoC3zl+AdJy660/8iBarPYl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIbYkkA72c+IEDbOUHsbHWaYM0JbGZVyxPVNz/0p4UG0ZJHvbdCGysiFL/7cjKa/jb9wSZwO2ayHQISg37HR4g7Q407J+71mviYJP+/mw7FsNDQl9ZTNga7gxJ8jLNkPgWr8MeJjQE1U8rVfKVhpvkA4uDTs0pB/FcKix4XfaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8oF1erT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8oF1erT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so108162765ad.3
        for <linux-fbdev@vger.kernel.org>; Tue, 26 May 2026 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779786920; x=1780391720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcJdTmTjfiBuviJiW8pIvbqp3hR7VDqq1Y5TAU3hp2Q=;
        b=i8oF1erTwKURoEkn7vkh/rScaeWUJYHNTqucxtDGmiA3WFAWSIy8c1cm+0ZAwxYypy
         5xtWYhsxv0KZgK6ekfEqBC+stqbkMSigA+ONcbfqY2/oYJYiJH9qZiWWxwZTWAzGkqyq
         TC3/oX3rXBwm+l0Emqx/aD2J0xFYkKjl8UciSfmgbC/y+Uy64MVmB9ldLFGCxLTp1Qi/
         f7vT470aAuApQmgOYFlmRkRfv9w2AvgSQV8elTmJA5L8/5AfwyA7f4KrpwFYRZLGPFAd
         2mT+Ibx6Vte9QiEcUHnd2DUUrm7lBkMSs64MJPfcpmgS/medDQZ6Bd6egleD0xQ+SSul
         Chbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779786920; x=1780391720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcJdTmTjfiBuviJiW8pIvbqp3hR7VDqq1Y5TAU3hp2Q=;
        b=AUaAAnOYn8EYPF5qQAf61DPd7wblhgRam+gE502wpwTiUlLF/SHmZ8gHbIZXhzPrrL
         3DNQ7hRfCX7ReYzfS7z3Y8LiK0cIICR5yPl7C3xrCHej+rg6+l30XVXCEK2LqNWrexHX
         PeXhBMH+wMA9ZQnEtdPUMfZsdVIctVxFJ9/XCglJ1fJ7nLKuVVU7JDo0r5Y4EAy2dtnw
         nu58ZWWkkWCbi2GfI3LvphZ6fZ7+Xp6NWM+vpEJQRJPphkw8JxKD9HRD6demeJjiDWUg
         JWFLayaoLWGKVSsC1d4yovAb1xCf8SbfXuno8yxG/FAymrUKzoaMRBJgevp25KQk9G42
         v2Sw==
X-Gm-Message-State: AOJu0YytnHNnuZg65qPfgti3mliJFOnNGeCOVmkChgXlNxjF0rUV6SX0
	pwB++CbHHMVXYsUEbZ9m7WT0mVOdl1nMNtFCAXXYnfhI6JbALY6k/vgr
X-Gm-Gg: Acq92OH1HiUENq3zqVSQaqOO8Bx0F7QW5JCv3LRqg5pZBDEwtgruEi9uI/tEqvlb+Cq
	rJq1udySGco02MyVf0JeyVmhuRFX+Y/xwX/bxrQweZImrcrJbKNQ8yDSB39xZjDhoKzdbPwsAqA
	Bqd4j2DTcjVArzCSHBLBDGHvR006EWftCxvOL/zMPRRYh1KAqt3KLi9DsTvkYlRd3XAKBG8aEUK
	lyL7EEGN20Sau4nLhifMtNaUkmz2JYdUSHRiCtW4oEjkYhDigg93qcj2BPIcm7wS6igcIicRPy3
	isTgeV3upmxJYbFntpJ1f0Xr8+fzRP0bMKSsND2/R2RrJvKWxCUGv81EtFJRudgzbnewpGPWT5t
	ZnGyOj6XGm+xIBYHx6RMQTzZHtkE1d7niM2+uBdCG6HkI/h8UYL3QK8xmUNl6LAjS/ouL6o9CL7
	/6tTONgehulatwEA/ByEsLeNMsTrBsHgiCjlQ8IB6DVLN5er7zpofJuKYUQw==
X-Received: by 2002:a17:903:faf:b0:2bd:2439:25fc with SMTP id d9443c01a7336-2beb033f460mr169505875ad.7.1779786919586;
        Tue, 26 May 2026 02:15:19 -0700 (PDT)
Received: from oslab.. (n058152109154.netvigator.com. [58.152.109.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beca535bc1sm71381615ad.56.2026.05.26.02.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:15:19 -0700 (PDT)
From: Tuo Li <islituo@gmail.com>
To: simona@ffwll.ch,
	deller@gmx.de,
	kees@kernel.org,
	tzimmermann@suse.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] fbdev:modedb: fix a possible UAF in fb_find_mode()
Date: Tue, 26 May 2026 17:15:07 +0800
Message-ID: <20260526091507.421730-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If mode_option is NULL, it is assigned from mode_option_buf:

  if (!mode_option) {
    fb_get_options(NULL, &mode_option_buf);
    mode_option = mode_option_buf;
  }

Later, name is assigned from mode_option:

  const char *name = mode_option;

However, mode_option_buf is freed before name is no longer used:

  kfree(mode_option_buf);

while name is still accessed by:

  if ((name_matches(db[i], name, namelen) ||

Since name aliases mode_option_buf, this may result in a
use-after-free.

Fix this by moving the kfree(mode_option_buf) call behind the access, and
add corresponding cleanup before early returns.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/video/fbdev/core/modedb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 703d0b7aec32..91f6c78f9e19 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -724,7 +724,6 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			res_specified = 1;
 		}
 done:
-		kfree(mode_option_buf);
 		if (cvt) {
 			struct fb_videomode cvt_mode;
 			int ret;
@@ -749,6 +748,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 
 			if (!ret && !fb_try_mode(var, info, &cvt_mode, bpp)) {
 				DPRINTK("modedb CVT: CVT mode ok\n");
+				kfree(mode_option_buf);
 				return 1;
 			}
 
@@ -793,8 +793,10 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 				if (!interlace_specified ||
 				    db_interlace == interlace)
 					if (refresh_specified &&
-					    db[i].refresh == refresh)
+					    db[i].refresh == refresh) {
+						kfree(mode_option_buf);
 						return 1;
+					}
 
 				if (score < diff) {
 					diff = score;
@@ -802,6 +804,8 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 				}
 			}
 		}
+
+		kfree(mode_option_buf);
 		if (best != -1) {
 			fb_try_mode(var, info, &db[best], bpp);
 			return (refresh_specified) ? 2 : 1;
-- 
2.43.0

