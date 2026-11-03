Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717924;
	b=aEnHZec/EctRU3l9i+1m2P2LtkScw0bDx2FIWqTy5JZ9MGhUVp/voUXa2DS/gUqFK+aX
	 obnKIOHdw8ZA5sE2DPHBxJjCFvyqmVfF85VbZBjYVAzoh2XlwJQJiwGlcwa6LzgaDMpTv
	 7AxD83w9bmO6XZaPthpiLr0GZ+dIbGEgPmRxRX1SxPYhiWXddoQ0WZmtsRxEuTZ/XZdSl
	 XhjmxcI7cvsrWhwSpYQGCNmrJ3qRAswFg6cqtbvxjG6m+aeJ2c3KZ3siWLm6UeOGY+A9O
	 mG2ooMtWSrlLnmn0fJUJA9rVpAnawzKSvsbiIRVph3qm5IUME0sfAlDdSQUP/9tZhYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717924;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=nTUozzCyh+pEWeTB0Eeq+kV2EjmkicqTp4fHiliIMdM=;
	b=g5+RSEdQr587VWrCXJsCN435NFkdoflE9DXUQKAjzI6jq2ywtzc1qQ8yGZFBGLnmhpuC
	 AsUI8dslHLUjDubQkCAMCzBb/R9mZIByEnjaEwf4bcCd1Y6YyJccAzCpclVPq4SvtFIQF
	 JEMUS1q6tUisNsTBZWqkLwfOqON0W2sgEwSKqO3b6E1vis53/TDyyrEQ/18Nbah0GVZhc
	 NKfDrkDGaE0Sk7yRprWXYSgzaeQhA2FLldg+yCJc+D2o00ixROCa8c5zwXpFnwLt48qwL
	 mT7oRqT2XqfW3rFUyD/YTxkzVKPa+1itR9YzD1SBXERs9AsbagEfLUYXLBI63HCmi/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyKZ+5Pq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24C606C829;
	Tue,  3 Nov 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyKZ+5Pq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7701F000C1;
	Tue,  3 Nov 2026 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717923;
	bh=nTUozzCyh+pEWeTB0Eeq+kV2EjmkicqTp4fHiliIMdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SyKZ+5Pq0K6VAtbMhCIWRWD1raf64pFT1Qxgeysf2Gg9T6CoRkWJbK3dt1APo6UGb
	 Y5pvlb9fGUZ/bl3qg0opZi/iyhu4CqqD8cck4G0dy3/V5YDAG+h3N+TkeTA/Wgj3pP
	 b0eGW3dNFvsLky1aa9t/KYVhxBP4v5Qe5vpZ2KxakwzXIuSVcWTYkFhYoVT5QcFT0A
	 VjJeobyw2wnDET8K+9p6sfD8AoexzjO6pM1LJRG7GpHwtgOOzVHlkMxwfaz+km/i9d
	 5Bs4PNRZujCeRKcIk7cxiuPfIZVebc9eYx2l3SdVhLvfFZKHcXaiQHXOXIcZCHrN9u
	 +2eP93vKiDPOA==
Date: Tue, 3 Nov 2026 14:58:38 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: add ktd3137 support
Message-ID: <aun2nniPnWaC36UY@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-2-b5b4f903c56e@protonmail.com>
 <aunskqwg_CbpBL49@aspen.lan>
 <1IItRacxO3yGApfxlr9c4eyKqir8AGxFAmGYXWKDS_spX5pByW6JP0hxMqthOs7_8j0cOzthZYeTyu2wA1LAwNWDqsw0B_E-WExI1IjjmRM=@protonmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <1IItRacxO3yGApfxlr9c4eyKqir8AGxFAmGYXWKDS_spX5pByW6JP0hxMqthOs7_8j0cOzthZYeTyu2wA1LAwNWDqsw0B_E-WExI1IjjmRM=@protonmail.com>

On Tue, Nov 03, 2026 at 02:45:52PM +0000, Roman Vivchar wrote:
> On Tuesday, November 3rd, 2026 at 4:15 PM, Daniel Thompson <danielt@kernel.org> wrote:
> > On Mon, Nov 02, 2026 at 09:58:49PM +0200, Roman Vivchar via B4 Relay wrote:
> > > +static void ktd3137_remove(struct i2c_client *client)
> > > +{
> > > +	struct backlight_device *backlight_dev = i2c_get_clientdata(client);
> > > +	struct ktd3137 *ktd = bl_get_data(backlight_dev);
> > > +
> > > +	backlight_dev->props.brightness = 0;
> > > +	backlight_update_status(backlight_dev);
> > > +
> > > +	gpiod_set_value_cansleep(ktd->enable_gpio, 0);
> >
> > Is this needed?
>
> The datasheet says "When HWEN is set high, ... if SCL/SDA’s pull up voltage
> is much less than VIN voltage, it can cause a small leakage current ...,
> there will be around 7uA additional leakage current from VIN in this standby
> mode."
>
> It's better to put chip into shutdown mode, which won't cause power leakage
> according to the datasheet, and ensures that I2C registers will be reset in
> case chip needs to be cleanly re-initialized.

Right but this is the remove path which as about to free the gpiod anyway
(allowing the GPIO driver to do whatever it likes and which will often
be HiZ rather than pull-down).


Daniel.
