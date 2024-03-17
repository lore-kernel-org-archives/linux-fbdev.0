Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E879E3
	for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710703344; cv=none; b=Dq9l8CJzMCZXnigD8o/Ob71+a3gne+uToHt1R25htIseWN29ueg8mwvhJnFCU/zfBNNdTPKGpHBiVXU0qrDu/89P0/BiBHTcTzFKkJmIlGRkTrSvj5oSntp0pdhsZbx664k51zorAh6bD3DxBH8F85ohv9/sL5fJ5AsEdf/9gPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710703344; c=relaxed/simple;
	bh=9/T6wnfSRocelHVY0ZS+9+czzO4D2IStsAxmKmcdHFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2hRLdvSFgsi1PdDmBUzFEnFHRdziIvJIBs7NW/u0K0uKuixgWcrqXhgEfV65FlxQixhfw0hrIAu4VQlGHD0fnKdr4GBAKjnznLhhd76RWexLAv6WRaO+absz69FvDHMLiHCLJEaHmoCFbNjK1gOUcV2KdygyBUbXCd2HNOrayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org; spf=pass smtp.mailfrom=tronnes.org; dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b=oya43n4o; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tronnes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="oya43n4o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
	; s=ds202312; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lw6nalN2Pd+fQokpxUm2iOrAmIH9EhNUgSXGX+a5Ms0=; b=oya43n4oQRfIpDzNvJ6KQiknpB
	4fmNiqK1S/lvwGr+MddZMBQfV4sI4rVLXL1RthBADW7Di43nzv964QrNai1E+unfZAkhBZ8nIWPRR
	YtnHhk+xsT/2w7ocM0jmJi9ejlz+BtcPLuLwHuvBlWIXeG//6L4tClhjb0IEJ0SNiFTwEX8g99z0N
	2ZCJrl2kCUrXvw1nEfW/xr2419Jie3JwxcB4lBbUpSN7Cy+a2VZjKuh5KiF8axbz5Nmjlge/fBJ1t
	o1XlDh0oSr3azSv2mono5Cy1H/ByZGQ+cuEbhffWaKePlPxre+d/quyzJQ9UKQCZ/QA+bnmP1PaiX
	4RqaUrZw==;
Received: from [2a01:799:950:4300:268a:bbd3:738c:c4c6] (port=39794)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <noralf@tronnes.org>)
	id 1rlw5N-00HYIi-8o;
	Sun, 17 Mar 2024 20:22:21 +0100
Message-ID: <67f12655-101e-4b2b-93d7-bc75b0d85769@tronnes.org>
Date: Sun, 17 Mar 2024 20:22:20 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/43] drm/tiny/panel-mipi-dbi: Use fbdev-dma
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 noralf@tronnes.org
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-39-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
In-Reply-To: <20240312154834.26178-39-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/12/24 16:45, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by panel-mipi-dbi. Avoids the
> overhead of fbdev-generic's additional shadow buffering. No functional
> changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> ---
>  drivers/gpu/drm/tiny/panel-mipi-dbi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Noralf Trønnes <noralf@tronnes.org>
