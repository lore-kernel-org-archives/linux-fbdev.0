Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA001D9A5F
	for <linux-fbdev@vger.kernel.org>; Mon,  3 Feb 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611673; cv=none; b=lZ11I6KEuFZlGt+KDXdPBCp1tD2b/WySRdgmvwcV7oSsj9a7sPjh21hrBFGz7AtdHCXKZTZuY848cS7AKOI7vE112aJydgYILM56lzxmC9BGHvsbDVfjWJvBLBQMk6ELm8H/ZD2S5OD51z6xJla6SI/7pu5/YqEoNJUbdlgqWJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611673; c=relaxed/simple;
	bh=olpUquEM09IiULoJY3nXb1dKlQ3ETQKBSEKowpVe9bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s0xqsiS6WIPN8PsHgYtGlFfAQBNsO8TrSPuWmqkqhJ2kKVNx7kg0O5NC4tJIeeofX/63teh4DCO8GC9sGbwkpZfBykXxWNTUlVgkkdagkNcGGTbJXnPjvzVKE7QHwtnd2XhJmI/MAaHt67w8pY/ouImxjpWBPc7vdWViomBi2QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=C3hSAzJd; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="C3hSAzJd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1738611664; x=1739216464; i=deller@gmx.de;
	bh=D+e6/UKakYk9gJj4pSwyWRCem/OkH3uCWnrW/Htp1Hw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C3hSAzJdElz8uZ3z07iVfGXxgVWWfb0G0M0MdxXC2BGfNCnmGjx707zyHp0FGOi1
	 95Y4RTtYGeH+9zE+X9CDhVqOjemRWhGxMjGBysP7Wysy6/aM5exvK03YGtpizs71n
	 QGM6sP8OzxXKRecPVPTdXjpIvEKb4CFRXmRkjud871/6FhN2nmdFCXd4tjiGDLBic
	 mNbX9RrtD7D1wCJV3XBbjZktU0h1vFCFEJJwymef2oEqgQtKGh0iTuAJw/d6/9ASB
	 WyJ7nSpeOoTtMSH6Wr7g7xUWChRlbq8fuqmmyf3hT3XJV7yRAp0GodAbM2KHw0sRV
	 K4vb6yZtf0wIUOwIGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.6]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1tycR71Wv3-00TMp0; Mon, 03
 Feb 2025 20:41:04 +0100
Message-ID: <1236a374-4863-4a4b-a244-2cb8e52a0526@gmx.de>
Date: Mon, 3 Feb 2025 20:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: core: tileblit: Implement missing margin clearing
 for tileblit
To: Soci/Singular <soci@singularcrew.hu>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <c8cc27ea-05a8-14b7-0047-4f1fa6d73f93@singularcrew.hu>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <c8cc27ea-05a8-14b7-0047-4f1fa6d73f93@singularcrew.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5XO4+3fFbxFWVUhj07dZ1H9l0igJqXpQyVe7xjksP1mNETWdUg9
 ulSYaG3LAJRgb/gpTCedd+6vC4v9HjIKXWpBc7mLaTXs0sgTBOsfp1XHXontrgcAXHBdMEn
 WfUcov1JcJaf/9q3EUpUHKfDDAQZfbZs9djyb3aeoplLB5eAWXYt4aElR9obH9FVRODFZ4t
 OG+1NZEJNjo6OCeV54wtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fdcWLwp+hno=;8eP4/KsljLeuMmCCE/GRxUvKgJP
 PRu2pNCzC0HaHBCnnilDsMVGZ9ucBD1ueqVDEBeNe+7z7SgobGPqobj3PMjrYmbsj8OfmLogj
 ymj4e6zHkCu7lMPE2SJgiPPtK/By5jQ/Y3Vlijk+heZqGIbPNlFP6JisnNHMlJA8JuLLFf9SR
 mvBUHil6oBiNM2AN61i1HJbqUJE7P/vnzi6BfTj55aW9BaNB9bzBeUsdq4O705i2uOGen14/w
 2MNduBA+uKv6BcdDRMjDxeryk2p0/Ye8bslqb36iR5CmRumNTOGoiuNKeKHdoYjtoZAgJLPaR
 HcKVKJ9idFPe94qQ6IrxG+RM2gL8pY3kU5h/q65nRK79QlxzKw3YbSGllcC6xMoGLH5l1UV+v
 ViEap0iQZ+UJhPELGNRitdB0Aw1Mb/NPiuD5aShJeryCrzHV1Lfy2w5sYPkgP6boXerhwqJjV
 xF3OnJr/qgirN/7blyNW7TbOTeQ8adbOM5ROJoixEYeBlOHv2fUD+wrxaS+iHGGK5ZYgQrriL
 egJWdL5EiQnBhTvTGhJ9/NVNMlwyJjkF339u0rFeQ9zVa4w1TUeRCTM+W2urbEx/PKrgUOycs
 TbDRTPH8yw/ejGuDBL0itEndgfgTJvyT7dmCHZmSS6kakVm7ZMnZvzjib0sL4/YgudOGbIMwR
 ZmHEGmvyRNk5kKaiIYJNvNVxBH9YlQmcKgqtcdjhPeFNqra3WDjXcumQHdaZbQfw8eDj/D9EB
 a3lJelMUlQKpJILCPweF+PSe+nd3f1WzsgMf35woXnLIo5jX0fU+PFi672qYjDqx517QaXY06
 mIU93JETrPr4FItJ5biEzDzI+3JDTV0JOYB0K2vrXS/GyQNZrUVquJ2EIEgbeGj+AM3oZy94x
 caAvdYMbWFp2meDyO2kZ0iVJwuPpaJkJMZ4R9PwVbMFR++ZLkOZmM50jUtE6bDLZhStdbNZBH
 EcptIaorrtd7tbQqY8dBtuP+zTqgOiROW0Kg7jBN9oNHytfDFdUL1MK0mVpHwjDavC7FM69Zh
 SF2Qi3Ui2EGlJbt6+SMiCk9qY7dMpJaBYtp+mhmpnbtG0bR+jV0CdQnNx2Q+TBlm0ZGVggUK4
 tUMWZp1u8zdt5Bx3pbItuk/jp1M7oV+3BtbgsKjX64S1nU4yVfTfPmQizbWDLI2m9FGo+M4F6
 SqB5hyBdUQkwEemJH/Up7KY0NZYrojpeRNkD+e7N6BretBES0UA/AkV9Qk7FOi0cyQpvnNTcH
 eSSRlv43NriYYAr6t4+k+Q1ivPkxI5aBy10LvZi1dGi3z+LY7c1jVeHjoEYABiatZkFId2A7q
 Rh29BUltj4liHMI4lVpz1ODPOv1bxb0VlzwJEKUpXXbkcA=

On 2/1/25 09:18, Soci/Singular wrote:
> I was wondering why there's garbage at the bottom of the screen when
> tile blitting is used with an odd mode like 1080, 600 or 200. Sure there=
's
> only space for half a tile but the same area is clean when the buffer
> is bitmap.
>
> Then later I found that it's supposed to be cleaned but that's not
> implemented. So I took what's in bitblit and adapted it for tileblit.
>
> This implementation was tested for both the horizontal and vertical case=
,
> and now does the same as what's done for bitmap buffers.
>
> If anyone is interested to reproduce the problem then I could bet that'd
> be on a S3 or Ark. Just set up a mode with an odd line count and make
> sure that the virtual size covers the complete tile at the bottom. E.g.
> for 600 lines that's 608 virtual lines for a 16 tall tile. Then the
> bottom area should be cleaned.
>
> For the right side it's more difficult as there the drivers won't let an
> odd size happen, unless the code is modified. But once it reports back a
> few pixel columns short then fbcon won't use the last column. With the
> patch that column is now clean.
>
> Btw. the virtual size should be rounded up by the driver for both axes
> (not only the horizontal) so that it's dividable by the tile size.
> That's a driver bug but correcting it is not in scope for this patch.
>
> Implement missing margin clearing for tileblit
>
> Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>

applied to fbdev git tree.

Helge

> ---
>   drivers/video/fbdev/core/tileblit.c | 37 ++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/c=
ore/tileblit.c
> index eff7ec4da..98e528d38 100644
> --- a/drivers/video/fbdev/core/tileblit.c
> +++ b/drivers/video/fbdev/core/tileblit.c
> @@ -76,7 +76,42 @@ static void tile_putcs(struct vc_data *vc, struct fb_=
info *info,
>   static void tile_clear_margins(struct vc_data *vc, struct fb_info *inf=
o,
>   			       int color, int bottom_only)
>   {
> -	return;
> +	unsigned int cw =3D vc->vc_font.width;
> +	unsigned int ch =3D vc->vc_font.height;
> +	unsigned int rw =3D info->var.xres - (vc->vc_cols*cw);
> +	unsigned int bh =3D info->var.yres - (vc->vc_rows*ch);
> +	unsigned int rs =3D info->var.xres - rw;
> +	unsigned int bs =3D info->var.yres - bh;
> +	unsigned int vwt =3D info->var.xres_virtual / cw;
> +	unsigned int vht =3D info->var.yres_virtual / ch;
> +	struct fb_tilerect rect;
> +
> +	rect.index =3D vc->vc_video_erase_char &
> +		((vc->vc_hi_font_mask) ? 0x1ff : 0xff);
> +	rect.fg =3D color;
> +	rect.bg =3D color;
> +
> +	if ((int) rw > 0 && !bottom_only) {
> +		rect.sx =3D (info->var.xoffset + rs + cw - 1) / cw;
> +		rect.sy =3D 0;
> +		rect.width =3D (rw + cw - 1) / cw;
> +		rect.height =3D vht;
> +		if (rect.width + rect.sx > vwt)
> +			rect.width =3D vwt - rect.sx;
> +		if (rect.sx < vwt)
> +			info->tileops->fb_tilefill(info, &rect);
> +	}
> +
> +	if ((int) bh > 0) {
> +		rect.sx =3D info->var.xoffset / cw;
> +		rect.sy =3D (info->var.yoffset + bs) / ch;
> +		rect.width =3D rs / cw;
> +		rect.height =3D (bh + ch - 1) / ch;
> +		if (rect.height + rect.sy > vht)
> +			rect.height =3D vht - rect.sy;
> +		if (rect.sy < vht)
> +			info->tileops->fb_tilefill(info, &rect);
> +	}
>   }
>
>   static void tile_cursor(struct vc_data *vc, struct fb_info *info, bool=
 enable,

