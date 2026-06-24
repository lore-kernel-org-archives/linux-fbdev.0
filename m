Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFE2F1FE3;
	Wed, 24 Jun 2026 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295255; cv=none; b=mTADapob37RLe5A7A0vtGFeBO/N+ZIdni1jXc2+SjxynZ59ae+FcUCd1KprW0lzE89jo30qz0ohaqgeVn8XP5B/vXelXtQHQ+o9AgtNCNG99/sP9hKEKdKXNIGCVCbrk6Q6OF3WqIDCWhR4FPFFnlmLYcDrmBDckJP6nILLmilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295255; c=relaxed/simple;
	bh=pIvYjWqlDZLqoStvcTjkJE5Gx1FLDsejyO0rZEZzs2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzJBDOKNPnFuknz6RGYWyw3doCjeEFr7QqWzboSb0nLGxUIQ0mOl4tkcnQAZ6h5fiL7HJt6jrHfqssDmoNJgNlo+mc5DDWtLWtloOzD9CFcSjuWc+0ZgniKxpcmc1qqgWvbB2ReLtASR1MU3UziKQACy6bN74wcT0mIgFr2zBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK5M5mGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK5M5mGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B891F000E9;
	Wed, 24 Jun 2026 10:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782295254;
	bh=pIvYjWqlDZLqoStvcTjkJE5Gx1FLDsejyO0rZEZzs2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bK5M5mGIONepHqqYf+OkaQrAneGgb0D5nPQ+60445jLOU7o2+QLr4NbyTuWjTMo8w
	 ecFydHHW8T2y3I7YRJ0KKpHRL3k473g4lyt0y5sUl/TjJLKIShZX7/IjWAqFrDXqJB
	 vWkZK7SedgwhP0SBdv+KvgtR28Eqsh2g87NsN3U2nE/dzoat6jADkR4HOUlV+6cm6h
	 0e9M10Gg+og+/5sblWAJePWkcx1cxOoI0xmTHa4xMms3lrRHDXaS+bhGIfgqcVd0fX
	 zWeGKe+d9DUP4mIocsbUVSWUZ9t1qK0SckJ06wIRUCNzv6OZK4tuRZiRoJxheaMhNb
	 R6qVc4j20Z7mQ==
Date: Wed, 24 Jun 2026 11:00:48 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>
Subject: Re: [PATCH v5 2/2] backlight: Add SY7758 6-channel High Efficiency
 LED Driver support
Message-ID: <ajuq0IsFT1UV2pAi@aspen.lan>
References: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
 <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-2-03aacd49747c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-2-03aacd49747c@linaro.org>

On Fri, May 29, 2026 at 09:23:09PM +0200, Neil Armstrong wrote:
> From: KancyJoe <kancy2333@outlook.com>
>
> Implement support for the Silergy SY7758 6-channel High Efficiency LED
> Driver used for backlight brightness control in the Ayaneo Pocket S2
> dual-DSI panel.
>
> Signed-off-by: KancyJoe <kancy2333@outlook.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
