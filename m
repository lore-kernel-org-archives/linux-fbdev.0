Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEDD212548
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776005207; cv=none; b=QWVqH8BqjnynsQWUerApdK/Wy6TjWPyAICpmFMDjQi14bKRU0Sw8I+iBFuIzrwq7mSpiWM2MyTgmRvcW9np8COnPeINLTHGw5VuS/Jgyfmtni9Qv1VSA+dIP5JqBVPMWZEllHxQvTDjKBSxcXVuOBRM6zidkU8gz4cWIR21Fz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776005207; c=relaxed/simple;
	bh=3iWQYpa4v/976oSNv3UVleyySQonyVZzxNwcwTPUUGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NIVbxpcihYZGLjoXq4yd196NrPWxDXMlQJhByLGgBqhCqPinhpyKm9QXgRUQTWVBioVS/4jG7coVnBXCDV2Etn+7nrUwRF4WuNAgIp9Gnu4HMgAHsUx2cla8tdSGi2lyo8EOtKvXoKYf3ObebgDf25x68Qx0KNjWie9HQQNzkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAb4JLii; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAb4JLii"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfd832155so2347896f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776005204; x=1776610004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBPvbkrYp9W7ICoOlah1q6oHXqyE/KvHmdfXYMP2BrU=;
        b=VAb4JLiikqv8hTIHkTHcysJY8cB4oRR3FncSSSgbAf/oL0YTglUf2kKlClO/kpetng
         XoUQhCZhBRyJIPVPo28EC64rhLkfIu9WubIrNhdlBbOVfkJOTP/3aUE5ENnx1UHliG81
         wMBTNGKXz0w+sGihKVU8vvPM0RypRDkKJfaGJ6i/LwItogpzABI7k0hxJGPQPuQsuzTV
         TAH7yiTbKIPaQGNqoclxwfUPaSeXA3y45c5+ocSLC6AWWyVTtOyM3gOAEooq19f6XbJ+
         zxhlztRCEt0ISQQcGKiCyFHxR3a8Q69oOJgKFC327qE1RanBL40m+xOx9qGo5/x0/T58
         4miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776005204; x=1776610004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBPvbkrYp9W7ICoOlah1q6oHXqyE/KvHmdfXYMP2BrU=;
        b=pJ4g32yK30BfUnkYl8Q6XRoDOU9SmaTMjWflrESRtFDaCeMQdmhdI5WLkofAKff8fm
         0VqpkFAHjmh/CyjIligeoJZHUzj/fA6neqNqLooEy8nPWB59x0xN4do8qgRcywok7rNC
         fIKnxf9HcOZ9NpeMC9nYEZca4/medTN6JjhS8UQ3hTQaYAEMIemh8w8nIBTiKTCOYYJD
         tIGXzKhEdzcMfiySEVFJcd5lqeV8wIm9hdSkoh64ssaU9O/X/NB1db7Xvu1ynV64B2QD
         RqjC66JRrZKh70wsMUTgYPV43kUu6pLZdo2yqV8X5Zwu9l3S8kL5LhB1Wq31WGDcAb6D
         eZSg==
X-Forwarded-Encrypted: i=1; AFNElJ/ylQcTYkXSniI2w7vfRcEN5cYpGitAlYn0wZaPhytwp/0temhYI13/cYwb74KFnvbXKf4P7TGJNU4eOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLUJh0EpaqWLZJRQ3hAHqdkzYJLyWOiwQq+MD7rRsES4Ju/Ia
	dEgeVqGRHC1tXb3USXQAxW2TJOv77OwJi/hg35Mtgh2Hi0VCcEekLHkZ
X-Gm-Gg: AeBDievLtxmD5MZIstxJX8Q0gruEHPRNY+RN8ddFRUYUqPTSaGDaI+gqKca5hYGstRZ
	oiXJu8DgAjqRFn+UpH3mJm3mHP5EVP1JF4lRipePWkEKAm7RNC1cHzGZKNiyhEjlzpXf7wpisjy
	i8QZQZLxuysanEB4ZWwj0J9nOpDGpt6mhfftCy4nyTIX+8hxEYaV5JpsNtJNy32Q/5JT+7/2+hO
	hD/+VjOamRChpBZUxl7B7DEibRxibuhh06EcLcfsmYQSMo95sZIOcdnPVGDXw+g0p2cB7cHQXW9
	MoU/S1TfQr3M8ZbO0WybvtLG5YjUYAKIL748l0xCKIbDOpnLfqT1HWl6eCZ9Jsur35OvbVw/pdc
	t/tJ8okrG6y7tsC0NqaY58io77ZoqnK5D3E0SisenMgd9zfYyWnpOcrLaipAlU5yS2WFmddygTx
	fUbtvrMn2STeQ5/OJWtrRnTQuJwKUFVM1Lm1fVKZo7+NSTbivZ1Q==
X-Received: by 2002:a05:6000:2489:b0:43d:77c6:be6d with SMTP id ffacd0b85a97d-43d77c6c43bmr1268704f8f.7.1776005203537;
        Sun, 12 Apr 2026 07:46:43 -0700 (PDT)
Received: from localhost.localdomain ([72.255.58.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5ccdasm26622541f8f.34.2026.04.12.07.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 07:46:43 -0700 (PDT)
From: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Subject: [PATCH] staging: fbtft: Use %pe format specifier for error pointers
Date: Sun, 12 Apr 2026 10:45:52 -0400
Message-Id: <20260412144552.18493-1-mahad.ibrahim.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The %pe format specifier resolves error pointers to their symbolic
representation. Previously %ld with PTR_ERR() was being used, %pe is a
better alternative.

Fixes the following coccinelle warnings reported by coccicheck:
WARNING: Consider using %pe to print PTR_ERR()

Testing: I do not own the hardware, therefore I could not perform
hardware testing. Compile tested only.

Signed-off-by: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1351.c | 3 +--
 drivers/staging/fbtft/fbtft-core.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index 6736b09b2f45..15524b80035a 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -218,8 +218,7 @@ static void register_onboard_backlight(struct fbtft_par *par)
 				       &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
-			"cannot register backlight device (%ld)\n",
-			PTR_ERR(bd));
+			"cannot register backlight device (%pe)\n", bd);
 		return;
 	}
 	par->info->bl_dev = bd;
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index f427c0914907..823315dfbf5d 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -187,8 +187,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 				       &fbtft_bl_ops, &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
-			"cannot register backlight device (%ld)\n",
-			PTR_ERR(bd));
+			"cannot register backlight device (%pe)\n", bd);
 		return;
 	}
 	par->info->bl_dev = bd;
-- 
2.39.5

