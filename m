Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B31553A3
	for <linux-fbdev@vger.kernel.org>; Sun, 24 Aug 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756049021; cv=none; b=Xwi7LFIHAmreviONHMF+HcWT8Z9GV9guzsM8L4iKwxEQi4Uds2mgJCnnvVwLuO3NubJ5XlEiN7tTxUpC3ScYaaJLaY59ruwdSM82go/lRtf3bgqgffNwpGlqNNRfNma7OjjChM39jpjuUiRcAPRQnDZICw9XIp9lcU6YtiZ4l1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756049021; c=relaxed/simple;
	bh=BS5AwrrZ8iknY39/GqdKkelwJWB5pMe1PSkptrHtYQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uyr1LEqDQjdfTWBm6VGF9lx0j708KncDHivr+wNQ+c7kfckpBmjfVWX90kqu5Wt0F2EHoLDBz34LvRVKt10jZ1occw8ZBSsTdtlD7bVtZGLl5u2BD+TtAoxf5Y/xQt6/wQ82LiLIXrgAYp/YvthtSIm7us+uCzzpGVQLisTlYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5czlA2u; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5czlA2u"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b1099192b0so64098751cf.0
        for <linux-fbdev@vger.kernel.org>; Sun, 24 Aug 2025 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756049019; x=1756653819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4EbcOf2LhfDb/WvZfcB3qbTMY0IghRJsrEw4IQnZ8=;
        b=S5czlA2uCZRuh04kg52kedF8pQt0j6dLKTb5YSjCfJCobNMYo0mJd33qi/BGCOGLzX
         PWVIlMYx4IDNmjhu2H6b30j4m5VJ4lawbNIHrGEd+v82sGMoi8KxkLzBBUz3lluq44oy
         DO+JVOuGGLDiL6UYThMiESXENDmXsIs+g7BKU+l7nNrVulOlCyLCiUZou+YBMNx4h3bF
         ufzaqStlQ9maaeuqLC96DqmMVxpVGlut7K0NrKmHGZkegK12A0SjkvNIMtVXg9q1xggQ
         UQ16bVSROCCjQxCCLR/EgAQzBVGBaWzHOVQZDCbVx+2ZMciNLgLUD2BO/BZqqo4LLAso
         dU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756049019; x=1756653819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1J4EbcOf2LhfDb/WvZfcB3qbTMY0IghRJsrEw4IQnZ8=;
        b=PVVU3PZIB51g3vVJZKFdAu2pNHDBxfWHas0O/kcTCnJPys4slbZzYsr9AjfzH9z7H7
         /XUVR0+Ak2fUiQJRSmhlhCs8UDuI/734zb07p/9oLxwIjIvPXFhgTuNeHcmlBmTrOamw
         uIqMGaTRTiQvHPL/ei81r8tycEThYrl+qsFyW84371HFJyW/eBmCILog5Hco+tNVRT6j
         RM43mYJOoqLh0FXJ486zOiK/AqK5UVdGQza2MRC930R+2UTEvEqQg/7RuAtU+ZgQh2iV
         GqR/2nKGt8Z31E50g+omt5+lTVu3ENiAWEkx81J9iU9zTfQh1sbAPE4Fy4T2Z7RrR9oG
         AJoA==
X-Forwarded-Encrypted: i=1; AJvYcCV1VvkiLVgMrizIJywo2b338Snnr3sTBMCv0jMHfXs6GHKd85cxpwG7dAHtHO1WVok/yq0Ox+vLho9rVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo39eMWB4KHX3G8nw3fJjlprzqhBpuE1b+db4xjHv1kvtb6KNB
	3OvqWBRn/nT34OgRs3FR7y6nvqYAA9nBa75VkWhKIqRxLR8bRbUbGa8ct1psJ6xZ314=
X-Gm-Gg: ASbGncuplyC9YIAwZ/gn82+Zd0YD4JS7VqHS/sCu0XECcamFyUvL0GLNzdnlxuDf311
	4xsxJsQL9F+gCAtedP9S8PsdpEQn0C7syH54JOXR1Dox3OZJaE9Lyc8khoXHj0xdPQUxBfHt2kA
	VMER1B9lMREpbf7VbB63KCmM1DIEKwy1zs2oWeeagY55ZkDh1ycbjCf9ON6z3IyfBfe9GPHSpuI
	L5Ck+OUmVjgiHY91nW728DYDfkNhq8yoDYONYlv1JIPcGM7DR0EWbYsnkqFWCX1E7YfUsMpz/NB
	YQn+Qq1DIMRjkrk+jw31QVyxggd1IMoEKAW5dyWnWvXudTecO1w2MNIWxk5jBqedjfOJi99HCHk
	U7f+7dum+7+gFQKlvMKiv9aDB7JPkylWLX6acZpnGMCZ6pft8ayDWwf4HvQ==
X-Google-Smtp-Source: AGHT+IHa6yPvn+nHszvBp9rYLUGeFHo/D+GxPGScD6pQMA3XTmHN3fGBTgq3bBxfFIJ5AsF0ZnnlsQ==
X-Received: by 2002:a05:622a:1a89:b0:4b2:992b:c88d with SMTP id d75a77b69052e-4b2aaaa67demr105454991cf.20.1756049019009;
        Sun, 24 Aug 2025 08:23:39 -0700 (PDT)
Received: from cr-x-redhat96-nsd-2.fyre.ibm.com ([129.41.87.0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e502cfsm33859801cf.49.2025.08.24.08.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 08:23:38 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: simona@ffwll.ch,
	deller@gmx.de,
	adaplas@gmail.com
Cc: raag.jadav@intel.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] fbdev: Use string choices helpers
Date: Sun, 24 Aug 2025 08:23:27 -0700
Message-ID: <20250824152327.2390717-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use string_choices.h helpers instead of hard-coded strings.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 drivers/video/fbdev/core/fbmon.c    | 7 ++++---
 drivers/video/fbdev/nvidia/nvidia.c | 3 ++-
 drivers/video/fbdev/pxafb.c         | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 3b779c27c271..0a65bef01e3c 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -36,6 +36,7 @@
 #include <video/of_videomode.h>
 #include <video/videomode.h>
 #include "../edid.h"
+#include <linux/string_choices.h>
 
 /*
  * EDID parser
@@ -320,9 +321,9 @@ static void get_dpms_capabilities(unsigned char flags,
 	if (flags & DPMS_STANDBY)
 		specs->dpms |= FB_DPMS_STANDBY;
 	DPRINTK("      DPMS: Active %s, Suspend %s, Standby %s\n",
-	       (flags & DPMS_ACTIVE_OFF) ? "yes" : "no",
-	       (flags & DPMS_SUSPEND)    ? "yes" : "no",
-	       (flags & DPMS_STANDBY)    ? "yes" : "no");
+	       str_yes_no(flags & DPMS_ACTIVE_OFF),
+	       str_yes_no(flags & DPMS_SUSPEND),
+	       str_yes_no(flags & DPMS_STANDBY));
 }
 
 static void get_chroma(unsigned char *block, struct fb_monspecs *specs)
diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index cfaf9454014d..72b85f475605 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/console.h>
 #include <linux/backlight.h>
+#include <linux/string_choices.h>
 #ifdef CONFIG_BOOTX_TEXT
 #include <asm/btext.h>
 #endif
@@ -622,7 +623,7 @@ static int nvidiafb_set_par(struct fb_info *info)
 		else
 			par->FPDither = !!(NV_RD32(par->PRAMDAC, 0x083C) & 1);
 		printk(KERN_INFO PFX "Flat panel dithering %s\n",
-		       par->FPDither ? "enabled" : "disabled");
+		       str_enabled_disabled(par->FPDither));
 	}
 
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index baf87f34cc24..b96a8a96bce8 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -60,6 +60,7 @@
 #include <linux/soc/pxa/cpu.h>
 #include <video/of_display_timing.h>
 #include <video/videomode.h>
+#include <linux/string_choices.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -1419,7 +1420,7 @@ static inline void __pxafb_lcd_power(struct pxafb_info *fbi, int on)
 
 		if (ret < 0)
 			pr_warn("Unable to %s LCD supply regulator: %d\n",
-				on ? "enable" : "disable", ret);
+				str_enable_disable(on), ret);
 		else
 			fbi->lcd_supply_enabled = on;
 	}
-- 
2.47.3

