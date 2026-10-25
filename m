Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792957089;
	b=1nPx2r3Ky2WCXVUQ84nmbCMjdaaEA/O7Oen3F0FYOVQG1x7ZmassoU9ZG8KzONDKWNkI
	 ua/mKCLgSKeJtlOHSDigYP+C9Ubq715Zpsg45t6f80nzyXYwcGMrvsQ7gXPZC/Scjv3Vt
	 7tg0vRwqtj0YJov7JcGqI5LGX6wD5D9+jPtmjILzoKFffrQCukiv7XsX6wA/3STjHLXA6
	 qBMUW0vGbG80dIbnN4mv8Hyhb56tEpsfRJ9TaWxc8/PXt/GUF/kyVYz5X4Dl79YUH0MlG
	 DtX3XeFJvGu+Z7rVqC/EjQw3YGnD5cCqRNaynlklwBLKIYMp9UKz1wu39hrgx2tlC7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957089;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=Qx0XNMDJKOmw5j//coeVgL5VSOXtSCf5PwOpyQrmoyI=;
	b=q/+Hy/gZE5IS0CBvxv41VrYXXN7mGZ6yGEPVtZtBquQhmZ9i7634BDRjv0VkDWDPOuGI
	 mCdaCKW5YhCBdrGqHp3jUGY4IilxGLo71lnjHmBOcmHJRmvfhLy3TU9LXdIcNPZsCGk+X
	 sWMUuuCowWGR4hu5xFa40x4kYUhJDVq4BNLSxkLgGo+YX6owUnZEXQB8m4jFdCXbxmlQg
	 x4mRsegVCQ8Pc+QZzM19ARe2F4e5eBjM/OAt6RVx4yw2POxmnyFecxBm9oby4JFebgBSQ
	 BV1NIhlgnoby+SvEpDFPpItsh8AWARWx2V09b9tORpYoKFjYBfQsq/UdRo6fzLfS4JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rYTfwbYn;
	arc=none smtp.remote-ip=212.227.17.21
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF6606A31A;
	Sun, 25 Oct 2026 19:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92EF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rYTfwbYn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792957083; x=1793561883; i=deller@gmx.de;
	bh=Qx0XNMDJKOmw5j//coeVgL5VSOXtSCf5PwOpyQrmoyI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rYTfwbYnyB+lPTNr4zR7H4sV14sN7mSSJ2ctfNtrxLYuQ2O/XNyPDSe6wwvazYd+
	 ys2tFnuYdu8gjXRoV5S5+oig2Kz4AD6KInC/8Zy4u+x4EKMTuGc+Dzzb9rdDvYd9P
	 BeSghkDjiiO5+9bjW07QxZ3tKu65sTiOzJLskROlL70IM6dzE91PBxgpplLQ6cyvB
	 koJ5Dz3fmjx+w8JIzsgzoCaz823ukKZPLyCXpRB92M1cTaNV4tNY9866lm7H6HDZs
	 b1RWP26vkDFFyBaXNXzEs1NW7lVmcC9PJdXW1gDr1zzU2vGlCEZV8UGD2y9lfMaQj
	 8v03IFq7HqecsN89Og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1xBxFo2j7D-00PcZV; Sun, 25
 Oct 2026 20:38:03 +0100
Message-ID: <f5a860e9-7b8f-400c-8d30-44f62e5129b8@gmx.de>
Date: Sun, 25 Oct 2026 20:38:00 +0100
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: vfb: Validate framebuffer geometry and memory size
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh,
 Xiang Mei <xmei5@asu.edu>
References: <20261023175128.4127122-2-bestswngs@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261023175128.4127122-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZpvnxpYgYxTsCsIaU8oBBpTKNdKPqaLP+hWsu87qPYs/ZOoQhbx
 sruM/rKXV2nuQO55eWY7OgoWAbgTLpHqmMB6mOv7UzUOvpIj1NBXCmEnkqxvvo+U7UJA5Ec
 VnOD/gVHZs/VSLLmJ2egPSyr2p7gcpQq0mZvpgr4yE+ZLA0dZro2v7wIvzrG6q0Eo+q2JgE
 q7xDoxG7mVg3FyadQvDNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:86+Q2HxGz/k=;IjLt5c2u1bxh2WBZDCpnTNh5m6b
 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

On 10/23/26 19:51, Weiming Shi wrote:
> get_line_length() multiplies two int operands before assigning the
> result to u_long. Setting xres_virtual to 0x8000000 at 32 bpp therefore

A xres_virtual value of 134217728 seems quite unrealistic IMHO...

> wraps the product to zero and bypasses vfb_check_var()'s video-memory
> limit. fbcon can then clear margins with a zero line stride and write
> past the vmalloc'ed framebuffer.
>=20
> The xoffset + xres and yoffset + yres calculations can likewise wrap,
> leaving an invalid offset in info->var after fb_pan_display() rejects
> it. Subsequent fbcon drawing can then access far beyond the framebuffer.
>=20
> Finally, PAGE_ALIGN(videomemorysize) was narrowed from unsigned long to
> unsigned int. Values near or above 4 GiB could therefore allocate a much
> smaller buffer than the size used for mode validation.
>=20
> KASAN reports:
>=20
>    BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
>      drivers/video/fbdev/core/sysfillrect.c:24
>    Write of size 8 at addr ffa0000001671000 by task poc/198
>    sys_fillrect
>      drivers/video/fbdev/core/sysfillrect.c:24
>    bit_clear_margins
>      drivers/video/fbdev/core/bitblit.c:247
>    fbcon_clear_margins.constprop.0
>      drivers/video/fbdev/core/fbcon.c:1410
>    fbcon_switch
>      drivers/video/fbdev/core/fbcon.c:2261
>    redraw_screen
>      drivers/tty/vt/vt.c:994
>    fbcon_modechanged
>      drivers/video/fbdev/core/fbcon.c:2693
>    fbcon_update_vcs
>      drivers/video/fbdev/core/fbcon.c:2732
>=20
> Reject video-memory sizes whose aligned value is not representable by
> the fbdev metadata. Check the offset additions for overflow. Compute the
> line length and framebuffer size in u64, reject unrepresentable line
> lengths, and check the total-size multiplication before comparing it
> with the allocated video-memory size.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   drivers/video/fbdev/vfb.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> index de137b2bd..84b0a937c 100644
> --- a/drivers/video/fbdev/vfb.c
> +++ b/drivers/video/fbdev/vfb.c
> @@ -101,11 +101,11 @@ static const struct fb_ops vfb_ops =3D {
>        *  Internal routines
>        */
>  =20
> -static u_long get_line_length(int xres_virtual, int bpp)
> +static u64 get_line_length(u32 xres_virtual, u32 bpp)


Instead of trying to extend to 64bit, I think we should simply
limit the maximum allowed screen sizes to e.g. 4096 x 4096
(or some other realistic values).


>   {
> -	u_long length;
> +	u64 length;
>  =20
> -	length =3D xres_virtual * bpp;
> +	length =3D (u64)xres_virtual * bpp;
>   	length =3D (length + 31) & ~31;
>   	length >>=3D 3;
>   	return (length);
> @@ -122,7 +122,8 @@ static u_long get_line_length(int xres_virtual, int =
bpp)
>   static int vfb_check_var(struct fb_var_screeninfo *var,
>   			 struct fb_info *info)
>   {
> -	u_long line_length;
> +	u64 line_length, size;
> +	u32 xres, yres;
>  =20
>   	/*
>   	 *  FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
> @@ -159,17 +160,23 @@ static int vfb_check_var(struct fb_var_screeninfo =
*var,
>   	else
>   		return -EINVAL;
>  =20
> -	if (var->xres_virtual < var->xoffset + var->xres)
> -		var->xres_virtual =3D var->xoffset + var->xres;
> -	if (var->yres_virtual < var->yoffset + var->yres)
> -		var->yres_virtual =3D var->yoffset + var->yres;
> +	if (check_add_overflow(var->xoffset, var->xres, &xres) ||
> +	    check_add_overflow(var->yoffset, var->yres, &yres))
> +		return -EINVAL;
> +
> +	if (var->xres_virtual < xres)
> +		var->xres_virtual =3D xres;
> +	if (var->yres_virtual < yres)
> +		var->yres_virtual =3D yres;
>  =20
>   	/*
>   	 *  Memory limit
>   	 */
>   	line_length =3D
>   	    get_line_length(var->xres_virtual, var->bits_per_pixel);
> -	if (line_length * var->yres_virtual > videomemorysize)
> +	if (line_length > U32_MAX ||
> +	    check_mul_overflow(line_length, (u64)var->yres_virtual, &size) ||
> +	    size > videomemorysize)
>   		return -ENOMEM;
>  =20
>   	/*
> @@ -434,9 +441,13 @@ static int __init vfb_setup(char *options)
>   static int vfb_probe(struct platform_device *dev)
>   {
>   	struct fb_info *info;
> -	unsigned int size =3D PAGE_ALIGN(videomemorysize);
> +	unsigned int size;
>   	int retval =3D -ENOMEM;
>  =20
> +	if (videomemorysize > U32_MAX - (PAGE_SIZE - 1))
> +		return -EINVAL;
> +	size =3D PAGE_ALIGN(videomemorysize);

same here.
There doesn't seem to be a maximum limit for videomemorysize.
Maybe adding a check and allow a maximum of e.g. 512MB ?

Will you send a revised patch?

Helge
