Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751441A4E8
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500376; cv=none; b=qV7Uz3uObnqSiGpLiHB+ZG6iYp4Fzl9bJ0r7JFeVHO69qI3DzcwOWqrJXxSTCSQk81bf/lvZkJNpdkW+lTSukC8LIOISjy3DuTwjHSnRltQS902n/+HD745Jje6PFgmG0HH/lkIlRLvANwDOK040FRO+F8F/xRWYeYeL7FwAf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500376; c=relaxed/simple;
	bh=6MXkkFX809Dcdreee2nhHD69edsUNx0ehY2U76SPV98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E071ZBgLpx+FiBXK5kUSjKy2DjOvs23JQpl42Wiw/HLeeBP77aNYsIg3XGf7mql7a95ehtE4mNQUVJDjzlQlLa04mZ+a4BV/Q/prikgtCrIiq47NpiuJNCkrW/3RefsClSZqNtcI4BPncCm14LMVqvbfaekgTEEcgIR2UmhWJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=YhJRbizw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="YhJRbizw"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e88b60121so746274a91.3
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 05:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785500374; x=1786105174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EcvBzuwsOWXd7sSY+ibZHDp7um7F6zB3s/KkWEJX80M=;
        b=YhJRbizwiHSFfbN6vFVIKKWd4rtHRg6LceLUm6TwB1FKUngzmey6ER67bE/ozwFtww
         01ETQsXO0KBXwQ/pN2jqWeux9FZU3thLPzquhbNCFVRFdAIHmU1Ci8hrdJB33El9BJcD
         /R+/ssoPm+VvdkXJFQNqozbIz3qAwlgcrVUS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785500374; x=1786105174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EcvBzuwsOWXd7sSY+ibZHDp7um7F6zB3s/KkWEJX80M=;
        b=YxVXL2c/eO+bEctDyP2OgndIfMUZkH3QLM62dRZ6X6i77a0suW9A6fkzrdYPJuJOhH
         lAd49epGfLCVxMsgmi1Liz4lnYoBMyKFi06WQTWpmWtYDBNQyovib6p81rN6QFBlTQwy
         xvZvottqhuqC55PX4tctHLZr/slJo3Xq7YAT94dqvObLU8QpQ7Q2gfAKjbtE76Hliz6U
         vhlGGLTeG2cvCWqh1PeSiltfAnc95EWtT+eLbLRPNTijCKWF0LI+7sTqznJEmYg7F/eh
         XehSjH2VFcuGzOsiUL74Hu16aL6URUAeCgFN6KpDGhrlIibaORtOTS7F5BzB7+yn97wX
         IOkw==
X-Gm-Message-State: AOJu0Yxtq4m4XM4hCUiA5suq2g6KUqVybZd72dBGz6FEbwcAAePb3ba5
	AHN/Z1IcpnmmI3DEt2jebgXX6KCNByyytArZKcpjjpnsbzGCUXzDQ+tIFrXrL/wDMr0=
X-Gm-Gg: AR+sD11NVZw5Cl/3JcSs9+QzgvIhA9PLdycEYGLmTAB4lFdLTom4uNvkhJvShvOAnMz
	1MGaYF62Zi8vnVgF+3ZYn2liYZW/zMHLDAK0G0sBT1XjwRPfHj4uyh7o+ET2JvhvImnc+InffNx
	QzC4iz7HCp8WuEIjmuIdJUHJaRapCDRBoIWAAItA8ql+l3xe2OzXGWdtoCVSnJ34lJsY9yXL/Qf
	NwV9Fk+5jFJf4VAloybMJ97UKbFEVUoX2k2JiP/5nITqz7STW/atCWT9Jpp0nkJ9uhvlwPJSdiO
	58Pyop1IIPtaPEYeQRmYeMPtAslAEAZG9yZFoDWn43eiws3v1tFBhy+9QqM9wlhHzeV2iw1B6u/
	n47CVqx7TeZH2fwii+Ltwz3xFxDjPBr4Sz6Y98I0sMT5W9C/ArmyjWHCPT3ITYKPEFMXnw1M3kc
	/Z1NAkix4k/ZKcqcGKa81wUUOmIO2gG0ctlFTZG5TaNVPcnYNaThsbno3L5G/gdQ==
X-Received: by 2002:a17:90b:3bc8:b0:382:5c31:1f8a with SMTP id 98e67ed59e1d1-38fb13bfd7bmr1819215a91.27.1785500373635;
        Fri, 31 Jul 2026 05:19:33 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:19:32 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 5/5] fbdev: tdfxfb: Program the initial video mode
Date: Fri, 31 Jul 2026 21:19:14 +0900
Message-ID: <20260731121915.3362232-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731121915.3362232-1-daniel@0x0f.com>
References: <20260731121915.3362232-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the card does not get bound to by fbcon set_par() never happens
and the initial video mode is not setup and the display detects
no signal.

Program the video mode and also clear the framebuffer memory so
random garbage isn't displayed.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index f2b658a47135..cb1c2e9f37db 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1686,6 +1686,14 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_err_iobase;
 	}
 
+	/*
+	 * Program a video mode and clear the framebuffer now, this
+	 * ensures the display comes up even if fbcon doesn't bind
+	 * when the framebuffer is registered.
+	 */
+	tdfxfb_set_par(info);
+	memset_io(info->screen_base, 0, info->fix.smem_len);
+
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "tdfxfb: can't register framebuffer\n");
 		fb_dealloc_cmap(&info->cmap);
-- 
2.53.0

