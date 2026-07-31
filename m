Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E243F12F0;
	Fri, 31 Jul 2026 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.96.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495175; cv=none; b=tfJoqLOqTdLJZvyCTrV+YQwiBWKdLotYvbdu37l9l36ldmpzZPrgR7pt99NRMra4MkYfPZdvAeAI6HPHU0R/F4+P5WbOvQNx+7c6eBoFUC8FV4BOscLyLEG+2VVMjGsSCntRlSK9jI17yAERFQcIoGufG6utUJIw86fjTyX1OXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495175; c=relaxed/simple;
	bh=SyH2q9vmycLZI/swJsr2rVqoKZXRwUBo6NMiaIM18DM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=km8PmVbh8TYs2gEax1gHsCDR5Xf6ymgBtzIGseMSRP/iTKwtbJEd502yVJywjXN1Z94zTbh4A+pJ1likw7wQLnWvfU7xPA4/M4hiZBYaC5BHYJuNiJDOFEZqPlCYOhMvKfIS0bps3asJsfabMmfILz+u3Hq4u8LStXMnPVDyfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech; spf=pass smtp.mailfrom=elsta.tech; dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b=uFIKBSaB; arc=none smtp.client-ip=194.150.96.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elsta.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b="uFIKBSaB"
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id ACE5D8D53B3;
	Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Authentication-Results: mail.elsta.tech (amavis); dkim=pass (2048-bit key)
 header.d=elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id iVg-pCXs99Nj; Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 769268D53B4;
	Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech 769268D53B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
	s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1785494793;
	bh=a9WFruF+jsbK+yzittr0qjwlm/b207TqVHPmsDedzSA=;
	h=From:Date:MIME-Version:Message-Id:To;
	b=uFIKBSaBP7PGdlR3G0JgPThh/DPXGqlmxk3c/VId7bQwoQ+WtAXzbl/PTo3tKjZjc
	 fv1YYwQn60YR5wOobZN0GZhz2o2VbyMRwOd0iOvDNfHLXWLGmNaBGlP8Nz8cS2GmNX
	 heFH/VMt/0WS5YKUjqkong5mzgJXp7VEtq1VINmDM11ltBWabfuDMRJbJUp72MThjm
	 R5314p1iP0TG9AhBW8ieFUpRMYSYYB2Ch0GIR7/5wBDsgP1PPUOnwF3yTWr/mf21Yw
	 Le1TWtkWrbk3c4Kp9x15F6a2ZMqSqp3Iefp5Gmn642oBCiwc5VmnpJhCumiaEB/hbX
	 Xw+xmzzYLvLDA==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id PaCv2EAx1WZP; Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Received: from [127.0.1.1] (unknown [172.31.0.125])
	by mail.elsta.tech (Postfix) with ESMTPSA id 3EA758D53B2;
	Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
From: Jakub Turek <jakub.turek@elsta.tech>
Date: Fri, 31 Jul 2026 12:46:17 +0200
Subject: [PATCH 2/2] dt-bindings: display: solomon,ssd1307fb: add SH1107
 compatible
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-feat-sh1107-v1-2-e10977f76e6b@elsta.tech>
References: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
In-Reply-To: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
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

