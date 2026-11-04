Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.240.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759731;
	b=UAD7y95iIwYPhca3RGiiabDXACDwL0tt1b0HC1ImF0hd9H2o2k4feHeI7CLUEdgLbQn4
	 vogvVBY13rszCGIMWzUtFCTo/yqFW0JkumXr+d+pt+OeKYnO31blCA52kxAiRo4oOSavI
	 40Y1EqZnlMgNxTDyMeNtgGy2/E6LIjX4ACfVzhfVChDFSl5SKqgHhaS9VmqmFnWyGQYk1
	 9xzOZBzXFzYnm6EUChL+xtOPNWhmFf5JkA3NSN10KTqH1v+Rli+YrRYPrHs9cC2KOoGb+
	 EB8NV6E/ED0qxYz0cLofjwWDSABofQJaXDyXvNnkPQOaetmGJxWihkiz5GOod6W9lpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759731;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Sender;
	bh=PHP0SwnDSi2ohIR1MvFDZ8aokfn8wXj77+ngpZIAMNk=;
	b=EM8K9SqwZDEBGa9Vgucb16yGYcaLO4tPULCnOXShJDM2FJ1POiv/tvla1OQyax/9XIc4
	 DdNRg08M/yvexsOE9UnixlZZIkJ8IrWcgvD8ixLu8GWOSzyVqzxuA7M674e/CM3ml7RcL
	 yJTNJl7IzKkDGEZc2YICbud0xq0tpV0+AxOpXTfHII8x24yZtpaQaKLPq6MDAHuGoP9De
	 +QAdKuExiDafbhRkE8QRj7mmCPxg2NMOeBBMrSH+S1bCfr0oPHX2tKrky8S5u7OaaEEMa
	 c7DZKy5LdLaq7FO6HMi0IpdwcuZgDKo84Hs8IecsMn9OEWDtZQgE1jxDFRRSREwzbqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sraa.de;
	spf=pass smtp.mailfrom=sraa.de;
	arc=none smtp.remote-ip=85.214.240.192
Received: from sraa.de (sraa.de [85.214.240.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BCA606A332;
	Wed,  4 Nov 2026 02:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53BCA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sraa.de
Received: from [161.142.148.162] (helo=localhost.localdomain)
	by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <basti@sraa.de>)
	id 1xOQqT-00Akzf-Pq; Wed, 04 Nov 2026 03:35:26 +0100
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
Subject: [PATCH 2/2] dt-bindings: display: simple-framebuffer: Document mono format
Date: Wed,  4 Nov 2026 10:34:50 +0800
Message-ID: <258a1228601ab9b5dbb8f077dacf61121b641f15.1793758480.git.linux@sraa.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793758480.git.linux@sraa.de>
References: <cover.1793758480.git.linux@sraa.de>
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

This is a 1 bit-per-pixel monochrome format, with 8 pixels/byte.

Signed-off-by: Sebastian Raase <linux@sraa.de>
---
 .../devicetree/bindings/display/simple-framebuffer.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index 45ffdebc9d86..c627ec088434 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -94,6 +94,7 @@ properties:
   format:
     description: >
       Format of the framebuffer:
+        * `mono` - 1-bit packed pixels, 8 pixels/byte
         * `a1r5g5b5` - 16-bit pixels, d[15]=a, d[14:10]=r, d[9:5]=g, d[4:0]=b
         * `a2r10g10b10` - 32-bit pixels, d[31:30]=a, d[29:20]=r, d[19:10]=g, d[9:0]=b
         * `a8b8g8r8` - 32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r
@@ -106,6 +107,7 @@ properties:
         * `x8r8g8b8` - 32-bit pixels, d[23:16]=r, d[15:8]=g, d[7:0]=b
         * `x8b8g8r8` - 32-bit pixels, d[23:16]=b, d[15:8]=g, d[7:0]=r
     enum:
+      - mono
       - a1r5g5b5
       - a2r10g10b10
       - a8b8g8r8
-- 
2.47.3

