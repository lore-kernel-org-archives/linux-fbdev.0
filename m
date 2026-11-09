Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232054;
	b=wWxATE0sw2zGXcEBBESeBChz3xb873qr64nGYbajywwq3X2tnDABdMmWB3XNdQXGHYlm
	 EfEjGj4WEDN97XB7uIxKlUiwx06OB8vRY+dyVzQWyFmklEmJQH4K8Zx62GKPyKamsLdZg
	 dNUEjRt9lWj22noE6FvVGAeiXBqKXiYWVww09Nn2kX90FAofVyMH2+MYAtR3q6CyD4pWq
	 KR+wS0fboqUpsDLLJVJYL26dr380D17E3pJZiovsFl8ynPklY3aCMXnZmYU4wKMJg8IgH
	 PbDmzwdlAnztLfjuUnMmLKx2ehl9a8JwvL8ULIiJ1nmK+5gxiKDXdwVs9tbXePE7Q0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232054;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+5mMH+ae6U1FA4SCfDlLpoRaYWHjV9rRt4QtO/Ofeds=;
	b=mFT7Iy0tnAujxC1wibfPV9CMRpH5brEnPYASPM5uyybv3xRX0HA4+qZ99YaS2cP7uGGl
	 KK7sK/6plVqve5ufAvSJ2rKtPA7xs1BJtod9iH+nSiGJ7a2zrWQUSbJTN50hSUNErhgD0
	 49GwUJfUH6HXOYrKN0LfF2wkrW5l2RV58GwMFsiuCknap5JLiS+1yDw92MZUH2047++c/
	 v5ePNKd+bz1WhWKoMLXzGxvSWkQxl233UZYtVFNH9OF68bTBPys1hAziLXKke+AAdKMJv
	 CQAckUhjcUXtQsaXuFlXMbDsFmcffpzf7g9fSpO6WzsNyOhkXN1DOeSDPp8pCOrWqdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSouJfLI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4C606A325;
	Mon,  9 Nov 2026 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSouJfLI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B223D1F0089F;
	Mon,  9 Nov 2026 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232053;
	bh=+5mMH+ae6U1FA4SCfDlLpoRaYWHjV9rRt4QtO/Ofeds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VSouJfLIpck7CNeRnZ/L/Kkp0YXjbA/9IIuZSaiFuNW9voZYJ1+6nyvOgccdKGIVz
	 HngNZh7yKwRqwl3CE+H0UZUoO9Dcuy43S0iRTf8lwKwUB4XUp+ZYAZqBpcLJdv4X86
	 AOUxxmfe0xmQ209GIw7DO0Zfy/dn3mqxlrIM8ZSGlozCWHLbDvq8lR7nx5wT16t/M3
	 H3tPUPFlJ0FbnmjwcVqi2JCkNsTZYXBhd/EQR/5xl9z4YPU71UmktyBKfGBXwRQn8E
	 adplzbfW/kMWVuz9bBkqTn5tPLGM8f/zi4F6gW0VWenGK+jhf5wXCdVmvuO58E3HCt
	 qf3myaB1SBGkQ==
Date: Mon, 9 Nov 2026 14:47:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	michal.simek@amd.com, deller@gmx.de, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, git@amd.com
Subject: Re: [PATCH 1/2] fbdev: xilinxfb: remove the driver
Message-ID: <20261109-jumping-dolphin-of-refinement-14df24@quoll>
References: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
 <20261106170902.3656809-2-radhey.shyam.pandey@amd.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106170902.3656809-2-radhey.shyam.pandey@amd.com>

On Fri, Nov 06, 2026 at 10:39:01PM +0530, Radhey Shyam Pandey wrote:
> Remove xilinx framebuffer soft IP driver. This IP core relies on Xilinx
> Platform Studio (XPS) and the ISE Design suite, both of which were
> discontinued by Xilinx years ago. Furthermore, modern AMD toolchains
> (Vivado Design Suite and Vitis) provide no support for the legacy PLB
> (Processor Local Bus) architecture used by these cores. As a result,
> no new hardware designs can be built using this IP.
> 
> Nothing in the tree document the driver compatible strings. Given the
> complete obsolescence of the supporting hardware development tools
> and the lack of upstream users, remove the dead driver.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---

You can include here defconfig update.

Best regards,
Krzysztof

