Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EA1917E7
	for <linux-fbdev@vger.kernel.org>; Thu,  7 Nov 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000660; cv=none; b=FXix+xtLj5562tFYAr+bUA+x9YjN61XZ+4Oz+zjrsBWP/RX55w0APmJzR9slumtWjVQMjk44o3w6yuHvbHkh9uLh+zPzFtOTLEr/1+GE1NIE2HLnIkNk7FSFj2HZmSNks3ncH+lSz2WRTGCQQB2/HI5AXH35mv8mZis4DMqsfLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000660; c=relaxed/simple;
	bh=KWmTLexdWG+10e2X8Jsayh6c7Tr3WkCJwNifhKSLri0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyfOJxBfbCaCKGVFd++uI42IsTGTOqjqBBo+Rzz/iNlXxdY4VqfVfcYbrqcVZlDjm9FasJ7oWqGmFUIART+fj+ilSrvYrmWxoSZ7MVMltYyRgjCw6KJjicvsh3WsSh8b1nesLDN2+2kSHQxyd8l74ZgYTIWviqFRpSt+55nhwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=KRuX4H1G; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KRuX4H1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1731000655; x=1731259855;
	bh=KWmTLexdWG+10e2X8Jsayh6c7Tr3WkCJwNifhKSLri0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KRuX4H1GOF/xs8W3D/f5cwfJc9iNAxefZWyZU0dxjo0k1XcqDYkhHouW1CueSnPsG
	 +4/4AFeeWHb/uHciYHM1GdUu6rmIwlsTyOB7Q2PMVYR81SQ9SwyJBIJySsLQJmo0c9
	 59zwg0WmOrf/mb9UFdoUGOAVxjLk11uz+Aj5gIvyhRMX60ErJho+YIZ+675UbAYvxv
	 XopiJBUpA/NmBBXuVdEWSd1iSQY25lpuBk9iasShOvMU3srzdf2yfJAIvr0/QhOkZ3
	 eEVisFe5zIEjzsWbHB6XR/bTP/MzGlbxyX1Sn3I6b3uPACWgfYZxpfmMmOQGIZ0Kqa
	 8QB4leb6MbvPA==
Date: Thu, 07 Nov 2024 17:30:51 +0000
To: jic23@kernel.org, lars@metafoo.de, gregkh@linuxfoundation.org, parthiban.veerasooran@microchip.com, christian.gromm@microchip.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 1/4] staging: iio: Remove TODO file
Message-ID: <20241107172908.95530-2-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
References: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: dad76bd5b32fdcf9e054ad3413ea0c53a9d26581
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove TODO file, as it only contains contact information.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/iio/TODO | 5 -----
 1 file changed, 5 deletions(-)
 delete mode 100644 drivers/staging/iio/TODO

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
deleted file mode 100644
index 0fa6a5500bdb..000000000000
--- a/drivers/staging/iio/TODO
+++ /dev/null
@@ -1,5 +0,0 @@
-2020-02-25
-
-
-Contact: Jonathan Cameron <jic23@kernel.org>.
-Mailing list: linux-iio@vger.kernel.org
--=20
2.34.1


