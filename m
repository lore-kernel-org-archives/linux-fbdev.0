Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.240.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769840;
	b=FJjQ6ZL7fnYyc+lUpnw/bNzXp+Wnnfgbz56HTJ4gn27m5gBNF5ONyr5GaFal6aqRySSk
	 19ROmMTQNoDhxp9PzSvEZnAKkWSEnZWpPvTYSNtiVvvCHJCUUFdrH6WAAQ14xXq6Fy4RT
	 zAPtGrjpb7XZoIgpwUpU87gd271zpLuRFxnpHRu+hVLhTxlHKjzyZq6HIujnJjZH4AOlt
	 bswTnswglOF/vPFbp+ehfz/wpYLGXvjeW0BXaeKWk6njjXjHwKybYzJu+n7dzfmXu9nWP
	 VUBWG6p0OpPz0t/X5nPRPJGjE15Fn1Jt9xMWcTZHjz+2ttPNoV8xmDyxjIk9mpnnjQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769840;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LtF+ZicJDI4fmgfCu+Ij9MY3N9bkIMYd5p+PyPTG2Fk=;
	b=OICFJPv7QlRQpQ4/qMt4jDo4zx4d2kCKO5j+eW5tNFvAMzpDRkzx7f0hg4x71NZxNO2w
	 UrXy++jrgtzFokAaUq8UOXbFrskNIO0UrACBqhYDsLACSrBfZMEvHqutrDazfHy2NBncA
	 75Hzp7wDKkCJEp/5fAC03yvUCH8yefS6zEmyvKknc8ZpvbENrvs9Df3eURglSFAHqVccK
	 ZV2GN5/VvW+Df6jeblwLy+/BCBmSv0fRtdKKKv5N8TJCAXHzqorq5j0yH0gQWDxffRjuj
	 ZjTt5y3qFOAYiOqqnCIvQHHqEe0jeb2h/dlmKbo6JEzLjVpflKFqlwPEm2MfZrQjI2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sraa.de;
	spf=pass smtp.mailfrom=sraa.de;
	arc=none smtp.remote-ip=85.214.240.192
Received: from sraa.de (sraa.de [85.214.240.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF3606A32C;
	Sun, 15 Nov 2026 19:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DF3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sraa.de
Received: from [161.142.148.162] (helo=ryzen)
	by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <basti@sraa.de>)
	id 1xSfcX-00FyWm-7L; Sun, 15 Nov 2026 20:10:33 +0100
Date: Mon, 16 Nov 2026 03:10:26 +0800
From: Sebastian Raase <basti@sraa.de>
To: Hans de Goede <hansg@kernel.org>
Cc: Sebastian Raase <linux@sraa.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH 0/2] Add monochrome framebuffer support to
 simple-framebuffer
Message-ID: <20261116031026.2afde847@ryzen>
In-Reply-To: <ae6f7b88-ea9a-49f7-a3ad-ba90185528c2@kernel.org>
References: <cover.1793758480.git.linux@sraa.de>
	<ae6f7b88-ea9a-49f7-a3ad-ba90185528c2@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Hans,

On Wed, 11 Nov 2026 12:15:36 +0100
Hans de Goede <hansg@kernel.org> wrote:

> Hi Sebastian,
> 
> On 4-Nov-26 03:34, Sebastian Raase wrote:
> > This patch series adds support for monochrome framebuffers (1 bpp,
> > packed-pixel) to simple-framebuffer.
> > 
> > Monochrome framebuffers require far less video memory and bandwidth
> > than 16bpp or 32bpp framebuffers, making them useful for small
> > devices or FPGA implementations.  
> 
> Thank you for your patch-series and I see that Helge has just
> applied this to the fbdev tree.

This may need a revision because of the DT bindings discussion. I agree
with Thomas that 'mono' was not a particularly good choice of name.

> Have you considered also extending the simpledrm driver to also
> support these monochrome formats there ?

I have, but my target environment does not support simpledrm (DRM
doesn't work with CONFIG_NOMMU), so I could not test it.

It's a very basic Busybox-based system, not a full distribution.

> Most Linux distributions now a days have switched from using simplefb
> to using simpledrm.
> 
> But I must admit I've no idea how well the drm subsys / kernel-mode-
> setting API handles monochrome formats.
> 
> Regards,
> 
> Hans

Best Regards,
Sebastian
