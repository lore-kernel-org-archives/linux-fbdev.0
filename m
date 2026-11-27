Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766830;
	b=DzKKqUMs8/ThEcJiZrn+tj/F9jNQYnJstO0y8BruN5kl1tARZ2ZF70OEGcDt60cFNaCx
	 ku9pKF3PrKPpeWd4ZiY1XI4Vx+ZD2Zk6GF+vjlLP5kbzNQHKZaCJ0AL9IKVUXtdVp4KHN
	 OP6bO1teVT0d+NC+5IOypqM2jQsZGrFYf1vE34z7YJ9oZ4cEYwjY3iU0PP+1IOZ3Ssn3Q
	 pPBxJHCIQWbKwpYjktwhHc/I+jR9MqWuAY6uI5mN+UkgAM3WOOfG8jkc8U0PLzsRr7YtJ
	 EXpyXMNp/9xOmpG/wg3ApPre62MxRoS+nwFA8v28urpK04qIQC0RbysUeazQyfyXNlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766830;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7/ihj9ZaLmQ6are+i9ZnLsHqIUJCuh85LNDTNIUPYnE=;
	b=Gedvi98n2TV/ImcqgFA6XAKt4pPh6jli+LpefMztUtzKTNNx2SiBbzBA2yFhBQcBbkjE
	 Lp7iYIPFHE+pDSavlPp9daWAKgLVC/yzwRaWY9k+aCQDYk5W9ZJ/PPgbyHW1zLqi3umLg
	 Gb5xcofvcGn64ZtHtNsBoDdMmsOy+qp6b3osqgvosfhXK8Oogca5qsfNlYlrki1SlP2+m
	 nxAmPgNL+VTUo3P8oTzGyuEHGV/g4PbPoDVXJP9Zz9x2y+/ONUn31TPILJ7vBpSGSTmJX
	 4YjU9vlNxGBaAMphqzC5dfUaL5EiHpCgtbgrcBWngjzb6T9o82BX4FlrFKY2Ays51/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=G1bBQy+r;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B3606A31E;
	Fri, 27 Nov 2026 08:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 609B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=G1bBQy+r
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 16CCD4C97D;
	Fri, 27 Nov 2026 19:07:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795766821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/ihj9ZaLmQ6are+i9ZnLsHqIUJCuh85LNDTNIUPYnE=;
	b=G1bBQy+rEdSQei71uD9/p/Nl4cDoRP9BFcZcbHbJ70isNLRQhlnxoALZSabSBHgmCYXGDI
	6fKYMTuFTsNxJGmN1xsl/ReJ+KQibYO43Yh8oCHsTjAXmp3SorNzfluhSYwH50AJDE3zVf
	Q05ozVOG2dzYk6+HjjMcuOkt5674HBEetOAuqtT6NMqrs2UWlXjuPC8jmKkmaSWORyf3sL
	jwkEERLnjQi3iHJ2gkiktJkfuwMcQKuJ2wr+2++k1ROz7zUKiZOYwlgglsNUvr1u+LOWSx
	tQ4PaUXyCa7qLbbiEJhEdFDV1ToMuPQ1ydNSXg4Ndvre8MDZ2VZzBafYgMnN3A==
X-GPT-Reason: legitimate; the email is a technical patch submission
	("arm64: dts: allwinner") which matches the technical nature of
	the mailbox (alastair@d-silva.org); the From domain (d-silva.org)
	matches the recipient domain, indicating a personal/professional
	correspondence; and there are no phishing indicators, urgency, or
	suspicious links.
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
Subject: [PATCH 2/3] arm64: dts: allwinner: sun60i-a733: Add PCK-600 power domain controller
Date: Fri, 27 Nov 2026 19:06:48 +1100
Message-ID: <20261127080649.1982883-3-alastair@d-silva.org>
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

Add the PCK-600 power domain controller node to sun60i-a733.dtsi.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi b/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
index e062b08006da..509d0cfea160 100644
--- a/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h>
 #include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/allwinner,sun60i-a733-pck-600.h>
 #include <dt-bindings/reset/allwinner,sun60i-a733-ccu.h>
 #include <dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h>
 
@@ -595,6 +596,13 @@ r_i2c1_pl_pins: r-i2c1-pl-pins {
 			};
 		};
 
+		pck600: power-controller@7060000 {
+			compatible = "allwinner,sun60i-a733-pck-600";
+			reg = <0x07060000 0x10000>;
+			clocks = <&r_ccu CLK_BUS_R_PPU>;
+			#power-domain-cells = <1>;
+		};
+
 		r_uart0: serial@7080000 {
 			compatible = "allwinner,sun60i-a733-uart",
 				     "snps,dw-apb-uart";
-- 
2.53.0

