Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC93C9EF0;
	Sat,  8 Aug 2026 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.20.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786185434; cv=none; b=QSvJOjPI1YJLZY/610h9ml3YHO1WkNOf4QhDNj2mtTuMQK0yYasPlJAdvGt3V6L0bkNhJqcOOPkcquhKU2CxRuG7hzS13TgeGzAuW5bnFvpvykp3gX3VD3bGIelWUviqVflv9IoHxVgytaxC4eU6eqRFU0NGqiiLQxipqdt76Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786185434; c=relaxed/simple;
	bh=LlHP/zwL8YMMXIoONO1cC4k0/B2R0pNN3MYlwRle9iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvShBgwUyZnk9qDtnyvuvvfX6jrnI6kIActGGT70r+yGYyFRTFQn9hLxvbyQBksIlnw3/ljc9aG1/cZ4J9aH0O0MZJ568GWGldVJvbH1l33vTMQjIF45dpFRPpFNQZyxtho6PRoqtcmaLTmZCUBq3qiPOYQG12RDzfIsSNGbvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io; spf=pass smtp.mailfrom=dewith.io; dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b=XwQx54XP; arc=none smtp.client-ip=157.90.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dewith.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b="XwQx54XP"
Received: from localhost (37-74-132-17.biz.kpn.net [37.74.132.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by meve.dewith.io (Postfix) with ESMTPSA id EBD802405F;
	Sat,  8 Aug 2026 10:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default;
	t=1786185425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSaDElFw+MnqgzYhA8gil00pUiBrcKmpVElDCxEHTOg=;
	b=XwQx54XPslzIhyxXiB6aSPF1Adj1QirMNYk6mQVdMqt4fC9iujdypzx1yq5owwh4w0h2pw
	ONb9k8aNGtNxwU8SNvMR7HuAxVESJ4sqaVm6lMg9NTuHNPPcwu0zDOpfplG/mfA6Kl7FOi
	++w+Dlf6XsZgQLd0E7jBfsnoAafLRiU=
Date: Sat, 8 Aug 2026 12:36:49 +0200
From: Wim de With <wf@dewith.io>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <ancGwXAICfur322a@dewith.io>
References: <20260806201541.101304-1-wf@dewith.io>
 <20260806201541.101304-3-wf@dewith.io>
 <anV9EBIaZvoTz-lp@monoceros>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anV9EBIaZvoTz-lp@monoceros>

On Fri, Aug 07, 2026 at 08:46:07AM +0200, Uwe Kleine-König wrote:
> On Thu, Aug 06, 2026 at 10:15:41PM +0200, Wim de With wrote:
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/platform_device.h>
> 
> Please don't use <linux/mod_devicetable.h> in new code.
> <linux/platform_device.h> already provides struct of_device_id, so you
> should be able to just drop the include for <linux/mod_devicetable.h>.

Sure, will do.

> > +static void ocp8178_bl_write_u8(struct ocp8178_bl *ocp8178, u8 value)
> > +{
> > +	unsigned long flags;
> > +
> > +	gpiod_set_value(ocp8178->gpiod, 1);
> > +	udelay(OCP8178_1W_T_START_US);
> > +
> > +	local_irq_save(flags);
> > +
> > +	for (int i = 7; i >= 0; i--) {
> > +		if ((value >> i) & 1) {
> > +			gpiod_set_value(ocp8178->gpiod, 0);
> > +			udelay(OCP8178_1W_HIGH_BIT_T_LOW_US);
> > +			gpiod_set_value(ocp8178->gpiod, 1);
> > +			udelay(OCP8178_1W_HIGH_BIT_T_HIGH_US);
> > +		} else {
> > +			gpiod_set_value(ocp8178->gpiod, 0);
> > +			udelay(OCP8178_1W_LOW_BIT_T_LOW_US);
> > +			gpiod_set_value(ocp8178->gpiod, 1);
> > +			udelay(OCP8178_1W_LOW_BIT_T_HIGH_US);
> > +		}
> > +	}
> > +
> > +	gpiod_set_value(ocp8178->gpiod, 0);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	udelay(OCP8178_1W_T_EOS_US);
> > +	gpiod_set_value(ocp8178->gpiod, 1);
> > +}
> 
> Is this function open-coding stuff that already exists in drivers/w1?
> (Just asking because you call that onewire).

The datasheet calls this 1-Wire, but it is a proprietary protocol, not
the 1-Wire protocol from Dallas Semiconductor that is implemented in
drivers/w1.

> > [...]
> > +static int ocp8178_bl_probe(struct platform_device *pdev)
> > +{
> > +	[...]
> > +
> > +	dev_info(dev, "probed, brightness=%u/%u\n", brightness, max_brightness);
> 
> IMHO this is just noise once the code hits mainline. The amount of log
> lines like these during boot is just annoying and makes it hard to
> identify the relevant lines. So if you're confident that your driver
> works, users are probably not interested in that line and you can drop
> it (or degrade to dev_dbg).

I'm confident that when the driver fails to load, a message is logged,
so I'll downgrade it to dev_dbg.

> > +static const struct of_device_id ocp8178_bl_of_match[] = {
> > +	{ .compatible = "ocs,ocp8178" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ocp8178_bl_of_match);
> > +
> > +static struct platform_driver ocp8178_bl_driver = {
> > +	.driver		= {
> > +		.name		= "ocp8178-bl",
> > +		.of_match_table	= ocp8178_bl_of_match,
> > +	},
> > +	.probe		= ocp8178_bl_probe,
> 
> I'm not a fan of aligning the = chars. But opinions differ.

I have no strong opinions on this, so I'll go along with what the
maintainer wants.

Regards,
Wim
