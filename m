Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794414161;
	b=4gDL884THnqskFodOgUR1JUvgrDKP0iT5/XeZbagj72aLMc/MVV0PlBb9Vg7SZmGSB/w
	 8YX7Y0nxT2qZyHEjS/Rbx1+BkTgNBWC5ujVsAXCGALcM3Gc5AT0wv/CSlJbCurZiFDJ0N
	 JafK2qmCm6cryXav6VUNVupZ0x4aqTwR0B3Pk4dA8sZoUcb2Ao/GYKtXo4WBnoxcWUEXK
	 grP8CPL62LSG/uzKMmHyRsqQ3cN1EGTZ0xkbIYjDbsyPCekeYTBdzj1F9k1/6q6hSIWZI
	 a+RP7G8369HBeMLJXh0H/j/itTrRhuTbfgRdDk9kzBMwakmZBBn9qT2UQ0YRvEaMxAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414161;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Or8nTk9ZVbnrA4q914nXGUz7qMvSQv0pWk+CqcMXwjs=;
	b=nZsR4w8hGaXY3Xi1Xg+KERIQOP/sUBW2HDdu/wfmBtuZPXS7dhwYERckCJ+ZTUY0I0YD
	 KsdsPdzomZ+jeen7e6Qsm9Ur5E28jfvA7M2PclCvLaLo/AgH2Hue5IvYPweYtZbQevJg2
	 d2U6YmqQ40f6m2Y8teHcpgx9WTnNBo3+Loms11kb408EahI0fKV4u5fX6SrSfcHYo0BU2
	 1qtxu0lY1BNt+4OnoL1udJ4YyjmWxq9vnOqqUUyoqOsKap6IJRvvzm+tVyFD22skj210g
	 KI317YC/giw3K79aoA5BsXz/jvhDJMBQEpi3MyfqBT8qpVjb8XI4ZtnViSBZ+ONepwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q08v406y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C2D606A326;
	Wed, 11 Nov 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q08v406y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794414161;
	b=ByNQdC/EqbSzhaAJ38QhFeeBItwVbLOXQjUw1E1+pTB4ENy98bTQWcOsIvkf2hYFlYs8
	 MmNVZ/FC3pxM9/5rQ6E60wxX5xMslItKnotEjoOy75pOQtGWL/uFb/TfH7kvRs+bJBT0h
	 F4twscc1P1+dfdQTJoOpHMpf76227nR3gW1fI0bJGVKnVFk9oAVhl71vMGez5odIbX8lL
	 E7R2/ZlATqfYp8G32bJJkR+GZZNULNLasBYz1NBIbw2XBOmes0OR5XYzyXK5+ZRaXcVo9
	 9YF0ibT87/n+RiEtkwWnqGVT4/JYGrbhfW9En7jEwgFoBkr6plG53qpypTCaewSA8Qw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794414161;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Or8nTk9ZVbnrA4q914nXGUz7qMvSQv0pWk+CqcMXwjs=;
	b=MuldGOrQa4m3dio/LCKKeOpODtAcAM00vJVO3kwx/BdkW1wVvX0inkPMqZ5tgBVY3+KK
	 KK3CILlwC8PPhMhSTdwlsJrvXg5OQU5N34miu9dkIwGTQHKbn7m6hBmN8Vs91M2K+euWl
	 MPvr0iJ0yGS7UXLqSXfbBX8xLr6Ap96ab+BCHr3O5D2rBaojLHQ8/tvJI3hzZBQP31QKN
	 kKaZT7INP2mrEciqalLOtQSFQ8LOnuadWF2PRTySJfennQK7M7dYIhk3SbmECHSY7PbHm
	 /dDaF6Fzl9kWo/DW5oFGZ5GNmdwOTMwKvhC8A/y9S7oABcj35iKN0kVAkCdXnZtU25A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3C6011F00A07;
	Wed, 11 Nov 2026 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414161;
	bh=Or8nTk9ZVbnrA4q914nXGUz7qMvSQv0pWk+CqcMXwjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Q08v406ybvKmpgk6WUkix9yHXCBI7SXdsFN8x8vFEuT/7r7MqXnISqLOZahZWdpLR
	 k/JLyctbWHsjRESICChCnBg2FGBKpnZw2uXWD1jYdPI0dMThCAni36/CipzBBjqtNy
	 bHS81FUSnkyqyjKZBP1t5jbsOdsfoqmiOJX9lJUE4/cnLMZ1TC5+HG7SUoUGHerIcx
	 TB/ribWc7yV8LqlJTaz6gfSzm6GmGMOrx9zbOCJ4frsSU4vocdOp3KbvDRdDaTYcsE
	 IewA5TOz2FTyeoXLcsNLK4YDSP7UpfobKsWBadibAHKys+0xhxzKi7nm/S3MgW7aq3
	 jmMVeLww4UgyQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BC15749033;
	Wed, 11 Nov 2026 16:22:40 +0000 (UTC)
From: Michiel van Beers via B4 Relay <devnull+michielvanbeers.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 17:21:41 +0100
Subject: [PATCH v2 1/2] dt-bindings: backlight: lm3630a: Add
 led-max-microamp
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
Message-Id: <20261111-lm3630a-led-max-microamp-v2-1-aff11756e7be@gmail.com>
References: <20261111-lm3630a-led-max-microamp-v2-0-aff11756e7be@gmail.com>
In-Reply-To: <20261111-lm3630a-led-max-microamp-v2-0-aff11756e7be@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Michiel van Beers <michielvanbeers@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794414160; l=1951;
 i=michielvanbeers@gmail.com; s=20261107; h=from:subject:message-id;
 bh=cVMp5TfdJqEv4/BLWzYSV7umn1bMpBqTXaN1LwgWfA0=;
 b=sKRGK7iQM4/JTa7sbXtUPCIl83y0BsZndAyrc2ZqLpu30HlBCBHiNfTmmr5Ca16CUyCW4pKJC
 4mZbHc/UG1lCDNOsiZWu8H137CPjB7L/RUE5JJ6KxfoXzMkQS5NB4+h
X-Developer-Key: i=michielvanbeers@gmail.com; a=ed25519;
 pk=C+lOje7u3+2x3o2NLMXrwz2veP2++eXfIi9MtYsUo4k=
X-Endpoint-Received: by B4 Relay for michielvanbeers@gmail.com/20261107
 with auth_id=1444
X-Original-From: Michiel van Beers <michielvanbeers@gmail.com>
Reply-To: michielvanbeers@gmail.com
Content-Transfer-Encoding: 7bit

From: Michiel van Beers <michielvanbeers@gmail.com>

The LM3630A has a full-scale current setting per control bank, from
5 mA to 28.25 mA in steps of 750 uA. Boards whose LED strings are rated
for less than the chip default of 28.25 mA have no way to describe that
limit.

Add the common led-max-microamp property to the led@0 and led@1 nodes,
and reference leds/common.yaml from them, where that property is
defined. The property is optional, so existing devicetrees remain
valid.

Signed-off-by: Michiel van Beers <michielvanbeers@gmail.com>
---
 .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index 6393cbf3afdf..92a7236eae1b 100644
--- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -42,6 +42,7 @@ required:
 patternProperties:
   "^led@[01]$":
     type: object
+    $ref: /schemas/leds/common.yaml#
     description: |
       Properties for a string of connected LEDs.
 
@@ -77,6 +78,14 @@ patternProperties:
         minimum: 0
         maximum: 255
 
+      led-max-microamp:
+        description:
+          Full-scale current of the LED strings driven by this control bank.
+          The LM3630A sets it from 5 mA to 28.25 mA in steps of 750 uA.
+        minimum: 5000
+        maximum: 28250
+        default: 28250
+
       ti,linear-mapping-mode:
         description: |
           Enable linear mapping mode. If disabled, then it will use exponential
@@ -112,6 +121,7 @@ examples:
                 label = "lcd-backlight";
                 default-brightness = <200>;
                 max-brightness = <255>;
+                led-max-microamp = <20000>;
             };
         };
     };

-- 
2.43.0


