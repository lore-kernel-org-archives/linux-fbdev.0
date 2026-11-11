Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395742;
	b=qSePmpG+/jIJ9KwdnaVv6kyolZEdxbK6bSM4nGR9hq+/WPzIQ9vGP/U/DFzpyv8esbpj
	 iHjDYYYf4B3ZbajieSRS0z4jgDLSiBQ9g4gQQdT3aXm0iPtn2yQ3AEjrl1d5GOaStaUgv
	 Pjt+dZ5ST/IgGYYbBzxED3WyZPkdlPBfhJ/oM8JANJZtIOYTEx2r8vviBf4yXoEBWSZfk
	 9QwHqyb0UsL0IzA3G1kM/vUXqEpHDZW03dLauDmYUe+TiHaUpeSa0hAq2Hh3WQudpe9A9
	 vr4guDr6BBR2TuSWr4rNE+0BCT5tK1ngUh2qCOXDAZF+ZercxwEYbzS6QHKyN/rsedw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395742;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6Digdi0J69cdmnfNAOroK/JVKXGvxIlZsj5otBtYtXY=;
	b=hp0fZYNc9Rj5HimAJQMwK9sP3+Ek9LpMjTvhux/kAfdqw97Nx0+AN6N4PEtjdtfhMWC8
	 ZxvHmcUBctxaEnGEUDFHZr1K43Q4AeSelM3zk9phRw3lGr44/sHZdWStuYRwM+3+HOUa0
	 qB/vTbCBSMUSBgYwNOvM6ihKgH1sfGc60lPMXiWBCpx35G7wZHe6bwVyqoNJIee0geQ2b
	 f3lGYOS/soQqeZ1IkwR2kLVPQ5WYL9cJilx1LcEA8Uza+IH4kBAioPgrrzsFTm6e9FQ1l
	 68n9pQFfs8FbtibabnUylaJrhvjieI4lb51yUYTZbg9v1duo5Umwe2PLuGRWpRzi90g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIe5oxYF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3CD606A326;
	Wed, 11 Nov 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIe5oxYF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91D21F00A06;
	Wed, 11 Nov 2026 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794395741;
	bh=6Digdi0J69cdmnfNAOroK/JVKXGvxIlZsj5otBtYtXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AIe5oxYF2M19g+llfNnhDDGdQRy3FrvfWXZvepwbD96kg94cj31gHfc/mQkehNC39
	 u1qedVzZq7ryZrxNj86XQJf1e/FOmy5/uZskKNAc3QwrY3aiLTr8mLzAgQ2guvRVpe
	 jGRMILKY0Qp5ShY8tiHwHmLDN0+o7sV5xrHlVdlFogIkeQfsO2668xHmt+yG6pU/fF
	 rti6Eyg4YJ1NbBhKwZwWFow7ZPOsjYjv9MLLFH0A5C66NLj2Or28ANMMmIZprER9ZH
	 u/57iG8h8ael69x1YzsGCp7zOzC1sxC5bH0JYMfbixAXhAnoEM+Q4P/CNadv1GVOJu
	 7ttqE+zpUltEQ==
Message-ID: <ae6f7b88-ea9a-49f7-a3ad-ba90185528c2@kernel.org>
Date: Wed, 11 Nov 2026 12:15:36 +0100
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add monochrome framebuffer support to
 simple-framebuffer
To: Sebastian Raase <linux@sraa.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>
References: <cover.1793758480.git.linux@sraa.de>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <cover.1793758480.git.linux@sraa.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 4-Nov-26 03:34, Sebastian Raase wrote:
> This patch series adds support for monochrome framebuffers (1 bpp, packed-pixel)
> to simple-framebuffer.
> 
> Monochrome framebuffers require far less video memory and bandwidth than
> 16bpp or 32bpp framebuffers, making them useful for small devices or FPGA
> implementations.

Thank you for your patch-series and I see that Helge has just
applied this to the fbdev tree.

Have you considered also extending the simpledrm driver to also
support these monochrome formats there ?

Most Linux distributions now a days have switched from using simplefb
to using simpledrm.

But I must admit I've no idea how well the drm subsys / kernel-mode-
setting API handles monochrome formats.

Regards,

Hans


