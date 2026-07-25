Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D332DC792;
	Sat, 25 Jul 2026 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992984; cv=none; b=TW0HGv+A2MPvWqfGv7RGafE5rAIgapaXDRYEbNrVsETQ2m5hImLDc+dPNkK50vAKj5nfpMrcWuFEORRKLKM+oR5s7cKwl6bZUH+sfuSwz7tIOU+vK+/Jxq5zkFV4wMc62LnQMzVW5+g/4WuR7jLfToTPloQk6tyB5KUD4nPr6YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992984; c=relaxed/simple;
	bh=YoelJNrP+Mde0i0cibM7fUveuOaw3PukiIWw8emfPYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tO7u7mBMXA4Uw63LIKDxtS04g8Ft0hxsH7J/ij1WBRk/KDz1O299XJ+Ljd4oOQAEL+E5Cqd6MfMDIwn9Q7kMzoDTIOV8DXJ8K6mThxc9I3iZ3sMA0+jQy6Hx++cgwBxK76z0rFwCgBZPiNNa1OsGHVxZD/limofe4pAF8m2IeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=c4AxulWZ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="c4AxulWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784992974; x=1785597774; i=deller@gmx.de;
	bh=nm5c9KaZI4T4miOFbJjx4jRS93oQhLm8+T32grubGbs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c4AxulWZahH9n88qIYqlIs6r857FZg3UzzQSWNHDtEgphW6AN+pGC5CD6+pDm9LN
	 PDeDlcx/KzmYrsFghn15sgq72XQqBjJluK3gIOTnM2hhWnoI6NIdMzty+v12cxdvQ
	 GlZM7hcfWMou/M/PicTjQchc7J7tyVRxBIbaKbzUITSZgbjkHR/qhjIgGAZdq1qGs
	 mPCrYZBe+bkGQxDVR0KvMVQXZ6U5eJFvPTS94Ek4DEKc/G7XstkSEbrX/TIWSSq25
	 Y4M6Yl2e8EhOMRuKfbuv6HlvexsjO/MbqG9A94qyfJfrgoyDVnwloQNd4lBDiRaQI
	 9YDILIIhqwfYUvysIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1xL5Ma2zms-00dWfO; Sat, 25
 Jul 2026 17:22:54 +0200
Message-ID: <bb0fb3ae-5d98-4273-93fc-b36394291d5e@gmx.de>
Date: Sat, 25 Jul 2026 17:22:52 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: replace dead select with dependency
To: Julian Braha <julianbraha@gmail.com>
Cc: arnd@arndb.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260723122818.437802-1-julianbraha@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260723122818.437802-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7O3Iba12pBEd7MuOk0xvWWTMoGOEpO426aRcPSkKe2Y5vC+fhMV
 +iHaMv0Z3adeVTeJXfIdQLqotPx5ZNEb/eIHo8MI495wZRhDpfs+PmtTR1aLEGz19ZwMUno
 DGXdLPb0DTIe9N7uj+3DffzdTJE2WZaJKdW1xQ0grplfBjbkcd5khdbwzL0NZPR43EGPlgx
 DHlqbcJuSKR4i20qlNaMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iSOaY6l8FOc=;2xSTt9DkRcKsWyfX/TitmGe4fu3
 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
 =

On 7/23/26 14:28, Julian Braha wrote:
> 'select' does not work on config options in a 'choice', so currently it =
is
> possible to enable FB_MB862XX_LIME without FB_LITTLE_ENDIAN.
>=20
> We cannot replace the 'select FB_LITTLE_ENDIAN' without also changing
> FB_FOREIGN_ENDIAN from 'select' to 'depends on', otherwise we will get
> a recursive dependency.
>=20
> Since the default choice is FB_BOTH_ENDIAN, let's use:
> 'depends on FB_LITTLE_ENDIAN || FB_BOTH_ENDIAN'
> to avoid breaking defconfig.
>=20
> This dead select was found by kconfirm, a static analysis tool for Kconf=
ig.
>=20
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
> Changes since v1: support the default FB_BOTH_ENDIAN
> Link:
> https://lore.kernel.org/all/20260722220023.196029-1-julianbraha@gmail.co=
m/
> ---
>   drivers/video/fbdev/Kconfig | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
applied.

Thanks!
Helge
