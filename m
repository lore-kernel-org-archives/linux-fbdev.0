Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6849F191F7F;
	Wed, 23 Apr 2025 04:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745381080; cv=none; b=hJfNA9uYchQBkTiLzqR103fTh+u8Bp8QNYA6e0R8rFeEcsffrcxgJdpvcbiaQnKVb0IYIYHAZKP4A7RtqGi5ZOzJ9+nEksNO/LfDaS5n5Oq6Vw2NqJaYC1tjTdTaKa/hCDEwyLkAP/DBGQoTb3Q7k5p8akY7uheuuB6F3fd+H9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745381080; c=relaxed/simple;
	bh=QLYcfn/WeBs9woCLnGnDrcxCf0Rs5lnjMgdmyrn4CQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QGQGsfZRGNiEW5GYVZLgu91+taTdosAjKzOEy0AFYhqwTukWvhmWtQM6J5NodrxKtQ5W3UMrLATUAfvOUXsKvC75fmc20bfxOQ5JBdDCnc3V7UIekoZVc0cb9hqY3UAqsp0JfX6i7xyQeDYfPdSbjHoHwpnDuJ+aEIenG6uW4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4B0G1ew; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4B0G1ew"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-af9a6958a08so659987a12.1;
        Tue, 22 Apr 2025 21:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745381078; x=1745985878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JaNc0pkR0bONw547U5Qqvy297DCGp0lAzMaANoLdgt0=;
        b=h4B0G1ewjWGM4aIMIQX2NfSdDa4SIBvCPpMghHzw/8CbZRQjGQBea06cvJ7tUlDe2R
         +S0Pcu37N2xyQetjWkC31+pDbvCOFIM6ubIpr8cjZF0+FiXgeLJ0As/YGjc+Rv/mjCje
         h1wY0xj0nojcOl6bBbYPsfzRyzAJh7Z5xGE3BcABspJAAENNRFAwVXLU5AI2Q5EJGzMU
         LWKOGSa5ErWJP4P0vf9lVu7FW+mIpBVE/yHvqEsEW0wzwjRlNfcCIwORSngWuvAjFvTK
         TcnVRwldI9UvjusHFEmhaXPljiWlLl06SOPspmcsVCtJr0LFe2/ApjR3tFBS6imr3jZg
         qf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745381078; x=1745985878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaNc0pkR0bONw547U5Qqvy297DCGp0lAzMaANoLdgt0=;
        b=PK1LKSqh6EMHvcWj3pXJt/0+n/Yi3r5RoVxMfRZzfCbJOXuExAlWeWedeWiYPdw4zE
         Cdf2/tI4BhZXVmDN7+Q0IBZoMNlyCQ0eZ9Pyu5ylNYWIZFHiaAtQMyea0n8Gku1SIsyJ
         Hu3tcEFzwJoffO0Z7JxKkdvgCmFratzB4BWjI5LRwX5EXUBHr3FRr1MYhfAMutWAUrNb
         42QDvBpnBow96EFiqmAPy/zQhVQDSDtWjbqLci7Ifrpkvf0p1NP153/4riFlMxoH+IwW
         gsVhZI96ODP82+H5O4/dX8cpG3gPKZ7uFzyBuaQHVuGfjc5tUVM2pRUCypnFEi6SVVJg
         cPzg==
X-Forwarded-Encrypted: i=1; AJvYcCUxDTYc9J3rHyCeP1K6nSk9qlNpL7JmMKnUVgaNPQrQKd+oL8f4+ItZRjH+9QTSHhMZjIEWGR+O4vkevA==@vger.kernel.org, AJvYcCVaRC1s20S6pfGU3ii/ZOXd0Mu/Eh5TqXoP6cKonlkG0/Oe2jd56x6GG4p3jpFbcCJVu7Tk0gn1cbu4O+uU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+7tBOj3XzHmLU4xgSBBwC2gBqIunUGT+RR373o4LHUEhc/+B
	ukMg89xToP8zuegIAoAxa9ulUaqRf6j7DJKIaSdBpnGjplz7RynZoCX7UHgiw8g=
X-Gm-Gg: ASbGncvvRvXhg4F10/+142Iu2/6scbDClrFz1OnQKHu0TY9sKfu8c7KPHXB0KuFSiSP
	DBptfnx2Hy10I4ay5kLNkBsV382iayhwpCc5hgDYTtzQY5CtjPYviSUEV4hLfOwXegZxHJC3r8X
	QDF/stw92w0JpvsRK++SVn716uxrEMcLO2Fr8gsd8VYDwzp7rVUBbQaWgejZnh6L093z93S6ljO
	uVuEECLI1KM0CziJQ3PYMetdsJE/nSBnbJxkJgrYFpfO5no1x3mAW8gcAxKw2l04XkwtiX8i+lT
	dJUjn3nuIRQIO+zLpA8R3j7AOZzRvfEA31/000HJHUOyrRNqziUN3axbVMgWrSji+tc5iluYLuX
	kxwZr91cMWA5PIN4ojprYNWer7avpbXtHK7mhYYtptJFoomqIRADwY6V1kY/uOjVJcA==
X-Google-Smtp-Source: AGHT+IG+cMoMirYyItPads7DUv0VZo+s/pmJuZ7P26NAWUahDz4I33xxAF22GJJJXZCUJqkkMjo7ew==
X-Received: by 2002:a05:6a00:3a10:b0:730:8c9d:5842 with SMTP id d2e1a72fcca58-73e11762d53mr881535b3a.5.1745381078569;
        Tue, 22 Apr 2025 21:04:38 -0700 (PDT)
Received: from kerneldev.localdomain (162-225-124-171.lightspeed.sntcca.sbcglobal.net. [162.225.124.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaeb5c1sm9475900b3a.165.2025.04.22.21.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 21:04:38 -0700 (PDT)
From: Eric Florin <ericflorin.kernel@gmail.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eric Florin <ericflorin.kernel@gmail.com>
Subject: [PATCH] staging: sm750fb: change `enum dpms` to snake_case
Date: Tue, 22 Apr 2025 21:03:45 -0700
Message-Id: <20250423040345.11323-1-ericflorin.kernel@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the entries in `enum dpms` to snake_case in order to conform to
kernel code styles as reported by checkpatch.pl

CHECK: Avoid CamelCase: <crtDPMS_ON>

CHECK: Avoid CamelCase: <crtDPMS_STANDBY>

CHECK: Avoid CamelCase: <crtDPMS_SUSPEND>

CHECK: Avoid CamelCase: <crtDPMS_OFF>

Signed-off-by: Eric Florin <ericflorin.kernel@gmail.com>
---
 drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 63c9e8b6ffb3..5cbb11986bb8 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -3,10 +3,10 @@
 #define DDK750_POWER_H__
 
 enum dpms {
-	crtDPMS_ON = 0x0,
-	crtDPMS_STANDBY = 0x1,
-	crtDPMS_SUSPEND = 0x2,
-	crtDPMS_OFF = 0x3,
+	CRT_DPMS_ON = 0x0,
+	CRT_DPMS_STANDBY = 0x1,
+	CRT_DPMS_SUSPEND = 0x2,
+	CRT_DPMS_OFF = 0x3,
 };
 
 #define set_DAC(off) {							\
-- 
2.39.5

