Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF51E231D
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Jun 2025 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661100; cv=none; b=TocCCxAEbip1HYLN+/maN3tC+CFNwC9pWPI/J57UFI9OwPad2XbLdntfT8v3ArvGhhyYcEmAcOh0gFl0pE8eRpdVZhF3FsKcIJ9G9vWFH6sMHYnbSj4/UWPeRAa6wUQAZnhXeBLpENJ8lnYHDYWIjqwnrHcHSYZojkTGcGc9H08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661100; c=relaxed/simple;
	bh=P/y3z3w1bngNRTUAIAgXINyaHlzNiSUuhAN9U3zpOWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfSZ45EmMEXWXznMqeTJ+Gg/+9gymijjrwIaZyG/2ngMtHapnucEv1j1IvMpBJWF3Go/WOOdKD7nOuXAi8a880ysE8W5snh3OSV/YNWusZ4ruoYl1AYCHMX9RzyZBLDNqC6JJay9mMbSWSwKXOsGJL9JabJI3xoz7NrQQl769wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zClBLkYV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zClBLkYV"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-adb2e9fd208so787860166b.3
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Jun 2025 23:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750661097; x=1751265897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCS5FhWMALYSCiWPAUtyrj6QhDfP/0lmNW3Nr7cvou0=;
        b=zClBLkYVl/L0cfN73dDvFKluhkWFpYpnFd3Y22fzEBu1MZ144r0GvS4zXSGzyh3WgC
         BLHk5YniDmsHPyLnVX4W4DFwnal1ijNXsRWu3zNYluPG0g84/Y003ggZcYiQMZFEVS6l
         90r9J/TUgpa9WjRBzQBNL8TJK2wWKg/tMmcdRO4Ks4JWQk5KzfVR+4qCkW5DAFTGfbSL
         rZhYs8WMw7LWP1A20UGhR7JE1zWqR+tTKFKZjsrpYIz/3rt2thuGjmdSgma7nZauQXay
         jL621F2ISoFXkb1o0ryJZvpoAvK3hTMgR1QvR7Udy7W2QWaZO6JD1pqwOQ8ZnXUHcqn6
         2XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750661097; x=1751265897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCS5FhWMALYSCiWPAUtyrj6QhDfP/0lmNW3Nr7cvou0=;
        b=s29+tBDov3rE7LT9JJamdzU8EjpKl52xUKd5e6U1xB2q2ZIpFl1oCOjDSNNRzzB/xF
         WdJHwbYB+DDk6AIivnCCDVXw1MVIUVOXz3YPfBQX+oLbPqlZ27ZMVwfsODMLa2cJyrUz
         g0MhjYnqJ27aBlK4hvIKnX7TB8zcw2XJZ3PgJ7J0Q7k8WPaq8DVkcbke4A7W/+8RiOCX
         KUhL133YDU7gORJ/dXEE/u6gTL8rRAkTUwOl1UL5SVMnU9L+YStHkyArx890pxyHBoUS
         0WuUinX6zE+WA8zaITB2nS6lDoFFJSivzpdgJNvqln8hJgWTvtLxRkzNoHnakWRkZYRp
         3mRQ==
X-Gm-Message-State: AOJu0YxKaNNhx3VwUOpgciOxEd92f2AsoO9pUFZk0NrkEn+zZxXyn0Ra
	XYil4Iy8+YoQ6UMa0nrh9lH6GgVxmszFaQgihACxJFxSNHX/uEsiOCX8nThMQvllSiA=
X-Gm-Gg: ASbGncuSuBVS9ZzW6JkauIR4bTJNOt5ZaP770idRFqOxWyeDGBY0sO046WoI+Ivw4vv
	N9FWGUUf7kQ2/W5Xqfwmrwb6MLCDKLRzzvsb8TaE0mBMGzxezCTqFAkhFsy6fmXmYpwaktpbtHN
	PMaMSsOFy+IiS2cCHER9GTZD8v5qUh9JTOqpL7HMlyLCQja8w0w2gi4rnw2DOfmglglXQoMEYAD
	58glRPfXidBmis4MM+lRzPsz6pMJw32KOqRR3eGHMby6/Y3cF5K4puKoEwx1kEkhMJy4Zj6yi3f
	2hLN1LdQ2QhzYP8DUe1AedoW4BzKLbRIgiNB7vaUrMQeUQwrNfcE0TeDOxLCQ0LmIZJKlANRKLJ
	Cb60tNrSErXD45rR/HW8objcD0i8m9Mbx
X-Google-Smtp-Source: AGHT+IGsh9xvJEArfar+Dr0uRl16EBYyKnUhy6OWWKR/qb5aCazP3FzJZEQo/dxm9nUzIFyPy5Bewg==
X-Received: by 2002:a17:907:d8f:b0:ad8:8c09:a51a with SMTP id a640c23a62f3a-ae0578f5642mr1122704566b.4.1750661096907;
        Sun, 22 Jun 2025 23:44:56 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ee4ce9sm659258266b.69.2025.06.22.23.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:44:56 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 23 Jun 2025 08:44:45 +0200
Subject: [PATCH v2 1/5] dt-bindings: display: simple-framebuffer: Add
 interconnects property
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
In-Reply-To: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750661095; l=1141;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=P/y3z3w1bngNRTUAIAgXINyaHlzNiSUuhAN9U3zpOWw=;
 b=6pjVbQkuIUa2qv2HWVS78fdybrtLmM+hDbK9+CQFefqu+4O7IH7z+Lx0F9v1sVHODRyMqXBxS
 7Wh2+Zt4EiKC+fvVHgIMp5BhnDBPnUj+x9vrujCz05xSnU29wMieOM9
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the interconnects property which is a list of interconnect
paths that is used by the framebuffer and therefore needs to be kept
alive when the framebuffer is being used.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
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

