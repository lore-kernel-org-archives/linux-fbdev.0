Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451550;
	b=VhOuSyvNx3FKnwmYgLinzHgzZxM+uFpFBXlaA043M3vh3eHet6GsZlewYQw3Jbe4ymg5
	 hUjOCfLMiO+ElXHWBSmG4IRc9LKzx28cA0JHyA2JG4ZbBsPh79Qu13oxYB+CIAMcghFCS
	 yXtQdm7/ZA1NOEY3gtyaIr10uREv1m8W+GCw6Wep5X0hMz9/0p8FfErzmBGHWHMBE4ytt
	 1dEaspyK+9LGhgXEIGRiPxQ7KYpeUQeyZ4zMWrem85EIa+O8IpfTnpw+LsDZBz7WM0vby
	 T+qVxrbhyrbSeTyN3pxSZPoiiZ12atFW9o7gezJhO85pxxQWLKSDHzKeLvAARV0PNpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451550;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=syh5NUCkFSDuNSoqaqc0P58U/D0IjYIPZRRH/6IPrVo=;
	b=DrtbrWuf7GVMlGGfDdfYFZzVWpID1wVRP6ljODiwwtmbivRhLisJuHYwNiUV18h7q6ao
	 IlXxJeq/sBVXKUhw+cMFhYvFzRI2EBIYaBeooWhH5Vx4EqFyj1Zg99TGso3Mc/w6ZlqAy
	 hVLxrTsmY7ThgKmNuz8TcZPdTqoAeFWjKTTkNmlY7yekzEZiifUF2Zf9OMGQFFDK6cUk4
	 4eRixgxNBrJewlnVvt27bIAFMEf5NuiRTkpqy/Jjp9i8qV6SRP6nOtTb/Z6jgAsCfvaAP
	 M+Dlh+Ycq5UHk4XyNSzW6pqoiyBQLqb3YojVErMlN/eOCwGDFQtzqYK1fUeLR4rtpZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLM1k6L2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6C606A31A;
	Mon, 23 Nov 2026 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLM1k6L2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90861F000C6;
	Mon, 23 Nov 2026 16:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795451549;
	bh=syh5NUCkFSDuNSoqaqc0P58U/D0IjYIPZRRH/6IPrVo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=CLM1k6L2JXN72bCmrf2hP4K7BImGUMgSljhky3dH1hK5x3lMsxoyNkZ1JHhGhgfED
	 xcHPy3el2QY4UR4M/HdmFGpmvvaWH899lGS0PcFe4JpIjtCy3fN0QjrQfXvQU5vyLu
	 hViBTSOHYeMAV/8lfwdnfODg78J88nlU3kJF71RGl9VcnOiJ4aF2APBc4tbWsHHJCk
	 pYx3kOyQbMeJ14LpaHdOVY5KSBImK/gtmL9/RQC/S8m5O08/H31KfgLsf1cw0d3H7m
	 jjQoRpHdfFVqEGLwgPAXSrAsb5eFP4fJz4qoMefDx/5hRz+Tye7H51xRX2O3Y/8wnb
	 EM3WSFyo7K+Vw==
Message-ID: <d72ce0d7c68709192afada7ad52409f2@kernel.org>
Date: Mon, 23 Nov 2026 16:32:26 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 19/25] drm/tests: hdmi: Verify scrambler_needed
 computation
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-19-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-19-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:43 +0200, Cristian Ciocaltea wrote:
> Scrambling is only required when the TMDS character rate exceeds 340
> MHz, so the decision must be based on that rate rather than on the mode
> clock.  Add atomic-check tests on an HDMI 2.0 connector, for which the
> core infers scrambler support and a 600 MHz TMDS limit, covering:
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
