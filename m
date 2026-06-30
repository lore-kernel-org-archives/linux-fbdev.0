Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ADA32B127
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Jun 2026 04:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793329; cv=none; b=FQ6cKP40aj4zmjvK0y/ygYDbUnlmx1l8a+VCQ9E8fIKAOtHRZdT4Coo/CNAhtD/bu+PqLn51ssstPLClJrENbUaeYc9jsYPU4myB4RAx3jTXZE2q9XHz7MzcXqTcboZZfWCQSJAmx9scACnVtWFsoK3YmTe0CB6K67su7OmQfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793329; c=relaxed/simple;
	bh=+6YAhJMdzp/Uoj/YHQo8dGg+kazEu6hMdCmKDj/l20U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPxbapOv7Tu4wGLjr6/gfxEksO98MxHdB+W1mEuWFCBC4c+gUgy/ZHnJiE/eyraijJE++9jB+Lw/X1cGZYNgvvWk/9rpUKCzr2TwhdLSXBFWFRcOra3H2VXEf3aPzY6aEMd58hooMejwAjMO0wKrYfwNFoVZUD3atKKLYqPeiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luuS4Yr6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luuS4Yr6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37fa53bc22dso2680312a91.3
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jun 2026 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793327; x=1783398127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxIwnvg1dJPUJwltpuvbg1AsYwjZf+P/fmHcIreJDzI=;
        b=luuS4Yr6sigp0EdGrh1EjQA4UB5+AaWGz5En9Nn6mQaJcBsZTcOxiDvl13Z3BwmAFI
         N/vV/tZTSZHoCe8NKmJRwzNAfYtUjsBCvN1sAlpcYkcmG+xqazRj+fKSiRJ5pvxl3Lds
         pUkBJuM+BOa2yUU+ilFn1Hcg/0ldex+YRxdzfEurLY/4NlhZwh5wdSL56PJsMGecEU9R
         TBm4KIOgC0Yh7Q/8JfRpWyEkht9F3JA3Nx0eg0HrlJVdtR7ktden/4t87DJC9aZFjlLy
         XGaeUGwiq8MsZ+NddQeRnLRpCZXppFc8iqtFBe+SymfJYOvD98a/G1vDuscBzJPiE+hB
         Y5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793327; x=1783398127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxIwnvg1dJPUJwltpuvbg1AsYwjZf+P/fmHcIreJDzI=;
        b=Va0dTFHE6qPTjs1reEDBPX9sh5MddJBDe9bfByfhPj3DRp1R3wQ4Gx5iBO13CKE0F2
         5C9W44/HiKEYmHESL9jFgD7eqMA0qwqKD7X4TL0usXjnuw5Q3HmQKXGVFp7eXeEyYUFZ
         CqYVTAgbdSj8suVTdzSravGoDHMksM4+zVC4rtS0P0ILrsN5aFAKbjXmPlcaL1SYJghU
         fVcBEYwMdJRFAEb44rN1Y5GIg4du4lyHMW64+mcx8QDRjWM8dG1RhoO9a1SgRmA9BHPl
         CDxyC0pdukoyfl6+fAk1VSVdNIAugPMh7/O6m1HeDDPw+R/htnWtoekKPoSXsFCGgSg+
         if2A==
X-Forwarded-Encrypted: i=1; AHgh+RqaK+rByfzW6ZgP8Pt/2btZwZttZi9GMnZ8IYzRfxBxkF+8c3uXRD/MKUD0NeQeQ46y2OTNBp3EZ8gaXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8UpkeVy2wQjC/v/P1jmZ/B3+bkNlLaFI+e7OEa75B3UHEfiR
	h/Weo9+aD5OJgUZhZYC1mogRWd4ptFnrv0kpsGROeG8fklr8m+rn90Xa
X-Gm-Gg: AfdE7cly2uCXpR/QxIDhp4PbNDDWTfPWomoo8IbdHGxvqrXDO0A95S43v/ShczFbdDi
	r3z413uDqhmzcauT2gNM+wjIeuvfL0/ZOMkvL9JLQ3HNw2KDkp2mJHf1K1YXIQFY21QrYqjHjf3
	Bp/N6paTzccA4KbkXU5q8wanhLI2SH0ISuFIiW5z/twQps4+000p5hdL+N/QBS5wLoBbSZn/bos
	YBN5khcdMXynMBpL21zpWGs+f02mt6N5SyQIN3qAfXibfnSMLIS5IsxG1hYpJV0ZazEhIUttpmd
	9/c/yu38LjXeRJG9iEqocTo20/5v8e0DWuwS7KwTTvXhaKNJx91GexM5OMa6R0Wl+rvOlDuUVXZ
	yCtxWXygsOFlS0I/QdQ18ADoI3nHmLw3QCdzLrl/oflRXqqg+G6DMJ3tcIhmhBy2E49Y4TcdiGQ
	bsfH4zXWxpVRxSi4hv/5H49+qmT7VTOpRajZ1LI5hp0Ge32A/+vxio2nAHoykpPA0LmCbZDDEug
	IY6JjAjId376Yhj1Ox0uypd4X1h8E7mGNun378O2yhmgUPP2+CT0MMgFn6/s3DlkInc1ni8E3HM
	dENQ5Gz1DomeWh1oqGMU35c=
X-Received: by 2002:a17:90b:47:b0:37f:9ce3:ca95 with SMTP id 98e67ed59e1d1-3805278b763mr1468080a91.30.1782793327254;
        Mon, 29 Jun 2026 21:22:07 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:80e5:49e2:c5b5:4cc0? ([2601:1c0:5780:9200:80e5:49e2:c5b5:4cc0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38052f47a3dsm832403a91.13.2026.06.29.21.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 21:22:06 -0700 (PDT)
Message-ID: <c3f61201-f1d0-4302-b726-04ae16294fa8@gmail.com>
Date: Mon, 29 Jun 2026 21:22:06 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fbdev: claim Cyber2000 SPARC I/O aperture before
 ioremap
To: Helge Deller <deller@gmx.de>, linux@armlinux.org.uk
Cc: tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260616043035.11952-1-chintanlike@gmail.com>
 <5879368e-1a91-4d4d-9243-dd9de9d06962@gmx.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <5879368e-1a91-4d4d-9243-dd9de9d06962@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/23/26 00:57, Helge Deller wrote:
> On 6/16/26 06:30, Chintan Patel wrote:
>> Claim the memory resource associated with the Cyber2000 SPARC MMIO
>> aperture before accessing it.
>>
>> This is part of the effort to request memory regions in fbdev drivers.
> 
> IMHO this patch doesn't make much sense.
> The PCI regions (e.g. for x86) are already requested one level higher 
> and are being kept reserved.
> This patch here only touches the SPARC code inside a path which is e.g. 
> being used everytime the machine wakes up from sleep (does sparc even 
> suspends?). So, instead here, I think (if you want to make this robust) 
> the region should be reserved e.g. in cyberpro_common_probe(), but I'm 
> not sure if this is even worth the effort....?
> 
> Helge

Hi Helge,

Thanks for the explanation.

That makes sense. I was following the fbdev TODO item to request memory
regions, but I agree that reserving and releasing the region in
cyberpro_pci_enable_mmio() isn't the right lifetime if the function can
be called multiple times.

I'll take a closer look at whether the reservation belongs in
cyberpro_common_probe(). If not, I'll drop this patch.

Thanks,
Chintan

