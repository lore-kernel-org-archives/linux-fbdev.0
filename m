Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554364503ED
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436029; cv=none; b=XjkwbdbrZ3H4LSnBLqezpufisMoSY9IWjVxwWRL9y+86DHiybAOyOnuJ0Dze9BBBsZemEWcoZRwiJ+R453sJVHCkVGsAoNM3Sp++akBlFmBFVlBNRc9s9FA2HnpmeeiZFJ+tk3MfKRjNrZmAmbh5I9XPtRRVBo3oUYwaqS8YAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436029; c=relaxed/simple;
	bh=mVWNu8udQkQmCQXSKJpUI4apjIY+TWRoqvpgS5P3PnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRwD4HgIScWcLUeybK8x/I3D01LHHYHZx0BTnLCvphLBDAxQiBOfdOm1bxMK7PD9C4L2Ph24ix5t6XDO5hHzGtLW0c0sPzgF1I0tuVVNOI+pxhBcmH9czJW887rRRzZfbDoHvfb4lIjp2d6BXqtdjFh61R5jq+rNdqmaSheQ13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=jL+LIKgF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="jL+LIKgF"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485ef63b68so252539b3a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785436027; x=1786040827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gtXncMJulG5/IdvNqALd27aEfY4Cg64b+rocTENNNEg=;
        b=jL+LIKgFU9sjNj/jMeNlvtayOCDbZkdTCMJ5oa2nIHK/N/AEIVzCpwl+mV4w2zKVcf
         b5krauyvq902hjZvzD1Cy7SgAUwdZLSmSYD6cpctOj/JLd9cd0aunbl6beezgdTEy8Bz
         Jo1QzVfs6OZPSp096m1/x8NIvDPzsowt8J/D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436027; x=1786040827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gtXncMJulG5/IdvNqALd27aEfY4Cg64b+rocTENNNEg=;
        b=F7Hx7YxtcQ3bN/2TIdviLhznGp4S5eFo+Z3NxmwSqpl4NN90cevGxeouzYzJoKz5+5
         Clkmh4E9WiAuVge0ipRDyEBrW/sWMsg0SStzOE0RhE2Kbdy2/On/Sd5OBIMWyoUiGxzT
         i3t5lLUwMWXxu5YwD+9qzM0XxS9+jQlCa+wG1Qiwbiq1OENxO1oylCJydtGoV0gwarjz
         Tq7wuJf6EQWE7w1r9TXs8ZUSaT0vqHp38BDPwVzh0kRZ0AhhYlTg9NjC350QO/70heMI
         RN5LcW0B8agZe21k11bX64C8E2zLie1iNvqZe4/T0Aih9BHuvJGqQTxrnaDmN6H8WqI7
         WZMQ==
X-Gm-Message-State: AOJu0YwUWK0he8UsZkipXMAQ4NtTMRhYGYL8swGSr/m4/g7XshibxPs0
	/UKHqZztj+MdofMv54m6ezGZ30QZ/dE8nMqKi7zReE0DOy4W1V+DJqd9TEVeIUGzPF4gk2FDwo9
	OvZei
X-Gm-Gg: AR+sD10C5Yo996wgRSW94jvH8eXxmQHC8IzQftjDKDXViIuVA8UkAO1yvKFqUyBam+D
	yW1vZg5Sz4tUhho+FfJ9DeUibG58efGYQ5a7zCZPXKJW2lmQND8rGe1qqf7CGugsdtykOwKqtKN
	1TGkQTLF191AS/6h/5j7h0sZ82Xpl6oqIszrneFTNg6wqcSNQ9dTjMfUkdCAhoN9iGphJxJs7+E
	tbvLT8PjY7b9Gvk5BvagVns/LLop5DJvkiyc8ctGmDMSjPnraNIdoJHq/pu6BPxjLTrXslKfibx
	frnWYD01YXC3CarGmPaqMhu5EMgQ/W632tb4l2qgzAKkwVaJ9W8HzdFu4ajTENgC2GtPd8eJWwv
	YkUVz2tpx8hD2CbbwN9gvr+FFNE6qLc36Z7kVP0tYqk6wvkhwGGjhkPpHBkb7c2QinyfcVGvAut
	WxGlaP2l7vfsnHv79Z++PQhkYUbYhf/icbjmMT0KtlkzoHMBXuufA=
X-Received: by 2002:a05:6a00:b8d:b0:845:363e:12d9 with SMTP id d2e1a72fcca58-84ebc1f01c3mr3502734b3a.3.1785436026696;
        Thu, 30 Jul 2026 11:27:06 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:27:04 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/5] fbdev: tdfxfb: Manually boot unbooted cards
Date: Fri, 31 Jul 2026 03:26:38 +0900
Message-ID: <20260730182640.2808572-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182640.2808572-1-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the card is detected as being unbooted it isn't too difficult
to use the config table in its BIOS to fire it up so do it.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 56 ++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 1d8bffe1e9fd..4c1d847c89c9 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -67,6 +67,7 @@
 #include <linux/aperture.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
@@ -414,19 +415,62 @@ static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
  * Try to work out if the card was booted or not, just checks
  * if the register reported memory amount matches what the BIOS
  * reports for now.
+ *
+ * If we have a BIOS config table attempt to manually boot the
+ * card if needed.
  */
 static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
 {
-	struct tdfx_par *par = info->par;
+	u32 mempll, gfxpll, draminit0, draminit1, miscinit1, dram_mode;
 	struct tdfx_bios_cfg cfg;
+	bool have_cfg = tdfxfb_get_bios_cfg(pdev, &cfg);
+	struct tdfx_par *par = info->par;
 
-	if (tdfxfb_get_bios_cfg(pdev, &cfg) &&
-	    tdfx_inl(par, DRAMINIT0) == le32_to_cpu(cfg.draminit0))
+	if (have_cfg && tdfx_inl(par, DRAMINIT0) == le32_to_cpu(cfg.draminit0))
 		return 0;
 
-	dev_err(&pdev->dev,
-		"Card hasn't booted and is unusable\n");
-	return -ENODEV;
+	if (have_cfg) {
+		dev_info(&pdev->dev,
+			 "Manually booting card using config table\n");
+		mempll = le32_to_cpu(cfg.pllctrl1);
+		gfxpll = le32_to_cpu(cfg.pllctrl2);
+		draminit0 = le32_to_cpu(cfg.draminit0);
+		draminit1 = le32_to_cpu(cfg.draminit1);
+		miscinit1 = le32_to_cpu(cfg.miscinit1);
+		dram_mode = le32_to_cpu(cfg.sgrammode);
+		tdfx_outl(par, PCIINIT0, le32_to_cpu(cfg.pciinit0));
+		tdfx_outl(par, AGPINIT, le32_to_cpu(cfg.agpinit0));
+	} else {
+		dev_err(&pdev->dev,
+			"Card hasn't booted and is unusable\n");
+		return -ENODEV;
+	}
+
+	/* memory clock, and the graphics clock if the card wants one */
+	tdfx_outl(par, PLLCTRL1, mempll);
+	if (gfxpll)
+		tdfx_outl(par, PLLCTRL2, gfxpll);
+	/* PLL lock */
+	udelay(100);
+
+	tdfx_outl(par, MISCINIT1, miscinit1);
+	tdfx_outl(par, DRAMINIT0, draminit0);
+	tdfx_outl(par, DRAMINIT1, draminit1);
+
+	/* Make sure the DRAM config is applied before continuing */
+	wmb();
+
+	/* SDRAM/SGRAM wake up: load the mode register */
+	tdfx_outl(par, DRAMDATA, dram_mode);
+	tdfx_outl(par, DRAMCOMMAND, 0x10d);
+
+	tdfx_outl(par, LFBMEMORYCONFIG, 0x00001fff);
+	tdfx_outl(par, MISCINIT0, 0);
+
+	/* Make sure the remaining config is applied */
+	wmb();
+
+	return 0;
 }
 
 static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
-- 
2.53.0

