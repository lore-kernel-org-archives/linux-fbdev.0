Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7F442379;
	Thu, 13 Aug 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.20.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615409; cv=none; b=BUQ1fWvmzmAfHanZCrTez68efoL6Yg7XfjAKq3IcFHjd2KYmBDWLkKP+jrdp/+23KLiQwuLwq0xVTZ2s86h5Ax+8+bLJ8L7ObBuHpo+gtw899sDfDmpVnFb0co1sz95BdtDNYVXcFBnY4H7hW3N1Th/Xxub2aw3v8DqzKzUPRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615409; c=relaxed/simple;
	bh=dKbvqlet+y0vK6nezR6ggg2j1UZKrYZHBJB7tv1pDMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwZiLDrtJ2RIWDFl5Gqf9lNrr3XkvCOHnRpJdk/ndtTBnhgu+zGmdt1oOAZvaWLpZnFZCabSDc6GimCNo9TmNtvwwfiH2nFGs1J3vJMPryWw8GkW73vqZLzg7DvNHLUEmO9L8YoDfjcNC+JJGzrGvSGvigulwO1s3oVVao7Xb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io; spf=pass smtp.mailfrom=dewith.io; dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b=L6w4TkoS; arc=none smtp.client-ip=157.90.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dewith.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b="L6w4TkoS"
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by meve.dewith.io (Postfix) with ESMTPSA id A460023E65;
	Thu, 13 Aug 2026 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default;
	t=1786615405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLaN4f3N6hbPhZzEo8AH8L3A2vrPXXcp/6EZkbNc4Lw=;
	b=L6w4TkoSNd7hnu6Nuxv73dllFQL9cOLiLvb4RBoGYI+2+AI/X0lbrjsrf6kXHSgQPUKFbh
	X0dyYBsyKB4r7A/119THkHcIEGu0jhvfwJdT77oJJjJe5q36V9hIqmdFhj2nBo7xxAZxLw
	Va7x/VjX0w9DD/wWHI2F2BbP2jaCEl0=
Date: Thu, 13 Aug 2026 11:59:44 +0200
From: Wim de With <wf@dewith.io>
To: Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Message-ID: <an2VkN3446Ndxn9c@dewith.io>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-1-4ad18b48bef8@dewith.io>
 <an2RgGwu2YaglM7H@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an2RgGwu2YaglM7H@aspen.lan>

On Thu, Aug 13, 2026 at 10:42:24AM +0100, Daniel Thompson wrote:
> On Wed, Aug 12, 2026 at 09:21:46PM +0200, Wim de With wrote:
> > +  enable-gpios:
> > +    description: GPIO to use to enable/disable and dim the backlight.
> > +    maxItems: 1
> 
> Is this really an "enable" GPIO? The enable-gpio(s) for most backlights
> is the HWEN pin rather than something used for protocol. Maybe
> onewire-gpios or control-gpios?

I agree, and there is prior art in the kernel for ctrl-gpios, so I'll go
with that.

Regards,
Wim
