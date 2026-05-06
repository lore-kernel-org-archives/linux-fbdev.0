Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CADB1A6820;
	Wed,  6 May 2026 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049248; cv=none; b=EMGO2h72zTMh4o1Ve/d8ytubquPqQ147YIi89OsX6NvFW8fLHCFBW3rpK1ou5yvkxSNTxX4K8l1QLlmmKgY7QlHBLis/QcYLsqCrsvNbbXdE6LllCw0wqYqRfFA0f76wWh/EBXSYToDwrEDwFViiW1E8jrl+cVkV7wKKhM+UA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049248; c=relaxed/simple;
	bh=X8n8tYEYVSFckriQ2NNLKWHkPAOG8wXm5IiiaOa0JvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFZhephD9WKn1SJAyN+L+DPJ2jyUG14g9rMa56Rw1hMSGFJSBaTasDLuiEbKVNuUC3ul1gMt1rtpAAYQKXV0a4fyrnyohX+TeO7Nb6Y3e9uwlgZ4M8oCeA/WdjX51E1r1SjOQLoJwlG3GdKZTPP+b+HmpfE7O0BgSoiHc+hcrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=FxwO8Uzd; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="FxwO8Uzd"
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c16:161c:0:640:b95e:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 92C6381707;
	Wed, 06 May 2026 09:27:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp) with ESMTPSA id ERa7n2739Os0-agotJqmI;
	Wed, 06 May 2026 09:27:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1778048838;
	bh=niWCALGlyrgaeT7K/gU5sVSbn65KOcJj/Toritv3bGE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=FxwO8UzdHXPpC6BBy4xDMQ/jsdQFfR75BzKyj9rdE1NuB1SEJS3C9MPaiVCPpLCSn
	 S1olVRy2FNDIj5yuCIGBGMGvvUWVAxvEUmUQlZWQea2ZUsr5sbPdNQJr1qX0YOT4an
	 xIxi891pX+MBkvzTL9xwbz0AQSwXMehXj5BxdTe4=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <fcfbdb1a-188a-4ab1-b7cc-b2c430d2cca4@sezginduran.net>
Date: Wed, 6 May 2026 09:27:13 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: add const to g_fbmode array
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>,
 sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
 gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260506035641.5060-1-chaitanya.msabnis@gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260506035641.5060-1-chaitanya.msabnis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/26 6:56 AM, Chaitanya Sabnis wrote:
> Fix a checkpatch warning by changing the `g_fbmode` array of
> pointers to be `static const char * const`. This ensures that both
> the strings and the array of pointers are placed in read-only memory,
> preventing unintended modifications and improving security.
> 
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index dec1f6b88a7d..08d4979c6755 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,7 @@
>   static int g_hwcursor = 1;
>   static int g_noaccel;
>   static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};
>   static const char *g_def_fbmode = "1024x768-32@60";
>   static char *g_settings;
>   static int g_dualview;

Did you compile these changes?

Regards,
Ahmet Sezgin Duran
