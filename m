Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261C430CEE;
	Fri, 31 Jul 2026 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.96.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509129; cv=none; b=pWubCynR7GqftDPk/Cnd2SjN7TDpEp5tECmPVqRBAgmBwR9W3+DMJjbHQLhXYnVfEWAuWvmXDQk9nf+KJyr0PaWyUoOdWoioSfb+kaNe0tYBgtH94PgX7POBB99jjMFhXurSgE2BWk2qHtQwQ2/xDAlfbsyszQQfxfMma06c7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509129; c=relaxed/simple;
	bh=SyH2q9vmycLZI/swJsr2rVqoKZXRwUBo6NMiaIM18DM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gyn4fs2KQNQfU//rlPk6OOxHEqAZNfEbiztfZHdSZxJsT349ICnr37y9iloadZILciVHOot3vJlclKemjezLLG7NtAYF+3RUOELk9LgvaBEqgf+LQmhOtAvrL5iJ7x4Bz0+mjosHertyqIIgmEMqN6G6YKjVtvdXLwfBPKh5Xns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech; spf=pass smtp.mailfrom=elsta.tech; dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b=zUEPY/xR; arc=none smtp.client-ip=194.150.96.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elsta.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b="zUEPY/xR"
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 702148D54A1;
	Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
Authentication-Results: mail.elsta.tech (amavis); dkim=pass (2048-bit key)
 header.d=elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id UPyd-3Okll7O; Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 32A788D549D;
	Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech 32A788D549D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
	s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1785509122;
	bh=a9WFruF+jsbK+yzittr0qjwlm/b207TqVHPmsDedzSA=;
	h=From:Date:MIME-Version:Message-Id:To;
	b=zUEPY/xRwyqCntX9Qm5l8Otu2Ws+n8DYHz+64OMPXAF8gQ9ZS4HKME99UdSWbwDOd
	 rlx1cNodimLGL39sT4/nBcssxS9/90OPg9rBPqRcig2L9pz+o0oS20dxD5wKxcaSUn
	 TMCAru6V0BURZsdzBrNETWyt83Gjk3kzk7rioxTebe1cupcowQBFYznsdkL5FUgG5m
	 IjgsN9FQCJ5L6tGm+mQWyyCIpYdn0yVYXrG4G+lhi35djU+o32yu+MaWibtHOJDIWK
	 RPIkJtT/8wgpPXEGf8HyFYJslw0OzQDAWp5AqUx95CyWeKjsnJAVpg1ywGMR2HxV2x
	 O6HEQvV77MKWQ==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id W-S8EvgvH-sr; Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
Received: from [127.0.1.1] (unknown [172.31.0.125])
	by mail.elsta.tech (Postfix) with ESMTPSA id 026608D54A1;
	Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
From: Jakub Turek <jakub.turek@elsta.tech>
Date: Fri, 31 Jul 2026 16:45:14 +0200
Subject: [PATCH v2 2/2] dt-bindings: display: solomon,ssd1307fb: add SH1107
 compatible
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-feat-sh1107-v2-2-0d2893e44ebd@elsta.tech>
References: <20260731-feat-sh1107-v2-0-0d2893e44ebd@elsta.tech>
In-Reply-To: <20260731-feat-sh1107-v2-0-0d2893e44ebd@elsta.tech>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jakub Turek <jakub.turek@elsta.tech>
X-Mailer: b4 0.15.2

Update the device tree documentation to include "sinowealth,sh1107" as a
recognized compatible string.

Signed-off-by: Jakub Turek  <jakub.turek@elsta.tech>
---
 .../devicetree/bindings/display/solomon,ssd1307fb.yaml  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 153ff86fb405..6b17a701bbaa 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -22,6 +22,7 @@ properties:
         deprecated: true
       - enum:
           - sinowealth,sh1106
+          - sinowealth,sh1107
           - solomon,ssd1305
           - solomon,ssd1306
           - solomon,ssd1307
@@ -140,6 +141,22 @@ allOf:
         solomon,dclk-frq:
           default: 5
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sinowealth,sh1107
+    then:
+      properties:
+        solomon,width:
+          default: 128
+        solomon,height:
+          default: 64
+        solomon,dclk-div:
+          default: 1
+        solomon,dclk-frq:
+          default: 8
+
   - if:
       properties:
         compatible:

-- 
2.34.1

