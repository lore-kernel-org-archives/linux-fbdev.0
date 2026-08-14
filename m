Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06980492525;
	Fri, 14 Aug 2026 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.20.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730312; cv=none; b=bFqyuze2HC4DB2ulc05nymKZYa336Z5xTBJzwFmkTCD2rAFzUtNGvxxbTNMP2O2fXoFnzE9UjipAErlZtSVjWwhP3WlN+I8XU6Q4ex6tYN3qkdgcasubnVDWRPz7P8KoCPIeEDVZfZuGoxaTmSYLmRcfAIWUfHHbCAD/nNNNnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730312; c=relaxed/simple;
	bh=lbGj7nzIY4w4x0Owb8AUzwmGiTRV8YOEQ8U5QYE7n7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiFfhfh52cVTaTvmGRSVgMThaZU+zd83tXTAPgVwbMBVY+l7Z1pvcMC+H8XIP2+MGeWDQdlcUd12sN30Z77dBEPrhyqb1Q1pTPaBqwh0PlD/ACjCXMzH+UTI7Qoj198AV/kKWBOt1OlHzUv2S1UVp3EDOLj/BNtSBx44Du6hw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io; spf=pass smtp.mailfrom=dewith.io; dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b=OtnwFJCd; arc=none smtp.client-ip=157.90.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dewith.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b="OtnwFJCd"
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by meve.dewith.io (Postfix) with ESMTPSA id 7005F238C4;
	Fri, 14 Aug 2026 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default;
	t=1786730302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3OSKF+fc/ftZbxaCIXYwiQoEpv2eaHUd9Rrn/IRaEk=;
	b=OtnwFJCdkB/JV32wn9xNz0UbCuMmNsNrbQarOg6Y/1KFOMEevIJXoBBKhFSyEm7axIK+7l
	NT3P8pz+5qbGSpCzxKY/2UQoZ0WpbboVQnJIgNYSVrnmkxgFdomGBPIweEBQv8e8sQtoT/
	ckYMgOpFOxxRjroRjFh95PqFMkfytmE=
Date: Fri, 14 Aug 2026 19:57:58 +0200
From: Wim de With <wf@dewith.io>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <an9XJmcXq_EUjY5y@dewith.io>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
 <20260814-peculiar-mega-mandrill-3a3148@quoll>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-peculiar-mega-mandrill-3a3148@quoll>

On Fri, Aug 14, 2026 at 11:22:15AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 12, 2026 at 09:21:47PM +0200, Wim de With wrote:
> > +	props = (typeof(props)){
> > +		.type = BACKLIGHT_RAW,
> > +		.brightness = brightness,
> > +		.max_brightness = max_brightness,
> > +		.power = BACKLIGHT_POWER_ON,
> > +		.scale = BACKLIGHT_SCALE_NON_LINEAR,
> > +	};
> > +
> > +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ocp8178,
> > +					    &ocp8178_bl_ops, &props);
> > +	if (IS_ERR(bl))
> > +		return dev_err_probe(dev, PTR_ERR(bl),
> > +				     "failed to register backlight\n");
> > +
> > +	platform_set_drvdata(pdev, bl);
> > +	backlight_update_status(bl);
> > +
> > +	dev_dbg(dev, "probed, brightness=%u/%u\n", brightness, max_brightness);
> 
> You should not have probe success messages even as debug. It's not
> printing anything useful as brightness is fixed (comes from DTB) and
> devices appear in sysfs thus you can check them. Printing debug probe
> success messages applies for core SoC drivers which might fail before
> reaching initramfs mount and starting init.

Clear, will fix in v3.

Regards,
Wim
