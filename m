Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DED14D29D
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260002; cv=none; b=VjVj2L7I/gTJfGc0RItYbRtAo3DObs4eNr+hRElDk1k38ZYjFGPeb2HStc3j4QICGbnzoXczfFT731DLMrIH/qPnrmEDRk+/BlSyGbFTg+vTQYEF0KwnlIz3tQ9Cc+W1Gf326MvO57gsrztazLW0QPYWcSBW6dVfT0Np5d+ABic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260002; c=relaxed/simple;
	bh=dF5aHEI9yltbH4AVdIEng2CdNqCOM9IJTlvYoaNgtZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nN+ARS3x9kKnfmrG2q5+7dTU11DF44OtQkIqkAZ/FOQNaKtKN1ca04PYqPJr7+BQAp2Lz+LcNxwe4MyB9CQ/OFcPmSvjYjJaPJ1eDe9CyejtPis2lhIslP7OLdVwT0WLaDcxlgGryxRuD1/xOd5hycaxOeg94CD6Ocmxy2Wn4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4YB08d2yhfz4wwdX
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by xavier.telenet-ops.be with cmsmtp
	id oylD2D00Y4qjdAp01ylDEq; Sun, 15 Dec 2024 11:45:14 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001Kk3-BC;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nmQ-OR;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 16/17] visops: Mark fall-through switch case
Date: Sun, 15 Dec 2024 11:45:07 +0100
Message-Id: <20241215104508.191237-17-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241215104508.191237-1-geert@linux-m68k.org>
References: <20241215104508.191237-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 visops/pseudocolor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/visops/pseudocolor.c b/visops/pseudocolor.c
index 2c3f4d9ac29b7b5e..112e2144979afbf3 100644
--- a/visops/pseudocolor.c
+++ b/visops/pseudocolor.c
@@ -50,6 +50,7 @@ void pseudocolor_create_tables(u32 bpp)
 	switch (bpp % 3) {
 	    case 2:
 		red_bits++;
+		__attribute__ ((fallthrough));
 	    case 1:
 		green_bits++;
 	}
-- 
2.34.1

