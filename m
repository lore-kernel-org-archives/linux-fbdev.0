Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864B1CAA67;
	Sat,  5 Apr 2025 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743851540; cv=none; b=Qdv6sqayDBzmXzIazDMqO8zzmJdV0pdxVXurEyQ+omfSIJIjo0Mhe5dDGCUvUfpGGsyYnV0el53mQQYH9nyaR1fwMzBSEeMXlyZfE9hhms0syBePYljbkAPt1EjnP1BIHRbl3BuGV8dqaA3ZEakp6riiA/GgBzHk6PRKGJIqxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743851540; c=relaxed/simple;
	bh=beAf4oeKfEtWFFLorLb9kscpUFlq1Zo7hXzlGWUFp8I=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=fiO/SW2LUPE4Px3fVMWGsLoYcq/qRMU4P78tUH5XrlhX8EvHkPp7QwvuT8/udt15dHBVqLOi+IseSYc1WPtk1RfZq+5DGqwUGEFRxgy6unPZueVXNmIfGaJZgOVU/oCSNqb6gitzV69svx6IvKWZ0evYJVPq3Zn2ekfA9GN5GHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt3t9C06; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt3t9C06"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so2407438f8f.3;
        Sat, 05 Apr 2025 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743851537; x=1744456337; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iccBNqnE1r6LyZ+rk34ys2cg+4klAtt7ZPrU0BU45c=;
        b=Mt3t9C06PqgdMf1HTJmswEdfmXapZQCGXdj0fRVdQIqG5iTnVl5XCknHUUgzrew/qC
         a6QmfHhjMN/5W3w80Al+p45CBpuN5nbix3NdzOk1qFs8uYmGWPF8PdnWpyohZhRllCpr
         A++ptVl90kdqnev2qqu9rbyVYUB0MNYLIDWdpMeBPWOscVncocNI0QSvkpS9o3D54N1A
         P+M9oFYuuyejxGquti9HEbekKKs1xJUA7WFP7FpaSSUMDly52sJ9yr2dcUxLYRytR08F
         cmnn2phxwqbahCmzG2ogMLJvpV8JViHZp24gXyFe3vC9ZFgWIENVGrGlxxE8VeD2VWXl
         62Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743851537; x=1744456337;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iccBNqnE1r6LyZ+rk34ys2cg+4klAtt7ZPrU0BU45c=;
        b=LSSePht4qBHlxJwwSVDvLCJ6bgWQZHUNLDnIMqlUt/F7spEhXLpnsWJDwlilyqnuE4
         EIXvtKa1zZaCPpny4zjKQRJ+5Sz/2Rw+2nF9oggwL3qiIR5lBHE/KXhpVzcxAYpDHjhD
         2g5WCiTugl79giS3g7+nlor+EAKf/WnK1La1HDoBcQUBsnC/1iK6hCmEtwcs+N4mGj1X
         TD7pHYvE9iWEvuCPPHC+tzrj/envLgRgBFONhOS+cv1W+LPtvI/OmwJ4eIJtOMBKjzS3
         ai0BiUDhJmrfMRUt4tDwv6HX1y+UB5GX68IyBxZEVma3MKlVLKar654BCUr3cWHMzwSE
         XZag==
X-Forwarded-Encrypted: i=1; AJvYcCVuSIqxpaZUFmluyrFkZ4+64csHRD6C6wf3BCP5R9xRkSJsrdQIMCPXb3/r4QlWDqF78btjC2dGd990gw==@vger.kernel.org, AJvYcCWkKWbHg2zCBRd9D9GGxR4/ePTcYsIXCciIUJWv+rc8VmfY90Mgi0LzNQrTS2R1yEPljnoKV0+xgrQcTkkq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1LPzrz9QiodVfmTIDkYYhf1LBwp/+HPEzkqxsqJ5UrzThjeKp
	6dfiI1n1ZRNacKXZokYPEsSrK0ysQj5qR7EGRuEgXojgry4zMLc1
X-Gm-Gg: ASbGnctc84v+ZUJf93ukZbS8ctXmxYdO/5BB6OiAzzTYmFuyXZatdZTe2vSJdrZHsVF
	Ec2x2BCTk3eutnytRhci2wqTczl7c1x4GtpdiyJmTpZKO1CEhOjgWcre5qwLPYSKE0xXUZSgjwO
	6ZYecFK35b90rBoL1SyryDuXAVc10LS8hPBVNzl5yiqUXaABafB2YVXwWl9mBKsqZuuT7FXyK3N
	89Drf6+sWNj2SNUMRsZoT5F9V3xtp8UgG5/jhwLYo2XD6Gg6o6kiO8WDI9GMdb6k9Hrwop5pMlW
	CPQYO4yiWo+wmPSKdLX3IgG5LA==
X-Google-Smtp-Source: AGHT+IEtMcyakkZeJjIiCJrpzUn4tJaS8sptwAbU0PmhM2qBiNcOFq9ao2zLhSFxvDnUURc923TwCQ==
X-Received: by 2002:a05:6000:1a8d:b0:39c:1f10:d294 with SMTP id ffacd0b85a97d-39d0de28a44mr5091032f8f.26.1743851537275;
        Sat, 05 Apr 2025 04:12:17 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a6ae5sm6695903f8f.32.2025.04.05.04.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 04:12:16 -0700 (PDT)
Message-ID: <67f11010.df0a0220.85b20.1b74@mx.google.com>
X-Google-Original-Message-ID: <Z_EQDqVX-ZGol-rp@princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 12:12:14 +0100
From: Richard Akintola <princerichard17a@gmail.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: julia.lawall@inria.fr, princerichard17a@gmail.com
Subject: [PATCH 5/8] staging: sm750fb: change sii164EnableHotPlugDetection to
 snake_case
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change camelCase function name sii164EnableHotPlugDetection to sii164_enable_hot_plug_detection
and it's parameter enableHotPlug to enable_hot_plug
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164EnableHotPlugDetection>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 8 ++++----
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index c12df1f9fb00..1ce44c50617a 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -21,7 +21,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.reset_chip = sii164_reset_chip,
 		.get_chip_string = sii164_get_chip_string,
 		.set_power = sii164_set_power,
-		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
+		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
 		.is_connected = sii164IsConnected,
 		.check_interrupt = sii164CheckInterrupt,
 		.clear_interrupt = sii164ClearInterrupt,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index d0b80b86a4d7..c8db6ceee9af 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -329,12 +329,12 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 }
 
 /*
- *  sii164EnableHotPlugDetection
+ *  sii164_enable_hot_plug_detection
  *      This function enables the Hot Plug detection.
  *
- *  enableHotPlug   - Enable (=1) / disable (=0) Hot Plug detection
+ *  enable_hot_plug   - Enable (=1) / disable (=0) Hot Plug detection
  */
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
+void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 {
 	unsigned char detectReg;
 
@@ -343,7 +343,7 @@ void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
 	/* Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
 	 */
-	if (enableHotPlug != 0)
+	if (enable_hot_plug != 0)
 		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
 	else
 		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index c15cd6a5d53b..9e289bf4a78e 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -34,7 +34,7 @@ unsigned short sii164_get_device_id(void);
 void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
+void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
 unsigned char sii164IsConnected(void);
 unsigned char sii164CheckInterrupt(void);
 void sii164ClearInterrupt(void);
-- 
2.39.5

