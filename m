Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B318C322;
	Tue, 29 Jul 2025 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809549; cv=none; b=sPJP5xIikyrOp/P73SELSAeOI5LsaWBJIOi33WuR0BZACStPCBbFyKcll//A1DVBFZCJj08yrJWXzImmQOIZ4LYmAycyKWQnxhrwDOftbj5kT6GLae3/sUXZjCPNiZWlkxOfIMWHhlUVaJx2gWAHK3fqHQ+4O9RpD0YL/eot8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809549; c=relaxed/simple;
	bh=XMO4QtQaJ+pfvF4AwsZ1qp1IuFcZe9SRZGyjHN9gGRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrolWYspZjTkuntRlEyFocSrxqkZqsacPYsdEYEvq1UCDVPzG5kklOmgN1O3UmC487MVH/pAWsTQpt69i6ZpQZdykhmpDh474F8RHR7icERN1soEG2vpvlBFsBHWYsgEv7eikl7B47KVUJI1p7JTOfPcfudBkWLUWAB+QcWPeqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=J98I1cvT; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="J98I1cvT"
DKIM-Signature: a=rsa-sha256; bh=fWm+GcZXSup2AarAdKQLnAFKN9LFFUj1rbKJ7tZFAjo=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1753809528; v=1; x=1754241528;
 b=J98I1cvTcGdkxSKMDpmbdFyo+EeAvkC9HCaVBlCWQ8YipmXXy/uH52lfgaAE6KaPd7tH1FcU
 Z2K0bVu+gKuMcPtpslKqO4fn4Oe8aGgDA2XHNWvjjW/eY0af3eK3kIRG4ZsGem9Xa4Hn8hZuFfF
 7BT+tJeFjThw8Yniri0dFlPaoV0ipaxaTs1DYEGk8J3aLN49Fn/Jx19hL6HOU2TgYRckJ4rVcXT
 Zwkg1iaAy2g5V1fTOnuCTrl7owf3dzFryMgSMvp7QRsV31S7tUdcAXYhcHjHL4yehJCGb9P4/+J
 I0y5ZYLe/smU/vUghgWkRguF7KvRiMdjxS0jtVJzcBinQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 86130aa1; Tue, 29 Jul 2025 19:18:48 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Tue, 29 Jul 2025 19:18:29 +0200
Subject: [PATCH 1/2] leds: Drop duplicate LEDS_EXPRESSWIRE config
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250729-expresswire-dep-fix-v1-1-635cd4cc746b@dujemihanovic.xyz>
References: <20250729-expresswire-dep-fix-v1-0-635cd4cc746b@dujemihanovic.xyz>
In-Reply-To: <20250729-expresswire-dep-fix-v1-0-635cd4cc746b@dujemihanovic.xyz>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=XMO4QtQaJ+pfvF4AwsZ1qp1IuFcZe9SRZGyjHN9gGRM=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmdTOXXLCU35KzMtPx44qbsbetfSnEli3Q7T0/j4Jm28
 GnqEmHhjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZiIrAPDb7ZntkeDT34vqGtj
 b7rQOn+W4t9tK6r3PnzY3qvaoDZnQQtQRXnNFwOZ8HMm3mJyG27rt0c93fotqlLrwwYWzrrnf1d
 wAAA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

While moving said config symbol out of the "if NEW_LEDS" block, I
accidentally left a copy inside that block. Remove it.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/all/b6c481bb-e854-405e-a428-90301789fe20@infradead.org/
Fixes: 2cd0d1db31e7 ("leds: expresswire: Don't depend on NEW_LEDS")
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 drivers/leds/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6e3dce7e35a490df050cb4cd8e98611028c8dce1..8098b7b49c9decb591a894fe514a7ee757da5b44 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -214,10 +214,6 @@ config LEDS_EL15203000
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-el15203000.
 
-config LEDS_EXPRESSWIRE
-	bool
-	depends on GPIOLIB
-
 config LEDS_TURRIS_OMNIA
 	tristate "LED support for CZ.NIC's Turris Omnia"
 	depends on LEDS_CLASS_MULTICOLOR

-- 
2.50.1

