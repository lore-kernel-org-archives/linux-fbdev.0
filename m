Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679466;
	b=qa1R5q6RA50Apwjk92R8dCq9GlogxX3EJFljm/x+qlmGWuoTL70xG7Z89yJaA8NCHKDa
	 cHvuZ/zn+YdqoO/RNS14vQEc9Jn+yHKputmNYhgV1yZ9+L+xZpg3lyeQuIFjZolFaleDM
	 dmu53Ln1n5JZl4I9/CdAApTiPc4Kcxfminy65L/g4GbLKhKv+C2SYcejIT/gS7Yvln7le
	 IrnWQYrcBwjpYzTCU2vfLFLxQJdygApo2viqWy46fq4MVNXpQNhgDw96Rld3kUuTStWxe
	 5RYETYUckzlXr+SlrQ94fLgJD/9A8gCSJc38RXYQlyjU9dPWbxAp46tn6szhj7HUYSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679466;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=VmgdJhLqdvObEmVdZHSnVjMxF7CRFu4RZ0ii1YVtQJk=;
	b=uerf/LnfasT/ylqqUDm9tuyxQ9EFTJJwOTn84tW/kIls010PKQUmTsfLt84HhdKXCIet
	 1Wblwa+6s4C7IQNAJ0PdMjVO3z4qgDqNKwrHs4pIGr9UdBPIyQuIQUnEhw7RWZCt6Cwx4
	 bzX/MQvO6FbsBp4dvjbDPamSsb2AZsNfOmx4BzlIalbbHEEU7o48Vl04oNzC0XDacTmLd
	 l4vFWKRcna5XvjB+w173U+E3K+yGdTZJxjUMjLZCM/Qj2iOs36Si/on9c0LauWQ9g6gXD
	 uY4Iv6aDsshA20ItGOGB2BxNP7mLncJ+zH3ZBnQ1SFF1aerMO5uugsn04opgW+bjt4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="B12y/U9Z";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44908606A882;
	Sat, 14 Nov 2026 18:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44908606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=B12y/U9Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679458;
	bh=owVPqFwaoXUU+Gcwxuroc+P7E9LF5U9XqHzH7kbz1s0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B12y/U9ZpAz20vm5D/hHAoJXT6bUWc70g2oxD7FJYj70lsjHuxYMk0KvXUVmc8Fei
	 sj2Lol28GXfoqtzZ/DUXkdVS9FOY3M//CY3rjl7QCYHaUyxVv8fusKD3D5NPueCAbS
	 EioT5ySwEncxK10qAQE1R1O5X5/Rvm5CaqO63kWxFO46HqaB1FDJpQB3AsXNpjRLm4
	 K+7qDUM+TLAABHVc2VoIalm5nNucBNh5PRVxk2BjubXwq3KNzLf+L2HHWzAXjBGYrX
	 hlDHzub9P2V7fUU19t4dEC9Vr/2Mckl1RU32SVMvf3ZMKI/CWonWN42wuXXX5YuxN/
	 cvdFwRv/tqRtQ==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A669617E0BCF;
	Sat, 14 Nov 2026 19:04:18 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:26 +0200
Subject: [PATCH 02/25] video/hdmi: Define SPD InfoFrame vendor/product
 field lengths
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
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-2-20e8a33a2286@collabora.com>
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

The HDMI specification defines the SPD InfoFrame Vendor Name and
Product Description as fixed-size fields of 8 and 16 bytes
respectively.

Add defines for those lengths and use them in place of the related
magic numbers, including the payload offsets and the log format
precisions.  While at it, fix the continuation line alignment in
hdmi_spd_infoframe_log().

No functional change intended.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/video/hdmi.c | 20 +++++++++++++-------
 include/linux/hdmi.h |  7 +++++--
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index cd18121afa20..7eeadac2de69 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -304,9 +304,11 @@ ssize_t hdmi_spd_infoframe_pack_only(const struct hdmi_spd_infoframe *frame,
 	ptr += HDMI_INFOFRAME_HEADER_SIZE;
 
 	memcpy(ptr, frame->vendor, sizeof(frame->vendor));
-	memcpy(ptr + 8, frame->product, sizeof(frame->product));
+	memcpy(ptr + HDMI_SPD_INFOFRAME_VENDOR_LEN, frame->product,
+	       sizeof(frame->product));
 
-	ptr[24] = frame->sdi;
+	ptr[HDMI_SPD_INFOFRAME_VENDOR_LEN + HDMI_SPD_INFOFRAME_PRODUCT_LEN] =
+		frame->sdi;
 
 	hdmi_infoframe_set_checksum(buffer, length);
 
@@ -1284,10 +1286,12 @@ static void hdmi_spd_infoframe_log(const char *level,
 	hdmi_infoframe_log_header(level, dev,
 				  (const struct hdmi_any_infoframe *)frame);
 
-	hdmi_log("    vendor: %.8s\n", frame->vendor);
-	hdmi_log("    product: %.16s\n", frame->product);
+	hdmi_log("    vendor: %.*s\n", HDMI_SPD_INFOFRAME_VENDOR_LEN,
+		 frame->vendor);
+	hdmi_log("    product: %.*s\n", HDMI_SPD_INFOFRAME_PRODUCT_LEN,
+		 frame->product);
 	hdmi_log("    source device information: %s (0x%x)\n",
-		hdmi_spd_sdi_get_name(frame->sdi), frame->sdi);
+		 hdmi_spd_sdi_get_name(frame->sdi), frame->sdi);
 }
 
 static const char *
@@ -1642,11 +1646,13 @@ static int hdmi_spd_infoframe_unpack(struct hdmi_spd_infoframe *frame,
 
 	ptr += HDMI_INFOFRAME_HEADER_SIZE;
 
-	ret = hdmi_spd_infoframe_init(frame, ptr, ptr + 8);
+	ret = hdmi_spd_infoframe_init(frame, ptr,
+				      ptr + HDMI_SPD_INFOFRAME_VENDOR_LEN);
 	if (ret)
 		return ret;
 
-	frame->sdi = ptr[24];
+	frame->sdi = ptr[HDMI_SPD_INFOFRAME_VENDOR_LEN +
+			 HDMI_SPD_INFOFRAME_PRODUCT_LEN];
 
 	return 0;
 }
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 08922d5330d6..7d96821b486d 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -267,12 +267,15 @@ enum hdmi_spd_sdi {
 	HDMI_SPD_SDI_PMP,
 };
 
+#define HDMI_SPD_INFOFRAME_VENDOR_LEN	8
+#define HDMI_SPD_INFOFRAME_PRODUCT_LEN	16
+
 struct hdmi_spd_infoframe {
 	enum hdmi_infoframe_type type;
 	unsigned char version;
 	unsigned char length;
-	char vendor[8] __nonstring;
-	char product[16] __nonstring;
+	char vendor[HDMI_SPD_INFOFRAME_VENDOR_LEN] __nonstring;
+	char product[HDMI_SPD_INFOFRAME_PRODUCT_LEN] __nonstring;
 	enum hdmi_spd_sdi sdi;
 };
 

-- 
2.56.0

