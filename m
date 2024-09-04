Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7A198A2F
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Sep 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440717; cv=none; b=a5Fx/TyaUAKydfnbZNJHOq7mTP/XlGY7ac7XJ6Kg7bb5YVMj7hbnTY/jEEjYM4NHi6yKXuO36UJH2rZtWxCdMzrSpejO0o/M+GlSvmGJIeZRsh5Ig7vlPSutclOhzIqnYZDOwsRtNKlwy+MqYDV5YdNvNUn/y0l+kN81FNodD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440717; c=relaxed/simple;
	bh=9RGuzKvIeYLmaPxh+OH8P69f+WSpAfCh6ohNYrSmNCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cuarst0m6yrDjW+Ix67Do3EdPelGgUUHFwtjlmr5QOdhe9uQAI4vGIdtI94aDb327lNsdsqTGTYdxh4C0q0w9q1GTOOwgxAaRW9An+OLRL4U+hEXRM1pCq7LrpLn5LPjBkNyxgSagptYQHm6vgO8vXtFwIpwTZxJqDQfXtOmTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllwo-0004y2-V0; Wed, 04 Sep 2024 11:05:06 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllwo-005Pbe-FT; Wed, 04 Sep 2024 11:05:06 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllwo-0005fP-1F;
	Wed, 04 Sep 2024 11:05:06 +0200
Message-ID: <95efd6b6491069d04b4bfae6616d9a43ba8467a6.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] gpu: ipu-v3: vdic: Simplify ipu_vdi_setup()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Fabio
 Estevam <festevam@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo
 <shawnguo@kernel.org>,  Steve Longerbeam <slongerbeam@gmail.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev
Date: Wed, 04 Sep 2024 11:05:06 +0200
In-Reply-To: <20240724002044.112544-1-marex@denx.de>
References: <20240724002044.112544-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org

On Mi, 2024-07-24 at 02:19 +0200, Marek Vasut wrote:
> The 'code' parameter only ever selects between YUV 4:2:0 and 4:2:2
> subsampling, turn it into boolean to select exactly that and update
> related code accordingly.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

I'd prefer this to be an enum ipu_chroma_subsampling or similar,
instead of a boolean. Otherwise,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
