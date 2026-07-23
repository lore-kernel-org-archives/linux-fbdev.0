Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F035F189;
	Thu, 23 Jul 2026 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789066; cv=none; b=mhAULN08JypiF02zc6+wCIIniIv27LMwH9jy8cw8nXBsMHgAJCnF81vMg6K5zbhV1WyC+h5QSSzff/7PNmh74arLMKntYU3pxe85giJQ+iJom3GzJgo7mNk+MXR6lMl/8+pMVcv0zkDYPfYih9mGcKyCAixvqzw83x9s1LiRRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789066; c=relaxed/simple;
	bh=45JXXy9qkNKYjUa8SmtcrV5/E35scfQqjbCO0yENcyA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FApZsp8XeshVxIe1qnwlVRHAjXyRN2LHJkHBA7T+XjM97BtqeP80GlFj8dVDsYzYdS2QeyH4BIxJTm3j2EFDsFRgzqM+w2ocatnVhwaycYkuE6qHfC6TDrNJ8y+SQ1XybL8gJWyUsf47UdR4YJxcbxiOwYx9Hgb9wcF9gG9MQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jXOCscFB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G9KqN6vh; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jXOCscFB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G9KqN6vh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14D4114000ED;
	Thu, 23 Jul 2026 02:44:24 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jul 2026 02:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784789064;
	 x=1784875464; bh=HTbkVd6Wq6Ip4RQIXSUsnzOc5fWskilI0JTEv1l2AMo=; b=
	jXOCscFBczbYwISru5b0WlMcuYHyvtRqw2pmaH6OT3Lb6EnHg4e5bng8wUhqQiKK
	xgZt4o2JM5wf3TSoNfko74u0BizEFMJQcpUB0xyt8rUK/uh0Wxe3w6pkwJtMDrFp
	2HFxjBDBUBlRZvVzyIWpyQUitKEm+U1I5DX+S6phKqy8tKkeFuFQXiULWI7ls1Ae
	AMVYgGqBwdmK19Vue5knOzfL5SV2TX+U5sHBRjIZLXqHipbTDbd1YByau6/qxdI0
	523mhrbGTm+JGVSd3rQslUvS4VT8zeFVOfHFKqvXdGKTGdxMmayAvZTQUTJMgdkI
	9IeP9BOPkpalxWOxw2UeCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784789064; x=
	1784875464; bh=HTbkVd6Wq6Ip4RQIXSUsnzOc5fWskilI0JTEv1l2AMo=; b=G
	9KqN6vhM/GhgdF8t3p/RBW3V+i7nfswuhNpM9vscPu0k/KZlQRZKvmTqWXWthJWG
	wjO50yIoRaycr1bp3LBthGGuET/plJ+OyZ0YmXXUz81pH/xNb0NTEeeCKoXOnZeG
	LtDE7OKaQetYzrQUCg4RBHuIwQbY2vndGA+bFHSyNaDrSmgytmYTAFwjLnmQZCSG
	aUtJiXVukz/lO3jPDMfD2379ljH2+FhlRlN21wcjWJ9OOSxMy+p4PKphqEvbnoxY
	yUOX7sM7Sg0MvhUlAXrvq1VBwwcrh7Bi4x2Fw1CApahvhRV7ZabgVejC2ytijVyI
	TO5CV3cA11ehOG2y4YngA==
X-ME-Sender: <xms:R7hhagKj-Zpuv1jlefp8cJ7niGwEwOjxShIUSP2rnCsmtRLMT4LKXg>
    <xme:R7hhaq8HJSIluZXkhqZZydCpLGICihC5N3oMhhK898use9lPVR9zb528zRcCNSGxd
    KVKZNoOM5Aa9pU76zN_ydY0rwa1nYbZ9e4PQL2qfKiXhATTq83Jik8>
X-ME-Proxy-Cause: dmFkZTE6QZb+iHWpL1mO+WsK28M5HOJ6jSDCRX4MJVUuJmHkrp8fjQqcnHFMOWQPUMjSZ5
    0s8AasFJxawL3drXqEA4wDRNhL64B0zge06O2h3kUM5afAxmuuvgb8Qx08+jzxeNyg4/dI
    1C509wUMH/JyAZay4iFmSDPW1zzc9Nun5e7N8rEQs0a7yRhtOTjAyuNmL4Me2yxh5SgAvp
    r0zUoj/aqBjFaNW/Jz4ckeuWIPcdBo3ePlbRtqlskTSCkN6XNQftiAi3lJsoYPVY0kozXf
    ofydBXq4yrDomyA8hJ2sCZPhpfTdxDEyEAvfcGgizTxQVjP+6AwT252IobqADl7wftU0o/
    gXOFbQFdLQPN6Hq6O9Slz5YZNemy/9SzKBmLpsIJv247uq99NafRJUJs6UPMzWEAjKmXPP
    NWoq/3xjwKITazN5kSscyqH9sKe4rH5gwQ7T9Psi5qKNf6OBxMpexcyhEoylbCeWXu0E39
    MYedRrKHgFiXHo3bz1DjXVInFZxijiLT/E9VI8JFu7QETP3PrXNbEa3bHdM/qgJSgG1Ild
    /LfmHTZOU+8lLBEMJsQpFJ2wG2wNiQ0ht7ec336hH1SESCBgbPKVcMBrd5CJonKBBMdcS2
    VClczfly6pNpgG9pgAw68pejhtlHxQgzR8Y42k+9AtXcqpb9KKLcp2+hlUOQ
X-ME-Proxy: <xmx:R7hhanYltOus9jeW9PUOYpZ_XJN1B91raAupijg09bYoM4YE8GYRdg>
    <xmx:R7hhaj7aEYzRyHTIC-reNM0ynROz06C8gW_QzCK2zQoaSkaxBqRH-g>
    <xmx:R7hhasmTm0AqrqFNy8nDxKe-rnPZFyu2gaMzW51nqyEqXlWRU8XUsQ>
    <xmx:R7hhajHQx5v4uZGsRIavqVQZ9Lu3um34IE_eNR7FluBRij1opvW1GQ>
    <xmx:SLhhagizdM4t9BqIHhjFmoEGNfEAADeOSlJiNGCG5o8gcKRecpTFC-DJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AACB6182007E; Thu, 23 Jul 2026 02:44:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADWwDUKQibi3
Date: Thu, 23 Jul 2026 08:44:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Braha" <julianbraha@gmail.com>, "Helge Deller" <deller@gmx.de>
Cc: "Thomas Zimmermann" <tzimmermann@suse.de>, "Wei Liu" <wei.liu@kernel.org>,
 ptsm@linux.microsoft.com,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 hsukrut3@gmail.com, rob.github@jumpstation.co.uk,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <99391074-24d8-4725-8e8d-ac310a666f29@app.fastmail.com>
In-Reply-To: <20260722220023.196029-1-julianbraha@gmail.com>
References: <20260722220023.196029-1-julianbraha@gmail.com>
Subject: Re: [PATCH] fbdev: replace dead select with dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 23, 2026, at 00:00, Julian Braha wrote:
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 085d3a202148..1ed4506c0cb2 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1717,8 +1717,8 @@ config FB_MB862XX_PCI_GDC
>  config FB_MB862XX_LIME
>  	bool "Lime GDC"
>  	depends on OF && PPC
> -	select FB_FOREIGN_ENDIAN
> -	select FB_LITTLE_ENDIAN
> +	depends on FB_FOREIGN_ENDIAN
> +	depends on FB_LITTLE_ENDIAN
>  	help
>  	  Framebuffer support for Fujitsu Lime GDC on host CPU bus.

I would make this one

       select FB_FOREIGN_ENDIAN
       depends on FB_LITTLE_ENDIAN || FB_BOTH_ENDIAN

to avoid breanking defconfig files. The default choice is
FB_BOTH_ENDIAN, and that should work fine here.

     Arnd
