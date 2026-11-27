Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.221.237.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795822385;
	b=N5pGncpYR7vw784YQY048Qrz8XKZ/t9InptSbhB1U6clfS9OKSlFP4C2hUKIzu5nOKB8
	 1YoW5KYMxOx9Ygf8DTDcSXUrqedQJm7aqFNWVwg9eNUaPFJwTzZX3V5Cc9VGu8o9Lm1eB
	 6IMbVAYw2kpoJGgisGq0yphv65CqAnwIfBdvDz1JXCZo397KGqKGJKVp6vH8dr25+0pOZ
	 VWXNKanI6nwVmbZABpwSWJeTT8XDF4+dSl7nmoRDSW0kv6ML/gFoVIBOciN/kWwTG/rsB
	 GdgNfnQ0cyLGkWyC+vAAFkR5qPfDU4hgLzRxyfajfzok/wgyxSAOP1WxihZvfc3E5WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795822385;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailru-Src:X-7564579A:X-77F55803:X-7FA49CB5:X-87b9d050:X-C1DE0DAB:
	 X-C8649E89:X-D57D3AED:X-Mailru-Sender:X-Mras;
	bh=p7rHqBFtr53PsJeEsSa+AyFm7nVo6qAICBOgCOIhAvA=;
	b=RpVh9AUNOmjilxkQnDjTikKQNc1sgur2aiEFTVEVP+UdSKXsGKlC8Gy3sUfG5xOO3/am
	 D72lzTbfJl89oY/phoKYFzZnb/av9DFL6PrEtAdw3o0aP4X2on99+nZZiXglK4mUtlWDC
	 Dn08p8KPVlE2Ecye/8L1+YL04NIzI1s2AEF24wsrPBOtbXhgfMfaBbeYqtB3UXIaKrqh5
	 NgYycTcRw8+xpbPeXv9AWez+SFWs78Kzi8r0bVkhHKdzCZb2dttxrSELTbvn1qxxIi5YG
	 bGLGgq3qdADQ7jcg8jYtV7YinZenld5KZDyWx/HYfcFDacP+smOmC12MV8qltzXuKKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=eYIibspq;
	arc=none smtp.remote-ip=89.221.237.224
Received: from send129.i.mail.ru (send129.i.mail.ru [89.221.237.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F7606A31C
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2026 23:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA4F7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=eYIibspq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=p7rHqBFtr53PsJeEsSa+AyFm7nVo6qAICBOgCOIhAvA=; t=1795822383; x=1795912383; 
	b=eYIibspq+ogUs6K2P4OA9KCC7dRaNE2Pfq2LEHrqHxPgq8fzUzz8HQUfMbam2EdaOPVks/6tVEG
	3NfuNdS+2KnimUpDmiZIvvpSsbwJpKUQkai29ZCpZPaVKHuCNzOOjHsl/W/INeLUx5VMw55kduqJ+
	/kQ5a4WxbaG3fBp6exc79ySy3LcOXUnM9yL5Fg9HDzxXEIOY0oPPRx2MnxYPnQzBoCQctka+YTX+B
	ej81vOYcQ+o1fUya/Q4Ip2sGAur90U9iTKJF4xSle9qhQx/cjqVdh34Ud684B/24EBMhtUeCCK4B1
	VUCAnL+WWZXeIxJl9shxwBQG9BI+x+GOnS4A==;
Received: by exim-smtp-558c69478d-m9w8r with esmtpa (envelope-from <listdansp@mail.ru>)
	id 1xX5Qz-000000001UA-2TdB; Sat, 28 Nov 2026 02:32:53 +0300
From: Danila Chernetsov <listdansp@mail.ru>
To: Helge Deller <deller@gmx.de>
Cc: Danila Chernetsov <listdansp@mail.ru>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] fbdev: kyro: Fix division by zero in SetOverlayViewPort()
Date: Fri, 27 Nov 2026 23:32:35 +0000
Message-Id: <20261127233235.114388-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
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
Authentication-Results: exim-smtp-558c69478d-m9w8r; auth=pass smtp.auth=listdansp@mail.ru smtp.mailfrom=listdansp@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D70A5F1A44F40AC43D0E6C000425B11C04362336E679F555182A05F538085040F22E11A790351CBD3DE06ABAFEAF6705D56B1B13BBCB64096DEDD8D0123AD74F718F752AB0E2B2A6
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70CF6737295EB4C15EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375669F88000598BFA23382AD04D68A503819EE04A50893A13BF8631B19FC615D17028EEF46B7454FC60B9742502CCDD46D0D7AE820D2C17D0E56F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C068077CCD40B79AC98941B15DA834481F9449624AB7ADAF37BA3038C0950A5D36D5E8D9A59859A8B6B7057D79CCFA8C9476E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C6B5F34833ED93A1043847C11F186F3C59DAA53EE0834AAEE
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5F6222A1A74656B9B5002B1117B3ED696B6A7830B35D0D71F406406D89DD9EB8A823CB91A9FED034534781492E4B8EEADA2D5570B22232E1EC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659FA38DD0D7A27D7212D5D44C1726F9B840830A235A2DB08508272F20761BE5569C9C61001E0E2033DB8341EE9D5BE9A0A4094D0EC68B737AB63D675394448594C6E9FE195E79E65269350E1BD188BD56E4C41F94D744909CE04437D853D7CD20871FE3B1D98EC473624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw5v+G6YiroYwLwAQKEQ+vbo=
X-Mailru-Sender: 4CE1109FD677D277CCA829E46AA49FF5CB0D5C3CA18C49A4B951B70A5BD4BD8E755FCD75DC2D209564F72039A0FE7D74C53BD13D3F6EEB2F3DDE9B364B0DF289C95E31D8FCF52BE1594FB4C9F0DBF4120D4ABDE8C577C2ED
X-Mras: Ok

In SetOverlayViewPort(), the vertical scale factor is calculated as
(ulDest << 11) / ulSrc and used as a divisor a few lines later. The
quotient truncates to zero if the on-screen viewport is a single line
high (ulDest == 0), or if the overlay surface was created with zero
height, in which case ulSrc wraps around to U32_MAX. The existing
check "if (ulSrc <= 1)" does not prevent either case, and the
division by ulFxScale causes a divide error in the kernel.

Return -EINVAL when the scale factor is zero.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
index cb6fa0991fca..fae1f5d5ec8a 100644
--- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
@@ -376,6 +376,9 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 	ulFxScale = (ulDest << 11) / ulSrc;	/* fixed point scale factor */
 	ulFxOffset = (srcDest.lDstY2 - srcDest.ulDstY2) << 11;
 
+	if (!ulFxScale)
+		return -EINVAL;
+
 	ulSrcBottom = ulSrcBottom - (ulFxOffset / ulFxScale);
 	ulSrc = ulSrcBottom - ulSrcTop;
 	ulHeight = ulSrc;
-- 
2.25.1

