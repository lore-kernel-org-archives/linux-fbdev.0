Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC3E472F82
	for <linux-fbdev@vger.kernel.org>; Tue, 18 Aug 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073914; cv=none; b=OneVW/Ha0dZCIutouiThu/VhYNjBM3g81fYHaSN4erFYLa8KAY3IR1rF1DlwRGtYGSfuvZjtOiqMuIYwi2aD4MaAgoU5h//D6TXjqeAtIDGq7EDuRlKhG2yephLrHAlUElgcCkjnyUL043vKgGztT0BVR5dTjq9P/tNlZIR5aOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073914; c=relaxed/simple;
	bh=oOMrs2LNOE1k+7MMTZiOkxT3hBV3rnFDhhBTGdvpj+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR/cXrfMshec2ASQKnuzS5oVeqLvXvWTH2Z5cKB2Oxn8O0m6QEpJkkKAhp2fyftB55UdpcWFL0+bqsSuYE92xVKpAs7nompU40Rjan6Lm1rOY0D/ZK23laIpgTLpwc5zyeu9SX40AbPS0M08mkCEuDtdOmHiUCziZby8VmSqmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=GcC7QfKH; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=/ZQ6mdzo; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="GcC7QfKH";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="/ZQ6mdzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787073901; x=1787678701;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
	 message-id:subject:cc:to:from:date:from;
	bh=oC+wbZ11MiVGNp3BL/DR+8hsY0fcHA1LiiIfSy5DLo8=;
	b=GcC7QfKHkOUrPSI94TQn+XxlpXbwMsxa7XMYgTO2h0JFyyB3oFha2HiMzUnGi71v4Pa09pPo1Nd3G
	 6HBZXIuflv6YSpUh9q6DR8RMiDbIPppMvj4KulZYW4Hcugs93zlJoPj+ehka2cCs6tlnb5zmUAe8FG
	 D01ABKdxFc0TMf3+I1gjjK+/fUmDJpjqVppRHosY8UQ+qhx4WpGYT/H2fCR9QBVcYFA6pOPR2isNwO
	 NRYlq4/MtFHB15/GHp1eBua/u5Dv7eHHibDQ7GMltxD71tNyZc+bYrmiLlRYZQH7CMpcwIWMcgzVzS
	 Pzi0M5BL+EWToqwsK0Ayt7hb0Z5pLmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787073901; x=1787678701;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
	 message-id:subject:cc:to:from:date:from;
	bh=oC+wbZ11MiVGNp3BL/DR+8hsY0fcHA1LiiIfSy5DLo8=;
	b=/ZQ6mdzofkH8/R5vXp9D2JUqmrEU+5zs9RgJTrS0ObUxrYkEYNBKjes79WhtGmK7fIk+HwbVCn9MU
	 iGJEeMRCA==
X-HalOne-ID: bd3e7268-9b29-11f1-b934-6b8d581b3111
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:12aa:6509:509d:7116])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id bd3e7268-9b29-11f1-b934-6b8d581b3111;
	Tue, 18 Aug 2026 17:25:01 +0000 (UTC)
Date: Tue, 18 Aug 2026 19:24:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?Q?M=E0xim?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Francesco Valla <francesco@valla.it>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
Message-ID: <20260818172459.GA770905@ravnborg.org>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
 <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
 <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat>
 <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
 <20260814155325.GB516994@ravnborg.org>
 <CAEUXW=Ffs+WKsQrNc3zjwtfAO=FKTf_7jQFovD+yjmD_yJuY2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUXW=Ffs+WKsQrNc3zjwtfAO=FKTf_7jQFovD+yjmD_yJuY2Q@mail.gmail.com>

Hi Màxim.

On Tue, Aug 18, 2026 at 12:48:21AM +0200, Màxim Pedraza Padilla wrote:
> Hi Sam,
> 
> Thank you -- that's a useful pointer, and it settles the question of how
> a splash should be drawn without fbcon: a DRM client at
> drm_client_setup(), next to drm_log, not a drm_fb_helper hook.
> 
> Francesco's series is genuinely inspiring work, and it would be very
> useful to me if it could take a CLUT224 image -- unfortunately it can't.
> It only accepts an uncompressed 24-bit RGB888 BMP, whereas our logo is
> paletted, which is what keeps it small: 17 KiB for 800x480 rather than
> around a megabyte. So as it stands the format doesn't line up with what
> we carry.

Without looking at it in detail I would assume adding CLUT224 support
would be doable. Step 1 would be to add a format conversion in
drm_format_helper and use that. You may also find this useful for other
purposes.

	Sam
