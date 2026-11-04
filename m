Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.240.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759721;
	b=uO9yQ/6OaGpsBQ2HeOF/tq+bPkK2O0JcLWM5ff1fy4/2PwJ1CQTX8fo7q4uEBJ2pBiMV
	 Ay8EDuty61OzpVPyPqsZlGE+vHG90BJNRLzwf06ymgesOdSqwMKscbt561Q505mIV4LTS
	 hr7/6kipb+QQur6SN88HhLkHTyTjkMI3+ta0425wNYfkCCp0eXEnkW+mNP/jEGYQStbLM
	 woFicxkv3HIlNpYx+N1dN+atwXDm4pxTZLV5Em08aZeDoUTekb6M2TnVsI8V/59h4qU5M
	 CfjbArwcRysza2U7dse1DOJBj0tqS+wwciiRe+Elv4l2Pw2hMHPnNE6LzzQxIMoh14A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759721;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Sender;
	bh=m0jpQhr502H8euq4lCgiJVE1vkzqGKBzlL4xY2kBczk=;
	b=48DHCGaaMmQmxaIAnkATt9QVZAzVOE3QdhzHGawpJHYX6wea8K02wttlfQAnJTvHCqgE
	 F3/2MDNikwXtdf1f33jJALEwqFuDmb5pN51zjLOISE0ETxSVajtkLJwPgPPlkAXdDGToq
	 Ozj85x/tpvdhIAltVQ1fqHidCacN1IIVrhi0I+JOQOQsAxvJAoat0xgwKlw/WKv+cnnfz
	 TjIAz8ye+w8svA8vbUyQGyYgdrvXM5lDxZU+NwH1LMFfJ2ddLrMisYVIO0sdXH54jDcYB
	 MwA0yRkxO1vj73/hspd0CnpdkX2YojXOPj5Fyx1qI4aRegcTjjL6dYr9Fxmgfx4B/Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sraa.de;
	spf=pass smtp.mailfrom=sraa.de;
	arc=none smtp.remote-ip=85.214.240.192
Received: from sraa.de (sraa.de [85.214.240.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D5606A31B;
	Wed,  4 Nov 2026 02:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B27D5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sraa.de
Received: from [161.142.148.162] (helo=localhost.localdomain)
	by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <basti@sraa.de>)
	id 1xOQq8-00Akzf-SH; Wed, 04 Nov 2026 03:35:05 +0100
From: Sebastian Raase <linux@sraa.de>
To: 
Cc: Hans de Goede <hansg@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Sebastian Raase <linux@sraa.de>
Subject: [PATCH 0/2] Add monochrome framebuffer support to simple-framebuffer
Date: Wed,  4 Nov 2026 10:34:48 +0800
Message-ID: <cover.1793758480.git.linux@sraa.de>
X-Mailer: git-send-email 2.47.3
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
Sender: basti@sraa.de

This patch series adds support for monochrome framebuffers (1 bpp, packed-pixel)
to simple-framebuffer.

Monochrome framebuffers require far less video memory and bandwidth than
16bpp or 32bpp framebuffers, making them useful for small devices or FPGA
implementations.

Sebastian Raase (2):
  fbdev: simplefb: Add mono framebuffer format
  dt-bindings: display: simple-framebuffer: Document mono format

 .../devicetree/bindings/display/simple-framebuffer.yaml         | 2 ++
 drivers/video/fbdev/simplefb.c                                  | 2 ++
 include/linux/platform_data/simplefb.h                          | 1 +
 3 files changed, 5 insertions(+)

-- 
2.47.3

