Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7B2D949F
	for <linux-fbdev@vger.kernel.org>; Sat,  9 May 2026 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778344904; cv=none; b=a8aBtS+Vx85tVL//lD8zlSHs5IjamRayAtfCERZn2UWyJEpE6JI2o2yqER9dW1qoTgwuWsrHiRIC18kpshEANSaOG7TycJXzFIXNTQGtT7EcO9CpjOcmos9pkAx5lFBk1XPuJhbQNauVMX2yEnOjwJal97lHiQJAyHJQG3PPohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778344904; c=relaxed/simple;
	bh=VRiwiTz8XNaEWhGT75/QXzn+AVRkunNE+SP20l/5r3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NipUMm7ayKHC5ehJMeDtZpegsmIgdyFPTdQ3LBSeQHyO4tkKbVFbHY03+73fNybreFx3SM7l4PIS2COuXsY08+m/zEwts5EvSk1GfI+NV6zbdqJ1G3F0Xw4F/lA7QqUtXteKfLyT/TWqtx1pjfDLY0QechH2etAn29Savb8Y/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMJc0JJL; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMJc0JJL"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1173061a12.3
        for <linux-fbdev@vger.kernel.org>; Sat, 09 May 2026 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778344902; x=1778949702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgvIJWE+YLkGRHO2Knnp95ExlejblRDIiVbXUYy3bQ4=;
        b=KMJc0JJLOFV54UIvAUfQWiwwckkd49SBYqHCkX/vixgIg5lkkACwasEYGRz1Q73oEU
         5a2/Tbwt/Yy42yvsYlxK4RO82zz7/Z22dnn91bAged/wriZxmhFYAk2L1+FpRGYBCKf1
         AhCrTOmTVzXGJJRg1nc5MF7lOFR9DOMe7pMOv4eg0gvgkivOvl29CcXnbLhkVty3iyNe
         eykO9TCCAV5CISFt8eghk3cRzodKAQSsv1LkYKYPV/R2dFcGLQa3lM+a6NxVrIEvh/z3
         D31y5jDi4Zo/qBzvhxGqUqxm4OPIlQZSBFBx1lcBRMI4f3j0cLYOf1tCAue+MXzaL/wL
         wxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778344902; x=1778949702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgvIJWE+YLkGRHO2Knnp95ExlejblRDIiVbXUYy3bQ4=;
        b=fvhvzo/aXiLOrMKW2JbFIPTDa7q0+lDhRDPWENjAhLh7iNGgDj5nNqOcvjaQqUZD7A
         aWFTZhKNPnPFQqPSSEnj4zMMNBd6pd4RksxwG3zri4A4ZFpkKddt2o7nh3w8J+b6FB4t
         DRYPUlReO5CasnXWE+iFmh/OUAcD4wYDUwA2L+JwAG2F75+tq0jTOxebAn6FM08PpDeP
         ttJyLSjI+kiuhNgcuXN5+DQd2OoPEWQJRkMddRELgKQa6n9vFG87T0CY0NhIcNRJbzBm
         EHpJMBAu49pv83hwkEiobQMHSo2HahG1rFYp5yCSgN7GdSgXhyY/EH/P29blCcmYgvtf
         v2Vg==
X-Gm-Message-State: AOJu0YxSNnVFOieU+GMqCd8olLkUshldIqjZ2P/qdBSQut2WwMFLXtzH
	HTMBC9J9/A/0hXpswUmMca2OtF5Vj+u6koVLwQD1GjYP/ZqA7PDIQKfo
X-Gm-Gg: Acq92OFV1srl2iTUFGOdzUq50IGQW2eFuCrKvFRPJvprCP8ubnbuGmGcM+ErW0mg2gc
	wBFzOSIAwTeQ+jVK9WJtSt/oIpGAa/l7b2ou0B4pAN0PjmxDF6QEPbJN2Jv0/sAfa2s3Bt4M8Id
	tAZkK86WU9FDpypOaDeepvsPIRTTOpsDZMGz4+UKJY6KrzYGSK/T54BAPzRS0hEPnxuW+FDwQJZ
	pjoTASZNxAtCjhLgv2sLfW2q+vcDEFI87RrbF7Qg8QSFxflq5O7cbbKb4Ey5WnSSFbTZIozTwUV
	QRutPiKle9wUqjhCgUmind0vghuIua4S1f81CDmkfDmv7uj4vpg5OTvZbdwMnWzE4mUOGty3lVP
	G//i0J+O5/ktY6S1DpO4d8SFSfsqHSN6+kbPwvywm+l4Tv6Gpa1jgnZk4BUmjAN/NF6lulNa4F2
	0xyQ6nhnxypWU+k40p2F5tkjv465k8+sxPtfgwp3IakPPv
X-Received: by 2002:a17:903:32ca:b0:2ba:1756:aea7 with SMTP id d9443c01a7336-2bc7a990937mr30488865ad.2.1778344902446;
        Sat, 09 May 2026 09:41:42 -0700 (PDT)
Received: from localhost.localdomain ([2404:7c00:52:5f25:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27330sm54722285ad.17.2026.05.09.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 09:41:42 -0700 (PDT)
From: Alone <yogeshdangal66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH] staging: sm750fb: Add const to g_fbmode array
Date: Sat,  9 May 2026 22:25:57 +0545
Message-ID: <20260509164057.71722-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chhabilal Dangal <yogeshdangal66@gmail.com>

Add const qualifier to g_fbmode array since the array
itself is not modified after initialization.

Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9f3e3d37e..19c3da654 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.54.0

