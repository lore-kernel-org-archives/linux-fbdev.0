Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F873228CBC;
	Tue, 10 Jun 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554828; cv=none; b=EGaB0vKB0UmVCS0PEN7CYAkTLn8/Cvm2QhoSwOL2aqfVZh4Lr5sWHwAWP8US5ZaHvZUAFWZUuA+AK4LI+KTlYevz+pGXQOu5tefXjQL4NjbzN9WddeAzDaRmFA6fmQ6bwwIYxUxktltqHkoAeHpDSsTShUVAsmtuCGp3UxxAjMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554828; c=relaxed/simple;
	bh=TL6JbSJqsHs7gNgHzQU9wqaEfdVLuclimzl3c35Zfp0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lAU6MHATFa85qb+Shy3RKadHSp1bFt6AF7ELoSE3vd4ZYP2lPdlszmK3bGdo5PQklbQpas6dyHk264xOLugYH7EgzKfNygsmcJV6OCfAl1N2KfGBUhmUSFuIW3X6y+euijCT1p/n9R7nhhv/Rmnr8fmQ64OU2Jqdv3xGkZj7Cq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=zrTiJGlO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Chk2bphT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="zrTiJGlO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Chk2bphT"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D5042540103;
	Tue, 10 Jun 2025 07:27:05 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 10 Jun 2025 07:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749554825;
	 x=1749641225; bh=yuDbo2GW1JzHKoT1DngI1u1qLCDPh52Z9n938BLR8Hs=; b=
	zrTiJGlO2ci1+axaxZsPc6PQHD6SYH//C+2Tv6G0ywd44/0TdMrweZwcZpWJitur
	Qjes3FI9doHEhtyYBwIwPUviaQqab5d/DSTbfRoiuUfe6/ptf+Wa/G7OFpMYCQO8
	90qmHDUFbEe+ojrSJFZ7VLLuZdASCiD0ZGuKdqcJEU4o28iKgiNQzQkJjQMvcVvF
	qbf4vimYA7zuEimcCNqp7GDHC6NqW5RPBMp/4ZKXPDOnPHvIoxHeAZ/5Kr1O/FA9
	PEtYAhD6VU5kUbHxhYNNUTVT4+RgpYdPgKgQtluQZXl3OpEEMeV/48N572b/4NOp
	Pm4f7vHDqxVdBpz0b/a6VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749554825; x=
	1749641225; bh=yuDbo2GW1JzHKoT1DngI1u1qLCDPh52Z9n938BLR8Hs=; b=C
	hk2bphTu8ab2tZ58nmZfBQFDPJIhl2sFEYbmP29EiqVXRuB8lN5n4zxlFYKNhlmn
	Yd1RBo7ojwAnVkNTKL2LExaxFQeIHn8SgG0Xqest6WYvtX7L8gV/zkjDNhIXvBQC
	JtEhPOWb4WUyl0/rx5+ihImFl2f/p7ramCQYWQvD7I94S8UDciHYhbXxIPRanKOk
	WxJvZm2SQHKLWEAa8Aze1aCXktWqIihpGsqi8vbM4TstNaEru43dzB/Vpxx8i1DG
	3SKqQnezCSWl8it+3BsntNr1rRPeCLaC2Q42gC8+zMYIGYx0v64cKQMmTyK3Wo7r
	e2bjJp3Y0VSLThydZJz2A==
X-ME-Sender: <xms:iBZIaJMMINykXGFrF7dbfsE92sE7A9algJW8pV1S6xq0q7Wxpg5QhA>
    <xme:iBZIaL-Ia97AHVOGJvKIYkr2yFDuLqajMQLupbCmVtyz6Hm3H4TRq2WLvZhm5uNaB
    qkCjkdCbd3wgntyONQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrihihrghnughhihhmrghnudegse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnugihsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepughrihdquggvvhgv
    lheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhsthgrghhinhhgsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthii
    ihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehlihhnuhigqdhfsgguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iRZIaIQrGfpPzIu76UcAcu7BdyFSd2LhEjxJJ5TZFLkuBs2jW283wQ>
    <xmx:iRZIaFuLY_Q52LZFl8G703CuiH8dMr0WXsK5N4Gl1rh9y2cXMSPj4A>
    <xmx:iRZIaBfcvRtZvgg3dAZHK2MpCQF0wg0As6zYEpSyqyqAOKTwfHAgqA>
    <xmx:iRZIaB38rbuiwMRMP411ha8C5PurhFFJbXnW9bjb1fGD6BNlcNo10g>
    <xmx:iRZIaCLwED6Q6-yoN7h0d8YP6-cJC6M3qCrDJ1RkEaQ7c7AZb6ree3dI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D99F7700061; Tue, 10 Jun 2025 07:27:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6da4eef3dd4d532c
Date: Tue, 10 Jun 2025 13:26:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Arnd Bergmann" <arnd@kernel.org>, "Andy Shevchenko" <andy@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Riyan Dhiman" <riyandhiman14@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <39920a53-0458-484c-bb6d-9d4bfaa38472@app.fastmail.com>
In-Reply-To: <20250610112357.3306246-1-arnd@kernel.org>
References: <20250610112357.3306246-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] staging: fbtft: reduce stack usage
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 10, 2025, at 13:23, Arnd Bergmann wrote:

>  {
>  	struct device *dev = par->info->device;
> -	int buf[64], count, index, i, j, ret;
> +	u32 buf[64], count, index, i, j, ret;
>  	u32 *values;
>  	u32 val;
> 

I was too quick to update this one, please ignore v2 and
wait for v3 after I've tested it some more with the (hopefully)
correct version:

@@ -842,7 +864,8 @@ EXPORT_SYMBOL(fbtft_unregister_framebuffer);
 static int fbtft_init_display_from_property(struct fbtft_par *par)
 {
        struct device *dev = par->info->device;
-       int buf[64], count, index, i, j, ret;
+       int count, index, i, j, ret;
+       u32 buf[64];
        u32 *values;
        u32 val;


     Arnd
