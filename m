Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24514A012A;
	Tue,  1 Sep 2026 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288645; cv=none; b=r6u4qdYjOuGlhdjoSIje3HppbM7QXmKpO6HEHCybsgSYp1oO1b3y/Gylh4jVl6kz/rXzgGTAjfmmNDSc9QEpcchYSURJCQ7V0ctO3plbu96ZwlNx2muO6HAOtF/GmtSNy7lVhnZpxf+saoMSqc41TLwdMk7MKKtkLQhxFyQvLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288645; c=relaxed/simple;
	bh=D/Mo27GDMqgDFGKu/PHByp3WOMc3rGEVU+1xPyeAtoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQ2RG+kAJei/3ZRBySCZMdHU1UW9WTKf/Njr7RsYoMRHMX2dlK9+sOHSDEtADE79fMhl5CT7VvxW1l0o/J7FPsRJ8aoJwsHAtykxtG7l9oB5WuA2BOaNIJyndSweOFW/BTzByybXnibq+EJt56unX47dblgZ/VDnORr0O5Fh8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=psmJeAhG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="psmJeAhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288642;
	bh=D/Mo27GDMqgDFGKu/PHByp3WOMc3rGEVU+1xPyeAtoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=psmJeAhG2lZAj1EtlnfR3XkGPbuiIBJAEoCGN4pfr0fT4GD5tMjrkQxXaWjHQ00vq
	 BHrLPEX3QB+llscfburDRtokNhg2UhwcIEI9G+Lj5qtGL5O4TM21avp2NxioiRP5Rm
	 MJlugQSASkZMzBq0SPC4KxolByw7/Aglg48UFdikPVLLXE4NfkZJrjV3rl23336six
	 3WncrTmoCyb2a9bWbHpD+UpEQcF2LjTfz3VHF0WlK5lWwe6pBqCfle4lfn0d231z4o
	 YuU81h15Xzn4vhvqjMgZTimxlQaCmEpxOv4vIe1l1SWQwErzXWOes5HHff9PA7Ju5X
	 r2E4OTp01LBhQ==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CC02917E0260;
	Tue, 01 Sep 2026 20:50:41 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:25 +0300
Subject: [PATCH v11 01/74] video/hdmi: Introduce HDMI version enum
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-1-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2

Add an enum to represent HDMI specification versions.  This will be used
by upcoming changes to associate HDMI connectors and bridges with a
maximum supported version and to simplify handling of version-dependent
features.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 include/linux/hdmi.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 8dab78e1f61b..b80a5ee63bb2 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -27,6 +27,18 @@
 #include <linux/types.h>
 #include <linux/device.h>
 
+enum hdmi_version {
+	HDMI_VERSION_UNKNOWN,
+	HDMI_VERSION_1_0,
+	HDMI_VERSION_1_1,
+	HDMI_VERSION_1_2,
+	HDMI_VERSION_1_3,
+	HDMI_VERSION_1_4,
+	HDMI_VERSION_2_0,
+	HDMI_VERSION_2_1,
+	HDMI_VERSION_2_2,
+};
+
 enum hdmi_packet_type {
 	HDMI_PACKET_TYPE_NULL = 0x00,
 	HDMI_PACKET_TYPE_AUDIO_CLOCK_REGEN = 0x01,

-- 
2.55.0

