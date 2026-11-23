Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451473;
	b=SxlNhuLL1r9otQbBalj/AY7KybuWpDIqf+dxOYi6vzdFw7jq8oOShfLcEVdYUexxrAGO
	 6RGX7meUhnL5pk0yONtbENtA/AoKQOaIe5JCXPUk7PLfZQ0RiryzFf7DJPrw5knY9329K
	 v0ig5cbYkjlDcBXTft/tywGD7caL3b7d+MPxrOBBpCpnzThwYWLQTaOK+G2+tSoLehJNU
	 GfUaMsujFZPUNmtJkxKPyeusPptp864w5dLJJ8gjtAgwWbhN5ZK6tQDkaKK92jPvxxA98
	 ekwRBBISHvFnHHShGwNDmVi7Y6R53TDRA0DJEhHScjCKNQGBVACGR/4cHqdHrFyp1gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451473;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=EeG8CcdNnFyu3Wu0cn0cp3neJz6lxVqBGhcCpy1RbRs=;
	b=AaHAYU0p47kYECNlV9zSPZg2u4q5ZbDLCJwB/qGqfaxV0FfAskv8W54Ep3mfHrqOBZOy
	 V+uxQh+uLtMGNZclGkxbTdWQzivJDFVXyZBISWGL65XPLgpkOxvkkGB6w01CMxTje/Sg/
	 G45nJrPbGfxbk9LPgpApOWXExhJlcnvELYDBSHI6WFVqL/4IUpsZCKWjWGjCZYs7na81D
	 MYptRx/oaJW/c0mqYrCBV77O4Lr1ImoYYOdG5lriY7JM2ym0pQfrsr23dzusmuiiKjTqt
	 F6y5j4ocKu1tXAf8kwqvXqijABQ0HgEJ1ajq11J9xt/wQVBnQ9NrwO3EZ1jE51lxkjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipx3O2ub;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7A606A31A;
	Mon, 23 Nov 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipx3O2ub
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09DE1F000CA;
	Mon, 23 Nov 2026 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795451472;
	bh=EeG8CcdNnFyu3Wu0cn0cp3neJz6lxVqBGhcCpy1RbRs=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=Ipx3O2ubMFBnyq3U4udDS09fhZwEf20oMZi7XmCLTFnDSLh3qbxBx+K2g1gUvxtDs
	 /BYn8A7+eKdeQ6xxF81YIs/buZtWu7aBwo6NgkipkLLsAOm18e7vKyeSapWGXFiXxQ
	 COUzWOYok9qLLnc3rS7EOFVSZ2AoFsLXUGNCYVWy2ICdXvVu2rkTzQBmeCKIJ3XCw+
	 uvw8Zn9iADYLinFFHpvXqiFjWs7SnQdWaraOpXuk9v85ynOBrZe9zDOyZvM4FalSrG
	 zGeA6qMjY9k42huPn3KaiCq0X7Sl0BOkWi6R7oEcMk2LY/AWg+lOKWqHrqdxK17g+C
	 crsE6dNAL6hpw==
Message-ID: <7d849ed180032b1fadef0d400534b44a@kernel.org>
Date: Mon, 23 Nov 2026 16:31:09 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 18/25] drm/tests: hdmi: Cover mode validation against
 connector max_tmds_char_rate
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-18-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-18-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:42 +0200, Cristian Ciocaltea wrote:
> Test the hdmi_clock_valid() logic that rejects modes whose TMDS
> character rate exceeds connector->hdmi.max_tmds_char_rate.
> 
> Exercise both an explicit limit set through drm_connector_hdmi_funcs'
> supported_tmds_char_rate and the limit inferred from supported_hdmi_ver.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
