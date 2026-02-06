Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929434BA56
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Feb 2026 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372731; cv=none; b=na/+j6eHzyu/Q3cczHwz64eI//HoKOHQNzdTdOwYQNStpcYQhGnXWIM5E3KjZRqtFn7WIwmSQd23rdTtpnRcXyQcZXVpn7h9sFllcUa27/WvoG0JDyKhusMOeuEGbp2n2XQiFabCbhzvOcbBLCnAK+cWwNbCvo0gj6Pb4MZ25CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372731; c=relaxed/simple;
	bh=6uX/G4oDZBW6g/QwYZ4CUqm9/Rch7rnc7Sl7cWPOc8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0uKzkpR2TGXy0dwLoTo5ZvJQjECcd1MUDz1S3obvTB3svqRMEJfTYIEyxnU1ALUPiI5q4OmRP92yhhjSxoTz2xr8RSQjK7bRNp+Fj7qEqMRLxbKHBjXH0C2pK2ozc2YC0aC+SOa+Ao6SP31nHMxsWh7BUqshKNkoLJK3hgqdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=dH+dE0OK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="dH+dE0OK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770372728; x=1770977528; i=deller@gmx.de;
	bh=RN06U4vBvQ/K09XRg0lfiGdJbceTfi/V5TjgwIL2OMY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dH+dE0OK5N4pQxUPAPgrlzkYiCmxDMr/QmojotwvCmOjoxt1DrCnMIZQvDf/4a+H
	 qfOV68lLk7BzhragpsMdV0qlsYTI129hE9iEyADPzLnMcP2SbcefBrSl1XBm2fz7j
	 gyMv4oFx7FZNhYdtXVfX2W7aBa1OSaq8FfjK4HxJzORp3SV29mN9bmUMDeOHHrMsG
	 SmYmA6ufoUYhCEUCObhUPTORhXBrUUfgWPRQ6xTRaZijKWWKiyu5mqd9ds93xiALZ
	 /GWt9Mthdnd5Uf3FnAufSTjbGcVrOG179y/gMKdTS3vO39mNlpaffQNYQzZheP4Pu
	 3im84UtwrAdHh6cCuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.105]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1vJtkI0fvW-00i9ya; Fri, 06
 Feb 2026 11:12:08 +0100
Message-ID: <685bb544-1976-45ad-a6bd-f298e2b05cb0@gmx.de>
Date: Fri, 6 Feb 2026 11:12:07 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/ffb: fix corrupted video output on FFB1
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: linux-fbdev@vger.kernel.org
References: <20260205.164958.765506119384437798.rene@exactco.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260205.164958.765506119384437798.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1bYXTg7Kiw5IjHPH27AF6rivzh75CYru8cYXT0Sd/CTyt2n8Poz
 Aomke6lwEq3S+1H+XAkYw1t7jPazeBsixr/QdLLYvk9fWjsfwzeHNLD2d9kfgx2WGs7Y9Lo
 ZbT4t+SgpoxtXSo1E/Bjv97i6b/iXtaZX57NZhpgGC/S6XsrX9lZKQsHCvC259IZ6SyE9tY
 OUclIxS9cJHmyqzj40itg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OjXnF5AHQLk=;f/izV5lXnmoeLSfUAmR39PL+ZNg
 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

Hello Rene,

On 2/5/26 16:49, Ren=C3=A9 Rebe wrote:
> Fix Sun FFB1 corrupted video out [1] by disabling overlay and
> initializing window mode to a known state. The issue never appeared on
> my FFB2+/vertical nor Elite3D/M6. It could also depend on the PROM
> version.
>=20
> /SUNW,ffb@1e,0: FFB at 000001fc00000000, type 11, DAC pnum[236c] rev[10]=
 manuf_rev[4]
> X (II) /dev/fb0: Detected FFB1, Z-buffer, Single-buffered.
> X (II) /dev/fb0: BT9068 (PAC1) ramdac detected (with normal cursor contr=
ol)
> X (II) /dev/fb0: Detected Creator/Creator3D
>=20
> [1] https://www.instagram.com/p/DUTcSmSjSem/

The patch itself seems ok.
But could you please link to a freely accessible website instead of Instag=
ram?
I and many others don't have (and don't want) an instagram account, so
the link is not very useful.

Helge
 =20
> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>
> Cc: stable@kernel.org
> ---
> Tested on Sun Ultra 2 w/ FFB1 BT9068 (PAC1) ramdac running T2/Linux.
> Defines re-used from xf86-video-sunffb.
> ---
> diff --git a/drivers/video/fbdev/ffb.c b/drivers/video/fbdev/ffb.c
> index 34b6abff9493..8d77f102dd82 100644
> --- a/drivers/video/fbdev/ffb.c
> +++ b/drivers/video/fbdev/ffb.c
> @@ -335,6 +335,9 @@ struct ffb_dac {
>   };
>  =20
>   #define FFB_DAC_UCTRL		0x1001 /* User Control */
> +#define FFB_DAC_UCTRL_OVENAB	0x00000008 /* Overlay Enable */
> +#define FFB_DAC_UCTRL_WMODE	0x00000030 /* Window Mode */
> +#define FFB_DAC_UCTRL_WM_COMB	0x00000000 /* Window Mode =3D Combined */
>   #define FFB_DAC_UCTRL_MANREV	0x00000f00 /* 4-bit Manufacturing Revisio=
n */
>   #define FFB_DAC_UCTRL_MANREV_SHIFT 8
>   #define FFB_DAC_TGEN		0x6000 /* Timing Generator */
> @@ -425,7 +428,7 @@ static void ffb_switch_from_graph(struct ffb_par *pa=
r)
>   {
>   	struct ffb_fbc __iomem *fbc =3D par->fbc;
>   	struct ffb_dac __iomem *dac =3D par->dac;
> -	unsigned long flags;
> +	unsigned long flags, uctrl;
>  =20
>   	spin_lock_irqsave(&par->lock, flags);
>   	FFBWait(par);
> @@ -442,7 +445,7 @@ static void ffb_switch_from_graph(struct ffb_par *pa=
r)
>   	upa_writel(par->bg_cache, &fbc->bg);
>   	FFBWait(par);
>  =20
> -	/* Disable cursor.  */
> +	/* Disable cursor. */
>   	upa_writel(FFB_DAC_CUR_CTRL, &dac->type2);
>   	if (par->flags & FFB_FLAG_INVCURSOR)
>   		upa_writel(0, &dac->value2);
> @@ -450,6 +453,15 @@ static void ffb_switch_from_graph(struct ffb_par *p=
ar)
>   		upa_writel((FFB_DAC_CUR_CTRL_P0 |
>   			    FFB_DAC_CUR_CTRL_P1), &dac->value2);
>  =20
> +	/* Disable overlay and window modes. */
> +	upa_writel(FFB_DAC_UCTRL, &dac->type);
> +	uctrl =3D upa_readl(&dac->value);
> +	uctrl &=3D ~FFB_DAC_UCTRL_WMODE;
> +	uctrl |=3D FFB_DAC_UCTRL_WM_COMB;
> +	uctrl &=3D ~FFB_DAC_UCTRL_OVENAB;
> +	upa_writel(FFB_DAC_UCTRL, &dac->type);
> +	upa_writel(uctrl, &dac->value);
> +
>   	spin_unlock_irqrestore(&par->lock, flags);
>   }
>  =20
>=20

