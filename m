Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9735C6AC;
	Fri, 14 Aug 2026 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699345; cv=none; b=OYAHCZ9ORtI4sEqb4lnPzNTlofMn1sk1fFJpZC+8+8JFDtOVSj7PQ13SYSBogsWi8wste01W6sE5E2sIysfWM5YCmTsUEToqdJYqLpYJK8u6MaHrk43zjEvHSktz0znacPUCXvzt+0PIGCDWx0RFXMLDWf3y2/RUmsXVgP6umyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699345; c=relaxed/simple;
	bh=Z9utvW+lVsCYkk/ao1XgLX/4iCAmFON0YfBwYJuecYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdxV/O1FY8QZkm2kkQUSdgi3HRXy4CGdKxuQzUnJYkni8dyo7pMQLcPaMcrEV1fIbJ4dufeZYuVBYVSdepblgodbiZx5HwAJ/niH88C9362GIH80eQhX//OsHtdZQ4ndxQ6lCxzh45WZTbBHS/yMhZnDv6X5Zf8/xJ63BtCLgZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2Gi1Qeg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2Gi1Qeg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260041F000E9;
	Fri, 14 Aug 2026 09:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786699344;
	bh=/BE5TBGxjSVANRjvlpPQ+jBGmT/P99F+2F3AmRMyMRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2Gi1Qeg9af4pXA15rxLOYF98Mv79l2nNHVq3SFuXK/xWrrjdtu6XXbSzSBTAhdjE
	 jOX5m0k4LAh/uKg0oNsf5pftVzGwMoOVRGacwJHrsH7GGjkO2xiO4/UZwf2gKAezsu
	 KvkwvIf2k0aFatQnPDoyzlptCWl+TJ5fwO0gvrQoQRibByUFN3IDq/shJ5Jb5vtSe6
	 +IwG98Av+lTQaF4hLQmz/fQe0DOcefvng/bnYVSHDHEhMBweejgK2iBUw640wG33TI
	 Uq9QCr8TpofGVRuYFg80mEVltk/vDK2EnGQ0K33UCYtW5zB5xGiCRzburH6cmIQ91S
	 TD2IcHVtQeLzA==
Date: Fri, 14 Aug 2026 11:22:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <20260814-peculiar-mega-mandrill-3a3148@quoll>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>

On Wed, Aug 12, 2026 at 09:21:47PM +0200, Wim de With wrote:
> +	props = (typeof(props)){
> +		.type = BACKLIGHT_RAW,
> +		.brightness = brightness,
> +		.max_brightness = max_brightness,
> +		.power = BACKLIGHT_POWER_ON,
> +		.scale = BACKLIGHT_SCALE_NON_LINEAR,
> +	};
> +
> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ocp8178,
> +					    &ocp8178_bl_ops, &props);
> +	if (IS_ERR(bl))
> +		return dev_err_probe(dev, PTR_ERR(bl),
> +				     "failed to register backlight\n");
> +
> +	platform_set_drvdata(pdev, bl);
> +	backlight_update_status(bl);
> +
> +	dev_dbg(dev, "probed, brightness=%u/%u\n", brightness, max_brightness);

You should not have probe success messages even as debug. It's not
printing anything useful as brightness is fixed (comes from DTB) and
devices appear in sysfs thus you can check them. Printing debug probe
success messages applies for core SoC drivers which might fail before
reaching initramfs mount and starting init.

Best regards,
Krzysztof

