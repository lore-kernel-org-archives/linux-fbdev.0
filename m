Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766818;
	b=qHr4mmaKxrJyjopd0UgczIeLdhxzcFwX8Mstw3O5lF/UkAaB5+fn+vLhM0YP4yAmIyC8
	 +1cOTMF8k8EgNU5oXpxbVx+uWbocPqpJBfVpcHEg1yj+ZV+KvDfjVQtOPj3M9H0VuTp6e
	 F8dCvSTy0Fydf1pt8k89r8aDPPbU/ah5zNaG6prTBy784BWWGU7sFgg1k/qGGYlWIHeyW
	 Q0XdSMv2xq6vseEyaELMXJV+JuNfWTrekTxxV6MQOZP59aFo9WAplmkB5/rwXD9M1GOgs
	 gS+LLcSCEpIEyNtgBCmD/scTfa0cQtHkhWn3KPLykLes1ZqLT4zPZ5Jvt3RpcUdG9kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766818;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gvWBA1mhx8ibYVBggwemKsSLz8VkwDf35wvv7VpFuF4=;
	b=jQl3xjlm8v828Uxse8WmCkq+f6E6CXoKSFAEf6CrUBBNCeL7QZ8IrYyt50KPh1HZPqhQ
	 yXotDgYeRBqzWe3PUOoWJzZmpmtrrjtBL3ff7HMXmrc1XfJQzmulM6n86IyHGTDje+tM3
	 ZkPBwza7byJB2phLtRmkSbkXXhE26rtqYyUlWmnG9wHtzENqB2MCdHVFeh8F8tWVS59nK
	 VlMBniVqNE9PAQgJ1rHOScH9I2jaz/fu0LBoAQndye9pViBbqrYWLd0CEAVSXdJuuV/2f
	 DkFjrv0FyBP64apRnHf5OR41gcK/xNaLXaS0ssfhCbE/qjgakuWUrETq4+NYzxuYLFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=NKiQWi6G;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32606606A31C;
	Fri, 27 Nov 2026 08:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32606606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=NKiQWi6G
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 2D6D74C972;
	Fri, 27 Nov 2026 19:06:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795766809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gvWBA1mhx8ibYVBggwemKsSLz8VkwDf35wvv7VpFuF4=;
	b=NKiQWi6GIrzDGR2pthCqjgdeHpEK1h48kycZnGQ7Ij9HtRGZZYqaQzFhr33YzIhXsi1wtz
	Hrb3hB6WyphdOfO4PgxapHCaxHo4CpfbhEYOPBZoKuJBa9aZNXnsV/ljO+tPh2cTY/z6px
	ZdnS0wSCDQOPZihsbANHOh0Nyb40lS3tWMWiALnJrcQsB4VydiV4h3H1rV6EuJQ1hNtuUX
	HcFoKpCA2XAkHSBIa34g6fCWIQFwDQxpX2+Jk7pqaneaEMiu9Dz6/7NlRykG5OtEE4/eN5
	wB7z1OQGZNxmcuAsT/zGrX5JHiikTexn8pVu91UgyrPGXTvlUmbMzUvjI848ow==
X-GPT-Reason: legitimate; the message is a technical software patch
	for the Linux kernel, which is consistent with the personal mailbox
	of a developer (alastair@d-silva.org); the sender domain matches
	the recipient domain; the links provided point to the well-known
	kernel.org mailing list platform; there are no markers of marketing,
	phishing, or urgency.
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
Subject: [PATCH 0/3] arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI support
Date: Fri, 27 Nov 2026 19:06:46 +1100
Message-ID: <20261127080649.1982883-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
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

This series adds boot-time simplefb HDMI support for Allwinner A733
(sun60i-a733). U-Boot enables DE3.5, TCON_TV0, and DW-HDMI2.0 and
updates the disabled /chosen/framebuffer-hdmi node. Linux keeps the
display clocks and PCK-600 power domains active across boot.

Tested on Xunlong OrangePi 4 Pro, based on:
  [PATCH 0/3] arm64: dts: allwinner: Add Xunlong OrangePi 4 Pro support
  https://lore.kernel.org/r/20261125124407.4098345-1-alastair@d-silva.org
  [PATCH] pmdomain: sunxi: pck600: Initialize pd->pck in probe
  https://lore.kernel.org/r/20261127080625.1982574-1-alastair@d-silva.org

Alastair D'Silva (3):
  dt-bindings: display: simple-framebuffer: Add Allwinner DE3.5 HDMI
    pipeline
  arm64: dts: allwinner: sun60i-a733: Add PCK-600 power domain
    controller
  arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI node

 .../bindings/display/simple-framebuffer.yaml  |  1 +
 .../arm64/boot/dts/allwinner/sun60i-a733.dtsi | 36 +++++++++++++++++++
 2 files changed, 37 insertions(+)

prerequisite-patch-id: 309a5a3ca5b216915907263dea7024263abf1d1c
prerequisite-patch-id: 55e543b9854c7ae2fa86969233d05ccadd3792e9
prerequisite-patch-id: cfcad85224e288ec2168e7f245b4a1c63e9a34a7
-- 
2.53.0

