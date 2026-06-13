Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5022459DC
	for <linux-fbdev@vger.kernel.org>; Sat, 13 Jun 2026 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781317739; cv=none; b=AH1HvLHZDFVP54SPzqIVkTTNxF8G3MLRBBBuKIjgj59on6MllR03ytoxNVEvWQ+ozMOJKd/mGcNiwfEw1rIy4O7jZE8Yh7HNDX3tLPOvPnd4NtFEkLrlSV1KlH3t3f+1iePC+enlgRnbPhe50UVfFegztsw1/o+z69AY1KsMvV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781317739; c=relaxed/simple;
	bh=XHGhehCbhHkZXiTsyVQQ9zQt6ll9mKtdLUraN4677UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqJ9JTqBTco45D7tL6gYZeuB+s6qGm+RkBE90IBR2+WRWe8P3hoAoKMmKR03hwkivd5wdXcPuU80KuRwnh3JgaU192WwaWu6TgFoY2brO3VEMgdWT8ce/hVGWCld0ATw6xDVUYKa1btjA7J1o0NtjFpuGEP8cK1ECy1RnN+NmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh2fjy/r; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh2fjy/r"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2247e38eso14765195ad.3
        for <linux-fbdev@vger.kernel.org>; Fri, 12 Jun 2026 19:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781317738; x=1781922538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLHJ0DrZbAxmSP/INU6NP0BNF9ycUzCW6F9L82yYfNc=;
        b=jh2fjy/rscdrHahC4Ui0M9P4r/BS58rKp0VY/8e/jGTE5ybHn7SXN0EADeYlVmeTUW
         CrPwOtOTjR4K11roScpZujwPbY/w0xaJWUUTWXcfnnXuYaVRlUX01UpzElcGOJd2o2Wa
         aKimTH/zpFOE/V6RINda4AKtjXyn6kDQji4rSUWtMfv+OMEUUj9P5L6Yit0u5wzQWhUr
         u2MAKu3C/9TbvrLu12DMlnBKfHFAoWUCgH4qhk4Li8QMuvnsPZXQJU4rqvDXCQkBbX0U
         LGBFs+yBcv4d7q5pAhHlpmdh71KeIc3AOIV8jzYkN/3wmkGsmaDwGRVtCs5CDzB3mXER
         o55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781317738; x=1781922538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLHJ0DrZbAxmSP/INU6NP0BNF9ycUzCW6F9L82yYfNc=;
        b=M5q+TkolDBZB9yHjYm2NKNwfrUQ7FO1k//6o0MJS2GmwVjIaE10y9mASFmKDKE3uRi
         lOhsYUWTx9TZTByivUTswwy8y7az2rNDbMfINgYDhvuTkMAK6O4StHilOm6iz0j9GSIS
         bPiRLt6qsG9mGUYMFtnQZYVeEsBwWgRJuoQMr/pMTPgLVajRKcDNh2QVHWLmi/+wZXbW
         y3JYWrPy4CEM8rUXRrBC6ECGiHSHSbJaxoaV3Ghi0fNZUEZZgcNLhbNmrXecK8vHH3CU
         i0Vp8CDUAVowPlJYqSHTB+YNYmXZEheGLLRRrYlKHuJazm/iUw2ujtdXRjG5Da6kjhu7
         v1zQ==
X-Gm-Message-State: AOJu0Yzoo4Jt4PlGgM2Yxdn7BPuOSlvVqQ6yzsqL/PgZCillCm3dzsr9
	oqzTDgTFoZPGGgoznkLx0rWAzULDrF782yyPsEtX9VUMnPS3vL/+QCTz
X-Gm-Gg: Acq92OHMTfIBOssf4pCA24YDUcCcR/V/5WRyw203jqRlluQhHYQXXPoIYDr3Pc8vwKF
	DWrtSsJmFTR2iIb/9GAKyIUszS4KlkDqJKaCD9vPv1njLAH5TslPLYcKOjyn4oYTKyWPw6I+any
	0euVRau6RA8P871Ei6PKZi3B4AX77SGoI29zbLNRmPP415jBie1FBnu1n67Wvq5S/N3zuxhq0gk
	YV5YW3xzgyDBgWbWErbTMAiWuSgLjeJPDPUz4iQGTJjCZvepdMakF3eXa4MWmmDNPCF7qMtL8Eb
	UKseje39froJ7ufMmgQDT5rsVxXlJ4ZkV001CkRYB3YkHg+CUsp2CQ8ZpShlK+SeoHq6GNHFrrh
	Dv0AFZSlXr74/ITA3OXkGePSDqHK2qOXnZV107a+TckG2/4UO1ffHH5Bls6NoGuUWNOPb80lz2a
	i+PVuPbqIzbeSKtmk450PAifxDfgD/Av8MT56GdWAlunpjAlYQ4cwtbSs/zhBZ+zXvXnMvAwm19
	AnC+766AW9IktwUV17gel2aKPyn4mygLiPfd0AlkUWYBl9pYzHkY5dmknjs/NGu86Qmks3cyKjZ
	Er5p0ER3P5YowRwPh+9uALFjsPlOLU6NiQ==
X-Received: by 2002:a17:902:e84a:b0:2ba:4ad9:70f6 with SMTP id d9443c01a7336-2c412d2854fmr68416635ad.31.1781317737604;
        Fri, 12 Jun 2026 19:28:57 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:2220:80f5:c3dc:900f? ([2601:1c0:5780:9200:2220:80f5:c3dc:900f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac79fsm29829035ad.45.2026.06.12.19.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 19:28:57 -0700 (PDT)
Message-ID: <713470d1-0eee-461c-98ee-b7a378ebd0c2@gmail.com>
Date: Fri, 12 Jun 2026 19:28:56 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: claim Cyber2000 SPARC I/O aperture before ioremap
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux@armlinux.org.uk
References: <20260611035243.16192-1-chintanlike@gmail.com>
 <9df39aa0-4bac-4479-87d3-667c8dd8000a@gmx.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <9df39aa0-4bac-4479-87d3-667c8dd8000a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>        */
>>       unsigned char __iomem *iop;
>> +    if (!request_mem_region(0x3000000, 0x5000, "cyber2000fb iop")) {
>> +        printk(KERN_ERR "iga5000: cannot reserve I/O area 0x3000000\n");
> 
> pci_err() or pr_err() please.
> 
>> +        return -EBUSY;
>> +    }
>>       iop = ioremap(0x3000000, 0x5000);
>>       if (iop == NULL) {
>>           printk(KERN_ERR "iga5000: cannot map I/O\n");
> 
> while at it, use pci_err() here too then.
> 
> Helge

Hi Helge,

I initially left the existing printk() usage unchanged to keep the patch
focused on the memory resource reservation change and avoid unrelated
churn. Since you've suggested updating the error reporting as well, I'll
switch both messages to pci_err() in v2.

Thanks for the review.

Regards,
Chintan
