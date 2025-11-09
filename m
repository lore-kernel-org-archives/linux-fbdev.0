Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3202F2FF147;
	Sun,  9 Nov 2025 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708125; cv=none; b=CGRD8YWDfssZup8bcYJulqLH/LXBdJ8KQraDi9qFn9pmursJbmsa316yv/iGWOjbr1Y4+5BSblWoGo6zMRdEkdSt9KwsNTqgWpjxav50WYbNeiW3wx284sxPTWmdxZXdHC06WUEvvRbI4cy2Nr/4mU8UjaLC59rgUbv8GqLGSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708125; c=relaxed/simple;
	bh=ET1zFUZTZRnzMVHdUq9/iGHDQDRbTzMHvG3AIriBGSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN+xG58aRJS7Ukz6zTqI9FiQPQXqrO6X0zTPniciKseDal6Le+b6lGRqsCaeqFD0AQMYDmwNFh6iQXua24TIpK8KZOQRFhXa2WTMTyXh8ioiHRjA6PGiSxAwP73w4o7MSXC+FD5kSkeK1pGBZeMKVqmxs/pK7RBFMuv+fZag4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk8IVwQh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk8IVwQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D15C116B1;
	Sun,  9 Nov 2025 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762708124;
	bh=ET1zFUZTZRnzMVHdUq9/iGHDQDRbTzMHvG3AIriBGSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uk8IVwQh0VOPTSgkhsyAP5awGCF7kD/7XLwTBhztlDI9xfMCkrbomuammpNj/p6j+
	 VfrdLjqdb7/12MJZTe1VimPRdieQWsTAKhtpvCexwmMeEI45iV9koopEAs34CKn23h
	 TKW4eT7ycao3l8mqbOUtTkgdtHKHzmKZFW/i/EXuwLthKDEC3fhsJsEh/hUbQ6EGuQ
	 em7oHrSIjMMStOPtDz/nYXdSCnrCvziFb+kHgde3htv/Hj9gQ9l85I1EO2jRy1wpom
	 W0Js1ZlsSdzfWOZzPEJxTvBz+t/k34hd96dZd8S8UBThehLlz/Ixjb0dhwISY+tcPF
	 3IxUxSnYjCxnQ==
Date: Sun, 9 Nov 2025 18:08:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junjie Cao <caojunjie650@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: Add Awinic AW99706
 backlight
Message-ID: <20251109-righteous-dove-from-saturn-9b9bb3@kuoka>
References: <20251109032240.3422503-1-caojunjie650@gmail.com>
 <20251109032240.3422503-2-caojunjie650@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251109032240.3422503-2-caojunjie650@gmail.com>

On Sun, Nov 09, 2025 at 11:22:39AM +0800, Junjie Cao wrote:
> Add Awinic AW99706 backlight binding documentation.
> 
> Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
> ---
> Changes in v3:
> - breaking a long line (Krzysztof)
> - rename backlight node (Krzysztof)
> - Link to v2: https://lore.kernel.org/linux-leds/20251103110648.878325-2-caojunjie650@gmail.com

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

