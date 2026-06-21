Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6C30C146
	for <linux-fbdev@vger.kernel.org>; Sun, 21 Jun 2026 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782017460; cv=none; b=hkHtS+FRaHBM6ik0xYGMNULP30kQ6Qt1Zgkzdh9wAZeaX3e895LoCX+rHHl+jQk9re6SGKPJcdoIoelMrsyfKIVptSvNjFyq13wCYD8h57mUA6LbuRCSkASQWc2Iz9IcdWU8PyZ8rGitSac6gwwlrNtWSAOyifyNgH6M+v3wP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782017460; c=relaxed/simple;
	bh=YFAUHjBXI+kFetjkLd/b3rCtVjUhrXZxxVWHVWINm2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOApPGeWtxkcCTnFo76z51bQWTLbSx8Y2E9eli6OueDo2tKLjenKcfgizHn12MZ4tRd+mwOy6rg7A4pPuz4TPVxbQqXeUOP0fV5dXij82JKih6Ca0fnI6Y/79qfts5z9udi8A21GZlY5CQEiEkFo+/c184NyLt/jz768I8p4jgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIcgstsw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIcgstsw"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c6d3851e09so16919525ad.0
        for <linux-fbdev@vger.kernel.org>; Sat, 20 Jun 2026 21:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782017459; x=1782622259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5y1GPeu5P5j8qh7qGP62ln0SsVrjPHUxMxNHCrsfkI=;
        b=jIcgstswG9JShXSchc/eXXyBsO8G2WxIe+P4d53djEK6E001QDo+D7jVbUKP6FE5aZ
         ve6peHJbWBEx1QXcIbjHApTohux2ggtPiZlIH5t5lOxM7CQm7s2nqTMb5DYQEfs9Pqfv
         7T0YCWiLawZr2u7FoS/YDgHOe2V3OM3urga6RDp4n9lzLD1XsRHcvM7UoTmqDu7uXrN6
         xL2Wea0D5YX5+dsVO9XetUzwgbQ5cyzEBGPJ0lRtRSaMMdN3TIK8brFidXlrsua2beG8
         j34hmkyLYAzx0XaJ34MwxmUk/WZQ1kWrVTW3a/bRR/+yUC4ZqohJDFOazb1x38yUDYdU
         mF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782017459; x=1782622259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5y1GPeu5P5j8qh7qGP62ln0SsVrjPHUxMxNHCrsfkI=;
        b=PT3KyotDUcc3lMES0R/15Us/5h6nkga2ch4JPXB4Dh/YwssGmK8mHtGzQfUqkKuiAm
         MFBGWTCOUOT+zd1XYYSVHk+pLasOS3bLh5n3c6KuOiAVnZX3UdLIenpMQVr+ltyXRDwW
         YJb003m/oNG9tdvehMqm9BeL8A2WxtEhfVCMRO5InK+sw4u9wLC7vAKunjttAa7VPV+P
         zLjAp5acRno3Rx34KJSrZjSWX1Jm4bXeIRnjxTlzWsYvnwNlKy2C+jIGkmEj8sc5BSuq
         tNV/irKclo4ownSZvqiOGKLsrbG3C4o3H0VgA0kmzm1+RIBR25LOflK2k1uGkPOr2tWj
         3low==
X-Forwarded-Encrypted: i=1; AHgh+Rq+KJZFhJgQo5av9A9LFmKqWbOXc2DhA2JbNzLQkdYGxiyjFWzBFGFkdVkIXiVNofTL7uCRj5vjkiBJyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/s9LnjUmDAOw+4Z3v64D0J9EfzXp4j+JxV7nbKp6B0CBX0kii
	ifXIi3uCGF/9exoZE2j29VspNeNq27S5ZDp7Y/mR9vwWjktxZO4GSw/b
X-Gm-Gg: AfdE7ckT0f1/Ch2KYZdiWI6ECDXvhEJjnBypzdfGjIYeFL5UrZX436qlsOoMe3aL8XT
	zrRw24Wbj390dCTDQ4BrQX8sYOjeXi0p3Gz2AIC9Zg028x2ayE+0T6CGu/kSL93eSIpgLEAX5yM
	cs1vveiaOfc/iParMi3DoA8FWypW0wm1qzSQDOXJ3YIDAWm4bYGPW8Nojr84A2JUGLEr/aCDfOH
	wtmxoT3dl8Vd+zKHPqvhVFB/CXSw4bJaYXJU/gmEbve2X6d081Y9kl4WpTeOZ7Ai+ZNJNo0DMyQ
	TC3Ix9wa5k0vtlPlnSP6LhPzEzPn8Pd2fALRXmWh7lUaNeGB0vzD8yEHdVXZxyT3Kk93FXZdWnd
	kZ8OTt2CPE5B5RmcvCCycOpnwqmxkIWVhW6u21ZCIDoLmsfo82aYXQ+lzTc6I//Ohok2iXnXF83
	a24WrKV75O3M6ie3kJKTfrP6FfoQ++4X12HriopKtWWO0aBpar8waZI5wrvLVN5SR7fJcYUx2E0
	B3eAnYWcdbLLk0/Ue0Ms/bmh5XpcW0DRLyxC+wkOxXeAsTE4YknzwWBMw==
X-Received: by 2002:a17:902:fc8f:b0:2c6:5bae:f9ab with SMTP id d9443c01a7336-2c718f65447mr104983075ad.22.1782017458605;
        Sat, 20 Jun 2026 21:50:58 -0700 (PDT)
Received: from kapoor.mahindrauniversity.edu.in ([122.184.65.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aa5f1sm44061025ad.78.2026.06.20.21.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 21:50:58 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [staging] staging: sm750fb: rename pvMem to vram and pvReg to reg
Date: Sun, 21 Jun 2026 10:20:50 +0530
Message-ID: <20260621045050.63460-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix CamelCase issues reported by checkpatch.

Signed-off-by: arnavk23 <kapoorarnav43@gmail.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 19c3da654..125ad1062 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -622,26 +622,26 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->vram;
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->vram;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->vram;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->vram + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -649,7 +649,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->vram;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -657,7 +657,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->vram + crtc->o_screen;
 		}
 		break;
 	default:
@@ -755,13 +755,13 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->vram + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor)
@@ -1028,7 +1028,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->vram, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1059,8 +1059,8 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
-	iounmap(sm750_dev->pvMem);
+	iounmap(sm750_dev->reg);
+	iounmap(sm750_dev->vram);
 	pci_release_region(pdev, 1);
 	kfree(g_settings);
 }
-- 
2.53.0

