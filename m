Received: from outbound.mr.icloud.com (p-west2-cluster4-host2-snip4-10.eps.apple.com [57.103.69.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1C2D3A69
	for <linux-fbdev@vger.kernel.org>; Fri, 15 May 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.69.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849975; cv=none; b=tCp4gKFALCOh9cFgolRweeUbeGhxPMZ/LWbssXcBoRgTUhb+uH/s+aVu5aq96ZnnDdTFmGDCgt++lzRbEW9/k5zxrjhbn1qTMspAdHjALDeAV55vJ0uXNvBTEZLydmSz49rYppMpM1e26hL4mhvWWQa8is+IjLOdkbvkS9Pz8bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849975; c=relaxed/simple;
	bh=ctUYJlUNgmIPDfKOM3QBJMka+q3iXzpXqWYLO6emfE8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=NRLLz/wbKZRWL5+NYyQcLHUrBwZy8qHEg2teAcTKTclTuGZNujHUfs1HM+xgis2lFTunk1/y3zPGFTi6Dc8EgpQvKkDwDUnqXaOxZj4Vjzc4TGI1rln94gPSSyllDkZ+A0smvu7Vr28mUN1bAEi4v6+Jg5vcIDx+K+PYUw/ILjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HtAeYJBk; arc=none smtp.client-ip=57.103.69.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HtAeYJBk"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id 293AB18009EA;
	Fri, 15 May 2026 12:59:32 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQxWB1sZUwZeC0gETVIPDxRMFVIDWg5aHVwMQAxaDkYwUBtfAkIPHBNWFRMLU1ZWBVQZXQBSA18VTQtSAFIfchlaFFwYU0VRH1RYQQ4KUxIYXBRcUFgeRhJWDV0JGQZAXlAbXwJCDxwTVhUTHUMZDysISgRDB0UCXgslEwlTVlsTVRdGCRkIXR0ZFVoJClcHMQE8ASwDXh9DekgAQAMvBkEUQQUvdUYGNgs9cC4DUgtICEtzBFQHXQVdVlACWlUSBEAIVlBeCF4fTBw=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778849973; x=1781441973; bh=ztgW+tK+j4Yy+fi5hgplSzNaD1VApxZajXl438/V7Tw=; h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To:x-icloud-hme; b=HtAeYJBkx9K36zj2oBzDKLhG2ZEvs/ouGSht42Yqud8fgVXqfEBizKxIx7MeISzVw8q9UxphmV+J1y1344cwZNEZ6esyePCcXKRekamJ04FXnYYmju6a06z8v9vkLknKafN9E7ysnBj/7l+DeIb0Y/lVmjhV5HVA3nqwSJ/e9G1xkp85Wmxm3b83gBambWSRminv8ooHkI2SWZdUYNu9bw9r7zf2MU9iyQJwav7hjhA0Z+1dG5B/wdO6/LACGwMm9Y3MoycM8p9JXGFz88tLgbydZKl7H48KEXOt+UjBDSMlAybJcfiFIxd77nNXFnhSK7CUMzvV1YY1kcw8VCZ3oA==
Received: from smtpclient.apple (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id 5E7C81800096;
	Fri, 15 May 2026 12:59:31 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: "M.samet Duman" <dumanmehmetsamet@icloud.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] staging: sm750: rename CamelCase variable in sm750.c
Date: Fri, 15 May 2026 15:59:18 +0300
Message-Id: <5A8D2A45-3C03-4D41-96BB-4F2ECC499813@icloud.com>
References: <03e9e75a-c63c-4a63-88b8-2287daf6c4ad@sezginduran.net>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, gregkh@linuxfoundation.org,
 sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <03e9e75a-c63c-4a63-88b8-2287daf6c4ad@sezginduran.net>
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
X-Mailer: iPhone Mail (23D8133)
X-Proofpoint-GUID: f1v-E_EIkj2w9-x0VSM7eAvZZPHqslWF
X-Proofpoint-ORIG-GUID: f1v-E_EIkj2w9-x0VSM7eAvZZPHqslWF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzMiBTYWx0ZWRfXw71WhPjn3Ixk
 IFKW8h0KIuUl8OaaSyQ1iBL0Td+iXr/2KTbx/DcN8+GxI8mk0RaVfO3XXBTfjwgngG/7gOshNvZ
 +N1QDO8FN2g5b618cMmMS7BwOcGD3noXf/Q7FAkAIuaM3+aiNQAEq1ufuBhpFwvdTZLpRNKjh3R
 1XzYhFE7Aw2iaJKeFpg+Eg7qOO9l8+oct3XrXXEZB6njR66QhTgU8mK5zskSf7ZF2jNVvRN39up
 yVCPnOG5y00N7AH/izN+iR/eAnsjnQ4WgrTUNwYGIAE+WW8aTsURmAzq5hF3bj8rpV0GFyzdqak
 4D/F2QMEbMoejeuzIZSPnwA7r2b1R4oH2melJOQcQnybwD8Lr8RuBNMSbwnZws=
X-Authority-Info-Out: v=2.4 cv=fdygCkQF c=1 sm=1 tr=0 ts=6a0718b4
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=aRhIMoA-k8UA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UqeRdc-kAAAA:8 a=pGLkceISAAAA:8 a=Hd9wlPITvMhDGQad-BwA:9 a=QEXdDO2ut3YA:10
 a=VY27g7_VbVtgkKdV-MCz:22


Not a change that will set the world on fire.

--
Samet

> 2026. 5. 15. =EC=98=A4=ED=9B=84 2:46, Ahmet Sezgin Duran <ahmet@sezgindura=
n.net> =EC=9E=91=EC=84=B1:
>=20
> =EF=BB=BFOn 5/15/26 1:38 PM, Rupesh Majhi wrote:
>> Renamed the following CamelCase variables to snake_case to comply
>> with Linux kernel coding style:
>> - pvReg -> pv_reg
>> - setAllEngOff -> set_all_eng_off
>> Issue found by checkpatch.
>> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
>> ---
>>  drivers/staging/sm750fb/sm750.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm=
750.c
>> index 996a586a3727..9b30627a19d0 100644
>> --- a/drivers/staging/sm750fb/sm750.c
>> +++ b/drivers/staging/sm750fb/sm750.c
>> @@ -755,7 +755,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, in=
t index)
>>       * must be set after crtc member initialized
>>       */
>>      crtc->cursor.offset =3D crtc->o_screen + crtc->vidmem_size - 1024;
>> -    crtc->cursor.mmio =3D sm750_dev->pvReg +
>> +    crtc->cursor.mmio =3D sm750_dev->pv_reg +
>>          0x800f0 + (int)crtc->channel * 0x140;
>>        crtc->cursor.max_h =3D 64;
>> @@ -860,7 +860,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev=
, char *src)
>>      sm750_dev->init_parm.mem_clk =3D 0;
>>      sm750_dev->init_parm.master_clk =3D 0;
>>      sm750_dev->init_parm.power_mode =3D 0;
>> -    sm750_dev->init_parm.setAllEngOff =3D 0;
>> +    sm750_dev->init_parm.set_all_eng_off =3D 0;
>>      sm750_dev->init_parm.reset_memory =3D 1;
>>        /* defaultly turn g_hwcursor on for both view */
>> @@ -1059,7 +1059,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)=

>>      sm750fb_framebuffer_release(sm750_dev);
>>      arch_phys_wc_del(sm750_dev->mtrr.vram);
>>  -    iounmap(sm750_dev->pvReg);
>> +    iounmap(sm750_dev->pv_reg);
>>      iounmap(sm750_dev->vmem);
>>      pci_release_region(pdev, 1);
>>      kfree(g_settings);
>=20
> Did you compile this patch?
>=20
> Regards,
> Ahmet Sezgin Duran
>=20
