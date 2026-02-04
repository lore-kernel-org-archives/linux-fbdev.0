Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E93ED13B
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206766; cv=none; b=qcI42FwNnseaey9GraRd2Pe7pCdS11CvWZP2O5NPGDNDYuDNv9b3Tyc0V5znW5I0v6iyTP26aKZowz0ss4nxWLnt8DaYnVNasOATo7kuS9MgrT7/3bFMjQva2l/JQuFTxNKxGmxwOg1k28DSry4V2IlF47gxhEA+grjp3i8qkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206766; c=relaxed/simple;
	bh=DiQrtXvSp9eCQt1h9ogElyp0Cqb3r6cauWeWpSKCUzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0hO0ye6eruboCrZSRjMCrBUwJKV9in4vDeMkVkic7a7ojOtX/aivLdKmvGbH4HzSIJ49pQU38tN5XATA4k/RBaYMsZ8EaTzaBa8An8UrA8ba3EOh/PlZQds6qefeT0ch23WlM4lIvdpZs4KGWjePuVSiCrFDUtoZFSxGlbilwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9z61FxB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9z61FxB"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b884a84e655so986187266b.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 04:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770206765; x=1770811565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8d7hAmMNj9Zk28HsG7cVWd/Fe/+w30W4GTBLy42O7s=;
        b=U9z61FxBqPA4f+1d7sYhWOrVa4QbTHXwzV04hh5XUHmFNoXrXOTdEEl9GVs+i2+ZRI
         Tv+TlXauO3La35/2VhKsFAerZ+k5pvoeGPeiJiTZjpZ52+v+B3C6jIWbXAoOoqD6Buum
         wrRZDqVs+orzKMSpAAGl9+hxEPtneHUbayt8O4CwDBHdtQ4MWhOzMXZhPxb/j5gJPaus
         kTzV+OHKHNsAdndj6LagnF2ttio7dAaszWp3gtnnm5UqshAJmjCoKGpb+PCOl/a/tAlP
         e3TvAuHrzLstjaaMmg1roGseD3yl8RAeinHo1Hm2O2ALjd0/hcO4RgTLJbXpGnhWfg1I
         x1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770206765; x=1770811565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8d7hAmMNj9Zk28HsG7cVWd/Fe/+w30W4GTBLy42O7s=;
        b=ac0UETQTaPsOwoLUDLeUTqSm+MsMO60nhP/8gA+LxZ9yFyH6wHTbSdnvPXgZJd9HGI
         p0QzqDw5zHiWdLsd79cQdIsJO18XGLSQxznncp0yLbs2e/U7ndKDO/+iW0HhkfAC+9q9
         NK+nn0ZylFxEkkBcaz2eROkUf7RejWveCEaAXa0GTwLENckPGJuhSzRgYvD7L2eRE1gB
         vTKQHyAKnIIEa3O+PoXXMK82kwYQwWUMLMO0b1oKRm7bbtENHtMRugvfPtfPo5Uc7Upp
         S9MlSgcL/wPoZ4ubmE/Cf+2iYD2tzqiCZ7RRoLrri/lBARvioifUnmI5lbLdyjgGVIcG
         j/zw==
X-Gm-Message-State: AOJu0YxC6dp5GUPuR/q4HUeOuMK7rZjzeOl43UlAZns3NIH94EmLOUBd
	fEobwGCNKXSmFef/M9pQOhQal0rt0Wa67pKWn1AY2EhBvG4dfobiYYNK
X-Gm-Gg: AZuq6aLHY9ly4Fzd1eYu/K1ylAyY8GZXguthA3Np/aLwdPq9CnTBrZ3X2a8CsH/ADqd
	GtTkZTvPiJ9xvTfpTtGNrApwvJr0DqwWEFbDKBOpqrMlm5fqNk7YhvrcU8vh+G9RbBJCQOJKeK0
	CaDCibjIYB0RwMlp97dG3VCOmAYGVOVXpekiH03kF1ZxEei8tGIUy3Z8Z+FUmzKRiJ6MuHJ5mqR
	D7Mlwa7hRlusf0z9hzoedELD6xATxqTPu7ONvD/l7rX5tdDod1aVw5EHX9muaiKKro1xwzg4c/K
	NYglD1A3AaW+MX2uF2g/51FxFwTj7OwiGq/59DIlm8gVrcrCZ/QDwLIPK+QAofo1s8QOWpjB/0A
	seK0oNLjYbnLSjboYKclr5GVeXBtHmq2uQMYnrT0dxZNnr2RCagYDRQvE0LKp5mZej1IDkmEryE
	vl5XLS0c7nuKdAO6kELAJU3qrKV8b0549dsj2fjsdYXk8R3Vj6+UeEZj/sqCjz0KP8m5BN0pzgs
	IQzN/IuGa5XWXpgw4CQFib1njlcrd2BaeLkZjGSN7h772R4asgxhO7XO5w=
X-Received: by 2002:a17:907:72d0:b0:b87:6:371d with SMTP id a640c23a62f3a-b8e9f42bb01mr200801866b.49.1770206764658;
        Wed, 04 Feb 2026 04:06:04 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.od237066db22328bb-tp.internal (216.79.91.34.bc.googleusercontent.com. [34.91.79.216])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fcd8be3sm117979666b.10.2026.02.04.04.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:06:04 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v3 4/5] staging: sm750fb: convert logging to device-based in sm750.c
Date: Wed,  4 Feb 2026 12:06:01 +0000
Message-ID: <20260204120602.6715-4-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204120602.6715-1-iprintercanon@gmail.com>
References: <20260204120602.6715-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert remaining pr_err and pr_warn calls to dev_err and dev_warn
using info->device where struct fb_info is available. This provides
proper device context in log messages.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 050408af2..1561fa5fe 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -388,7 +388,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
 	if (ret) {
-		pr_err("bpp %d not supported\n", var->bits_per_pixel);
+		dev_err(info->device, "bpp %d not supported\n",
+			var->bits_per_pixel);
 		return ret;
 	}
 	ret = hw_sm750_crtc_set_mode(crtc, var, fix);
@@ -487,7 +488,8 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	ret = lynxfb_set_color_offsets(info);
 
 	if (ret) {
-		pr_err("bpp %d not supported\n", var->bits_per_pixel);
+		dev_err(info->device, "bpp %d not supported\n",
+			var->bits_per_pixel);
 		return ret;
 	}
 
@@ -502,7 +504,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	request = ALIGN(request, crtc->line_pad);
 	request = request * var->yres_virtual;
 	if (crtc->vidmem_size < request) {
-		pr_err("not enough video memory for mode\n");
+		dev_err(info->device, "not enough video memory for mode\n");
 		return -ENOMEM;
 	}
 
@@ -527,7 +529,7 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 	ret = 0;
 
 	if (regno > 256) {
-		pr_err("regno = %d\n", regno);
+		dev_err(info->device, "regno = %d\n", regno);
 		return -EINVAL;
 	}
 
@@ -793,21 +795,23 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 				   pdb[i], cdb[i], NULL, 8);
 
 		if (ret == 1) {
-			pr_info("success! use specified mode:%s in %s\n",
-				g_fbmode[index],
-				mdb_desc[i]);
+			dev_info(info->device,
+				 "use specified mode:%s in %s\n",
+				 g_fbmode[index],
+				 mdb_desc[i]);
 			break;
 		} else if (ret == 2) {
-			pr_warn("use specified mode:%s in %s,with an ignored refresh rate\n",
-				g_fbmode[index],
-				mdb_desc[i]);
+			dev_warn(info->device,
+				 "use specified mode:%s in %s, with an ignored refresh rate\n",
+				 g_fbmode[index],
+				 mdb_desc[i]);
 			break;
 		} else if (ret == 3 || ret == 4) {
 			continue;
 		} else {
-			pr_warn("ret = %d,fb_find_mode failed,with %s\n",
-				ret,
-				mdb_desc[i]);
+			dev_warn(info->device,
+				 "fb_find_mode failed with %s (ret=%d)\n",
+				 mdb_desc[i], ret);
 		}
 	}
 
@@ -855,7 +859,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	ret = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (ret < 0) {
-		pr_err("Could not allocate memory for cmap.\n");
+		dev_err(info->device, "Could not allocate memory for cmap.\n");
 		goto exit;
 	}
 
-- 
2.43.0

