Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF9283FC3
	for <linux-fbdev@vger.kernel.org>; Fri, 20 Jun 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415498; cv=none; b=ePeqB35m9ujVoz2GcFyjR4EtkMfzUGeA/hzr0q043qd4eVCI6LiPIGhDcUbQuHgL+B5OT7omsVOC2C1Gp+Vt8hmNCFo8V9LMGzORcW8zYyjYXzh/RN31oStrLFUT3CAmF7JhKjMDRbn+EtT/xz4rTjsFmzjAb6rw/ZNvF0o1+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415498; c=relaxed/simple;
	bh=WbYAkf28JuDB96zhXvwINlUm7Z+jr4BgOqrEfl46LOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cn5uqE46aRG9NOC8YAkCAw3dUcWmznEe8CHFMnlHVPm7ZI+Q4NN+B1Z6auEv3gyzHuqiAq2z+C8F2UEymYMLltMoPRsX3NV7BcXYB7zMBC+wmRJ3L1b6DVADv+VAR3W/mLkGMHcxsRLAdgGLtwfAavU+szH5oLe6p0Wlwp+Rv+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=0YERWasn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="0YERWasn"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade4679fba7so324758066b.2
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Jun 2025 03:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750415494; x=1751020294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8TW+dnA/RLSUCo5w0FhkO5CxTqAKcs/iJjNLMWWbto=;
        b=0YERWasncf+NVmlsSfe8Cv1whAklJamFlVlB7/HIsEaUEq8YeXWyCvEjSYDSxCZsja
         bn67UXwW55iwrWuYTe9uhhTarQ6Cy+o+ThNOPy4NACCB+tIfEPtDNVg8xk1fZBoZSX1b
         ZiOruCxw2qdq6mQwTWc7e2wm1is132LuTqyp+fG92tfOhkPGVo17WnslDgb+uPeiyIee
         9BtXInIW8VQg4LjOHf4Z+4a8qHafFUPkT94nHmp34PJewSC8nw0XXMlwiP1gS4GbiewR
         zhydQFMMw+zqR3K5FlZA0509eKb+ySUXM3iOKqkDIKV3LYi+XDFQJQiI62RX3l3C5WIx
         8PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415494; x=1751020294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8TW+dnA/RLSUCo5w0FhkO5CxTqAKcs/iJjNLMWWbto=;
        b=JS0FWXGNRUI1QWWEQk24zivjnKMmJIwbtoG2hAqRbnYdnQqJxxVZ4jNlzweZNYcp0E
         Nps4mu/nPFKDW9/v2mqrgpLYaTIQ9YMZZGP+TxTxec1lw1fdfLMFDwVcejafwauqCe7q
         fuk2OfBC95/t2yXnKcoOf+QZAgSvM2rfyUOaU0Keuu04yZsw0Nt+My8mBiXyFAC/m5bG
         V/PlNWGQdjgZpNNuAUyRESawrG6fbkckZPtFQHsxoxPxYIE4E7EJE49PJyTPcdhRya3w
         Ks1INj3wwCJdI1oexBG4xbypKH8Vdh23iqASctvreAbVVL+nUpqk1rsKHYIBD5J2j0yh
         5T6w==
X-Gm-Message-State: AOJu0YxmKcKzMBrn3ZYsUhFtEgAF3Y/5eLK86WyipwhV494ZGSzUkYWe
	uGLbFq80xPE+I4c1mZVcm4UgUAqfFHqZsjFiKlFDGfrSRDCQtB7pHy01JoZ+4JUa2KTR4gA+5QS
	sEhpV
X-Gm-Gg: ASbGncv1t4W89oshbuz1MXSQBjHwgfh1oHVxsFbrxzZKDY4HGWwjL+r8IUYTSaxap05
	Vqj13DWYsX0Xwgio2FY9AugkuJzhx8D3VUGMe3f6s66nrhJ//k8s96zPZRemXidfIAVdabOwQjc
	gSq6thPqTYAyaPSmPUUvsg6AiaQwKV6G3GgVlXCL0l6kPgd/SXtyeYwQQNrCOsOn00FcfJE4aKd
	wKGQXZmsQuOSBujmCuBOMAwuxDedSG4xo9mYHE8rXo6gX8Q7w/0AzH7M65EJLKMOQanD96ZOJ1i
	At9G94sXGuwfiogXKOy7Q9EURtM2ueLM3nrOUuLeNW+WT/uIlJ8JHoBr4Kw+BOFMsxG5bzjvSBF
	cgFAuHtVP1plqyrP8cDAilQ8zKquTk/MU
X-Google-Smtp-Source: AGHT+IE9P6hDfRXmnpE+5S+EKxKkHp70DsQJ2ovXtC7hTz0ZIMVcZscGLt+vhpJFn076myB8MB2log==
X-Received: by 2002:a17:906:dc8d:b0:ad8:9257:5735 with SMTP id a640c23a62f3a-ae0578f527emr214907766b.3.1750415494301;
        Fri, 20 Jun 2025 03:31:34 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6f5csm138047366b.122.2025.06.20.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:31:34 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Jun 2025 12:31:25 +0200
Subject: [PATCH 1/3] dt-bindings: display: simple-framebuffer: Add
 interconnects property
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-simple-drm-fb-icc-v1-1-d92142e8f74f@fairphone.com>
References: <20250620-simple-drm-fb-icc-v1-0-d92142e8f74f@fairphone.com>
In-Reply-To: <20250620-simple-drm-fb-icc-v1-0-d92142e8f74f@fairphone.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750415493; l=1090;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=WbYAkf28JuDB96zhXvwINlUm7Z+jr4BgOqrEfl46LOQ=;
 b=Y2GDVlFS+pU31aOX4ttTn8hlbLrxRlFtAH65SYN7sC9Zi1EhHz2D8Jo4kgsda6sDYGZfr6MTp
 AOzkGxhs9TXBET7U25bdMMFdcIgeFo2aN4c/Q85bn4pS2/9RgeCHpZw
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the interconnects property which is a list of interconnect
paths that is used by the framebuffer and therefore needs to be kept
alive when the framebuffer is being used.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/display/simple-framebuffer.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index 296500f9da05e296dbbeec50ba5186b6b30aaffc..f0fa0ef23d91043dfb2b220c654b80e2e80850cd 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -79,6 +79,9 @@ properties:
   power-domains:
     description: List of power domains used by the framebuffer.
 
+  interconnects:
+    description: List of interconnect paths used by the framebuffer.
+
   width:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Width of the framebuffer in pixels

-- 
2.50.0

