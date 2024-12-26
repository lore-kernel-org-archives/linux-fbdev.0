Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7114A0BC;
	Thu, 26 Dec 2024 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735180098; cv=none; b=N0xQrxJ/uT46qoTjl8h8RL/tjs28UksM/FbZwipUB84o21r+iOqzuCEfYXGViY3LmpF9uHvX/Xrr1DYB3Zu7VXOv+P8WAkC68SKzpkbqRMleE/CfJ12TX+yQKQI5J+iJfpUcRAQUXbSldWFn6LU35Csok+ZkXSqO4l1AjYkVXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735180098; c=relaxed/simple;
	bh=cACDnPioAgBuHuOikatqK1RNjbYawNrFuz90HUF5fXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWABgdMmjyCogxBtN51BiXkQIFuOIpTTMjM5IvzBDC5FMtDtxCo4qwJ4V5I26lJ/hJPymuxH9AKaS0Kr9s5zxD4kbDFLWwK5pmQP3LDRwAB7q0URkwREsiFEX9jDFsLfWgiQFT7r55TPooFZ/2LMMqT0YLdJVKZI1iKHDyvPU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Eevo40RW; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Eevo40RW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=8oqYD/B3UMlO69nH16a4qOpq5t9+uPPTLogH0zzGwks=; b=Eevo40RWUifZuus8
	s48V+jvzoplAN44z3+2xITvRxcWrZODQotuSNCN8wjQZybqro18vPFkZgTbEAYY235W6LwC57qM0D
	dpOdCBNN7PDJKRu9/yia/r984fVZljCpIJLXNEbIa71EQfRv66ll2UPeFeYN6r0XcLzuJBuEFjcAA
	Orxi5NXo7PFbANyaAqxZDDIkL70ou2H+gmTU/LBgBb6NSDiUE61Mf4r4ZqSijCM3VZLWZAHJngA5B
	8p/Lx6Sm+y23DjoDBG5Lqwcc08wY5/4H6y/CDracxO4tbiTPnV4PXOIv2htKKk8EMyo0q2EH1hoj3
	XQQRX5RXR+LOz2Lmog==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQdbO-007F0L-17;
	Thu, 26 Dec 2024 02:27:54 +0000
From: linux@treblig.org
To: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	deller@gmx.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/7] gpu: ipu-v3: ipu-ic: Remove unused ipu_ic_task_graphics_init
Date: Thu, 26 Dec 2024 02:27:46 +0000
Message-ID: <20241226022752.219399-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241226022752.219399-1-linux@treblig.org>
References: <20241226022752.219399-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

ipu_ic_task_graphics_init() was added in 2014 by
commit 1aa8ea0d2bd5 ("gpu: ipu-v3: Add Image Converter unit")
but has been unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/ipu-v3/ipu-ic.c | 73 -------------------------------------
 include/video/imx-ipu-v3.h  |  4 --
 2 files changed, 77 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-ic.c b/drivers/gpu/ipu-v3/ipu-ic.c
index 846461bac70d..acd76ecc5221 100644
--- a/drivers/gpu/ipu-v3/ipu-ic.c
+++ b/drivers/gpu/ipu-v3/ipu-ic.c
@@ -321,79 +321,6 @@ void ipu_ic_task_disable(struct ipu_ic *ic)
 }
 EXPORT_SYMBOL_GPL(ipu_ic_task_disable);
 
-int ipu_ic_task_graphics_init(struct ipu_ic *ic,
-			      const struct ipu_ic_colorspace *g_in_cs,
-			      bool galpha_en, u32 galpha,
-			      bool colorkey_en, u32 colorkey)
-{
-	struct ipu_ic_priv *priv = ic->priv;
-	struct ipu_ic_csc csc2;
-	unsigned long flags;
-	u32 reg, ic_conf;
-	int ret = 0;
-
-	if (ic->task == IC_TASK_ENCODER)
-		return -EINVAL;
-
-	spin_lock_irqsave(&priv->lock, flags);
-
-	ic_conf = ipu_ic_read(ic, IC_CONF);
-
-	if (!(ic_conf & ic->bit->ic_conf_csc1_en)) {
-		struct ipu_ic_csc csc1;
-
-		ret = ipu_ic_calc_csc(&csc1,
-				      V4L2_YCBCR_ENC_601,
-				      V4L2_QUANTIZATION_FULL_RANGE,
-				      IPUV3_COLORSPACE_RGB,
-				      V4L2_YCBCR_ENC_601,
-				      V4L2_QUANTIZATION_FULL_RANGE,
-				      IPUV3_COLORSPACE_RGB);
-		if (ret)
-			goto unlock;
-
-		/* need transparent CSC1 conversion */
-		ret = init_csc(ic, &csc1, 0);
-		if (ret)
-			goto unlock;
-	}
-
-	ic->g_in_cs = *g_in_cs;
-	csc2.in_cs = ic->g_in_cs;
-	csc2.out_cs = ic->out_cs;
-
-	ret = __ipu_ic_calc_csc(&csc2);
-	if (ret)
-		goto unlock;
-
-	ret = init_csc(ic, &csc2, 1);
-	if (ret)
-		goto unlock;
-
-	if (galpha_en) {
-		ic_conf |= IC_CONF_IC_GLB_LOC_A;
-		reg = ipu_ic_read(ic, IC_CMBP_1);
-		reg &= ~(0xff << ic->bit->ic_cmb_galpha_bit);
-		reg |= (galpha << ic->bit->ic_cmb_galpha_bit);
-		ipu_ic_write(ic, reg, IC_CMBP_1);
-	} else
-		ic_conf &= ~IC_CONF_IC_GLB_LOC_A;
-
-	if (colorkey_en) {
-		ic_conf |= IC_CONF_KEY_COLOR_EN;
-		ipu_ic_write(ic, colorkey, IC_CMBP_2);
-	} else
-		ic_conf &= ~IC_CONF_KEY_COLOR_EN;
-
-	ipu_ic_write(ic, ic_conf, IC_CONF);
-
-	ic->graphics = true;
-unlock:
-	spin_unlock_irqrestore(&priv->lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ipu_ic_task_graphics_init);
-
 int ipu_ic_task_init_rsc(struct ipu_ic *ic,
 			 const struct ipu_ic_csc *csc,
 			 int in_width, int in_height,
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index c422a403c099..0bb1d714cbf5 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -445,10 +445,6 @@ int ipu_ic_task_init_rsc(struct ipu_ic *ic,
 			 int in_width, int in_height,
 			 int out_width, int out_height,
 			 u32 rsc);
-int ipu_ic_task_graphics_init(struct ipu_ic *ic,
-			      const struct ipu_ic_colorspace *g_in_cs,
-			      bool galpha_en, u32 galpha,
-			      bool colorkey_en, u32 colorkey);
 void ipu_ic_task_enable(struct ipu_ic *ic);
 void ipu_ic_task_disable(struct ipu_ic *ic);
 int ipu_ic_task_idma_init(struct ipu_ic *ic, struct ipuv3_channel *channel,
-- 
2.47.1

