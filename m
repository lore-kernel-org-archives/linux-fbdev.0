Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C460375AB1;
	Sat,  8 Aug 2026 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786157989; cv=none; b=t/m3AHENMFkgq49nmADRPVBNAhq/e5cpGvWnxWN8fiFu8pCx45v2TjhpYvEzQTe+3Jvp+gQlcZCDGYHBUXVgIcN2jtYWh3/zP8ozh/zqucMGe2nphGypZ3Nd2u8lRKzh10Zx0sBG2a7t1xmK8zdoKGXSk//UvYKrnH/LkFgqi4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786157989; c=relaxed/simple;
	bh=lhwuIE0zT+IiBqvhQLOpEcS/lGGVH+Bj5PmvGL4nLO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8gVRWfki1+Q2lHZPOCEZQndiV6qXSVIlWPiqu4+Vk4xLEw+ClR6NRjVnD0rB6US3pWFAnRKKdsfLp49T8m36HXA4pO+1Azr5wGlzz6ds3687iS2DO5MXeg4YPu/FrPiRr7x/U3jitbovfxIy5Fj3TmS0FTxFZ11S4HpL23OXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3esOBYK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dMXx51JW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3esOBYK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMXx51JW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786157983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhwuIE0zT+IiBqvhQLOpEcS/lGGVH+Bj5PmvGL4nLO8=;
	b=U3esOBYK6yJpD5fVQ/b+bHyU1wrzT97Zsn8KM5ECQqi5u41JHnWHBYdUCNKce65jOpwo31
	SMvLNWRaln34LYsnJtGt02jhob8rjDRDGP1FNUjZ2YxsTceitrkr0yu0II17kUSwkrgSHa
	MB4JNbGhzJaLYKCGHimij/VPOWS135w8VWU4UKrIDW/4MPjOovA/x1Zak7HhaLbWjq8x3p
	EO2EaqBUZeWeYGbu3SpxaHLAwfaMBCwEc0kncUtuU1saLZ5fpzuOH1Bwy1Zp8b00ChhP9Z
	F0/CJPFt975vs9bpdfpC+vwN02N4yOKqjYy2kdbLyHfUr/sBUDRiU/p79IBdww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786157984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhwuIE0zT+IiBqvhQLOpEcS/lGGVH+Bj5PmvGL4nLO8=;
	b=dMXx51JWLovgzeDso0jw9r6M6/EuXb3sDkUB36Q+UCoQ6+yoVlt3/ogqaZ6ORyt999AQXi
	60R462v3r+rVoEDg==
To: Hui Su <sh_def@163.com>, andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, sh_def@163.com,
 thomas.petazzoni@free-electrons.com, notro@tronnes.org
Subject: Re: [PATCH v2] staging: fbtft: make dirty_lock IRQ-safe
In-Reply-To: <20260807150953.2811933-3-sh_def@163.com>
References: <20260807150953.2811933-3-sh_def@163.com>
Date: Sat, 08 Aug 2026 04:59:42 +0200
Message-ID: <874ih5b9lt.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hui Su <sh_def@163.com> writes:
> fbtft_mkdirty() can be reached from the fbcon rendering path while
> processing printk() in hardirq context. Meanwhile, dirty_lock is also
> taken by fbtft_deferred_io() in workqueue context with local interrupts
> enabled.
...
> Use spin_lock_irqsave() for fbtft_mkdirty() and spin_lock_irq() for
> fbtft_deferred_io(). They only access the dirty line range, so the
> IRQ-off regions remain short.
>
> Fixes: c296d5f9957c ("staging: fbtft: core support")
> Signed-off-by: Hui Su <sh_def@163.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
