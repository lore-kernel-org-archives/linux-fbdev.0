Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66614328B7B;
	Sat, 25 Jul 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993409; cv=none; b=Lr28kqx802sricPDEFVNFceX/xpow6naecu4PUofPykbnOOjK/+/Q/gTe1v4HRXRiQXGUrNtlGbrEk90+bYpOpLYZSMIXXX4uH1NzEQzE7j0fw/gtgRlGJDmZt9wY24y/QHXmuo0I0PUpAYkJHHSCvi1OMAP++PKC/AseFD+EIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993409; c=relaxed/simple;
	bh=rkqTou5VFECwHgA95jzYON9zXj7OoPsWnOM67tU8Koc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ta0V5PuRaDhfKNyNNxusG7AShA4aV4YFgqbfVnM2lusvz278pvfwCIBqy5IbV7q8KvEbQmQS0SioX+cSXQNm/JdC/EzOW81kqq+BfaEa16pcwIVCryrD+Ik7KCRrRayJNizEvOS4LZQOHP+c8wMbFx7sJfuF4mj2cTb0AwXlCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=igG4JFbX; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="igG4JFbX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784993400; x=1785598200; i=deller@gmx.de;
	bh=5jH0ii7UHgwikPFMsv0g2mLL/BI9qapzarRmv/m/hv0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=igG4JFbX7bt8oYD8JXt8Y54y8B3Cbpd9UeGvu1gFKUjga6RW5mETLxlv7Yb9H/Lj
	 eB8+AUIbbe9bOp7xo2I8RSSTKDaO+RxiM9x9iPU+nwkljHZ9YFMd41ozKUhKHe9O8
	 nDcQvaqyvvpE/T1PyRaKTmDyuN4L990assaAUDH6yLEWmTMEciVUJj/7MzzrQVZPj
	 akGxD/Jg0WiKeKzi7wOLHDYyvvoisWD4V+qFT3hKAUVzOUB0KfhYDrv6DpikAaPsq
	 ym6lRiMw0VQtOFTDI29IC7WJL5YQkE5r4QE1N76Pyz3NkjOw2mZ/IF0T7/r1nfp9G
	 q+jCdGu50WYw4VatDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1x3PqP3MRm-00uJWl; Sat, 25
 Jul 2026 17:29:59 +0200
Message-ID: <bb8a8d13-07fb-4ee9-aed2-172c86cf3ac0@gmx.de>
Date: Sat, 25 Jul 2026 17:29:58 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: core: Clamp total_size to smem_len in
 read/write functions
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>, simona@ffwll.ch
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260721071522.106306-1-25181214217@stu.xidian.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260721071522.106306-1-25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:af7SGvPzDI5Z4Wq8txheByJH4TozpWMyidPl+AJ4tX8UdnzraBy
 imwg3z0SQxVd9teLnImKz3f+vmNwrfHXqFVTfRgyplFQUtCIcQCbytr9VZjmt1urGtmDOua
 P4nMLp0cHvVDQFo93d3j+xehQgGkl2V2kMnhDfLAYAoF6FA0OsoGOhpSUDD7gockPRJyGbA
 THfdKQzonhA9h3wherNgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3ex+zhN5Tow=;40XJ2YSBEn94wL4CknKJiDnCCOO
 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

On 7/21/26 09:15, Mingyu Wang wrote:
> Some legacy fbdev drivers may incorrectly set info->screen_size to a
> value larger than the actual mapped framebuffer size (info->fix.smem_len=
)
> during mode switches. This could allow out-of-bounds I/O and system
> memory accesses in fb_io_read(), fb_io_write(), fb_sys_read(), and
> fb_sys_write().
>=20
> Prevent this by clamping total_size to smem_len when smem_len is non-zer=
o.
> Virtual framebuffers (smem_len =3D=3D 0) are unaffected.
>=20
> This is a hardening measure; no specific crash is fixed by this patch.
>=20
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
> v2:
>   - Apply the clamp to fb_sys_read() and fb_sys_write() as well to preve=
nt
>     similar OOB accesses in system memory framebuffers (Reported by Sash=
iko).
>   - Update commit message to clearly state this is a hardening measure.
> ---
>   drivers/video/fbdev/core/fb_io_fops.c  | 16 ++++++++++++++++
>   drivers/video/fbdev/core/fb_sys_fops.c | 16 ++++++++++++++++
>   2 files changed, 32 insertions(+)

Sounds reasonable.
I've added it to fbdev git tree for wider testing.

Thanks!
Helge


 =20
> diff --git a/drivers/video/fbdev/core/fb_io_fops.c b/drivers/video/fbdev=
/core/fb_io_fops.c
> index 6ab60fcd0050..335f16d2cc23 100644
> --- a/drivers/video/fbdev/core/fb_io_fops.c
> +++ b/drivers/video/fbdev/core/fb_io_fops.c
> @@ -24,6 +24,14 @@ ssize_t fb_io_read(struct fb_info *info, char __user =
*buf, size_t count, loff_t
>   	if (total_size =3D=3D 0)
>   		total_size =3D info->fix.smem_len;
>  =20
> +	/*
> +	 * Security Hardening: Defend against buggy legacy drivers that may
> +	 * calculate a malformed screen_size. Clamp total_size to the actual
> +	 * hardware mapped memory limit (smem_len) to prevent OOB access.
> +	 */
> +	if (info->fix.smem_len && total_size > info->fix.smem_len)
> +		total_size =3D info->fix.smem_len;
> +
>   	if (p >=3D total_size)
>   		return 0;
>  =20
> @@ -88,6 +96,14 @@ ssize_t fb_io_write(struct fb_info *info, const char =
__user *buf, size_t count,
>   	if (total_size =3D=3D 0)
>   		total_size =3D info->fix.smem_len;
>  =20
> +	/*
> +	 * Security Hardening: Defend against buggy legacy drivers that may
> +	 * calculate a malformed screen_size. Clamp total_size to the actual
> +	 * hardware mapped memory limit (smem_len) to prevent OOB access.
> +	 */
> +	if (info->fix.smem_len && total_size > info->fix.smem_len)
> +		total_size =3D info->fix.smem_len;
> +
>   	if (p > total_size)
>   		return -EFBIG;
>  =20
> diff --git a/drivers/video/fbdev/core/fb_sys_fops.c b/drivers/video/fbde=
v/core/fb_sys_fops.c
> index be96b3b3942e..e97cf02f7c70 100644
> --- a/drivers/video/fbdev/core/fb_sys_fops.c
> +++ b/drivers/video/fbdev/core/fb_sys_fops.c
> @@ -35,6 +35,14 @@ ssize_t fb_sys_read(struct fb_info *info, char __user=
 *buf, size_t count,
>   	if (total_size =3D=3D 0)
>   		total_size =3D info->fix.smem_len;
>  =20
> +	/*
> +	 * Security Hardening: Defend against buggy legacy drivers that may
> +	 * calculate a malformed screen_size. Clamp total_size to the actual
> +	 * hardware mapped memory limit (smem_len) to prevent OOB access.
> +	 */
> +	if (info->fix.smem_len && total_size > info->fix.smem_len)
> +		total_size =3D info->fix.smem_len;
> +
>   	if (p >=3D total_size)
>   		return 0;
>  =20
> @@ -80,6 +88,14 @@ ssize_t fb_sys_write(struct fb_info *info, const char=
 __user *buf,
>   	if (total_size =3D=3D 0)
>   		total_size =3D info->fix.smem_len;
>  =20
> +	/*
> +	 * Security Hardening: Defend against buggy legacy drivers that may
> +	 * calculate a malformed screen_size. Clamp total_size to the actual
> +	 * hardware mapped memory limit (smem_len) to prevent OOB access.
> +	 */
> +	if (info->fix.smem_len && total_size > info->fix.smem_len)
> +		total_size =3D info->fix.smem_len;
> +
>   	if (p > total_size)
>   		return -EFBIG;
>  =20

