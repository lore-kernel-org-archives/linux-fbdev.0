Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7910044D020
	for <linux-fbdev@vger.kernel.org>; Fri, 15 May 2026 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841513; cv=none; b=ByLxiMi2aXCxYNSBzzrDRRwgQvU+XsSK32jHLwa9FQM7Nu/r67vf4qY9XMqsxy/TQ6Cpir14oLnzNTzbbG2lYLghc1tijfIbW6Wl3gktRLPt7Rd/VXf0KQECoWeYUYiVmAsBqdaaPN7+6jZ6n4tVz7CcJDwLD1FHGbKMCT73WqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841513; c=relaxed/simple;
	bh=JXO9K/UWrd7JiYU4CmF3JCr1nL+D3hpSGREU/uqsNxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jf4Fb4H8+1sia5TcaeTMz2cGVSPXU6P0c8KWDo3YoGh4Fpyl5K6s9qPUXjncAJm5waapF2NN7BZp2UsxCIsgSCvZKB9BK3hksJ4NIPLdRIJ2LakvmxQUdktZ20dDVOo4aIGiSQzIY4GyoHPmlc0erSe+C6EunyxSwejTh4ktOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mynQr+FV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mynQr+FV"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so1165694e87.0
        for <linux-fbdev@vger.kernel.org>; Fri, 15 May 2026 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778841511; x=1779446311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRJKWy1O4nl3i01yN37op8R09tvKSwOIAS8zqvO/8bY=;
        b=mynQr+FVG8qrOQddpuIEnYDB5oTDQxFmg9ovkP63zPd2nfOQF5tIN2qd6VBpmrYj+P
         TW/2o6sYNmsVxHrHTyPnXwd9+IDaR/dhenFmJpfP2F+UZ38+UpEyWWJyM0ZoN92whibY
         oJoVQvje/uY/JbvnXexUuZ6gJ4yvlFK5XlTTM9/21smyB/85KhL8VbIMT7GaEBhukuO8
         2k81AnvfwJPp+9WF90uF7basHcGXItZL2+i9rHd/LUneGGbHyZozpHXHbsW5QQlV+8pw
         GQM7CVzDiyJkm+vJSp9rgNUf7Thr2T6uvVbZhNAqU7NrgvdFtOoC+4K+Wf/SZOQRevha
         hCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778841511; x=1779446311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRJKWy1O4nl3i01yN37op8R09tvKSwOIAS8zqvO/8bY=;
        b=rADqwXyon6Z5myxeIeUFczCc+mF+1fHOt8S4JKKoAvClIutNeXVHK2jPS3+FDcTu6V
         uApqGvjIGfB3MeKvaS1+WtvTeUhZzVatlEI9Y0Qc20ag554T/i4sG7VRytHun/ZGo4Y9
         E575QKiXJkczvr6BJkZYPiu5gx92WOUQBfvVJe9rdP3Y1lNL+pm/Q/2VM3s+U7r5pxds
         sjvp0KtIHJHlAIAnRJ3y+zDg9GMfJJLRMEntt0mhrA4r9beSOHVHoe0NnP/wcc+9qG7w
         5DyH3BxiiTMbIHrQV0Geq9+ZWD7jcGnOSctl97wmuRv0KacFTGakHcCQ3riyBMz+qchp
         UkvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wxJdhE8yelmpWfsS9gKvqdLvrGM0tZWI/QgOLFcRPznOftQTPpQ8xpV05Tn0dE+IlSRQVFcm1tt0rjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQijc/gCagRmcT+rrUXJiZlk88Aod3TcxMgXK1bijakBeihcCc
	Q+hSVeszZSYZ7/MpgfCanc2qQpyMeRhnG6w2st30SA9yytEcSOJgFOR2
X-Gm-Gg: Acq92OE7fs93SN+EyQ/lzwMqx4L+2cz1VyPb1ijEp2qndZSCpC9sO+ac4vcW5GPdrCr
	PzYdkvsZ9v0c0sbfbPtewqjCsgw4tdPZUu8IGQzSBH/qwt0roIh+UgFa+CwLkcaJXT0SEBOB9zV
	437RMxVCs5kcq4jw1RIk8+p1C5lg7fcn9WwVSXkYa+a48W+nCfrj60c2FkD5M6sCLYtwtL2u3DP
	FVHhjlLJsJ+8nZMSE4tIlfTAV8XxYAnYsD0ajXXls8OeiV8VMXcidFNpJsdY75bvu30RcbPgDHQ
	VzBpIGuP51fPbTHOiEn3Rs3yHUa02iGe+Q54oK/vsoY0ijkrvg45dlxfga+HhwFdVeII6vhsD8Z
	IOdeni2Fs3gO6XMAiuw3fitD6DMdHHxvnlAgRJmMgdWMjlwBGwdBMYP+j+L83RL6CTbO6BlZ8XY
	r6zbwcVWQgCLGyYpNCND1AvGzGBiTH6MVLNcOWijzcpV2H+KHqxXRkSlWig3tZTttdus8JbpShO
	4l347AkLgs44mUkXQMtDfI=
X-Received: by 2002:a05:6512:695:b0:5a8:f984:1541 with SMTP id 2adb3069b0e04-5aa0e7640c7mr843728e87.37.1778841510306;
        Fri, 15 May 2026 03:38:30 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f11a7c2sm1210663e87.32.2026.05.15.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:38:29 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH] staging: sm750: rename CamelCase variable in sm750.c
Date: Fri, 15 May 2026 13:38:11 +0300
Message-ID: <20260515103811.2808620-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renamed the following CamelCase variables to snake_case to comply
with Linux kernel coding style:
- pvReg -> pv_reg
- setAllEngOff -> set_all_eng_off

Issue found by checkpatch.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 996a586a3727..9b30627a19d0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -755,7 +755,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->pv_reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	crtc->cursor.max_h = 64;
@@ -860,7 +860,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
 	sm750_dev->init_parm.power_mode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
@@ -1059,7 +1059,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
+	iounmap(sm750_dev->pv_reg);
 	iounmap(sm750_dev->vmem);
 	pci_release_region(pdev, 1);
 	kfree(g_settings);
-- 
2.43.0

