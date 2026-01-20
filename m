Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1FC42981A
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Jan 2026 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913452; cv=none; b=OyUw/QJIc7X1fG6jloqT/El7SKSY4lonnZB+qTGKcXTglY+K3m1cauL2/xeyhCeiI0EwOZxcLU2q8rPT0IdbYGOt8R0mRO/hRZVnzBF8Oo28hgJl5i1yce2Bfx9BogxDHrEO9wMLLI6K6FOifkp26FNH+f48MC8qkJ2cLVhDZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913452; c=relaxed/simple;
	bh=jIBkxlJHIcCc3JY8HlzcY+4/Sq1XPQvovm3vReAxEQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T8Fqw+FsGuE1iP2E6QUEXmsPSU2w9efInLyOuaGCeKOs6yuRwsgWjabkAW9TVXxgBqdGvFhYC5i3KA4FgnfHgn7DBndNkZNRg1bZBFONYIVCEinw/QwNV2+wLRio+VVzkto3En4a1gbh8HntejnV4sMVwRY1NYxZ0LFCqUKJeNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwpd6/bl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwpd6/bl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a07fac8aa1so39988085ad.1
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Jan 2026 04:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913451; x=1769518251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnR4PJhsaUjZWZn+C6vALPZ6Lj3dxWE4L9BjOpkr0AY=;
        b=iwpd6/bl8uw0/LmLRlTE4DpbocYpdYAtij2ti6OibJmaoLOl1ul3O3A+4/ygEvVJBp
         U96MCfXYoPXqzglepNXfHmpsy/Ug8SuUWfY24Sqdg0m4yadYbGddQlccCuv6ceWM65vw
         zmAGQv2SJYcTfy2HIl4h02FgQbOtQscze8NTVyQsxyEF83LifoLDB7uP7FDAcL5+M73R
         90M1mu0d+nbzJw5XQApC6/XBIlIu+mAaXFhx2I1uav1CxeIK70K6j6DX2asQbzgUnmOy
         yYd/JNcAoNqV+o5GeXsqs6aKiOCws8oszEDugPi5jeUd/I+0qF65V6s0dxjD+0ACKemk
         wRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913451; x=1769518251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QnR4PJhsaUjZWZn+C6vALPZ6Lj3dxWE4L9BjOpkr0AY=;
        b=oqNB/c6EWFNHEQ9HeI3bws/rOlKIpfWZ9nKwR+N30JW66MGCUE09ArERWDqy2h8+YA
         OT0y7umQNZH1wy2Q11KjHKpT62XpRvtuJdAM6Pz0dhXsm7VNhidj1QcEeUFPeZI3NhKe
         BD7bwYlmOPQRDeWPX1t+VKCEVsJRK98102AcdbE5nM08svGHkRz26LJz4DrQ9usO9TEq
         0+IQ6+p2XMGuAIwrdZVfhIsEEr92i5Cn+uI+rmJcJPbbc2Mij2fdFVF02b/AICfmLhrE
         Zqj3gODjNQQasI1hFVGtim3c0l3G8Nm2u9yMOQAmL2ibXh++OeT4eaFRSWmh+hRTGpx/
         I4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWBfoA5T6Spn4cH8yjTIvZbRgxclQTok2rtc6c/oCZj/WVLxY2Wo8r5SBs7MlE04ZPDNnJz7FSu7dFRXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyalXeo/eo9EZ+4ZRPxYtbaAtSqx0+caUqDy8OpdtufGhY3l5S+
	OeK28vY262WPTF3YT3V5jpBznnl8kv//SmAyT1GZhgFFsJZSaE7d9OTH
X-Gm-Gg: AZuq6aKvnPOcE64EEhpeW0310sHm6Px9OKeZl78ATFFiDYruKVTOisSxn5i5eQn8vp7
	QnWM8m4qpvUPAMZ6+ptw8jfj/XHwWy4V4a22kv7MaWNkP9Bgl+NTu/VpCKJe/Ur0E2ubVaj96GJ
	gmZLDPEVtbfLd+gYpjzU6gzDsETfyVM+Q+Ua2bMfmsw5RTF8lfywFR826UcS4n9yfDlRlcnFV+C
	bL9mHGYqHm7aRlOaj7qh4S9Tn0lQmDk4eH7CKVvoobtcUVKt5MyDtuDgIJcdoXYixi9pjvOlN8a
	MYVBiIRtVYZrgP93FWdJzDnZyr1i8qCBiuPM1xUGaMbsXWZc66XHbCetQGG5gqHjkGzA8DSdmjz
	zh74MqfIxNEy717THV0hlCvtEACKPnxR+dOfous1Rko6aZ4M0z5BxrWLo5Oa0B1sw0IWDLbJ8tx
	ZfEJPObFmlDdJ9xJo87dzuZo+xM4VYWoXfuzUr
X-Received: by 2002:a17:902:e842:b0:2a0:ccef:a5d3 with SMTP id d9443c01a7336-2a768b7a68amr16787195ad.3.1768913450709;
        Tue, 20 Jan 2026 04:50:50 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd582sm124973815ad.52.2026.01.20.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:50:50 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com
Cc: deller@gmx.de,
	pavel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: backlight: gpio-backlight: allow multiple GPIOs
Date: Tue, 20 Jan 2026 18:20:35 +0530
Message-Id: <20260120125036.2203995-2-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120125036.2203995-1-tessolveupstream@gmail.com>
References: <20260120125036.2203995-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the gpio-backlight binding to support configurations that require
more than one GPIO for enabling/disabling the backlight.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 .../leds/backlight/gpio-backlight.yaml        | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
index 584030b6b0b9..4e4a856cbcd7 100644
--- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
@@ -16,8 +16,18 @@ properties:
     const: gpio-backlight
 
   gpios:
-    description: The gpio that is used for enabling/disabling the backlight.
-    maxItems: 1
+    description: |
+      The gpio that is used for enabling/disabling the backlight.
+      Multiple GPIOs can be specified for panels that require several
+      enable signals. All GPIOs are controlled together.
+    type: array
+    minItems: 1
+    items:
+      type: array
+      minItems: 3
+      maxItems: 3
+      items:
+        type: integer
 
   default-on:
     description: enable the backlight at boot.
@@ -38,4 +48,14 @@ examples:
         default-on;
     };
 
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    backlight {
+      compatible = "gpio-backlight";
+      gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>,
+              <&gpio3 5 GPIO_ACTIVE_HIGH>,
+              <&gpio3 6 GPIO_ACTIVE_HIGH>;
+      default-on;
+    };
+
 ...
-- 
2.34.1

