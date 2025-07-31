Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86F20B22
	for <linux-fbdev@vger.kernel.org>; Thu, 31 Jul 2025 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995382; cv=none; b=SXTh4LwUA4BAlT6N0QUY+cmoGe6rhmy5xIqlRiRkwBRMNc5T0WnTRSAt2AHlc22yt9KOuHPeJuGesn2mjaj0YlnDjWroDy+BOguwK2ry68n7sKcsr5XmcAwUMD6inekbbx4tBtQAr/GRFd3HAQGuicEMzgvp9uzU7PGhc56C9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995382; c=relaxed/simple;
	bh=TqZfssJJK1BeCNN3PvMzUT7G2rS+yrFFtOWpFRPNVZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PXXlNG63bxZS4Cx9g4sIJs6M3gbMB5J4ujB3VrAIoTYv+WKw0M325vAOy69eB8FAwiSSaGuQquPZ7ZPbt16EEebeWOC6rN26pgwa+anRTys0Vdt5fqWbIUo4wM11DyoOUQB/yY3ho9hkyWILJz4JG2SmbhO78LI3M9H9F2u7as0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=F3JTJ97O; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="F3JTJ97O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753995374; x=1754600174; i=deller@gmx.de;
	bh=vSwZW+jOSd45ZRztGnUCkcbLFfml31qJSidQ+ajywnM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=F3JTJ97ONsmZVyLQ5vw+4vsNotfDLkR5B1y8IY0LrnFAM292seMj3cEHQo+P22eV
	 kHNAL6dLFCVZ75aScYJJRkQYAttm/Jgmjw5SPRmjACeLyAVVvI9EPY/Kzxof57mq6
	 A3n7DGm36aBUUWRzSNjREqSUMhrlJCdscDv0T/aoUg3QfqUH84w+ikOfD7uNt1b3a
	 dSV2ADc3ceQ1CuBwj+0UgA/OASY13vljc4WxhQ9GWyDACr4uNI5JIN196ymR1Yg02
	 pnLGvCdbHLwd2I+kO0VvvkI2o8TsvK8Pcn1eEZglRi563umE5SKLYQO2wXHdJywOP
	 ezjJDTbzpUePcbUhNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.22]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1u9bPx0FUR-00bzp5; Thu, 31
 Jul 2025 22:56:14 +0200
Message-ID: <59be2951-79a2-45c4-b59d-6b7fc500b4cc@gmx.de>
Date: Thu, 31 Jul 2025 22:56:11 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: core: Add checks for vc_resize failures
To: Zsolt Kajtar <soci@c64.rulez.org>, linux-fbdev@vger.kernel.org
References: <20250731171552.33585-1-soci@c64.rulez.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250731171552.33585-1-soci@c64.rulez.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BNLrWAb4K95VgrWJa9k3umIYijHCSt4ulql6+37nNkNkg76CwHM
 kYofMvux8J/H9g+DBSsEOayNEGD6bumJC89a3nbZkewe11uj/gXdz6MG63vRNfJ1qbEcA0r
 g6RCuAGM2my+jhhvV7CmhL4/sEcBRczUn3F8TADYaRDXdbj1HPKXJLz2gJ4R+Zm0/g4skV6
 WAICzFGh7vVHiK+CJDm2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UEhcX4pQnGM=;21qc2ALF8Yx28XePanj/7MUvrj5
 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

Hello Zsolt,

On 7/31/25 19:15, Zsolt Kajtar wrote:
> Whenever fbcon resizes the framebuffer the virtual console size is set
> to match the new geometry. This ensures that the content won't end up
> off-screen.
>=20
> But in very rare cases vc_resize() can fail. If one follows the syzbot
> monthly reports then this isn't all that rare because allocation
> fault injection can do that reliably. Usually the one in
> fbcon_set_disp.

Can you point to one such example?

> Handling these failures gracefully and rolling back the resize isn't
> trivial effort, at least for me. So the next best thing is to add
> BUG_ON() checks.

I understand that BUG_ON() seems handy, but it is not acceptable.
Having BUG_ON() makes it possible to trigger a complete kernel crash,
which we really need to avoid.

Helge
 =20
> In theory these checks shouldn't trigger normally. But when they do
> memory corruption is prevented.
>=20
> One check was left out in fbcon_startup.c, that's not a mistake. It
> needs more investigation as it triggers on boot for me.
>=20
> Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
> ---
>   drivers/video/fbdev/core/fbcon.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c
> index 2df480376..b9b65ae32 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1144,7 +1144,7 @@ static void fbcon_init(struct vc_data *vc, bool in=
it)
>   		vc->vc_cols =3D new_cols;
>   		vc->vc_rows =3D new_rows;
>   	} else
> -		vc_resize(vc, new_cols, new_rows);
> +		BUG_ON(vc_resize(vc, new_cols, new_rows));
>  =20
>   	if (logo)
>   		fbcon_prepare_logo(vc, info, cols, rows, new_cols, new_rows);
> @@ -1412,7 +1412,7 @@ static void fbcon_set_disp(struct fb_info *info, s=
truct fb_var_screeninfo *var,
>   	rows =3D FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
>   	cols /=3D vc->vc_font.width;
>   	rows /=3D vc->vc_font.height;
> -	vc_resize(vc, cols, rows);
> +	BUG_ON(vc_resize(vc, cols, rows));
>  =20
>   	if (con_is_visible(vc)) {
>   		update_screen(vc);
> @@ -2682,7 +2682,7 @@ static void fbcon_modechanged(struct fb_info *info=
)
>   		rows =3D FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
>   		cols /=3D vc->vc_font.width;
>   		rows /=3D vc->vc_font.height;
> -		vc_resize(vc, cols, rows);
> +		BUG_ON(vc_resize(vc, cols, rows));
>   		updatescrollmode(p, info, vc);
>   		scrollback_max =3D 0;
>   		scrollback_current =3D 0;
> @@ -2725,7 +2725,7 @@ static void fbcon_set_all_vcs(struct fb_info *info=
)
>   		rows =3D FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
>   		cols /=3D vc->vc_font.width;
>   		rows /=3D vc->vc_font.height;
> -		vc_resize(vc, cols, rows);
> +		BUG_ON(vc_resize(vc, cols, rows));
>   	}
>  =20
>   	if (fg !=3D -1)

