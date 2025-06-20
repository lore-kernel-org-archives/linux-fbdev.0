Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8391F03C7;
	Fri, 20 Jun 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438480; cv=none; b=uYPL751if8v+Xs8/sqkdUHj3gT5qsG56z40U1w08SMCwoSYWgUC395PX5TNlJjxZUvjd3s9OIm55bORQo89bKpt/BUppePSm/UmCimKGfNSQNQvcRtiTr0AeKU3/nNuisZTNwjt/LNoZNYvVgOAdEa0maxfxh7cm9ZIEz9nbCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438480; c=relaxed/simple;
	bh=s9nqYb57y/nutAilPgtn+5a6ISQWT7mmIgEn/sTWkNw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BCtEy66hsXeciqaeqiBm6b7UyLvv4qmQNBB0erO9VplxOvzIcXGKjEoN9VlcFathIJZiBo5eMyM1lTuy1HfpyhDJnxHPwW7GAYALtcS5nOJYkN/6lJgsisSSrsXuGsbaCHcjZ1XaXg2IxnLBK3QyzXxbfEMc1W7SiE0vBNqk/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQhDyjKE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQhDyjKE"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2352400344aso21966185ad.2;
        Fri, 20 Jun 2025 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750438478; x=1751043278; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5n8UMa9ZY2/Uq1XXfaQRztTpb/VKkz/BaxVAYOVSYU0=;
        b=QQhDyjKEp7CvZ2F0gEpqzN+o3Uz2TwsAOl1/g80FiFeYhh5UZziV+I7Kzr0aInhPLW
         oMGMbImOFD5FkuL5xIiMDgKa1zo44DvedMFE+F0vcNQDnp6JDCoyEh5FkLVncmU25OD7
         6OxW5eW6hqt6XewP/TC1rnKe8Zkx2L4yGvgfAXbKJXEM9mOiI42EaYG2w2HeZWEbKRTg
         hg+V9VXJSRQTY9PExZJ1WOQgxL8LQy+4PKvArzKoGlJy4DNvgNcxNGcCRsakYkvVPR2D
         QqBNEwo5WvwDvscf8Ztq2S3Pu5FYz5REteEA5K3ZonGxgcvLjRkQ6QI27zWaWMkoVOEf
         9Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750438478; x=1751043278;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5n8UMa9ZY2/Uq1XXfaQRztTpb/VKkz/BaxVAYOVSYU0=;
        b=Reb9E5tA3Nc6z3CSJUEQbp55HPk3LWu0pdvtqHHDE5T1hyU0hjNI1uQHkHmI6KkiYe
         aXM+xStclFl4F/DRW4xuOuZpZEsuQB0HC4LhCA6TuI8ZzVtwhtRUqisMmw1zMjzjO/4U
         hwFyE95YFK86wB/CMAWHLX11691ihIOTopdy0gsMs2wb7vEfjlF5cmgu7JzNumt/GPYX
         sLMD3ZESQzBqm60LKwUx3bKzpAaQJThX9t4kECpfn/FdbU88AN6ESjpKuXSAPTgbZKgM
         iOktCuHu6XiQ8q0Yh60iQRQCt//XyTAHUJbaAdFkXtDzFmlwXSKqvM6uZIptS+U6cvvB
         EGEw==
X-Forwarded-Encrypted: i=1; AJvYcCUcW2e8Lrc4MWclzhtVeOIjmtnm6QRzS7mrqLlXLwiqiWBJdcWBQt+oCtSPkhZnB6fgeI6pW9Omkwg8P80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUVdmC9sKk1nnVCZI7yTotgcW/UpAoiC54MNdtm5D0paLWl4W
	yVA93B1VCIciPyotZaxQkE6YJx5zf0+fB/23lVjMmy2MBY+ivZA8pn/L
X-Gm-Gg: ASbGncujBT9JBQH6GEeMrbPwVZJm9MTJ6e90AkCn0eCBym5tllneuUHGtjewXnJhSjq
	rC6wfRnwZrxHhjwintzDd5Mr0cQ9UZ0/M+4K4iRrUG+COxmnZf+sQIRl+DUSCxXCcKBsXVB0Fb0
	sAvJayzfhhpSWYqojrmAjmk54xd0H+fX9Qto/IX5HTeLL885XbRSvCvmThuu8Lw9yKAcCzfwcSp
	PVCiU/1CrPep0zwt9Gm2TfVBDHSMK5Ux/PWrXqPK0vsf883gY7OAG518+JFqVQZ/OQRGt+B4979
	VbTRkSfWsIurfafcA3m4JxJq/kbK1qGfMWQISVYIx+akB8aUgbRgchii7w==
X-Google-Smtp-Source: AGHT+IHaN1oW5Hlwn8COrjTD8w04UIf4nZDmAvGd+2JS44q7BflFiyYUhW37lDPvB8pB5dOo1nA6Ig==
X-Received: by 2002:a17:902:da8c:b0:225:abd2:5e4b with SMTP id d9443c01a7336-237d9841785mr59869815ad.16.1750438478311;
        Fri, 20 Jun 2025 09:54:38 -0700 (PDT)
Received: from zinc ([182.216.63.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d867f5cfsm21727635ad.181.2025.06.20.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 09:54:37 -0700 (PDT)
Date: Sat, 21 Jun 2025 01:54:32 +0900
From: Kisub Choe <kisub.choe.0x1@gmail.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kisub.choe.0x1@gmail.com
Subject: [PATCH v2] staging: sm750fb: remove function pointer proc_setBLANK
Message-ID: <aFWSSAcboBVi4ROh@zinc>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Call a function based on sm750_dev->revid
instead of using this indirection

Signed-off-by: Kisub Choe <kisub.choe.0x1@gmail.com>
---
Changes in v2:
  - removed the function pointer in accordance with the feedback
---
 drivers/staging/sm750fb/sm750.c | 10 +++++++---
 drivers/staging/sm750fb/sm750.h |  2 --
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1d929aca399c..b65a527314f1 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -571,13 +571,19 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 
 static int lynxfb_ops_blank(int blank, struct fb_info *info)
 {
+	struct sm750_dev *sm750_dev;
 	struct lynxfb_par *par;
 	struct lynxfb_output *output;
 
 	pr_debug("blank = %d.\n", blank);
 	par = info->par;
 	output = &par->output;
-	return output->proc_setBLANK(output, blank);
+	sm750_dev = par->dev;
+
+	if (sm750_dev->revid == SM750LE_REVISION_ID)
+		return hw_sm750le_set_blank(output, blank);
+	else
+		return hw_sm750_set_blank(output, blank);
 }
 
 static int sm750fb_set_drv(struct lynxfb_par *par)
@@ -605,8 +611,6 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	crtc->ypanstep = 1;
 	crtc->ywrapstep = 0;
 
-	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
-				 hw_sm750le_set_blank : hw_sm750_set_blank;
 	/* chip specific phase */
 	sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
 				    hw_sm750le_de_wait : hw_sm750_de_wait;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 9cf8b3d30aac..640bff625052 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -169,8 +169,6 @@ struct lynxfb_output {
 	 * output->channel ==> &crtc->channel
 	 */
 	void *priv;
-
-	int (*proc_setBLANK)(struct lynxfb_output *output, int blank);
 };
 
 struct lynxfb_par {
-- 
2.34.1

