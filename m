Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679476;
	b=ruQzc189gd2UWMXTsjJ+3ju6tlZfK/9M9Vw2wBP54TiNr+JUuXPuSlvdVTu9r9mjNd2/
	 AuJRafhMWmaeWkIguSyeX8KfaThHk+xvOvnWscQjIZMP+O9pqxN2g6xESWx/KJtFwjI6+
	 r/77n2iwhRK+fybCT1mhDbCXCY1eqHDndhPBMy6d9pztT4Af/onLyHtzl4I6XeNnQ8YPC
	 EsazrPFJr/HHKfvxv+89uFDzSLwWtbJTXEbh5xsP8/Lw6K9ZDU2AbjQFUPkoG8aYR+Z3U
	 qtr8Pmk56hF0y5RUM+CJU+NjMBCdHuTu+5eTI2vELx9pYUeVNg1bFXh8oEHsF8e8shQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679476;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=8bjBYiD5D37jvpg5VesdXHVTRHD5jnnq1u2u3oek6rg=;
	b=h3tSKFheQfKhkzC24bRW2ALarN0Hn6CAYItyISq6jH7dXGB3UeGzhPQ48FQbXADKkieA
	 YW22czlydBb8Lkl6+c8RfvYWjEVzCVGc1YAXDDWuIZwgeVttkyUZRpzNcHCj8ZnDpMXdl
	 XTpNa759uJA8arw1cej4IHnkmBuE1Ihxk5C+u/LBFks2iP8VttWRDt3PSlfGnIhNTbsNt
	 PfL+N+9UWHyqtWDZVNtsTIsaFL4t3G6FKZ0JkQJggbO5b8joD8Is7xakm+OLYFah0EVxE
	 zdLpuFFQ6MDnchOOCICMyLXbrO3plhVEaQtl5n4QvLRvct0dSe4UiuEWJ2wsT/pRwlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GBL2ZaHg;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C1606F73E;
	Sat, 14 Nov 2026 18:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8C1606F73E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GBL2ZaHg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679474;
	bh=OFB12+1anyq+FxPnNN5cDkJ8yEUeCz6dJ/YZ1rPl/kQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GBL2ZaHgaCud24DPMWRwaGvZUU35Q7UUoagt4PirZmlB9RRg1VdWPG9aF2QIGj7th
	 trjEEqxRZfOc9Perc4r0VwZswQIrR2CCrCnA4JCye373YT3/Razak+qa7c/44XWxqF
	 wniilQS73OCTKsb52i9Z2S768slA2uy+tYD9TphBj5m38tUTl/ZPerQpMtv5TD1rLF
	 vJ3Cs6RNfE+ArMgDad1jXBwMS8E8QODJQUKOrpqAQO50pbpiX9lfU+KvclL+YSDYnY
	 qmosYqlSai3gnDH41MPS8WsVcObWGHx9jVNyo+SB6aH3HkHgEiVIwAGAwNyqv/r9pV
	 l2cAOdPVp6/WQ==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8E11D17E37E7;
	Sat, 14 Nov 2026 19:04:34 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:47 +0200
Subject: [PATCH 23/25] drm/tests: bridge: Set supported HDMI version
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-23-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

Bridges using DRM_BRIDGE_OP_HDMI are now expected to also provide a
supported HDMI version.  This is not yet enforced, but will become
mandatory once the migration to the new HDMI connector initialization
API is completed.

Advertise HDMI 1.4 as the default for the test bridges, since that is
the highest version that does not require additional initialization
data.  This also avoids implying support for HDMI capabilities they do
not currently model.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_bridge_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 15583ade8494..a445f71c31b8 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -497,6 +497,7 @@ drm_test_bridge_chain_init(struct kunit *test, unsigned int num_bridges,
 			bridge->type = DRM_MODE_CONNECTOR_HDMIA;
 			bridge->vendor = "LNX";
 			bridge->product = "KUnit";
+			bridge->supported_hdmi_ver = HDMI_VERSION_1_4;
 			bridge->supported_formats = (BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
 						     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
 						     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
@@ -597,6 +598,7 @@ drm_test_bridge_hdmi_init(struct kunit *test, const struct drm_bridge_funcs *fun
 	bridge->ops |= DRM_BRIDGE_OP_HDMI;
 	bridge->vendor = "LNX";
 	bridge->product = "KUnit";
+	bridge->supported_hdmi_ver = HDMI_VERSION_1_4;
 
 	ret = drm_kunit_bridge_add(test, bridge);
 	if (ret)

-- 
2.56.0

