Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3D58039A
	for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194280; cv=none; b=AaRLeonlqmSXuzo9moBHNuvuM7TtThimeuXvsdN2wAsJs2NKbr7bONZ6nZYv0hWPgPfR8j8Da9JcTbsJsi7PEsDddPF2V+epcXVI3nd7DORt1J/Ls7LyN1CjMmgWJvJ/iiHFG9Mjy1Acl+74cN6HrdGIy00ajBfjq+UyLsvk0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194280; c=relaxed/simple;
	bh=0bOxnq+Qjeh+sxAlHlASgbdrTP5Xke/gEBsr1dGPWwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Du2kqwWSNpS6ir5cZU9Wxsy13ODVzfLeT+wB/dOUOKpPOvFq7JChqOQQ96Pz4RRlIlk5gg/o4nhjcPVj8iYS5ovRQEafpHj8fY52zyX03fEi25gp2maS0wZOWY5YMWk6NWHhLMzvyLSIb3FSrHbiVdkPOldhcxEpITu5NVrrGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxa86pxk; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxa86pxk"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4ad9so7772995e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 13:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194259; x=1790799059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OHFYvczNQQ8zbB57FCazhQfFZ5fguvDLVHqTQCN5Cj0=;
        b=cxa86pxks2OvJmhjl2gKHFKGCbvSm269fshF+eV+GcZMI7KpHBFDJqDjXJpFxqxXGa
         AtowXnFpYspunZOSHqIrDcTnVkncgQsyXm25ODPh3MFB548CuLtZOxxijFcZFwy778/T
         7xdDnWLp0eaITiv6wF/REXpQYtmKjcXdybIOBhbTo3a7vmon/LGMB6LT2bzbFVgi8YDk
         vi5FidlCoXEKwW4saaViCVIMpeafWRVrWDgdQj1WxhcE1lezbF355e46YbtLHHEUYqTn
         vo0fzCYx/RD5kFZ6C8FvZ12iDNFibFBU2zfDgovkD9pUBOm/zu9+LKvI6WmDiFLfzaYv
         DyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194259; x=1790799059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OHFYvczNQQ8zbB57FCazhQfFZ5fguvDLVHqTQCN5Cj0=;
        b=H4cbiHCMJMR/ieZ/uR3rzOIe+rqH60pucaRW8+GYds3LeQhe+9AUb804omnLCph+eV
         gQgbj6M2wkWahgJA31YwofeTp3ZM3XzPkGoJWYIScXgLxmwfTqmBMWmmrnIVy0VxA6EY
         kAZaNIbMf2gE5bmenfNmC0kJBYvdgEbnbhFcb8tYPbcTsTK3vHTCwwOY+IrwOB06GeMd
         +WpzcuUPTNNxlFNFbuS6t48BK57r1ARqcwZMpvM1dzrUo40Or57bZZiYzAHHxVQqQmB2
         0qtQhqDuLGZ7Kcd7fS5YVyNyx2Wy2YxZBrojhYfo2CoGiNHEXCKELNYtIU/iVopUcqg6
         LBxw==
X-Gm-Message-State: AFuF++lFTxPUwpEaNMJs2QNiFb3AoXXJqfENKatctyM06nbhX5pBCOGo
	d0LuWnoLQYfI3lUGAbHbxtYnKR0MnvGTXNNc4d7o/rgZwsz1PmqIPTv/
X-Gm-Gg: AYBFou0AZbgh6j16SSYgntKSUdGWDAWB0J0k9qDVr88mTMW/Tc/AdtaHUJSCDIKFH3T
	xY478iJILHb54eFYVcRfPaWTWaQmRezSysiBVgeDQOztp+b8V5lWSC+YNt7u2IO+OuJ1/uhSy38
	WQpWnL4ub4a4Zl7opW6vYDEFABjthcQe4QVDsMwDmH4b4DSiA0J5h5Heq1XsoGCj8UQsm5h3HZH
	HWuhgKEzUFC05Vhm1yxnuqSDW/6I0T+BChmskq2qAkLO+pObdbwh/b+yhFZOZNepF9ljsB99yl3
	kr6eyWL7rpaLhm1eHsnoNtTiLMtcPoUsCpU78zz0xxxv4yqKNPJEAB77mNgV814vd735i+fRnBg
	qw6r0BRrZtPLGSIqAgKo+XA5BmoT14TjeCxF0yak/qr/SMTdANW9Ie3MIOsrOkzjgL32liOdsnt
	sFPewwroSShPO6xniGAjuZxy580ZV6p6ahnSXYOfbRm34VqKKFWX9yHnCCqCMbjT0g/L5Fyn9ap
	4vnBwK4gzi92PL3IdF1HC7+
X-Received: by 2002:a05:600c:c16d:b0:49f:cac3:c68a with SMTP id 5b1f17b1804b1-49fe66f9ff1mr4161775e9.31.1790194258869;
        Wed, 23 Sep 2026 13:10:58 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:10:58 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v3 5/7] dt-bindings: display: allow the boot logo in a reserved memory region
Date: Wed, 23 Sep 2026 22:10:33 +0200
Message-Id: <20260923201035.51007-6-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260923201035.51007-1-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
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
a size to validate against.

The two ways of supplying the image are mutually exclusive, which is what
the oneOf introduced here says. Until now the image properties were simply
required, since they were the only way to supply one.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 .../bindings/display/boot-logo-clut224.yaml   | 40 +++++++++++++++----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml b/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
index 9dc3471763..a71fc09a7c 100644
--- a/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
+++ b/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
@@ -62,12 +62,31 @@ properties:
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
     $ref: /schemas/types.yaml#/definitions/int32-array
     description:
-      X and Y coordinates, in pixels, of the top left corner of the logo.
-      A value of -1 on an axis centres the logo on that axis instead.
-      Defaults to the top left corner of the screen.
+      X and Y coordinates, in screen pixels, of the top left corner of the
+      logo once it has been rotated. A value of -1 on an axis centres the
+      logo on that axis instead, which is the only way to say it when the
+      logo size is not known to the device tree, as is the case for the
+      memory-region form. Defaults to the top left corner of the screen.
     items:
       - description: X coordinate, or -1 to centre horizontally
         minimum: -1
@@ -103,10 +122,17 @@ properties:
 
 required:
   - compatible
-  - width
-  - height
-  - clut
-  - data
+
+# The image either lives in the device tree or in a reserved memory region,
+# never both.
+oneOf:
+  - required:
+      - width
+      - height
+      - clut
+      - data
+  - required:
+      - memory-region
 
 additionalProperties: false
 
-- 
2.39.5

