Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519BA334692
	for <linux-fbdev@vger.kernel.org>; Sat,  3 Oct 2026 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996689; cv=none; b=rbG7oII8j0NOXdIT03blliEGIWq/f5wCJ5UORymQQq1VlBM8UTIEGveRhj9UKHqh7bl/eBLrnDoR7Q2T/04kU3xRhZXtI5k7dNRSLUaU3Qiz9T/k6nqXtcJ3/ZmybC5qCWbABgFC1dOqmC+zZg8inYBu2RL/e5SorM+C8bAhFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996689; c=relaxed/simple;
	bh=4BYVqjUglUdukgdquAFjv91VzVsZy6yCRbIPkKsP4hI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5pa6A6KbVGGtb3GWKU8b0NbwaWZiYGa9BYZVW+VT1ql8Kkk4NoCOvW2PvEVn2og7mFZv0nVUccfbPW3Ogj9O4WdiPLIiifaM3xMnuBlCxfgkdwe3RQVxWgXAKn4BS/ousGvdiVr4USWfV9S3oMH7yEUIPJiVmWfTh3fBw5pdU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTKAOkMt; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTKAOkMt"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-533861a59b8so2101791cf.1
        for <linux-fbdev@vger.kernel.org>; Fri, 02 Oct 2026 20:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790996687; x=1791601487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbQpt4XN2R0/yiVPfAFgl5CdQcTGytdEwK5oHePqLiQ=;
        b=NTKAOkMtGo3EeQ4qnu0C65C29P7ibVmiO+LtvTQxVPRzC8sCXFUkXXwsHgTd2a7urg
         ccnmlDHizCQ4Kigyq5StOhY4Gmfv/V0yU9ZLmxgd2g1Qx/Om54zELfYOOSSlRpNDIjk+
         /cG67JNQZBDRciqEe6nsPrXnBseKH3UkDkGjfBia+CBqDryBLjkXWM+T6gRtvVjEfu82
         dVguZRFF5gbjBfYwWjtWFYYa+UeW9tOmWnPINEZJYbwu7bgKqeOocyI/8jFUK581FTUu
         ZHrqsZmnDaEEPVOx5Eu9gAZ1YkpftMVELoAjzflSB1/a31Spphh0vUn4rIlDUsSrQpbK
         iGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790996687; x=1791601487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbQpt4XN2R0/yiVPfAFgl5CdQcTGytdEwK5oHePqLiQ=;
        b=rUZxWnrGGW91ulN+Q7hKYlij8U/35BGNUW6+4A8MVSCiyQlZunJkZTou7miqYtUMEz
         YNx5kwMHRD7y5t5+1wB7jN5zVlhFZbc5dsYZJS9PW3JdACMPBsLI0IdxMg3CGinlpOlE
         i+W4aDe+nAdzr4KFOJK8OJxzoMGhq4aU5psYPYnw3pGj39+Zblk+senqU7gVLUFxR0xA
         Kd1hLSoSySArRXDClY5pzrDwkx3UqjTaWNIv3xtdMFSc4Mvx4g5ZX8NLy7HhyIQEUhM3
         bA6lK6QWke/2tOSYtsvAhPjMq84S2GZ3+IrQhPtK355nxZ9b2KdvIF3hgNpSY92sVc+R
         v16A==
X-Forwarded-Encrypted: i=1; AKwUvBzqY0u6cVa1ZV+332Muk4n1ghO/a0YaGffz01hHglUcB9n8naxnefpOC6RSjLh2Z2dyWGE7j2oFa4DW/g==@vger.kernel.org
X-Gm-Message-State: AFuF++mUvmpEqxdnBHQrhyIQrUA1ylJeNEhW2pdBqjmqQ7IJeZ75jEmf
	OlvnSoz9F3xOwaSGFZVs9GKvCGz2QNVP8y/S5j/w8cFdaMHLvHzfzt85hgkI
X-Gm-Gg: AYBFou1BfARmCM8v7CnvpWnOyvaCJvzp8b/BNe+V4yzmzV0XN5JEf+OU8ySqQYOXcgp
	MDt6gfrLblF08lv1XEnwiWnt9sxppUw67+CumeNHld9nnAOCDvxebtIXZwIxVzA3LN147qkurZ3
	dbJnijY9spez/iL8OpM6ryZSi+QgtTnRsdnFOlP89buQWrVWnDvveX7UDy5nkPtc6lGKfjeqsHl
	auQ5Ng0vTrCy9qDJycGiFtn7K139bDHTnxrP+hRygBk7GGvBT8oQaP5sTjjRS93a3Lexp8Fvz8k
	3Bt18KC51ka5ZIn8Zg/4mg0yVTxtg9O2Ea+0WfTh92oSPaB1WgmSkH1fvHgMT6AD3SHJmORO/8G
	EnCG7KDmakVvEwrZVMm0cSDXPsYDbal0oHTrL1SWOQrRF4nbWMp4m/UIl3hmGxs6wHKWIaSgWeQ
	skuqL1xbssiOm4x47JtWTKCK5ZfdT6/dQzzrEf+ylWtjg4oMoB82Cd4SmE+W4bBJ6Wuf/9szWBb
	wzXHEO1ezaAUmKbQvbgVJ0ws2heXodWaV7FVR/4i3dmCsuiPx85aRvNetj0UVKH3VLEicEnfiof
	iU5phTtbRY/H8/F0An0x6s9PAsI8
X-Received: by 2002:a05:620a:2851:b0:93a:14c:32ad with SMTP id af79cd13be357-93e50bfed26mr274906285a.0.1790996687163;
        Fri, 02 Oct 2026 20:04:47 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bc8faesm34443696d6.28.2026.10.02.20.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 20:04:46 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] backlight: lm3630a: Cancel delayed work before destroying workqueue
Date: Fri,  2 Oct 2026 23:04:39 -0400
Message-ID: <20261003030439.599330-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt handler queues delayed work to read the interrupt status.
After free_irq() stops the producer, this work can still be waiting on its
timer. destroy_workqueue() cannot drain delayed work that has not yet been
queued by its timer, so the timer can outlive both the workqueue and the
devm-allocated chip containing the work.

Cancel the delayed work synchronously after freeing the IRQ and before
destroying the workqueue. This also waits for any running status read to
finish before the chip's resources are released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8f49e59ce374..8ef8163c7fef 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -591,6 +591,7 @@ static void lm3630a_remove(struct i2c_client *client)
 
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
+		cancel_delayed_work_sync(&pchip->work);
 		destroy_workqueue(pchip->irqthread);
 	}
 }
-- 
2.53.0

