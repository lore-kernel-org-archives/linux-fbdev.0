Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766822;
	b=SkFidnT9D8iOo/n2taMZDGuSvov5Xsc5WLR0R8qSXVEijnqHuslUAHT2HquG6TQ5zgeP
	 hnZyIbyb0B6b9bjnkZND3wmnv/yfz2jvX6+BYgwkUFs7bUkxePvyzs9AhFpasfNrrjuUi
	 5dPQ0dFSrqx4wIg44es5G0tcywTUzsE/+8qbEZJpG/LImjcfkO9p2zsiImsWUrGIfExGr
	 UaKPhk41W2J0NKrLDSwAfkmsbnK1rGgAAQva9v5yJ3rpXztXct3/RXFvDSPYXAlZnyX3q
	 s1Ryu30m+P3Tw/JbDehVOCfwt/6strkeQju+3I7LSFwSCRqAxXUvK1eQjgyYHrMMZoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766822;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5+4WWMGxQZEZwgmCm5Go6TCy3m3YHuZQuM4Z32rUfXE=;
	b=XvCRW8ZybkF2kPUzfieXb+FHbZ7xQ8+yq1CSD3fczaTvwvDqThj7JQnMpNRalXiokOZR
	 Nbeoci1asi4EG3jkSEe23cuRzxklyOAhYCRpEO9Zq/K3yFRd0PRBB3rM34mRh5L8NqRc7
	 57K6KGIpJiL7gNOQw5eEN/ZCdBRyuIDWGuR9kVgUufbatbSuHdmzLx/J3HytRqAhkxx9o
	 QuEAlmvXaue03f/dYxlfc0oZ+DrqtxRCrUMR2Gw1gOcWdwUbs/Tzf8R/NAZW7ISW+7O0u
	 bacVWeZFk/281PKpD+B6FWO2jy0JPUHx3OqucS8Lm9y2feLHLhuQ2cvdFtvLv885/Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=ODRjKCOG;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71684606A31E;
	Fri, 27 Nov 2026 08:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71684606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=ODRjKCOG
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 909534C979;
	Fri, 27 Nov 2026 19:06:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795766815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+4WWMGxQZEZwgmCm5Go6TCy3m3YHuZQuM4Z32rUfXE=;
	b=ODRjKCOG8mpFQk6IQDfrwcfRKrp4wvILiOuH4J9F74evzSwb5hfcIz4XfvDBq6m9YbdYa5
	a+80zMmC1UlgjtpoLfYwCU8xOsXBiB13CIUHlwHPvDofuIM0mjWdbm0V3/RaXwDFN/C8oZ
	hl+D4QbmkvxduyDrWzPDiSbGU8IdIsJVEXfLw7c568UaGVI2431JtpAIo+wsFtpRiWumzQ
	yyaE+GXf3XAuRx7OlkkIYVgpq+bP1ShPfQ5Vx9x6VZ1cWEBJYzJS9tMwmWI6tDERyifZDK
	Bn3ZPZFI1LR3AdQQr9A5y5h0XDxgzrkupigLw1O+dE+2NOdz2JMnE6eZgRJ5gw==
X-GPT-Reason: This is a legitimate personal/professional communication.
	The content is a technical patch submission (Linux kernel style)
	for a display driver, which aligns perfectly with the personal
	mailbox (alastair@d-silva.org) and the sender's identity
	(alastair@d-silva.org). There are no phishing indicators, no urgent
	scare tactics, and the message lacks any marketing or malicious
	links.
From: Alastair D'Silva <alastair@d-silva.org>
To: Hans de Goede <hansg@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 1/3] dt-bindings: display: simple-framebuffer: Add Allwinner DE3.5 HDMI pipeline
Date: Fri, 27 Nov 2026 19:06:47 +1100
Message-ID: <20261127080649.1982883-2-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127080649.1982883-1-alastair@d-silva.org>
References: <20261127080649.1982883-1-alastair@d-silva.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the de0-tcon-tv0-hdmi pipeline for Allwinner A733 DE3.5 HDMI output.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 .../devicetree/bindings/display/simple-framebuffer.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index c627ec088434..350cb075f055 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -131,6 +131,7 @@ properties:
   allwinner,pipeline:
     description: Pipeline used by the framebuffer on Allwinner SoCs
     enum:
+      - de0-tcon-tv0-hdmi
       - de_be0-lcd0
       - de_be0-lcd0-hdmi
       - de_be0-lcd0-tve0
-- 
2.53.0

