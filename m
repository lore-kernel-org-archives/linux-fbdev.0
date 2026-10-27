Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109242;
	b=YVq09q3opzgXVeoKnjRyMdcmQVnK8DWaMiRJOdxHM20cDkLD5SPVFt8CNm9Up9nFm+iG
	 5G1BoqF2whKiRqTT2h/Ee5HeA7mFFYPs24sam0dxm7ugmREZMKpdKHAGrdPL0BinuEuJC
	 ukNsGcLae/z8ITEDYdWpwjZKu5436T9/gMt66yJMqTUCoZopxSPRgRw1h1tZWUfaltAnz
	 B+WdJQlfZjX4NATFv4qABvXWzXUVTbSVJoRngnzXYXla1txoxN3KmqBl8FRfzjOtub+XW
	 80BxxpF+UpGDbGff7LlrgmJRNklmq0QC8kg7p+roZxduix7SNmCakVnzyJ17Y3o9EqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=udMEtEpdximcj4tmN6XEoXZYcbf6JGtTIKRmg964qrM=;
	b=a+Y1xtE4d19Vz/IZ2d8lhAL1vSauBcYIfj2XfZIXa+8jMjIh8C+TiOiG3kEeQdYKuZxx
	 I8ciT6GEIF4RaoYaELVeaZQxp6hK0gKd6WsGJCpFF2ykwCYCgxF5ogPAuzxoUnkm/H4P+
	 ZoOV7rb16SB9wmmQDzxsCXH+XVtKYEFAJF/seEYhMegtSkdSHybdIxYmJ8iYfOUBxpJ5V
	 tPuCFMdT06xf7hy+WbJzXlkXZIetHd1R6PjGHmi82tXBD+XvVquNfRnypVwIn1WS31ogI
	 l6VhI97SWv/XokgLlj9ICA6oWxQLVlOaYEiN4RggDFskoPqqwsR7xTtmT0DSFtg6KXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oimiZnio;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B860A263A
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 13:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF5B860A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oimiZnio
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso2666247f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793109240; x=1793714040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=udMEtEpdximcj4tmN6XEoXZYcbf6JGtTIKRmg964qrM=;
        b=oimiZnioitMUEnEBSrenFhRbAKwenXYmVyqgKmWsRYCXK/JKGbsa6e1hchO+K8E4AP
         aKqtDi+/aJJxJ/ZpulCQo0A0FFLFB/P4ruAZvVuMg/2UK5Qi5nmFDuEhOUZtyGtwcLe2
         Cy+j4nHDSbUeCVSFCVw+TcY43hi62SLj4fCqzF/nem7rtyWJ28BtO6lO/RiZua4Xss0f
         IIxPsaHdtd5IKWoq+iFATJQSwz14z2HjyaC167tn5z93TbWRuy2QukEXN6vuiDh6h7kH
         IjmyOEcbEQ6slNZxbs92lcTHtMkLRShklgeyiQ3bXndapKr3p3emUgxr1TirGAYeVUY0
         6x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109240; x=1793714040;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udMEtEpdximcj4tmN6XEoXZYcbf6JGtTIKRmg964qrM=;
        b=JLxCMwcwFo4RdEM0Nj7sq9mH6UlNV1VxrqjUZ6tp5b2OnJzxRh7gqnSUfwcJFSr8H2
         rBJP/GLbgUi6vlxvOXFaikWtffXlL9LImLgY/X74KaH6Nu6kTc3W7TbaAeCfhIOVNhXT
         JidpmKBGpKzjw5uQx8Sq36LVD3XPdjZOVMV+ftdMOGBydT1u+xDfVEwzsiCrZn5LFNez
         dz1ZfBIZ9auRu4CSzpWoEobXpF1XSH2sqvIOQYOFX/7uFDWblX1p2rE8LN+a7pLVuNw2
         bhzJXeIBY8IdZkK/9W4zAPbp7b4AVrCjffF7u73vNp/3XRxCsPwKb7xo9nrd93NziIpl
         8eiA==
X-Forwarded-Encrypted: i=1; AKwUvBzg8g23AXgIKmXX/z4WGh24LlLN8QYsobwHZQQjNgQjyjMYX5fd1wDcQHhkIxO/GGmwqEYXeiF3+Bv2/w==@vger.kernel.org
X-Gm-Message-State: AFq9FYL0CERkSmTpV8s3nv+IYfwQW/GUG6gKCAIv2TPDIdPhOa4cbtgO
	FTt9QyYK11iGTq7wMv7ahWSgDlxPW3DOLbPknTUriux3HlBE8Ezf1m1i
X-Gm-Gg: AYBFou35GYlhDU7ia0SD0DCknmF0saxaF4LGvkuShEcK9wsRhKb4BobRtN2wjWvdnXB
	RFlubGgSg5vpldp7grV8F7FuwgPdZt2/qn56kHV+uiw4m9x8f66qmVr/3jZZBnCoHl7Li7NC8Y2
	Bpj1RWA9L49qyjtZKCPkin6ZizvAWDM8+gD7CFei0sOnhfLekeoofJU/WpBiRltGX84y4SG9DSM
	EEaTppEaO/w5NTkw1k8iAe57EsRAeXajinOEG/HR1crrqfBi51vCIVrUzbOrV0UP0cNmNY1bj2R
	gh5YDGgcM50MlkngT0x4AtvKPb8+JV/ozRny0SwZ3JNd3ts9h3gFrY7ncQVRimkLui1+KGq6KwA
	qKXbepJDZJDs6sgdwYqqIcPE9ro55WfY8fjDBlHwiBemKSZzfEPJ+Zhb/z8zN5EjY2pl04Xq+vD
	uNy2zalOwAEcCChvLr9KCfLTwDPpz9iFIB6NLrVp8SjvDLQChe27Wqm564Xi5nW39Ngm65Qlwhz
	wkq1aThBw3XJ8F9XV8DkCU0r1dZO5xIMeMxMIJuAgmc0mvVqJ65HlXGmlP6MvL2aLISUs82rMNk
	8U2wf4cmvQVS4XQH1jAlMN1I0Ito
X-Received: by 2002:a5d:5e8a:0:b0:48d:f56d:be56 with SMTP id ffacd0b85a97d-48e3eb7642cmr19483905f8f.13.1793109240024;
        Tue, 27 Oct 2026 06:54:00 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:53:59 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Helge Deller <deller@gmx.de>,
	Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-embedded@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/15] drm: docs: remove bootsplash from TODO
Date: Tue, 27 Oct 2026 14:53:33 +0100
Message-Id: <20261027135342.2003632-7-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Valla <francesco@valla.it>

Now that a splash client exists, remove the bootsplash task from the
TODO list for the DRM subsystem.

Signed-off-by: Francesco Valla <francesco@valla.it>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 Documentation/gpu/todo.rst | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index e6d36f8da086..5e987e18bfcd 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -756,23 +756,6 @@ See drivers/gpu/drm/amd/display/TODO for tasks.
 
 Contact: Harry Wentland, Alex Deucher
 
-Bootsplash
-==========
-
-There is support in place now for writing internal DRM clients making it
-possible to pick up the bootsplash work that was rejected because it was written
-for fbdev.
-
-- [v6,8/8] drm/client: Hack: Add bootsplash example
-  https://patchwork.freedesktop.org/patch/306579/
-
-- [RFC PATCH v2 00/13] Kernel based bootsplash
-  https://lore.kernel.org/r/20171213194755.3409-1-mstaudt@suse.de
-
-Contact: Sam Ravnborg
-
-Level: Advanced
-
 Brightness handling on devices with multiple internal panels
 ============================================================
 
-- 
2.39.5

