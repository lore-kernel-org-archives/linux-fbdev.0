Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8641F366;
	Tue, 18 Aug 2026 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.20.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041201; cv=none; b=t15s/m3X34uiJTrvSvaDBwKwKami7QSPEO2cz6JSpvm4JHXfHMlLR16+e654+BuHcZzSYARSi1B0jLxQAQ+LvgCGzZs5ClXrS4AqE/iK8H2WU7UQ305s3Od9ILzKgjZVdF29RIiv78XJSXzL49B3plrD8ioBiLs3GrfEodlUYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041201; c=relaxed/simple;
	bh=1uITmLd8Aoo7TeMhUpjph4c1zmbRhJUdcIwNNT12xWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMCviWTmNeTDhgI4tNtnLwJSJHnycvIcTFLdwv/GN+YznHY/0XpZ5W0mF4xsT4Ww39LxrVA69/lAoLXAZc9pblBiv3IZwN/A0Yzi9YbnWY+OcXH6e1GSqXiFk5Auq0RuTK2AoyMDcXNMTqF/wpHPP1KvdhxF01xAkIVu8Y2i5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io; spf=pass smtp.mailfrom=dewith.io; dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b=w/uT14aL; arc=none smtp.client-ip=157.90.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dewith.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b="w/uT14aL"
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by meve.dewith.io (Postfix) with ESMTPSA id 82B4B23D8B;
	Tue, 18 Aug 2026 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default;
	t=1787041191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sme0lWRlPwues+3nXUDbIzXVcq97z1tTJyjaUWjJXfw=;
	b=w/uT14aL41UZVnue474ddxJFYpVEu9H3ifWdHXBj28vdbAkOOMwCZwBaY48TxpLfuzvEGh
	lyNf9jmOosbpdIbqQdFwCoKVjVyKdIEEo7DCJ+Pn7kxl+NU289awLWGbspvf7cUr0PAdfV
	pH2RRbdZaZCh81jBtT1xUynlgs+xdmI=
Date: Tue, 18 Aug 2026 10:19:45 +0200
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
Subject: Re: [PATCH v3 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <aoQVofK2EK6Tjsw8@dewith.io>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
 <20260816-ocp8178-backlight-v3-2-caf95c453c50@dewith.io>
 <20260818-crazy-corgi-of-sorcery-abaa23@quoll>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-crazy-corgi-of-sorcery-abaa23@quoll>

On Tue, Aug 18, 2026 at 09:34:14AM +0200, Krzysztof Kozlowski wrote:
> On Sun, Aug 16, 2026 at 12:57:04PM +0200, Wim de With wrote:
> > +static int ocp8178_bl_enable_onewire(struct ocp8178_bl *ocp8178)
> > +{
> > +	u64 start, duration;
> > +
> 
> It seems you re-implemented one-wire interface instead of using w1. Why?
> What sort of one-wire bus/interface is this?
> 
> Best regards,
> Krzysztof
> 

It's not actually w1, it's just some non-standard protocol that the
vendor confusingly calls '1-Wire' in the datasheet, to distinguish it
from the PWM mode.

Regards,
Wim
