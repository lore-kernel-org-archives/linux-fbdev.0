Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5BA3E49D
	for <linux-fbdev@vger.kernel.org>; Wed, 25 Sep 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282631; cv=none; b=c7UpsDUetNt/ufSBZKrukrYIs4snlmcBqdsToUpSUuxJewuomXAIjDBgZTXSHIvHRD1cNEfI1uoqYQpiRKuOE33arA9i5YsnIfQuqEUTxAhX7Cv44nX/yHdlqkt+avLrHQJhSmZ0Cii8Fpui17gZa4P8PqcInaqB4ZDK2q4tKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282631; c=relaxed/simple;
	bh=tjBd66E1CNlkxerhMBehRMUUuUb71uIioVTaC3bKJnQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRHQ2+jEw5148hnRtKhvJ08Kyr7R/FhTI2DwWM2kEGMFOauvEDLLWujtnZwA471+1ltf6sZ0s84sIwT/kpDLaCf/FghsIxbptIRF2bkuuRjXNKKKv2mWWfKr9JgKgAfq6gQksLF8PONxWdjyDuwjzGgQsPxMlSGXTVo7U3ylfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stV71-0004pf-N8; Wed, 25 Sep 2024 18:43:35 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stV71-001UVL-6C; Wed, 25 Sep 2024 18:43:35 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stV71-000PFR-0K;
	Wed, 25 Sep 2024 18:43:35 +0200
Message-ID: <75edf945c98a68bf85b13efd1c13549288f56488.camel@pengutronix.de>
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
Date: Wed, 25 Sep 2024 18:43:34 +0200
In-Reply-To: <546c9dac-39ab-4abe-a495-ab54d6ee925d@denx.de>
References: <20240724002044.112544-1-marex@denx.de>
	 <95efd6b6491069d04b4bfae6616d9a43ba8467a6.camel@pengutronix.de>
	 <546c9dac-39ab-4abe-a495-ab54d6ee925d@denx.de>
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

On Di, 2024-09-24 at 12:47 +0200, Marek Vasut wrote:
> On 9/4/24 11:05 AM, Philipp Zabel wrote:
> > On Mi, 2024-07-24 at 02:19 +0200, Marek Vasut wrote:
> > > The 'code' parameter only ever selects between YUV 4:2:0 and 4:2:2
> > > subsampling, turn it into boolean to select exactly that and update
> > > related code accordingly.
> > >=20
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> >=20
> > I'd prefer this to be an enum ipu_chroma_subsampling or similar,
> > instead of a boolean. Otherwise,
>=20
> I'm afraid this introduces unnecessary back and forth conversions=20
> between the boolean and either of the two enum ipu_chroma_subsampling=20
> values in the code.

Fair enough. I dislike the opaque usage in vdic_start() a bit, but with
the in422 variable in ipu_mem2mem_vdic_setup_hardware() it is clear
enough.

regards
Philipp
