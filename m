Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481556;
	b=omjLhdF0ZAyomikERinOWQt6NKGt+3OjMPAn6iTfDojxPVaPsTGk6Wshm2i/Mll2of48
	 hQxCXJ4K9uejjduz0L49VVByMF1giMBwMDPJvnpLkJKoPbWQj4opgf/Q9L3AI8ej1omH3
	 L+R+9xJblmEbZtAmeSchiQMhFCX3GbDE3zSeBvy60q7u3W28+C4R1K8cqKYJrOgPq/eOS
	 bYrjouGanIdi79SyvQ8kga88vIrK3e9RoKI1FSfkMZSfCFxSMlr62HCOWv3lPO9BqbwcR
	 0zX4cwn/W91nXrkSpCe+a5twQa+1sMGNw6VapLzN27W8iYks8gBXeE2NkMqI9q0tf3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481556;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mXTe+OT6mzHTMHVv+nfjup1kUqTXR5f3gseQxSoH7+o=;
	b=AbjIcTr83TzM141Hpky8aUTahZRQupt42wPc/8FE14FImvotCk9LtXQqQZgYT3Lkz74I
	 1VZ9QaRKyj1UX347hmr4F/Ccs4mqn5cWu7i2lAQG7SwDhSMdn49Mo7sS2Tx3K/lzXveCz
	 fV5EhJJgn62M2RHcqApXWj2sloQFFBvN2z1o0+g0zqpr2wzw0XT8vsWsodOZFlJ2ax4du
	 6TdccQJF8NDmlaZPF9F9y/CKU6GHaUnC28I05tFyhfeat32kDu59I4k6mue5GUAgJ0dgE
	 8QSRAEgjEREhdEGrnA6TOBj8bRgg1G9dzTX5fldu6f7xqvG8xh4ElQq5r1ZmGMomSag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljR1QnRL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F8606A321;
	Thu, 12 Nov 2026 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljR1QnRL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33261F00A06;
	Thu, 12 Nov 2026 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481556;
	bh=mXTe+OT6mzHTMHVv+nfjup1kUqTXR5f3gseQxSoH7+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ljR1QnRLgzHSvEvMfu6/ddMKedwrVFT22MBaP7lJSG8fdrJ+5NK6I05rOFtaU+Wo2
	 S2P4S0AJACJqphkjI2TpTcDxRcV/BVcr/4UjB7DKbCuExddYyH8BKUPR6yEgpBS2KU
	 1VT9N0hcNWcu4wXfaceL/hOteLBOwfgWLAh++gi4+qLHeXKazE604RBkMeo6yOfTCc
	 +DSOKDTk7sC1Y0Rqvftp/vqTdimKrCMP8BVDmONpyMNL0tfSDCzzN1kl12umaNPKGa
	 7Ni19Kk77K3bCUh/ZID2MiDJdyHkSf00VwYj1WoIjHzToP+lpMuCxsjAKAklybfB+O
	 0Xu2X4oKf8MRw==
Date: Thu, 12 Nov 2026 12:05:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michiel van Beers <michielvanbeers@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: lm3630a: Add
 led-max-microamp
Message-ID: <20261112-subtle-kraken-of-serenity-04ea8b@quoll>
References: <20261111-lm3630a-led-max-microamp-v2-0-aff11756e7be@gmail.com>
 <20261111-lm3630a-led-max-microamp-v2-1-aff11756e7be@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-lm3630a-led-max-microamp-v2-1-aff11756e7be@gmail.com>

On Wed, Nov 11, 2026 at 05:21:41PM +0100, Michiel van Beers wrote:
> The LM3630A has a full-scale current setting per control bank, from
> 5 mA to 28.25 mA in steps of 750 uA. Boards whose LED strings are rated
> for less than the chip default of 28.25 mA have no way to describe that
> limit.
> 
> Add the common led-max-microamp property to the led@0 and led@1 nodes,
> and reference leds/common.yaml from them, where that property is
> defined. The property is optional, so existing devicetrees remain
> valid.
> 
> Signed-off-by: Michiel van Beers <michielvanbeers@gmail.com>
> ---
>  .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

