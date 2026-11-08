Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.32.148.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794100297;
	b=QKqiwgtDTUEpiiLPd4vcFMtpSpdn+3Vz25/y6MLBivEuPyJ45islKed9xbp7ZLP++FRi
	 MX+XRNcGP3banMs/1NiXGpPgwVsWqKVXqG7pwqP2doZocAivyO6t8tpwZDrkphtwUugN5
	 4TxOHyxZU/9fYshvogE7GpJAUeh9fHdoRHDiDFsJqkh6pGhhtWtZE5FS9rj+Apwk1L323
	 JsySl9UkfAWZSvZ1HtkLLki4jwEKv6XBPg29czXitiVzUjYp8g9ebk7yy5wFeL5c68ui3
	 E5n3TYh7+SN96D/VUC17md+POHg7HuBIXt6XsmfZeQBNO7Zm1HsmIGoMMAjli0DDCiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794100297;
	h=DMARC-Filter:DKIM-Signature:X-sib-id:Cc:Message-Id:Origin-messageId:
	 List-Unsubscribe-Post:To:Subject:Feedback-ID:From:List-Unsubscribe:
	 X-CSA-Complaints:X-Mailin-EID:Date:Mime-Version:
	 Content-Transfer-Encoding:X-Mailer;
	bh=sZfzNXh4BND9cCS6sfS5q9SmaLVYUprSC4+0dzXm2Xo=;
	b=JveKIs5GPQ/OFSc4ASwz6aGbiSwljBWcqBBdi5fGfQGiWSHautDYN2J+1gTc8i10uvVM
	 1ngvyu8sI+6bXuIdaTsuRlHeJAmfG2tuS1mIJdDwBQn1sgeKVb9RN3m6g9YJOrC4un+93
	 NAU8+LOE3KD6w4et/xzuln9MYYj4ZTf99KgFm4jkk6TRgUt9oNVJEoQdqom1viNmTjOqI
	 1uWixFUl5RAcqmyYe1Hq8he6V1T1YPrCP9+yuBbmJ0HwEBRqTlMTvCQdS7EXoB6Jfeiya
	 eGECMlEUv1vWE1bqpWb05WLeO2gPX8/ZFieuYUZDvjOHHOnTCDT3dIu+x5XkxEaiB+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tubot.lat;
	spf=pass smtp.mailfrom=gy.d.sender-sib.com;
	dkim=pass header.d=tubot.lat header.i=@tubot.lat header.a=rsa-sha256 header.s=brevo1 header.b=ChSK+Wel;
	arc=none smtp.remote-ip=77.32.148.25
Received: from gy.d.sender-sib.com (gy.d.sender-sib.com [77.32.148.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C88606A331
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Nov 2026 01:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C88606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tubot.lat
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gy.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tubot.lat header.i=@tubot.lat header.a=rsa-sha256 header.s=brevo1 header.b=ChSK+Wel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tubot.lat;
 q=dns/txt; s=brevo1; bh=sZfzNXh4BND9cCS6sfS5q9SmaLVYUprSC4+0dzXm2Xo=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=ChSK+WelIjdhX5NeaK1suA/90uq2PoR/O5D39hyo9b47e8bxaOfERjPni44nIzvASvY7nL5HRcf/
        GUSDWiHBajAiK6OwNGftUyD5qR4fwGTzn0Rc1n+Ujdw4IEVoKYx0RR1JY04PsGx7QzwycOW84HEM
        jOfqIGQJxXcgwZW3R58pRQYf55Eqv/kDYvvmUAnoT/7ucELi4Ek2OKZrH0p+EpDOOJzi1qjMIIfU
        4A8nvqbobHMqdOrh2y1ekeAowiEFpfosgd56mk0mNSKVHUwxGDswqKjMQSbTkS28uAIuvegb/AIY
        83M0nvT5JQDntdGOT41Y5Ve2E3OIKF8KvQf8bw==
X-sib-id: vY5TOxWgtJl17aqXuUvFG6byHIUWa_pIYs6rWiLIzmaDwKN_4NXFJ06LMK-gT0JrW65hE5pN85XT0YBvkuKmitRnUCDvC73JP0IS24Jsa-c2YlddLwCt2LBJL7JDFxfc0A4LErCY-XVakwNAxJKnKSD5ZWS0SiDdNTH4LuaeIwNbcB2zVVGOCQ8a
Cc: <linux-fbdev@vger.kernel.org>,  <linux-staging@lists.linux.dev>,  <linux-kernel@vger.kernel.org>,  "DelaySystem" <delaysystem@tubot.lat>
Message-Id: <20261108011131.1124831-1-DelaySystem@tubot.lat>
Origin-messageId: <20261108011131.1124831-1-DelaySystem@tubot.lat>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
To: <sudipm.mukherjee@gmail.com>,<teddy.wang@siliconmotion.com>,<gregkh@linuxfoundation.org>
Subject: [PATCH v2] staging: sm750fb: fix remaining spelling mistakes in readme
Feedback-ID: 77.32.148.25:11287567_-1:11287567:Sendinblue
From: "DelaySystem" <DelaySystem@tubot.lat>
X-CSA-Complaints: csa-complaints@eco.de
X-Mailin-EID: NDczOTMwODc4fmxpbnV4LWZiZGV2QHZnZXIua2VybmVsLm9yZ348MjAyNjExMDgwMTExMzEuMTEyNDgzMS0xLURlbGF5U3lzdGVtQHR1Ym90LmxhdD5%2BZ3kuZC5zZW5kZXItc2liLmNvbQ%3D%3D
Date: Sat,  7 Nov 2026 17:11:31 -0800
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.34.1


Fix two spelling mistakes in the driver readme:

"Silicon MOtion" -> "Silicon Motion"
"otherparm" -> "otherparam" (matching the example above it)

Signed-off-by: DelaySystem <DelaySystem@tubot.lat>
---
v2: resend in plain text via git send-email; v1 was corrupted by the
webmail send path (HTML part, whitespace mangled).

Note: this complements Hussain Sitamouwala's unmerged patch
<20261104112629.180890-1-husainsitamuwala21@gmail.com>, which fixes
"defaulty" and "althernative" in this same file. The two patches touch
different lines and do not conflict.

 drivers/staging/sm750fb/readme | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/readme b/drivers/staging/sm750fb/readm=
e
index cfa45958b9d2..dd8ba1a85695 100644
--- a/drivers/staging/sm750fb/readme
+++ b/drivers/staging/sm750fb/readme
@@ -1,5 +1,5 @@
 Introduction:
-	SM750 of Silicon MOtion is pci express display controller device.
+	SM750 of Silicon Motion is pci express display controller device.
 	The SM750 embedded graphics features include:
 	- dual display
 	- 2D acceleration
@@ -27,7 +27,7 @@ About the kernel module parameter of driver:
 		ahead of parameters,so,it looks like:
 		video=3Dsm750fb:noaccel,1280x1024@60,otherparam,etc...
 		it equal to modular method with below command:
-		insmod ./sm750fb.ko g_option=3D"noaccel:1280x1024@60:otherparm:etc..."
+		insmod ./sm750fb.ko g_option=3D"noaccel:1280x1024@60:otherparam:etc..."
=20
 	2) if you put 800x600 into the parameter without bpp and
 		refresh rate, kernel driver will defaulty use 16bpp and 60hz
--=20
2.34.1


