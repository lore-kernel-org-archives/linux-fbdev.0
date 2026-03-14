Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC7628850D
	for <linux-fbdev@vger.kernel.org>; Sat, 14 Mar 2026 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475805; cv=none; b=NsMKNwFVWCg+bv8RrosAeX1T+YI93nrYS1Dw6emW0GP7v551j7Uw0AtOMpIvE9SqI31IOPRyZ5sHZss1/3gZgTMcRz8R0Da0ijEEMtFeexn8TLHxG4gMmv/tt6bd6y6WkVS5Qlca7KoSZSQtzLTz9pFFuD4ycGx2T7DOBesvnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475805; c=relaxed/simple;
	bh=u73qQwGF5sga5NfxOUpUjAEhQky3bXwXMtnc3QKj0P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZfPgi6cpw7mHcXhrHfA9Xk6ScQ40oX1lMVExCx0HpV22Q0AZBkVBbqDqigwKkOHGnBxAXhkjiTSXYGBQLcPN+yVBxtUo1Pc/Qon2WbD9qnC4f+E+LGJhwC45upi1EvB7VD/20L9bIMQk4CzPZ0TYRWk0Twcbj7BT4B74q9ohEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFZMkKuO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFZMkKuO"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c739561f0d3so1815766a12.3
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Mar 2026 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773475804; x=1774080604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeIgkxwl9JJwWuwyECyvmWjJWhOSc5N2s3Zcd0cjeZo=;
        b=DFZMkKuOFrnF/S2cuJczdS89ESKcrsKbTk9Pw65SgM2EITzWl+oFz69BkW58dhM1Rc
         TuofP8uMU7iF3IKjY7VQU8ZZ46eFeTC66Un3eZlOvWsAtGEk8lWIgYIRmHYV8z4s/QZO
         WH1te90E6j0H39DHWwM55sTEL1tgHWfybICWIlbJVoK5afJcD9A5gadiBs1lg3AXqDy1
         MFasAU6hKOB1JR54Sx6VDFu3YOQzpr/854guUP9vucASdl6yKAToUyTi0ngXTqtyPCkR
         JyaFuEKCyk1yXelyeEGfb8FbaN7LjZU7TvqT3FGsGSRPxmKc+O36Nk9F+u15CBuH1sMb
         XJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773475804; x=1774080604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KeIgkxwl9JJwWuwyECyvmWjJWhOSc5N2s3Zcd0cjeZo=;
        b=R5GdzcQIXSUrmMw2VHlO3oStDV4exBZWNEo8V8K40enetAjb07u0BPwwAbASlRqkmn
         yHBLgao08hbHfJBcgiPBu92SrUIvOae8+3Yip7Oaa4/eTothg0xreF8cMN7lkFKolzPs
         DcOKXHLSNbKVNxUibFW7+SuW2GZ7rAzMpFSqMuKN2bYL0c8lIJwuNwtQY6VkuwA52qT1
         E9EeEbjmACPXpLFePCU70M1ETGd34+AnvB/wTDdi82WUOr21s3mkXj28zgtRrf9LkQQI
         7Y0ADnlMmWrowIbv50vrm+u3a2gKlAvUfp99k81MOZlTV2EhOn8GvzjnfE9EACbWVLzQ
         KJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUthYUGk+SMcEBP5ew5pjPMYJmS1/ugUrWqPzY+fCV1jma1ZlnIBXdWCwnn2sRRvFgRpzQWG/LHGSlPPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6P0ENZ+/Ux/EoVY0lVnMvKfbjy3ObP5TNCqNYB0nvCw3oPV7v
	/JwZsEvzRM4iZRbiy39Fbf1WR3mox87EtpwV+ubodPBSuapIYSIyzyyd
X-Gm-Gg: ATEYQzxso/dDi3iazWxHuX7cVb+KWVMw+CHPqL/McADRcWzE6SYKDj4qfCVw2YCi3g/
	VKxeE8AI3Abz8nT17LLJYhpDHW5ecOa8jZeVRzOsW9uvA3lfz8JhdeM8OG3oFU3LdMNPlURvxPi
	4PJq3ppbgTMc8d2MCoZbXohGhWnTlKMdB0TIs/DyuTHpE0oSEyk3OJNC48eM56n/FHMLxXtjOeN
	DwadeYvI5HM40GdOBeJjLBL0ISSIskofMhb6KfNg4uwbL+zfhHRuXNThZAQssYVIVu2lsbt9ahb
	IB5BarINoNcbfVvnPdr5oLOAPpmLMf9PQXIH8a+xBgW5VXkKfXs0AjIfYzeJd6Opq7mm0V3U6B+
	p/VHnfNBUHCGDVlUHUVTfNjDIkn/MkgoEpaVhTCfsRWewC4C/Cm9SlC3+7VIo5B1cBTRotysk2m
	pZp4jUpCoQIi0zkVQ9Vsr1TY6qq93jMlc4
X-Received: by 2002:a05:6a21:50a:b0:398:9662:110d with SMTP id adf61e73a8af0-398ec9ebaa2mr5649068637.4.1773475803657;
        Sat, 14 Mar 2026 01:10:03 -0700 (PDT)
Received: from fedora ([2409:40e5:1052:9a56:d0d2:2da5:541:7e3c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb9966d9sm3665378a12.11.2026.03.14.01.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 01:10:02 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH 3/3] staging: sm750fb: Rename struct sm750_dev members to snake_case
Date: Sat, 14 Mar 2026 13:39:32 +0530
Message-ID: <20260314080934.135457-3-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314080934.135457-1-chakrabortyshubham66@gmail.com>
References: <20260314080934.135457-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename CamelCase members pvReg and pvMem to follow the Linux kernel coding style.

Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 22 +++++++++++-----------
 drivers/staging/sm750fb/sm750.h    |  4 ++--
 drivers/staging/sm750fb/sm750_hw.c | 20 ++++++++++----------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c30ffab8a5f3..1c60ba056719 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -624,27 +624,27 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -652,7 +652,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -660,7 +660,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -764,14 +764,14 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->pv_reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->pv_mem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor)
@@ -1090,7 +1090,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->pv_mem, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1121,8 +1121,8 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
-	iounmap(sm750_dev->pvMem);
+	iounmap(sm750_dev->pv_reg);
+	iounmap(sm750_dev->pv_mem);
 	kfree(g_settings);
 }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index b683a82af349..3f6570fc8f08 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -97,8 +97,8 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pvReg;
-	unsigned char __iomem *pvMem;
+	void __iomem *pv_reg;
+	unsigned char __iomem *pv_mem;
 	/* locks*/
 	spinlock_t slock;
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 0e594734a8b9..32b3813d0d8b 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -49,19 +49,19 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg =
+	sm750_dev->pv_reg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->pvReg) {
+	if (!sm750_dev->pv_reg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
+	pr_info("mmio virtual addr = %p\n", sm750_dev->pv_reg);
 
-	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->pv_reg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->pv_reg + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pvReg;
+	mmio750 = sm750_dev->pv_reg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -76,15 +76,15 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->pvMem =
+	sm750_dev->pv_mem =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
-	if (!sm750_dev->pvMem) {
-		iounmap(sm750_dev->pvReg);
+	if (!sm750_dev->pv_mem) {
+		iounmap(sm750_dev->pv_reg);
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
+	pr_info("video memory vaddr = %p\n", sm750_dev->pv_mem);
 exit:
 	return ret;
 }
-- 
2.53.0

