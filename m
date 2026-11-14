Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679469;
	b=KhAOSm6GtGfZJ7tCNMGB/DyW4MJ1X5EkE1tn6F4UnIVsD/8KOROsfRrM2hYih0qr1Jtb
	 Azrk1+gDWwuvpAW7nXrwaIMiDJ7Q1Z6NEDMFjKn0AmPw9CZTRNHo0QQokrIjGkj7ScTM2
	 0KVpQImddju+KwQ53xOccJcV0WehePoDDFDboTsiNFN9gxqEjSoPCaMFqkRRF31Di+raX
	 Z3/pacTRB9NUVA/KNwTr+yVLK5gAPWVdtX1/E2wo4aryHK++4cgl51HHOAXE7LqFNi9Kl
	 AKM5uG1fMx7IfalhbzMcaGbxnuszuFbkxaTRXqUOiYZwiSEkq1CSoUEe6dJXxZLvFRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679469;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=PPKZv2ZzWTsS10CNs+N/NoGqG4vTt9e9Cz+Oum51lWQ=;
	b=btilzCw1XZ+ohioonjsold+2OUCapaJ41Zn0l00APem4elPASmWouZY2qj6XfMfd/Z7S
	 JsBtBjFi3AqahlrghRlJCnWYW1MrynvAUEFzdAbPWutTGrpRK0u6DzirCHA0s3CFiSyGB
	 QLLB/ASVvUCfDi1TIchoahzO9N8/NxEvkMkLRAHACTUUs0vO2kSFIMrSWRXAAoqYUz263
	 MymjdF+q6O8J4ANwhi3gS1nvOIVpTW7d/pi36uwzUXq7glO5Cz3eFLga26kHRFFILJMq/
	 x3tIVm6zZdKr3evDdurLL6YWpfvUebX1IkU56K23p6tIUQGV60Z395l+LN6pGnBOWNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=LrOAWRRG;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD660A2609;
	Sat, 14 Nov 2026 18:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57FD660A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=LrOAWRRG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679466;
	bh=kHegC5BQ7xe8gZdxhbX2Jf9EJvSuDhfvsRHTrlqLOtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LrOAWRRGaVJpYl54Tp7GGGBg/+l3K7cGb2ek5Vs1X/20nQ60E+Sds0dEMjsdDnMkA
	 oGypaSvo98YzJfzJ799LtD0442vb7SmFBmvVm58N71x4r7E4izUgo/OiYnT0jLc2cj
	 rHWiHBeBc77kKQAlEOP+eZvEnEAGs/Uao06rzm1dLWJoMwJxue84z6tcsv90m6tuKC
	 ve+NY0TjpKtrerdT6lr6/8SpuDX0iLKWdVdwiRB4Mf1QLZbizKnUDXrigQN/w4MNAa
	 c8uO71RlGeBA2UWV9c5k9PPB15dMuzb6wGhwx15P2KhHj/fVxaWRfMUPPN5qgIAmGJ
	 ZzW7BTt+zhIqg==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 41EA817E38A5;
	Sat, 14 Nov 2026 19:04:26 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:36 +0200
Subject: [PATCH 12/25] drm/connector: Fix comment in
 drmm_connector_hdmi_init()
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
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-12-20e8a33a2286@collabora.com>
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

The comment related to the computation of maximum TMDS character rate
refers to a non-existent caps->max_tmds_char_rate, a left-over from the
early stages of development.

Update the statement to reference hdmi_funcs->supported_tmds_char_rate.
While at it, replace the incorrect "determinate" with "determine" in the
same comment block.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 355ba53cab6b..663b3072a1d0 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -618,13 +618,13 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 		return ret;
 
 	/*
-	 * The supported HDMI version can be used to determinate the maximum
+	 * The supported HDMI version can be used to determine the maximum
 	 * TMDS character rate allowed by the specification. Some controllers,
 	 * however, may support a lower rate than that version would imply.
 	 *
-	 * A non-zero caps->max_tmds_char_rate lets drivers override this
-	 * default with the actual controller capability. A value of zero keeps
-	 * the limit inferred from supported_hdmi_ver.
+	 * A non-zero hdmi_funcs->supported_tmds_char_rate lets drivers override
+	 * this default with the actual controller capability. A value of zero
+	 * keeps the limit inferred from supported_hdmi_ver.
 	 */
 	if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_2_0)
 		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;

-- 
2.56.0

