Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEA1C700D;
	Sun, 23 Mar 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769995; cv=none; b=K6YdZvMOVHLrqgKghSA1DxzKwnqKuGKHj3Sdywq1h1GDvz0Tm7crp7IQ9UQnYlZzG3PebvpUbIQwC2wusOcMGIA9BNKM6+2J+QLEJ4Izb9BQStkKkLL+iGnq9rOyXx7WfPQeSj2XWm5OvI5LG3SoDFygr0e8TgGUy+tke+clBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769995; c=relaxed/simple;
	bh=ccm0vWMDBLowOtsgeC0Np4Dq+ieIsmlaDmtQ0vxCKuc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BdAESbjPhxY82I+m4t+7dedxKtnTxx7L92fBPc3s2pFP+kadw7t2syjna3jItCVONE72jjYpd/+q9uQB4P8mFqAwqM1cXuSLOG46bDzgowQPmgSJQU+ehINdtyC8T3X3bjWepMQOS0WQ70Z51VsOqWDpk3m/XMQc2RYIWJJXD3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ7YXgpa; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ7YXgpa"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301493f45aeso6185083a91.1;
        Sun, 23 Mar 2025 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742769993; x=1743374793; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YQbIxlTNY+cHu7R6IhUq3rHgE0kIfvcWVGQIcjca71s=;
        b=UQ7YXgpaYT9n1lL03AxvgXfhroDuAURrFhEXoInGbKOPXkIOrdAeeanTQxql7zi3sD
         SwDyDHOJc1whgQ+h8Vx/YXRMpFuEKxaTflEAkf4Ju7lNqKIC3GIHhAsF+NoR8ROQ2qVy
         jU9ecTb4TNpvdsIkQrq7uTIf6GLvK12msPFvlHfx/UPQ4IVjynJj2noPyYNdLCGNnomw
         C/FnwtROFMMCThIBSZihDOLYOlHp8CiP0RdF/v4XR6iTzGZCCV2R+6pZthBGCaP97eAj
         Us3gghz/JhAv/WkKfsJXnzDQ6RAvAN2rqZmBUSRnG85BPeb2pWMVSjuPBIaABcj/xRim
         89Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769993; x=1743374793;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQbIxlTNY+cHu7R6IhUq3rHgE0kIfvcWVGQIcjca71s=;
        b=POeVrGfzCHK5eeu9PymXE4lI09A4agu7HwEEHrC/DhXe7wNFnRNz8TiK2SKcg7w1e1
         A1wuWLxyx6xg1v3DE2g/aKcANTiucBBfU7HzMwpKH14nddteCpMSoOtXmp3zaK5fN800
         5aLhbn5/zyJDIm8vmvxerlLjnyY3s5XVyzFY/9QA2fRIf3WT9t3H4gZTWTRJ4MWdSLoB
         YNywpEhjPNXUfPcL1I+MUVuSdPz3o3akk7unsKwjtIsvLhSzcOxMB264pr898i5vv3Dz
         zTMyifSv5cpPzK7lIhQPHvbqf5D5UNwMrvcdFI9utWo05I8PYeVZaGheCYJAd1T7QTh1
         MdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtBi6SVTt0/pldYRqrBKCX4tP/Mf2TA0pbKbcK2IA/n3Tb2WIwQC5AqonilsR+VqFNoSS4V44hCsPYNw==@vger.kernel.org, AJvYcCW2d1ucnEbX4ig9hVUBy7hzgPqBdkL/XKYCGbFnObf9htgd4+TqBWpshxCFeGDy5gSuVlK774Ba91Jv3wup@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKPdYkxx/BAJAzgQ+ky1AfViMdxXTOECyg4hmBgVT63Pk5jg7
	eGVbj52opfmVisZE4iEk2/y0iJj+JjSq7Eb3MR6eKFYpfqu83JEQ
X-Gm-Gg: ASbGncu4OVdf9c5oo6aQnLSZgWw/AYtBv0ITv1HgQ05bZkZjsae1XTsH7oWcKzcLhfO
	YfwsKyqx71yq1QaQOMkYLD6m2woLMlBXa4Qg8f1VZnBl4rIiUF6hK2uoambmarls0fdtr1nqjgX
	qSXEh4y/jMkYVd6i1rNNEEl9+qcUyiUruzI+Dgzos3kr07/YbBimDjbx2M0Jb4Ad8WoRaaNZCFm
	dtQ2TfrVqUX3IMtYGwNd1OgmueZlQ/acdKmfF77qlmxtucFXneU85BjJTmAFXvfelYdbPuIYBar
	ZT1pcUFir9EiIsLZg/wz+0aFD1h1wWSR5QsC/VALROOw9fFMZQfpIhqpKb+m3uaR29GMq8s4oat
	ZJkVxrVI8+oT9qZvWPec=
X-Google-Smtp-Source: AGHT+IEzb/FSn36rD8g3bjC3CLhUP4bXdLZq4w66P1jvHqoP8f7Ex/B/4Qt/Da6+yywl+F0R0SDUjw==
X-Received: by 2002:a17:90b:4c52:b0:2ff:6a5f:9b39 with SMTP id 98e67ed59e1d1-3030fea76f8mr16980734a91.18.1742769993320;
        Sun, 23 Mar 2025 15:46:33 -0700 (PDT)
Received: from fedora (c-66-235-14-182.sea.wa.customer.broadstripe.net. [66.235.14.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f5d4e46sm6589100a91.14.2025.03.23.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:46:32 -0700 (PDT)
Sender: Justin Cromer <justin.cromer@gmail.com>
Date: Sun, 23 Mar 2025 15:46:27 -0700
From: Justin Cromer <justincromer@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: fix casing style on getDeviceID
Message-ID: <Z-CPQ7dGuTBZ3sWv@fedora>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fixes camel casing for getDeviceID function. This includes an update to
the internal function variable 'deviceID' as it's relevant, needs updating,
and is clearly scoped to the small function.

Signed-off-by: Justin Cromer <justincromer@gmail.com>
---

First patch for me, so I chose a checkpatch.pl issue to get comfortable
with the workflow. Any and all nits welcome. 

Verified my change by recompiling and loading the module in question.
Additionaly, checkpatch.pl reports two fewer errors.

 drivers/staging/sm750fb/ddk750_dvi.c    |  2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 12 ++++++------
 drivers/staging/sm750fb/ddk750_sii164.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 8b81e8642f9e..3fb14eff2de1 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -16,7 +16,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 	{
 		.init = sii164_init_chip,
 		.get_vendor_id = sii164_get_vendor_id,
-		.get_device_id = sii164GetDeviceID,
+		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
 		.reset_chip = sii164ResetChip,
 		.get_chip_string = sii164GetChipString,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 2532b60245ac..d50c71824321 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -48,22 +48,22 @@ unsigned short sii164_get_vendor_id(void)
 }
 
 /*
- *  sii164GetDeviceID
+ *  sii164_get_device_id
  *      This function gets the device ID of the DVI controller chip.
  *
  *  Output:
  *      Device ID
  */
-unsigned short sii164GetDeviceID(void)
+unsigned short sii164_get_device_id(void)
 {
-	unsigned short deviceID;
+	unsigned short device_id;
 
-	deviceID = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+	device_id = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
 					       SII164_DEVICE_ID_HIGH) << 8) |
 		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
 					      SII164_DEVICE_ID_LOW);
 
-	return deviceID;
+	return device_id;
 }
 
 /*
@@ -141,7 +141,7 @@ long sii164_init_chip(unsigned char edge_select,
 
 	/* Check if SII164 Chip exists */
 	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
-	    (sii164GetDeviceID() == SII164_DEVICE_ID)) {
+	    (sii164_get_device_id() == SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 71a7c1cb42c4..a76091f6622b 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -28,7 +28,7 @@ long sii164_init_chip(unsigned char edgeSelect,
 		      unsigned char pllFilterValue);
 
 unsigned short sii164_get_vendor_id(void);
-unsigned short sii164GetDeviceID(void);
+unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
 void sii164ResetChip(void);
-- 
2.49.0

