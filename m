Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0C3A380A
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Apr 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548107; cv=none; b=pXfeFGm8UBqfVjKC0erMLfLgwou+Z1WjdPFc4C9gSoYB5KKCJMtkZgKwt4oWjKaDNz6fmIJcbIlzDDkWmsibf5rvng5Ib050C1a7ChZUtpc10oXlhPKP0E+pDjNaTlzVMIDVaJz/XdvoiR1ncdjgc9ZcK09uruc5cWyJwQDbQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548107; c=relaxed/simple;
	bh=eYS4q1hhfGfEjPTVo2MAMjtGc+4o9uMh3oyKyZQ0zf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJDPFdm3e9WyNMtsk/x3wVDGGEC3iua6dcEcO12Rp4DjM/zkfLX0e+YvpO7pTxtKKbHuLieYdMT7B123/C7vtpxzUfRJNER7B7GQs2JumQhYA5kU5OIA1CA7yFMDijJla0agZzjR7t8TtAlBsppugQX0VUrm7mMGCRGH5LtnFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lraCoUL4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lraCoUL4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d95017a68so2615090a91.3
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Apr 2026 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775548106; x=1776152906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIQhC6F608N9WuxvQ6whrebBgn5g/yKf1QU2tQg2AqA=;
        b=lraCoUL4FUkPj12M0uJUq49P2x27zWAmf0/PseDnjlzDPUp2/l09POKd1CHC9SHUL2
         ntb8E+SvdrmtzVZmXhkaKA7sy/QKANAG0DYuObR5i9xiuaIZkUi1EqcDQzWCXXHg6HA1
         lhwLQ9GxFM9SLDL9J0LIvwIVf6BDfWmm8MPJzjXgOjs/1b9LZniMEK5KM2gDTiw2Q53H
         4F+VFNQ9exxZnRZx29HtWRH84ie0CGnis7gkNII/+TgoavE9TOqszmGYw5RL8molZ1CQ
         AwNMGh+nA9P9h1PUNr6s4qlun6d7fnXMdTKUQk9nGnDAeelSYA/2Rct7glBD+rUhs1pi
         EB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775548106; x=1776152906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yIQhC6F608N9WuxvQ6whrebBgn5g/yKf1QU2tQg2AqA=;
        b=iGdW9k3aRzPTXmUKFUth01jjBALNNpVdQXhhBPQPbzZ408tcFkJb0y0aAEUQkb2Ybw
         p8EJKeSshw9x45hQyFU60s6tGhQenIsNgbG+tod9EHJA4I4j1O3M4MJsgFjylqrw94Tr
         OhI4j+And1Ig7uXmEY2bAJKDNz0p9hu4xdAHvKnbgi7HczFBJv1qHXGzR6xfQP/dU5qj
         YMSBXJ5ebWRP28rKNYIke3dN+FwlNYm2lcFaNd9oV7ut6TVPiOcMMVuPeJSRP2ginDUZ
         YsnSOpGeUISc+wYaQfpUln3LqAeg9HcTLEcy0mUJM7f5EnFOhtjxk04iLbKAyqY98AFB
         ri5A==
X-Forwarded-Encrypted: i=1; AJvYcCVjk98YVRkuovVAy76as4r+Y0N3rTcJ+Hb1ws4stM9NjQzh2+VILOTdpo8j1+K144vukpPhLjR4nNktqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUnsHnySwVK1mDNRSoY7XW29wGnAhnGbHRG4MLNwB91NRkDgC
	N6LdJ0siC2+Sz1jUV/zfqSlkdIkdda2J0rIIqJbDgmGRiZS8LpzSknp2
X-Gm-Gg: AeBDievR0qrk43LeU8ZvdLP6K6KJza0WRZL6MssX5loQGh3J5TNF2Bvrks9nyOTazYP
	NVGKkevvmf82iOodSEiEh3zClkVFNdpV/ObyK+H6H1HyXu9NLG5CHNtKBCjpu3vvbLCgMCApb1p
	jj7aHUxKUkC6vxpr8HQMfyVeA6xdciGtns1abt1NHdqKUUAXZG+uPTEtWD+Xtero3V6vp0+7/RU
	PqRmH6T2OShZrr8R1UQfSLYoNxcHOCijg02N4ujCt+QUxrHmvDREi5C4CkYHSTP1NTKJg97kWyj
	5QgqKG6COca5CmTaXnoYsuv1ROtTZQCorJvzf/oewFhzJwwiYSyAp+rqdpjZ7+xJxjo8lGz35aS
	B1mmUzLAbgwfpLBl/+LAi10Hz6AsqHL4OXKtrZnVg1gvjEn80k6SZ1eke3mF2AsoZquWjwyqdUl
	yC5+dC3emKg4HanZgsq/IPxWb1lQoVPNrXmpw=
X-Received: by 2002:a05:6a20:4f15:b0:39f:94cb:1cc with SMTP id adf61e73a8af0-39f94cb0749mr2018043637.46.1775548105951;
        Tue, 07 Apr 2026 00:48:25 -0700 (PDT)
Received: from fedora ([2409:40e5:1126:477b:379d:30fd:d3e2:3b3c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9ba21sm22093716b3a.51.2026.04.07.00.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:48:25 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH v3 1/3] staging: sm750fb: Rename sm750_pnltype enum values to upper case
Date: Tue,  7 Apr 2026 13:18:03 +0530
Message-ID: <20260407074805.14505-2-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407074805.14505-1-chakrabortyshubham66@gmail.com>
References: <20260407074805.14505-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the sm750_pnltype enum values from mixed/CamelCase style to
upper-case names to follow kernel naming conventions for constants.

Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 6 +++---
 drivers/staging/sm750fb/sm750.h    | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index dec1f6b88a7d..729c34372a1e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -942,11 +942,11 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
 			sm750_dev->nocrt = 1;
 		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
-			sm750_dev->pnltype = sm750_doubleTFT;
+			sm750_dev->pnltype = SM750_DOUBLE_TFT;
 		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
-			sm750_dev->pnltype = sm750_dualTFT;
+			sm750_dev->pnltype = SM750_DUAL_TFT;
 		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
-			sm750_dev->pnltype = sm750_24TFT;
+			sm750_dev->pnltype = SM750_24TFT;
 		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
 			g_hwcursor &= ~0x1;
 		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 67b9bfa23f41..49a79d0a8a2e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -13,9 +13,9 @@
 #endif
 
 enum sm750_pnltype {
-	sm750_24TFT = 0,	/* 24bit tft */
-	sm750_dualTFT = 2,	/* dual 18 bit tft */
-	sm750_doubleTFT = 1,	/* 36 bit double pixel tft */
+	SM750_24TFT = 0,	/* 24bit tft */
+	SM750_DUAL_TFT = 2,	/* dual 18 bit tft */
+	SM750_DOUBLE_TFT = 1,	/* 36 bit double pixel tft */
 };
 
 /* vga channel is not concerned  */
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a29faee91c78..0e594734a8b9 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -134,12 +134,12 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		      ~(PANEL_DISPLAY_CTRL_DUAL_DISPLAY |
 			PANEL_DISPLAY_CTRL_DOUBLE_PIXEL);
 		switch (sm750_dev->pnltype) {
-		case sm750_24TFT:
+		case SM750_24TFT:
 			break;
-		case sm750_doubleTFT:
+		case SM750_DOUBLE_TFT:
 			val |= PANEL_DISPLAY_CTRL_DOUBLE_PIXEL;
 			break;
-		case sm750_dualTFT:
+		case SM750_DUAL_TFT:
 			val |= PANEL_DISPLAY_CTRL_DUAL_DISPLAY;
 			break;
 		}
-- 
2.53.0

