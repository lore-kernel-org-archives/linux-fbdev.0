Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DD53AEF3A;
	Wed, 16 Sep 2026 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552446; cv=none; b=jNVsJKQW4dAk6cR/VE7HYlzRZWKEODXMp8qecswRDE8Rua9/rkbqVxl5xcuHZdrsycrdM3HQOvJ6rWOd0KsDNA/RzgCpXkSYDTEaTmi1hQCB28wBuW+qTiyAOaYt/fQUlUj7Y8gQZpiaaQan86DPPS6xPvtDXkpOrdccuz7goQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552446; c=relaxed/simple;
	bh=gU28K/TBmhCpoW3RpgGeEwSRVwR0d59zct58qf7aOmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hNklmmON2tBZEtQK86R/o+qu2u1heAgGy4uaDGGE0QFcXeVFSMNkNSNY+Yw402Pc/dlxaDMUZzN0CInHij7krziaxxAtOHr/7jRadokoQibvzlewG8+WorRo5YxM2qlg0D52arc2FLKQFGG+Ir/sy5sZIaG7zAuzAveCKW7wrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fINTCHd2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XTBEJa4S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fINTCHd2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XTBEJa4S"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789552436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gU28K/TBmhCpoW3RpgGeEwSRVwR0d59zct58qf7aOmM=;
	b=fINTCHd2rV5qr8hjmNiqsQ4kOatkIK9D9rw4UdLHoz2bQS/o6CllgkB3r7yfaRgZ8h8A/N
	9ZWUJUXswF3y/wEMSvF97Bcyi5ijZpITTAFGs1xKXXZUn6JgFMLlQ4HY6hrY8Ak4c4wJ1R
	HdOMPTC+Fm9QLPckwARGA0qcR6vSsJYONMDfHSOc9mAKt/0ceLsusKTE2zkREdEMfFRZax
	VMAvNojX/ixR/MKY2wJiCqMZPv/zodO4iz8BgAN/6Q4H0UdFxOgNCoeYOGhE8CyFNDoyja
	MGAcIOtkkok0yiGfD4arKl5sEkWhUsHG9KFJwKsp8HRhSCLSOq9a3W1lZ/ht6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789552436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gU28K/TBmhCpoW3RpgGeEwSRVwR0d59zct58qf7aOmM=;
	b=XTBEJa4S1t4j/hKUlrlaaDS2takijVXH7QjcDoSKns0Jg3CN6SgDUy41SQB8W5H5heoKF3
	zNiHzB2t8we1GiAg==
To: Omer PALA <palaomer100@gmail.com>, andy@kernel.org,
 gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
In-Reply-To: <20260916093928.52057-1-palaomer100@gmail.com>
References: <20260916093928.52057-1-palaomer100@gmail.com>
Date: Wed, 16 Sep 2026 11:53:55 +0200
Message-ID: <87ecet5xos.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Omer PALA <palaomer100@gmail.com> writes:
> Replace udelay() calls with usleep_range()
> to avoid busy-waiting and allow the
> scheduler to sleep during delays.
>
> Signed-off-by: Omer PALA <palaomer100@gmail.com>

This change cannot be accepted unless it has been validated with
hardware.

Btw, I am curious why we have these udelay(). Can we remove them?

Nam
