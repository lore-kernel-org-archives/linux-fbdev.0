Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451682;
	b=KtRoPOVzQDYoxR5uCHxGfQQbybTl8TX2kDLKi0EDxG5M5XTms4IRl8mYG2DscuEvzTo5
	 EXgr3kcESoAmanD7Kjb7QuUAEfXwnwDRLVd/9GKWv8KSXfewbtPJiZ0hipKPTabRhUkq8
	 FqWV/cAlYK5+b3s8AEGZDGJ07bQYpuMn/odGdzM34yYqPq9Oe0NcNnJdz8zzUTdQM8vfI
	 sfDsuE32dtX4TiMLp5TCN3YZGFv+h00XdthXo2GFDk87yEXIB8BNrvsRxmDAExWZQ3ynr
	 OIZJr5tZLIIJHvSAKB0pgnFbxfircvQWB6x5AUizCsRxEySVQeQTM9UBhbLnftz1/gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451682;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=k6ik7b3Wu505/fmtIFICmTXA27T4QVBi8Qs06F9TrW0=;
	b=HZJqkgwIksvk3lmTfibOaGbynfKHbHlmDFN2IWAadd9qDLc/XSEHXI3tk9M4Fp+axxXD
	 XPQRXAnpo7ygUy6GjLXBXbyze/MFk1kcTfejovfdTaMwXt0Ld6aQZ9Z8wziedl1kUB8/H
	 oxxYlRyWSR0/vTlqNvWVElc+sV01n0470zBVNA3b6l+UKKILiVrcug2uo9XHTVaZmyVJJ
	 mAPT6S/8NrdEffkJMSB0eSahdm8hVY8Njrw9PV+N6nPWeXxK3i/xbmffKxuJO6Ylk0wID
	 N4tewYpPtjmjXytND8ZIR4ykGfzE6aeP1fG+gTdKb43GBerZLrvPImalg9Gpsa7T/Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHo9XLlW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0FB606A31A;
	Mon, 23 Nov 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHo9XLlW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8641F000D2;
	Mon, 23 Nov 2026 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795451681;
	bh=k6ik7b3Wu505/fmtIFICmTXA27T4QVBi8Qs06F9TrW0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=kHo9XLlWwiCnxwxe2ET0kxB7kuAHZuu7NK5JPOcC/x4YjlQ32Z2jbqi9x8e5sQUs2
	 rFt5cX4ZuOHnUkdkB/o50qM0C5YCph2A6gWU8/78SFW634swZSJWNnC1a4F5dIJ4vK
	 Ovls5WnjdJoxG/hPtukYj368pvB8f0XqsAtRpD+4yVqhzfXbWoHFKZtDE7e+dQQNqT
	 BcZbScqxbesWQ51b5F6i9pINDNNNReBZEtitgZY/9c2o1QfDj32DkqrisUSQ8H3SoU
	 c8AuWHCpthDbSJbMa93LaeJzHgz5FBGPqIMO84p9shf/zE8T8op3KDK8OPutEXVljY
	 cm1d3+Q5cB1bQ==
Message-ID: <e1f51916a704096cf8e26711d4e7c793@kernel.org>
Date: Mon, 23 Nov 2026 16:34:39 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 20/25] drm/tests: hdmi: Add SPD InfoFrame vendor/product
 coverage
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-20-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-20-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Hans Verkuil" <hverkuil@kernel.org>, "Helge
 Deller" <deller@gmx.de>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Maxime
 Ripard" <mripard@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thierry
 Reding" <treding@nvidia.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list

On Sat, 14 Nov 2026 20:03:44 +0200, Cristian Ciocaltea wrote:
> The vendor and product strings provided through struct
> drm_connector_hdmi_funcs end up in the SPD InfoFrame, whose fields are
> defined by the HDMI specification as fixed-size: 8 bytes for the vendor
> name and 16 bytes for the product description, padded with zeros and
> left without any trailing NUL when a name spans the whole field.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
