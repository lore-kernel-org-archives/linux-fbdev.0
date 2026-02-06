Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35880366DA3
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Feb 2026 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374425; cv=none; b=fDOW5YLfkNZe1xKmRkI2GBtv+tbcA3iXidxFIGaLEZGa2hFGtLvIt3qB270ILcYBLr8cjb/JTLUiDg0gnQ5tNZ5Eh9/v5r2GHHp3mQKAEmbxM0MwYYUyHzS2akxFYJ2BhDYrc9gfcam0RLmEtG2x5UWVsLVJvyV+IPhgae+p0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374425; c=relaxed/simple;
	bh=vpwm7F0cqSl8CNuJqiryI6wPvuNp/Ddv36snFDHPST0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YwV13Qxye37ZNz3bYFpVza4292lmM1EFK6LiXJHRaWocgW8Ns7UXn7q2rM1KC/mQ5ZmXByr/D0Ht2Na281lSJrA0AlOOjK67dDJVanCAB2FF0iViim3LELLqiqLrBoedxHQHmci0SRBDbx3QfjY301RlgE7UvIUG8XVzV6GrwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=VX9xOs6H; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="VX9xOs6H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PJ/RvAgq+Gn4oOCdhQnBD7K7f90OfHmkMs7GeGFIXwI=; b=VX9xOs6HGc06qf/4L6q2eBNTOW
	5UVV1OQAV4246hj7g9I15rgLuAdZOjOZp0UBEuMgH/yBtxKBqz2Zxe+M08uh0BdqgDbVg5FA0D+L2
	K0VpgmqX0aJPtP3gRcK76cdTVPMvlsglFotqZa4xLpBUkPNYP0q9gfzxLTowwfqKVUlkz20O9xcZM
	C6ukNOWsdxkbbssUDur0agEaLXKVOkuH73cVUjv5bXtW36Z3xXz9NQD3baqnmUjx76oL7xgPSUNCJ
	A7LquGCGfMVTAipYG8Xc8/hiWPVwMEXzIrFZXIwUsK9ckeB4De+lF4tCDcehsp+7NmwbWxtiQgVgY
	tu93M6WQ==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] fbdev/ffb: fix corrupted video output on FFB1
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
In-Reply-To: <CC6760AE-15B4-45FC-B796-577AAE728ADD@exactco.de>
Date: Fri, 6 Feb 2026 11:40:22 +0100
Cc: linux-fbdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9CBCCD19-9A53-486F-A543-E4098DFD0EA6@exactco.de>
References: <20260205.164958.765506119384437798.rene@exactco.de>
 <685bb544-1976-45ad-a6bd-f298e2b05cb0@gmx.de>
 <CC6760AE-15B4-45FC-B796-577AAE728ADD@exactco.de>
To: Helge Deller <deller@gmx.de>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hello again,

> On 6. Feb 2026, at 11:30, Ren=C3=A9 Rebe <rene@exactco.de> wrote:
>=20
> Hi,
>=20
>> On 6. Feb 2026, at 11:12, Helge Deller <deller@gmx.de> wrote:
>>=20
>> Hello Rene,
>>=20
>> On 2/5/26 16:49, Ren=C3=A9 Rebe wrote:
>>> Fix Sun FFB1 corrupted video out [1] by disabling overlay and
>>> initializing window mode to a known state. The issue never appeared =
on
>>> my FFB2+/vertical nor Elite3D/M6. It could also depend on the PROM
>>> version.
>>> /SUNW,ffb@1e,0: FFB at 000001fc00000000, type 11, DAC pnum[236c] =
rev[10] manuf_rev[4]
>>> X (II) /dev/fb0: Detected FFB1, Z-buffer, Single-buffered.
>>> X (II) /dev/fb0: BT9068 (PAC1) ramdac detected (with normal cursor =
control)
>>> X (II) /dev/fb0: Detected Creator/Creator3D
>>> [1] https://www.instagram.com/p/DUTcSmSjSem/
>>=20
>> The patch itself seems ok.
>> But could you please link to a freely accessible website instead of =
Instagram?
>> I and many others don't have (and don't want) an instagram account, =
so
>> the link is not very useful.
>=20
> Well it is more free than accessing Linux Foundation training material =
;-)
> It was only for illustration purposes if someone wanted to see or =
follow random
> daily  development fun and not that important. Should I resend it w/o =
it?

While I try to influence next gen to get into OpenSource and low level =
programming,
how about Mastodon links?

	https://chaos.social/@ReneRebe/116023241660154102

Do you want to edit the patch or should I send a V2?

	Ren=C3=A9

> Thanks!
> Ren=C3=A9
>=20
>> Helge
>>=20
>>> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>
>>> Cc: stable@kernel.org
>>> ---
>>> Tested on Sun Ultra 2 w/ FFB1 BT9068 (PAC1) ramdac running T2/Linux.
>>> Defines re-used from xf86-video-sunffb.
>>> ---
>>> diff --git a/drivers/video/fbdev/ffb.c b/drivers/video/fbdev/ffb.c
>>> index 34b6abff9493..8d77f102dd82 100644
>>> --- a/drivers/video/fbdev/ffb.c
>>> +++ b/drivers/video/fbdev/ffb.c
>>> @@ -335,6 +335,9 @@ struct ffb_dac {
>>> };
>>>   #define FFB_DAC_UCTRL 0x1001 /* User Control */
>>> +#define FFB_DAC_UCTRL_OVENAB 0x00000008 /* Overlay Enable */
>>> +#define FFB_DAC_UCTRL_WMODE 0x00000030 /* Window Mode */
>>> +#define FFB_DAC_UCTRL_WM_COMB 0x00000000 /* Window Mode =3D =
Combined */
>>> #define FFB_DAC_UCTRL_MANREV 0x00000f00 /* 4-bit Manufacturing =
Revision */
>>> #define FFB_DAC_UCTRL_MANREV_SHIFT 8
>>> #define FFB_DAC_TGEN 0x6000 /* Timing Generator */
>>> @@ -425,7 +428,7 @@ static void ffb_switch_from_graph(struct ffb_par =
*par)
>>> {
>>>  struct ffb_fbc __iomem *fbc =3D par->fbc;
>>>  struct ffb_dac __iomem *dac =3D par->dac;
>>> - unsigned long flags;
>>> + unsigned long flags, uctrl;
>>>    spin_lock_irqsave(&par->lock, flags);
>>>  FFBWait(par);
>>> @@ -442,7 +445,7 @@ static void ffb_switch_from_graph(struct ffb_par =
*par)
>>>  upa_writel(par->bg_cache, &fbc->bg);
>>>  FFBWait(par);
>>> - /* Disable cursor.  */
>>> + /* Disable cursor. */
>>>  upa_writel(FFB_DAC_CUR_CTRL, &dac->type2);
>>>  if (par->flags & FFB_FLAG_INVCURSOR)
>>>  upa_writel(0, &dac->value2);
>>> @@ -450,6 +453,15 @@ static void ffb_switch_from_graph(struct =
ffb_par *par)
>>>  upa_writel((FFB_DAC_CUR_CTRL_P0 |
>>>     FFB_DAC_CUR_CTRL_P1), &dac->value2);
>>> + /* Disable overlay and window modes. */
>>> + upa_writel(FFB_DAC_UCTRL, &dac->type);
>>> + uctrl =3D upa_readl(&dac->value);
>>> + uctrl &=3D ~FFB_DAC_UCTRL_WMODE;
>>> + uctrl |=3D FFB_DAC_UCTRL_WM_COMB;
>>> + uctrl &=3D ~FFB_DAC_UCTRL_OVENAB;
>>> + upa_writel(FFB_DAC_UCTRL, &dac->type);
>>> + upa_writel(uctrl, &dac->value);
>>> +
>>>  spin_unlock_irqrestore(&par->lock, flags);
>>> }
>>>=20
>>=20
>=20
> --=20
> https://exactco.de =E2=80=A2 https://t2linux.com =E2=80=A2 =
https://patreon.com/renerebe
>=20

--=20
https://exactco.de =E2=80=A2 https://t2linux.com =E2=80=A2 =
https://patreon.com/renerebe

