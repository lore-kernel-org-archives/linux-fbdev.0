Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BDD79E3
	for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710703370; cv=none; b=aGxkSVaVxXqpngHf2dEKMrgsx1BKXuKeiDFt4E6+i1L4ztEdDIt6dvNUJGUsSHy1EfOVLLvcG+aHszTN9IpaZKRB8xPll4zfK+QcY/qV/HrjwZP4/RFzyPJdupvLv5WV7NbKR8/V8c9Lp9ZhOlhESezJn+AQYywd+Na8gZnz0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710703370; c=relaxed/simple;
	bh=e3nV4wnrWG6SWp509F7YAfxzv6ZDOqRLWEAPuu0hBqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXdMSZv5Ouc0QEwZ5zR1nfDYAQZlESYDYe+LIWoy1SPd2OSgr1cKOmO/yw7jOfEdCyq+4L0v29Xqon0J0Af5J9tWBzs6IOQ5m/P3cj860nhg9LDpabSCl/PermttpDwNSeFwbSpL6drr2I0QGvFh6KRDM+Ofw7YQvKQgTLdcnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org; spf=pass smtp.mailfrom=tronnes.org; dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b=jRfeZ9jz; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tronnes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="jRfeZ9jz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
	; s=ds202312; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J3rmugwOBqmFCeFyr0Zq+TggeSH2clrkfuPS4qvEykI=; b=jRfeZ9jz7BCQwAjeWxqiHzCmuy
	tG+mi++H6GCvv4BsixXRgsUb0m8M9O+uhbvJOhEgT6LsobxFXafX36u0ZV5ct8aGq8R9RXWI9TN01
	EWHrQEYIBLIilmSkagD184HJvil+Sah3ejBKBOdseNTLZM6UNQgFNrKQBNPw5k90UU5ckaf93rarr
	Pmpf96MaizDICLWBhyrWvPNljqffU2ZZvr/15zeL6cfzOHMDruRW6botEdjIrWBw7UvxUdNrU2Avq
	V78vqKwZqjiBC/HixE0adYrS20ap6cTJv/cNz4HxMwuhEbSMFw8y4V7MvOUcVl1V7HkLp3a7zzJSx
	W46zdywQ==;
Received: from [2a01:799:950:4300:268a:bbd3:738c:c4c6] (port=39794)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <noralf@tronnes.org>)
	id 1rlw5n-00HYIi-25;
	Sun, 17 Mar 2024 20:22:47 +0100
Message-ID: <d56769a1-e96f-42ab-b38d-b8d6525da288@tronnes.org>
Date: Sun, 17 Mar 2024 20:22:46 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/43] drm/tiny/repaper: Use fbdev-dma
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 noralf@tronnes.org
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-40-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
In-Reply-To: <20240312154834.26178-40-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/12/24 16:45, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by repaper. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> ---
>  drivers/gpu/drm/tiny/repaper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Noralf Trønnes <noralf@tronnes.org>
