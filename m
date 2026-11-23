Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438729;
	b=aZPgKgBdZvr6KfGnc/Yg3z+E64aFNsvO0pfxeqxra/uMtzbzRv3j++HAjfJzXC3JTkN7
	 KqHaXP5nA1Xhj/Ar1hAGqTUhfQLYl74UGTs6DrhPqWBHEEcmlFsvwBRrA1unaTHzzjD4e
	 OAfxlkBTawbUYcXTXZbkmm/slnZjzR7OAQDN7qIQbQVFVuxrB2lhk6LAV8dHfHTkPIif/
	 f0LwFZuBTXSl4DBbQ8v6TB2wLCegvUVbhPHMDuPMWWSuSv+ooU3DH7NJ6ZkKA2aKKP8Sh
	 xZx5SPohDYCZqOWrkL/8ZgNS+6uqquWdkRQVqxs7ACzNiwv1P06Zl37Io02S7AFWs0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438729;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=/iMdDPOlUrYpb8pfDUfC/X2GGru3CmJD7BQ2/aFt7vo=;
	b=VMP+/CF8JmIpW897eNllYTQ+OuXgSo0S92jfY3FKlJRREwsHXio+HHGKv5Ai0RfNCVTU
	 rY3quM8UZRoqSCdJ0lcbTpw7zMHQ3sUvPUZIuWbRfNuz2bSEKbLGqKjqG49Jz/YRCD76r
	 EMrRT/+cGPj7AMv78hAmsCst5sIO9OXL/l1zfuyh2QsneWghK7MRjsUOFdWwwAVw1qDSf
	 YZcmdOxZXb3QQcfdwGB+ZlKD9dtXszm/QDYcDQKgBts7Pcj59sqbbEaQCKjwqVpCVWUU4
	 EiD+vuA0h1r2wd+Ns0qA0GOMwMMGJVauHnPYetfU7BEBXEhZUJzALHSSjjzggZbtZ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8Fh3daD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FB606A31A;
	Mon, 23 Nov 2026 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8Fh3daD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7681F000C0;
	Mon, 23 Nov 2026 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438729;
	bh=/iMdDPOlUrYpb8pfDUfC/X2GGru3CmJD7BQ2/aFt7vo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=g8Fh3daD3xH+mbm/mrxKESnZNu3kBwJ2o5nRb+HFA7we1T/7H+YEdvL42tRd/YLav
	 YAWkg4Zb10Odzmg1d1hRv3d0ym6GOvra3iFAPMQkMpYB1X2wcBeiy6KXpNczXRF3Tq
	 pRvSLxkYjPjEVlA9dMhEprbZGDEU1Y2JqMOVx67JrgwlsPG2Gg4G9ylnjhV5LRUXwv
	 aMKQvMIKBK1CxR58eT6uRB9sARJn0Jq5sO7gYYLk2BB86r2Iv7eDzt0vIyxrCar8qm
	 WICwTayWsG7YpMqKWwX8Db/paUAu/YhXjdSSzagWk8MLm2qQf6ac3SO4A4FEa6alXG
	 S+pWvq8+AJP3w==
Message-ID: <28fb51fd6287f4b2faf996b696724c7e@kernel.org>
Date: Mon, 23 Nov 2026 12:58:46 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 06/25] drm/tests: hdmi: Convert to
 drmm_connector_hdmi_init()
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-6-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-6-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:30 +0200, Cristian Ciocaltea wrote:
> Switch tests over to the new drmm_connector_hdmi_init() signature, where
> the vendor, product, supported_formats and max_bpc values previously
> passed as arguments are now provided through struct
> drm_connector_hdmi_funcs.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
