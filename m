Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.134.164.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234076;
	b=Ke9Yl7NgNwvUhtfjaB98DXnDp0sKRUVnWJ6QUK67fl2BVeQopfTYKMCVy8OBTDxQTCSi
	 GkxAwokE144CDzNRXy5GsnKqdjg4rV5p4IMG3PL/0LVJv6zc7ucfwKbZTKN8P+HOGR/ue
	 GD6NNjE7vg9CCbS/8R4gb5NZbkow5WzNGVEGphOajVPWtCBaHDkaYvWTgXglTzGgoXy8z
	 lA3NwzTFUXMf1sg+e4bUN3G6GcKe+XUkxcXR6Btf5tJ7OyBTErHzTh5HG9dhtk6Iy52ZR
	 O3rHXfE0hiR05uREFg5s9PVmJiKop7D94zPtiJKOwEJpbQV63knf9RTBh+bCXs3nM2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234076;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type;
	bh=NNQc4AZF/LOIBNx2K85deaaBLDBCMdMGjAS1ywWnU7w=;
	b=PXJHEk5B9Gov4VY6NKDnidPaFXrqff6gaPaeoaLR62GaZ3iNG0Mn4dZRmbsJw3lOS9pW
	 6L+9sfn9gSILbZyzdtgo7XFkYFHMIUo/3po0UKgHjcuteR/pcA9iSGSZhgOhTu28LOIFj
	 TPrHyQcKp3zU3TfXO56RSLDWSoehYOJaEI/9Av2B4pYwluNBKwV5ZyCQBfXQ4tJitL/mn
	 YwkLBunp3nUKw1crF9lSAvRxFWHUDRM8aKQQ7km3MK7IUP1HoIlOG2pRRBTAsq1G9HXCq
	 RJByvgBLuzxihlLWFZFWUDuJbxzNPAs1KPp3h15t9nksvpkYZmwlycnPe2nY64OF9eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inria.fr;
	spf=pass smtp.mailfrom=inria.fr;
	dkim=pass header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b="O/lH5k+V";
	arc=none smtp.remote-ip=192.134.164.83
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECEA606A31C
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Nov 2026 14:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ECEA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=O/lH5k+V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NNQc4AZF/LOIBNx2K85deaaBLDBCMdMGjAS1ywWnU7w=;
  b=O/lH5k+VUVlZQwONhSgPDSiyFD/i2B0rVGBD7EWDyli31fC6kK4vSeUh
   g/IKenfltNbFs9KPk88cbPfWLXbprdd4aLQ9CAqex8ws/AujfXtg6jz4G
   roHBWB7Wvdp5EVn5rB8gEgtAe3vL8HkO999NHo8qDmv3U1OjZ8nqV6y3P
   I=;
X-CSE-ConnectionGUID: B7hJjYGQS3q6NVmBi67wHQ==
X-CSE-MsgGUID: 7YknnplXTiaHyH4b32XI2A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,203,1787004000"; 
   d="scan'208";a="304586840"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:21:11 +0100
Date: Mon, 9 Nov 2026 15:21:11 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Shivani Patel <patelshivani2283@gmail.com>
cc: outreachy@lists.linux.dev, Andy Shevchenko <andy@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org, 
    linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix spelling mistake "writte" ->
 "written"
In-Reply-To: <20261109133731.66016-1-patelshivani2283@gmail.com>
Message-ID: <e235fcb8-c0fd-1e63-eddf-41efd70c7c4@inria.fr>
References: <20261109133731.66016-1-patelshivani2283@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 9 Nov 2026, Shivani Patel wrote:

> Correct spelling mistake in comment ("writte" -> "written").
>
> Signed-off-by: Shivani Patel <patelshivani2283@gmail.com>

Someone else has already submitted that patch.  Please check the mailing
list archive before submitting patches.

julia

> ---
>  drivers/staging/fbtft/fb_st7789v.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> index 861a15414..c4db681eb 100644
> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c
> @@ -221,7 +221,7 @@ static int init_display(struct fbtft_par *par)
>   * write_vmem() - write data to display.
>   * @par: FBTFT parameter object.
>   * @offset: offset from screen_buffer.
> - * @len: the length of data to be writte.
> + * @len: the length of data to be written.
>   *
>   * Return: 0 on success, or a negative error code otherwise.
>   */
> --
> 2.50.1 (Apple Git-155)
>
>
>
