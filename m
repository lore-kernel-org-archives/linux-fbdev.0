Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CC328257
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603103; cv=none; b=N/Jp62WcnK/FoypSIYJt0mCAuCnHJ/cyYh/b7qCvshLB5qskBRripmZRFz9DjXkBEMPAzZeGL5yk0lwD2gliTWoQyPi2djoPSTGVjH/k+2M89sJXoXHW9bSu4pal9MG1pC2z3gkyk/qwuaHF0uUvmnq40Nj1v9IM0bjxumoJniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603103; c=relaxed/simple;
	bh=SVJlcDayOcdOuFmlxFZIJno8JEUkvS2rwI28zFq/GdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXqQXSxG2bIbdkbTG/3OZBI864qG+IE00LALkTIt7w/PAzDNGxwjevMH+GAszU2X+D0PBRr6QH8+AbyY9qBt85RqVtKL/S9Wr4LuI6PKbsMNymwyFDbfaxqiwT7Nd+ltpKlD9gJYiDFw2t0/8mcSj/RfhvJ/2aSq0tRDnL4cbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtiUjjqX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtiUjjqX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f2676bb21so193137045ad.0
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 00:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767603098; x=1768207898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSJakbOsK6HuPfvndjr4pklixI6V6EaaZEWI2YnlWqA=;
        b=dtiUjjqXbW5jdbL8VOlxiuTtQUfEyMJBuZMuwbZ5AP9HI++LewDfGeIciBkMo97qLV
         k0p15eG5aY9g1rbscY7h0juJw7cKsewiUL58yWyB0wh/r+uJIFC0luGbgIXBnJst9bXm
         kcqMiCHDatExkU3ZQwDIj+2wRdBuXPmxPxxLW7IHyWcQeLIvCk0A025Qz2SIVy+vBGr4
         XMswSvZMCJPmUoJK4o2H+WZ8YbfLfvSvongu1fX4RdUdKorVROsOei/2kvlEclnG9cmb
         4QsTQ5fPWxFV5vFztXowIYQtjU41uFmoSXpJi/okhjDnYd7QFqqyfj+7pYuZyMyK6x8d
         mxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603098; x=1768207898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jSJakbOsK6HuPfvndjr4pklixI6V6EaaZEWI2YnlWqA=;
        b=MpeZWNH96v+Cp54ccXXjiz3gsbL6hlUo0PiSUh4f3Vt3DIklGcHa0DHLnLPU47Qa6W
         yc/JCOObvmkzkabi4texzs0E3ll5IAISrL96a3ggw4B1eofShqjqZL++jsVC0rEqRaw3
         0eqdP8MeenXKM3VBOiDoJBFcQtHx/eDr8CWHq4O74E09HVr56sMW5Ktb9eMP/U2lRRA4
         VBl7dl8h0Ug7N7iiK6FWAeVmgOyu/T99Visx6pYtGWOcvDw7Wj6LMs9aqb4SSCC7YlVr
         OA2D9N4gGmrfFI42bPlc5bqIutWJCjLfKqjU+yt3NXESHOpqqhdwFEKwykeCqt+SsKYm
         qPzw==
X-Forwarded-Encrypted: i=1; AJvYcCU9fAQHjyGrCnNpUWpEfDAW2I0KBALKT6Vi8gv+LT3k7P7ixHjnGiBv8A8hdcAah9tacGtb+4d6bIC3OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3s7pp3VI51yGGklmuK0LcKebGRYaY99PHOtNslSwILHz18w8c
	4CdOK7dyg/QEm8d3dtHaI7wR4cLDajs0EzylA3OeFSdeaT7r5f/876v6
X-Gm-Gg: AY/fxX5dAvYILuYNOnyEskyUs8fQG/w4pgYtL8FIBHfrq9pEsTpTMqAenShLFoaqSII
	HTQBbrsYeLg8oSRp+Gwh76w1NgJSvDqqxeyzO5zTtYuT10Hk4WzK5Q3SucdR+lw+pjQK0/VTIuR
	NMr9tHfhZ61rMX/m5vyUhcTI40JV6fQme9L/Et762eE5XwJ/1ieq/XOv6CzuLG3VSdFM1+y46SE
	McpO5/dOcBd02EJSii7a35rVkFkDxO6wOJa37pjgjxdupZvOx1YeNxxEsyViOvjC1BRI18hKSwG
	rL/HccvmUrnwLvMU7Z8tgpcQoIYk/AKghoFiA+WzOYYqaWf42HUP7TuB9aqhOPTQn6OdT15ejTy
	wcx1R+3fEE9r09L8h/xkEk7aqoFNZoNYH7Jare92cNJ4k0Yq0qJHHLhKX7MrwwM7pqDTrV7redq
	OD4xv/TQX5j4wrMCDonP83BXrxRyo6zGpncj4r
X-Google-Smtp-Source: AGHT+IGdSTNTsFlnHGoKbBjCGcgH0vsgwPkGV6SlKLkkpRQlPt3vpratMO2N1qpXOb9AsWAQeM28kw==
X-Received: by 2002:a05:6a20:3d06:b0:350:7238:7e2b with SMTP id adf61e73a8af0-376a81dc150mr42017932637.16.1767603097900;
        Mon, 05 Jan 2026 00:51:37 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476fab12sm5631951a91.5.2026.01.05.00.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:51:37 -0800 (PST)
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
Subject: [PATCH v1 1/2] dt-bindings: backlight: gpio-backlight: allow multiple GPIOs
Date: Mon,  5 Jan 2026 14:21:19 +0530
Message-Id: <20260105085120.230862-2-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105085120.230862-1-tessolveupstream@gmail.com>
References: <20260105085120.230862-1-tessolveupstream@gmail.com>
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
 .../bindings/leds/backlight/gpio-backlight.yaml      | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
index 584030b6b0b9..1483ce4a3480 100644
--- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
@@ -17,7 +17,8 @@ properties:
 
   gpios:
     description: The gpio that is used for enabling/disabling the backlight.
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   default-on:
     description: enable the backlight at boot.
@@ -38,4 +39,13 @@ examples:
         default-on;
     };
 
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    backlight {
+      compatible = "gpio-backlight";
+      gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>,
+              <&gpio3 5 GPIO_ACTIVE_HIGH>;
+      default-on;
+    };
+
 ...
-- 
2.34.1

