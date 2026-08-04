Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03C342CAFB
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Aug 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876991; cv=none; b=kycJEOh90V4f1yW0n/i6rCeoL1hUAySw04eSeJ+ijr/Q1w4iLce9eYN7YYNSGfGAaAJJ+dZjrh2nKcO6GUkZFAH3no+F+8ef1pZm9mya8oq08e1CBrpv8hBlEoPP3qNVDvCkw40RqEpEuaDp4IZ7pop7uKRzW3cieVVlaIQFPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876991; c=relaxed/simple;
	bh=yu7fTJEvu/WM6iPEXNZYvP9LNyFeTGKqeWmRli0lQx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iDvAshsK3qRppd3/pESLQG6Owcm7qXB8bvTLYEC4OkspdFfhuwmTpQwvC1Ni9UkKD/dxyy+3xfHgKTietalPoNzYK/TSj52JmvdtcIAzNxbKkv+uEFxuPUOVqCT4hzU+oLlTxB5jwyrZwfeXz5poKN2JZZpyt0F1xYGjBqTFW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo0GdF3Q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo0GdF3Q"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso1114245e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Aug 2026 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876988; x=1786481788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHxdaaypANO4SJdv7vjmn9Syq8V3Ebhk1vARZd9Mr0s=;
        b=Mo0GdF3QcDQm4YHlRyfbx+lTUWgf6Mv/BK4DFeijlJ6PeSeIi31Yt1F+mT0KjBi4YC
         tB5oMX0imr0pKiZF8qhRSNGcd4QymbE7OqPrh0UycDm5FP40Jwkoyv0m30w1yTCZ/Y+B
         7skLtt45Ap5j3WPY3LqjcsxdbY2k78Nje4RFrdLK89axRUFc4T9Jr3jePGNl1Vn+8KUU
         UJ/+BVdy7rrqRWpgUFewEMkNX55cb3eN8VRphrDHd92vYjChl3/jdYGJQwJL+kG76Ehf
         x/lZAicCg06959pEV87iqdit8ut1qps6yXaba5+9h+DOQvTwhbpPaGoqVWBDsXD+vi4B
         W0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876988; x=1786481788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHxdaaypANO4SJdv7vjmn9Syq8V3Ebhk1vARZd9Mr0s=;
        b=Ea6mERT7d8bDuH1iqWZMb895AnLqsg5GBqXLTdT6nH2DnAyxxqY8Vu6BttZGYQZUyZ
         THZoaxLiGDYtuq6KWLhpAXg7YzEykm4x0yJwcGG8w8A9kNICzx/s9JwIAFltjiPIHDd9
         aXQa63HkrL7VG55nG486BkC3OkWOc4FVbWRoKo3l2ta99PnhAB7aP1tepW/2vHNYVFg7
         NgPOdhFuEAZUFD1VsOyNFQsBrsCW2NcyazyB6vuBRbTbEiNdEY8aYNSiLCBgjEKraytw
         2jHhmhb+o0JrjUZ95q9TgCUL9/k1/RQumJlI//5RxwDNNqRPBBAH/2Ksg0q+2MArOKEC
         L55w==
X-Forwarded-Encrypted: i=1; AHgh+RqqfJamI1wbsCRHot7n/X6dhxhhoWwJ9u8DTnn+LmAVk6Lsl2NOkQ4zNC/9d612Muhyc9WV2/OIw09+nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QwhA5GSlAxAJSK1D4ffbcYcBbZMl6qjM8N7PaR9qvLOQrY+6
	CsX907+j3VnW+REqUA6tvCIOl0u7gzZrFxu0j8Wzfb4Cre7RpMeIj82M
X-Gm-Gg: AR+sD10CnXztMRgMOMdDfAsI32GpfuU1VzoKzDJ/BPuXoEikydfknDe23esUPyCyy1d
	aq5esxt+jl1VCwAEcgA5bCQ/wLW4yo4dg9NAXfup+8MJzg1zgsypkfA9LZwtYdDf3PltUPS7rwX
	811AMWo5315BM49Uj8nzMbBKymKWe1w7M5HfvSDPpqhR0PgE94csIiCV8VUJF3OcGkjyIsKpURX
	W8qW7HumAo2BVS0AQ1p25vC+on+NGc4Z1SQendWHNILnFSUooEdwHRTMCVD1ampPrPZKYPsHwVF
	+0+PJKQ/p8s21kDYqaK7EUaoyGN0TBX6kUZc4g/A80lv8UpbKQdLNJobvn8O0G7Ukm/JBsdi++F
	zuRRTFpwRvguYJ+VvtRw0y/e8cOradszmbCB4W7AajF4u2oNNqxbEj3e2dCmin1VmvrxFKuudng
	sWo/Y64ZF4AWgTljLpLL0i36hyxnw5tlVB0dBQGq9v25Q7YrlN2urgGnSr9SMOB5x5gyoVHzsHW
	W8YykiSI2xqTaE=
X-Received: by 2002:a05:600c:1d22:b0:495:6338:1453 with SMTP id 5b1f17b1804b1-4994e7cfdcfmr12133965e9.16.1785876988197;
        Tue, 04 Aug 2026 13:56:28 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.176.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf820sm12070645e9.0.2026.08.04.13.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:56:27 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v2 4/6] dt-bindings: display: allow the boot logo in a reserved memory region
Date: Wed,  5 Aug 2026 00:56:15 +0200
Message-Id: <20260804225617.264861-5-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260804225617.264861-1-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Carrying the image in the device tree ties it to the device tree, but the
image and where it goes on screen are independent axes of variation. One
board sold to several customers wants several device trees that differ in
the logo; one customer with several products built on that board wants the
same logo placed differently on each panel. The second case would otherwise
mean duplicating the same image into every device tree.

Let the node point at a reserved memory region filled in by the bootloader
instead, so one image can be shared by device trees that differ only in
placement. The region starts with a small header carrying a magic number
and the geometry, so the kernel can tell a logo from an empty or stale
region and bounds check everything against the reservation.

A phandle to a declared region is used rather than a bare address: the
reservation is what makes the memory safe to read and what gives the kernel
a size to validate against. The two ways of supplying the image are
mutually exclusive.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 .../display/linux,boot-logo-clut224.yaml        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
index a6a206964..7aec0cc2d 100644
--- a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
+++ b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
@@ -59,6 +59,23 @@ properties:
       index into the colour lookup table. The property length must be equal to
       width multiplied by height.
 
+  memory-region:
+    maxItems: 1
+    description: |
+      Reserved memory region holding the logo, as an alternative to carrying
+      it in the width, height, clut and data properties. The bootloader is
+      expected to have placed the image there before starting the kernel.
+
+      This lets one image be shared by several device trees that differ only
+      in where the logo goes, which is what a family of products built on the
+      same board but with different panels needs.
+
+      The region starts with a header of four little endian 32 bit words:
+      the magic number 0x4f474f4c ("LOGO"), the width, the height and the
+      number of palette entries. The palette follows, as consecutive red,
+      green and blue bytes per entry, and then one byte per pixel, each an
+      index into that palette.
+
   logo-position:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
-- 
2.39.5

