Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F243C9890;
	Fri, 15 May 2026 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843933; cv=none; b=lWbbDpl6VoKCg+MadOq6L1mCANYnk8eVJaFwUAaotZduBwNyp+XnDzTzJanQH4fK6iQrNOQDTLW7z279dpvkvbN5Ga/ILMZKW0LZm6d5JJnMIabj+9mO2dfbT2JhAfdZKmAFCQ1y0RlGUtDog8+iDHCP5x5YK/rsjs+fFB0Mg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843933; c=relaxed/simple;
	bh=xWsaLDyR/aXTs0ZVfT/Jnd7ddmtd8lszJsDed0VF2DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDQqWrT/8qPcmgV/NovZeNAeIe9cPBa6szOospnkEPosrnquB1534ROODZjyRPj2r8Szp0yEGVH9z78oViDshTm0Ig4FvTDzCoM6uvyH2GXLKZkPc7VeeRymh8RolofvexjteDRSeMWgoXxLn2CT/hofCgfwEhorITyHBXCbjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=FVjwzTFD; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="FVjwzTFD"
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:638c:0:640:aae5:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 22F0080B53;
	Fri, 15 May 2026 14:18:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp) with ESMTPSA id gILtOAgQTW20-0lAlUsac;
	Fri, 15 May 2026 14:18:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1778843925;
	bh=pPcL8QglBnduaJUdPx15aMenKqVYlzbpH6eenpJ5idQ=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=FVjwzTFD3ty4DlNDw0SqQAfhmrXvG0+fcapXyeLnLpEOLjV+1cALG5JwDSl8EuDDs
	 an3QrFjBP+RabU3uY0pJAqCmMr8NeZm8TTeyElRn9/UDMw1m6WhHqTsgU+xP1ynZdZ
	 jjrTIB+uQTY3+Cr3uHsiWpzsgrvtTQ4qalvqVk6U=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <03e9e75a-c63c-4a63-88b8-2287daf6c4ad@sezginduran.net>
Date: Fri, 15 May 2026 14:18:42 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750: rename CamelCase variable in sm750.c
To: Rupesh Majhi <zoone.rupert@gmail.com>, gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260515103811.2808620-1-zoone.rupert@gmail.com>
Content-Language: tr
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <20260515103811.2808620-1-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/26 1:38 PM, Rupesh Majhi wrote:
> Renamed the following CamelCase variables to snake_case to comply
> with Linux kernel coding style:
> - pvReg -> pv_reg
> - setAllEngOff -> set_all_eng_off
> 
> Issue found by checkpatch.
> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 996a586a3727..9b30627a19d0 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -755,7 +755,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>   	 * must be set after crtc member initialized
>   	 */
>   	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
> -	crtc->cursor.mmio = sm750_dev->pvReg +
> +	crtc->cursor.mmio = sm750_dev->pv_reg +
>   		0x800f0 + (int)crtc->channel * 0x140;
>   
>   	crtc->cursor.max_h = 64;
> @@ -860,7 +860,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>   	sm750_dev->init_parm.mem_clk = 0;
>   	sm750_dev->init_parm.master_clk = 0;
>   	sm750_dev->init_parm.power_mode = 0;
> -	sm750_dev->init_parm.setAllEngOff = 0;
> +	sm750_dev->init_parm.set_all_eng_off = 0;
>   	sm750_dev->init_parm.reset_memory = 1;
>   
>   	/* defaultly turn g_hwcursor on for both view */
> @@ -1059,7 +1059,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
>   	sm750fb_framebuffer_release(sm750_dev);
>   	arch_phys_wc_del(sm750_dev->mtrr.vram);
>   
> -	iounmap(sm750_dev->pvReg);
> +	iounmap(sm750_dev->pv_reg);
>   	iounmap(sm750_dev->vmem);
>   	pci_release_region(pdev, 1);
>   	kfree(g_settings);

Did you compile this patch?

Regards,
Ahmet Sezgin Duran
