Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D4402457
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Apr 2026 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542445; cv=none; b=bURM0+x2dk3Laqxtdq8gczdewXK+6xr6Y0G7eHjvZzgEuIccYl24iYXIguFSy2PrJGsKdZY9rffeYmD2OWEZDlgfM4fxyVYdoDvmuLhx2MAcvUVIbmmVb2y8DGZZtpAgbqcCdtHQVulihQCHfI07j0aQoIo2GjJN9PUQz3FfuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542445; c=relaxed/simple;
	bh=sTmt6cdg1kP2+eYTeEKKnHTzDGESqLOto0bqSvNzmv4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cbVHSVB3Nbzoyu9sirucFHWRktlJMZ1eoWlDLaUamz6mvVwjJ9Nw6WAPbs1KID8GZMaRBnwPQKUIb2IDnMioNknKUa5cW3WQkWDW5EJJArZ6b+PSitgJ+T0AoUlLx4fGk3HkyyCuIsURjbNAK8mFjuK6qKcUryxVrLkApwtBqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qloev3DS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qloev3DS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso6180265e9.2
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Apr 2026 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777542442; x=1778147242; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRjYmZEKAOcTK8eSw3z2UVlFOUwJtPih74xVLDcM6go=;
        b=Qloev3DS5tHBdsybmK/z0AIhQARlY1xsZLmzpOu/fAjvVfrjKvCL8zmVqqfsTL3DUL
         L32j0m6BNHRj/xC7xTYAWeikHaAMwBaO6vFKYEXosivLpMEVsp3tgkUeQUQVimKB/sWE
         M5kWjWlfaQHGBApN/xRJU8fmoQIr4w2rRCdieSAQ3MY84rw5aIQ04lKV4WAPgXPSM4pz
         E4ufEyt91fz/BADWcYqAG9K3hQO4yERjD8zqPgeT1FR+ICy/EXQbIbX9p+EWsAJk2qmN
         Q5DKy7sRkYaMjieRD10lHablDA4KITo01c6fwRzRnIK5B0U/OWHrFXxEkGMo1IRR/vQI
         dS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777542442; x=1778147242;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRjYmZEKAOcTK8eSw3z2UVlFOUwJtPih74xVLDcM6go=;
        b=rhNRgsAJUideFemBkmWAYNTSAFEwlxndntPUHR/h/F3sbyPi5ih45dDOzLPA8/+sl5
         aoBKH41IGtmbd0dY4er+v6l6RyR0kP6Ak/RxBl3mShtpWSLT6ksAKmmRfoOlIFWQbmEn
         YE/NxAe9AC4GAozc4J1HOx3kxh5gLLTsJL6mcx9eGWPkdQdvKdb/+C9L38D4/jgdKGus
         Zzl265sSs+XyZ9xzGf47AtR6ureH/9ChKhIdjVD5bI34wF8nvfPMYtZR48ILpJFdQp7D
         8p1ezBNOQjJHTrZUVPMnhjO7QRU7UYVFABBTi99y7hSCOiO91e5UvuyZqXmD+fPtOAv+
         R1WA==
X-Forwarded-Encrypted: i=1; AFNElJ/wsWJDEtpwkpvZ5aIvZjPVY6la/LxbxbIcdVmabY1taYwHOYkf6iGr4Tr3vRy0+bgSaI3CprIMR2Fy3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJ5+317ebb8kSoWSpxuHlcELXvL9D3XOn7G+YfcVInvgrjg1N
	FSP0TLWmhza1U1mw1VKBTVXNQkvMduCN8DVcb27jaVx3qAkzE3qLaU2R2lWla0CEQA0=
X-Gm-Gg: AeBDiesiDEWvXE6i7ALr1ZOusWkn+3A/+QTIB+MqhrKWND+arXVXc/LqXqj2l8wgxWK
	f2Zui9rhBzN3skHA9dlfDzVkCXezy7lnOWYTNXMFcXESCgUEqUgMnZSOBItL5j96ZZtErWqVt2y
	2j8AhS08aA80whaTV29qHMd/qO4vWvmlKb5AltENeG2v8u0nueZSEp631Fogkj41F43CYvgH2Ac
	STScJlis4yyv3XcVXTXi4PKbVX5jFTNA9KvSs2EKCwOeU5pG/FB8RuKmVrbUQ2t+hdeBU5Nqnx2
	s3WSxbAE8BrhmEdMDgk8sI4+Yn35V5jVX5yvvTsTLi4VdRHDXsNWJMlnouD2YWSCAgy/yuCGeue
	0EWG28w7NuyDvHIb922HB8exIOD6I1ZEVV29ctaH//jndV47cTVeGcq9lJbPzweHyGKFE06wqmH
	mXprrx7U8zaQnXgHWrTfBy158ghKD6MY9oJZS1A1ghVKMqtiiRTYpwfvk=
X-Received: by 2002:a05:600c:a312:b0:488:bfc3:efc with SMTP id 5b1f17b1804b1-48a83d119a7mr27313465e9.0.1777542441736;
        Thu, 30 Apr 2026 02:47:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81b9493bsm48984745e9.0.2026.04.30.02.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:47:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
Date: Thu, 30 Apr 2026 11:47:14 +0200
Message-Id: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACIl82kC/5WOTQ6CMBBGr2K6dkwpFhpX3sOwKGWA8aclnUokh
 LsLeAKXL3n53jcLxkjI4nKYRcSRmIJfQR0PwvXWdwjUrCyUVIU8KwMpDOSAX6bQEuxkPQYYgnt
 gAlbAU1lqA7k0GWLZZqi0WKeGiC199syt+jG/6zu6tG1vRk+cQpz2H2O2eX8mxwwkSGdtg7pt6
 lxdn+RtDKcQO1Ety/IFCKGgpOsAAAA=
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sTmt6cdg1kP2+eYTeEKKnHTzDGESqLOto0bqSvNzmv4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8yUmoqUJMN6KNXMYggn4lvttmBXtPuV5E+4QafFy
 alS9YaSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafMlJgAKCRB33NvayMhJ0USJEA
 DLLfrV+XmHVTW0+P0QA9uwsYnnl//UlTxUS+XiiMlrgttbffXtd9m2HIhP7aWnLwK3BcGSNyvm8z3Q
 nbl4+8HkGfS/jsDRnCrHRT+cSvpBl0gLyaF7yarxlI4U2FlS8dcDyWEOD6306AXPrFcSnzxXYwNO2z
 J6HOROZkbBe2rsbTC7kTI9BsJq/vwizGsHzOnLEczfJp1bks34RE8PrAr/U/25d+09/jkXoU1DGXeZ
 8+i3NE4tV5P0+TXCWCHsBdPrvtJlGXFYG/4/nk9J1zNTISz/XXOwy8MIziBkv+wX4s6d5S6+M9aK9V
 oXFOBSScGN7N2/y54VcDJ/k6jI5z2KBkvoSFfwvLkQ8pbRBCCyLFnimrT+bLgT6RZyImrVrJi70MNI
 IEiCN1hGnAYbcsldxgw0oFbUr3swseraQKWequ5W0vGwVWJGC6ORpy7XdOyETiiqt9D1rrvrnPdEZq
 cTK/RAPZcoJbCtDuJw88xOXVxaa/2/xkDJFH5VBxAmVlALPZTKjXFFNjkXObuZqgfiO5bBHezjkFHm
 H6tN/NVPOfFIE8iXMOgMCHOIzbrdBlN2czkQ6FHmhRK++TAlvsr3HWr7s6v1+GnWABOzsQ16wYQ+u/
 A3a3Z7suvh4S3r8aqe3gaWm5HVEHtPNvPQ6IxtLBvVuR3WaASL2HSIbfJ5YQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Implement support for the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control in the Ayaneo Pocket S2 dual-DSI panel.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fixed bindings subject and removed "|"
- Added review tag
- Added higher delay before reading ID from HW (100us was too short)
- Removed probe defer if i2c read fails
- Link to v1: https://patch.msgid.link/20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org

---
KancyJoe (1):
      backlight: Add SY7758 6-channel High Efficiency LED Driver support

Neil Armstrong (1):
      dt-bindings: leds: backlight: document the SY7758 6-channel High Efficiency LED Driver

 .../bindings/leds/backlight/silergy,sy7758.yaml    |  53 ++++
 drivers/video/backlight/Kconfig                    |   8 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sy7758.c                   | 311 +++++++++++++++++++++
 4 files changed, 373 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

