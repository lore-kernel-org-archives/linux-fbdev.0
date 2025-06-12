Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777531531E3
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Jun 2025 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763159; cv=none; b=Q47lfAmYhqe4DlOkWGrdAvpTTYUboex90A5JRJHaLPTmb8sYurMIj7syF8XpGV7W8rzoPt+2PX2egvP/Ldo3+jFDmAnHacehowDGU9vYUXUmZqEJbfULw/Z8M1vgRfnJFuYSNQHmmHHRGu6p027zSRLQ/1HGuLf3BcJ7e3m9LAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763159; c=relaxed/simple;
	bh=Nmmceo5/X0XoUUnyS0qvHrX/ADEv/sQjGSHAdNHlcFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsD9RYNg2V8U/yu/84gmI3I9OB6afG9s7hDLoKxtxXB04+NtEaGqBmbQUMXZrDEzdBm0Iqzl9ClYX8InqCQzrrlPmXctrwzPYVziLM21AUYeFnV6wD3ZBH8cCoZ8iheVkidB0VdPKFls0bSqyiPGdD1fBviLP6M0m3HiFVyv6PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Br3fFmgX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Br3fFmgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749763153; x=1750367953; i=deller@gmx.de;
	bh=r44+RAC0PbOCiKZ0u1Ilbvh1iOInyWXtgHvlm1xgwUM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Br3fFmgXjhDvTC3wh5gt6tY0GeVKKyItdpiT+MtKpAhmoKVdhCVdVk+aRmh4TzHO
	 E1wTv57pNprA03/kCNScHoudPVnFcZ6NfWEykrO/km/JoihzSj5XNRPolRvnqZwQT
	 PYvWOarJooiFy/RjitzPkfoNMC/ZZlJ7luUSCYG08Xk2PQrNJwUggGZMCo3dVoS8l
	 Zvcl03y+09J90/CRdMM6oUbtHwidZRdzDQ7hrci4SiBb+LGf1BK+CGIf9Iak+sQXQ
	 92DtBt0CB/UeIQeW1DpLXGsT4yP6T65GUlWNkcHZ8L78ziAcWZ4Em29hfAA3o2RQE
	 mD057aeXk4N19Vo38g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1usHRh2w8n-00wBLi; Thu, 12
 Jun 2025 23:19:12 +0200
Message-ID: <0efe9043-dc11-448c-a25c-a1dc2def9a1a@gmx.de>
Date: Thu, 12 Jun 2025 23:19:11 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] fbdev/cyber2000fb: Unexport symbols
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20250612081738.197826-1-tzimmermann@suse.de>
 <20250612081738.197826-5-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250612081738.197826-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yawz4FWwUmJ65fPTPXCkWDffmER/vjVG01/0wFjwvNE/gG8OlMW
 HjNYPT5jITrmNVuYg5qVD2gNQeS/TEZTCY/B+Knntm0XyYAp3uspZ+X+mDpfVNQj9DMxsm8
 70bt0ba7cYfRs1K5SFMr5s5msHqbx5jc3qaDQYGJlZLjoI1Y8H+Sf5K3Ny1lgvvAcasl8S+
 ikHuBHJvvtbgc4y4W9ntQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q+brD2B8kZg=;wf/79FWE5CNGHQSSIbFtpcFVngV
 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
 6S0s=

On 6/12/25 10:16, Thomas Zimmermann wrote:
> Fix the compile-time warning
>=20
>    drivers/video/fbdev/cyber2000fb.c: warning: EXPORT_SYMBOL() is used, =
but #include <linux/export.h> is missing
>=20
> The affected symbols are not used anywhere, so remove the functions
> entirely.
>=20
> v2:
> - remove unused functions (Helge)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/video/fbdev/cyber2000fb.c | 36 -------------------------------
>   drivers/video/fbdev/cyber2000fb.h |  2 --
>   2 files changed, 38 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

