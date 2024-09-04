Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712DF1CF7B1
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Sep 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440449; cv=none; b=Cv/le8K1Rau6/mmK+Hi0wEmwafvT1tMKRHZ2ibviC21PLDKYkQY2LKp5TMUmG02FobbUZwzYpZ10JHCkmKoHbQ8svwxeo6VpCXsWapjYSTRkbMbu7b83x9D5JSq9jN9aOKkwZBvn6dMarpVBCK9fIOp6gxOs0rRt8SxQ8xK3NCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440449; c=relaxed/simple;
	bh=kKpbV7T5jUPtXTxocZYWVKGYgF7sZOsNV8TjbJGjq+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqOFgzznuKjM06LWmv582AIMGSB2e8TrF+znDkbQeXsaQ8swZ2rgHrQpfM4C4juYvTvvDm2IXTdPtNPUG7OpKKB6Lo717obCAOn9VVNHfgnEkeDKhoFphA0U/1Kg+iGL5OCn5xFptVBDWkUko1n5NBdopzOexx+YVEXvivJo2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllsR-0002wJ-AE; Wed, 04 Sep 2024 11:00:35 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllsQ-005PYH-Jb; Wed, 04 Sep 2024 11:00:34 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllsQ-0005LZ-1g;
	Wed, 04 Sep 2024 11:00:34 +0200
Message-ID: <d4d8746a388e9f939e3fac73b5b51044b53c02ee.camel@pengutronix.de>
Subject: Re: [PATCH] gpu: ipu-v3: image-convert: Drop unused single
 conversion request code
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
Date: Wed, 04 Sep 2024 11:00:34 +0200
In-Reply-To: <20240713153524.107019-1-marex@denx.de>
References: <20240713153524.107019-1-marex@denx.de>
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

On Sa, 2024-07-13 at 17:35 +0200, Marek Vasut wrote:
> Neither ipu_image_convert_sync() nor ipu_image_convert() is used or call
> from anywhere. Remove this unused code.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Thank you,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
