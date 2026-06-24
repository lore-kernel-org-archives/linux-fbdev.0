Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAF277007;
	Wed, 24 Jun 2026 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295218; cv=none; b=pKSlkY+jeUCNsplA0jwNiNX6XEJTNpJHX0EksEzi4ideNeYO7Tf5JoYL4znlKdzUEiEhpCndmMGjwim1ti/Yb7scM+Rd31qX9WazhqBu9UKeMfkfDD8NYVHh9V50Lidbfmlnm8qF4h2hWvennArBa+No4hL8au0p8tQ6sJx1Bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295218; c=relaxed/simple;
	bh=g8vUxhLtAa/Un5KLBvlEilLefUMRE/uYyY8Wkg4W/dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqplig3a6Nz4LOa1IhHrjHi/i6I22739GSGXQCVnhJ/j1jGn+ZvcEzJvC3A5FlRKhDOOr0br03f6qJujkyBzLJJlRi5K7J0wuiH2kd250SAins+DZ+imo0/IOrgZ6hGWs2l7OPtStilA5VUUFTW8KCHnBhRKBCSIPC2AM3B1KAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOmqHl99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOmqHl99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BC71F000E9;
	Wed, 24 Jun 2026 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782295217;
	bh=g8vUxhLtAa/Un5KLBvlEilLefUMRE/uYyY8Wkg4W/dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EOmqHl99s2+aMkqdNnUl1Xq2bYK3lWOdSgcXrfPk385jLNBkJbbc7RYfAMt7cJV7e
	 DVxr0Rb5ND03aIG5XpTSLkjJWHu+vve09V8prQNo53YwoIkAK79JjuK0roIUnzFQEU
	 7XKfyAad2Ld7QmPwKBUMsLm7c20g92N+swSUQz9wqh8yvv4lYUVFGM9jI55QyqkMYs
	 kTevBfja7Rr9ahFZAqOip0+UPyJoq4f9fCV8CRQSlDzC/tFgec4uRl7dsNzmYaidjj
	 /8sh87pRm9l4LCuxb07bLhDrbQYCJLZhtbRZrRP2SLIxw3P/mghdP97d5jbrzV/UNi
	 8cnO+P4vH20Ww==
Date: Wed, 24 Jun 2026 11:00:10 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Message-ID: <ajuqqpdf7ubAWdL_@aspen.lan>
References: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
 <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-1-03aacd49747c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-1-03aacd49747c@linaro.org>

On Fri, May 29, 2026 at 09:23:08PM +0200, Neil Armstrong wrote:
> Document the Silergy SY7758 6-channel High Efficiency LED Driver
> used for backlight brightness control.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
