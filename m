Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB930CD9F;
	Fri, 29 Aug 2025 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756442372; cv=none; b=V4488zoD88oUVTAfG5Jq42GgFlAAnmMThXuKAUQ0t56pSL9LaKARV7dd/VuBR7QCdu8Z7pFn11zOr7osjJ2gYiVPMi3TferDdEq0iOEVYS097bwVMPN/jGbC5k6pGh16iijuFwxgJCCbRjDjRGLB3OI7wo7ChePAjmdfDd1Hsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756442372; c=relaxed/simple;
	bh=HmCUTmclUH+l14uLFBEDWRsTY0aJH86oSyDvSLARr8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgGxjIQBw7g4ZUIYRsrhOiSF074z1iallYRijlCb1xbMF0jPZhmY4MO1OB0eobUnUjju2OrPXditb4QUFoUM1YNhKETuqiOMyS6Fuvca2KrnFUKRWLcJ7IR+Zoic8VMIjT0lZtpQIn7Iq2TfdOvf3iY5hUL9rnsuvFBPI3iikcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0R5OEAD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0R5OEAD"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so278068b3a.1;
        Thu, 28 Aug 2025 21:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756442370; x=1757047170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMG2hjYDplEAn5LWv3MpjvQ+a5gZ6WKPCO72/I7KThc=;
        b=c0R5OEAD2P7RHDfYDYZrJ+mdMHxWWEK6Gg89IE0BgpBXBf8NMx+EpJKqXBDady0OZA
         UySerriIsurKWJj0ZC+7Ru7QUOM+EbfeX6jnnbTd/1ELzicza65gvtKihD9eG+fWk8H4
         hwYmVIvNlechBUd15FX100Qsjb2/KbEM21tH2hWxJ0/r+mKSvJVmsi34UwOSDBXoYYWk
         4PiJQRVjyKXN50eaDU6WlpHAxqOcI5/9c7eBdb74CaTBvGI/wDt65ExGq8oM/7kpx/is
         eVtcg9zVR3w42/pCt+g7rnTkPWVLbKYx/MLcwNwF6RRr89huF9BMGx6pPmXe5Rf6iyZv
         g7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756442370; x=1757047170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMG2hjYDplEAn5LWv3MpjvQ+a5gZ6WKPCO72/I7KThc=;
        b=OaTgCWfyTzXHADZl49GX+7VXljRqlR/7cBFTUtETb4EFycUiHfgrkXnLHSv8uGiMUy
         zyyp2jtOO/15Fy4t9AYaIzk4v/h5O0gloRHhTVMnenr4JJljcsPrlvEDa7jd//nrQNKZ
         a0HojyY6EDjdGkoEpXgPEUj8CbAMS9T7mdaOGC8nNnWl2aaBGpWbS4Lm/Ja5xAkQVp9B
         tF2cK2bkMSCs+0dEMVhqUPwkZnx5q0DkXApoO24SyfVfBcLjEEygo+azis3xxxiGYR9V
         rUbnWBl7QUcTiMCw+eAM1cWxy2UYuEhBgB4G5hEhb5g5vz2527n6fhXxq1wGKZ27FzqE
         ZAjg==
X-Forwarded-Encrypted: i=1; AJvYcCVV8O32oh+HFmq+qJpYQxZ+NHzhXIpDYmJUyoH6x1zesqBzusI+35p6JPLLxIzy8+epd8far+v0/xkvdg==@vger.kernel.org, AJvYcCXLxM19a3UAgurRwLbiOViGYJW8ueGtdk1fMUQT7jEP77yWTwJanTdkfsRhrC0qnpVbWTHQjNdqCxuAC+BI@vger.kernel.org, AJvYcCXa66D4ix0UJyWglc4qtMP9o0B6vN883Itw7AhN/FC4ehyexNRhKRYXYQR3gb8q3k9ICe9F5KtES2Vxl58Ne8NQ@vger.kernel.org
X-Gm-Message-State: AOJu0YznHONCGcNvdjiu1U4Z9LHQIiL9cMJW0I4lBgMiIqjO1Hxr0/NK
	QCvlCViWxAy+5zOIRQxtrvKQY5b1s7Wyb5Enw1ovzjJgyD/MbkrcYOAn
X-Gm-Gg: ASbGncvDiWyTtjn/eG1CgMRWB3k7zL+TMSn5BUY/1arBuTh0aFRCMB+t2N5IPBEe25f
	/1r8JBtY1rB3iNIn2kHHwI7/DZ0j6pU9N08jd/1ycJqbc1h9nI3BKTFdQqJcuS2Qr3qI7PbQulx
	9KqUq+kpmv3VPxYafjV/HWrjb36VNICd5GGNBuG37raHTH+wl549662qKrducrCiX+UCwy99AcO
	yTEZnrBGBkbU62aB0zdqE3bX6ns1QZrRZXw1dviNp+/WF7doFSvF2d+SpHcgA+T6RZAdtvWCJYX
	ErxwSqn0TjuG/YhqED9hZgkMPJHH/MZCHQ9kuscHPTaGSw/k7v3/x/46XYUQuXdhLG1hT6j1tjg
	IvacHZRAGhvmku6lXrZcSJ/IL7Cuk9cHrgD9iJxDyUJTCv+w=
X-Google-Smtp-Source: AGHT+IGJUc7Yk+JHWAKY9iaRV2EhpE+ow/DVQcP8YQgFsIIxjRV2hvCIR3RWEDtRtL041w/+SYnwCQ==
X-Received: by 2002:a05:6a00:bd92:b0:76b:f7af:c47d with SMTP id d2e1a72fcca58-7702f9df039mr32683745b3a.4.1756442369806;
        Thu, 28 Aug 2025 21:39:29 -0700 (PDT)
Received: from [127.0.0.1] ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a4e5sm1070875b3a.19.2025.08.28.21.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 21:39:29 -0700 (PDT)
Message-ID: <58e87116-a8af-4c8f-b5b4-3d0540cd3333@gmail.com>
Date: Fri, 29 Aug 2025 12:39:14 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] crash_core: use panic_try_start() in crash_kexec()
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yury Norov <yury.norov@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Shixiong Ou <oushixiong@kylinos.cn>, Zsolt Kajtar <soci@c64.rulez.org>,
 Ingo Molnar <mingo@kernel.org>, Nam Cao <namcao@linutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Joel Granados <joel.granados@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Sohil Mehta <sohil.mehta@intel.com>, Feng Tang
 <feng.tang@linux.alibaba.com>, Sravan Kumar Gundu
 <sravankumarlpu@gmail.com>, Douglas Anderson <dianders@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Anna Schumaker <anna.schumaker@oracle.com>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Max Kellermann <max.kellermann@ionos.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, Tejun Heo <tj@kernel.org>,
 Luo Gengkun <luogengkun@huaweicloud.com>, Li Huafei <lihuafei1@huawei.com>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-4-wangjinchao600@gmail.com>
 <aLEQy-srX89Rndch@debian.debian.local>
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <aLEQy-srX89Rndch@debian.debian.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/25 10:30, Qianqiang Liu wrote:
> On Mon, Aug 25, 2025 at 10:29:31AM +0800, Jinchao Wang wrote:
>> crash_kexec() had its own code to exclude parallel execution by setting
>> panic_cpu. This is already handled by panic_try_start(). Switch to
>> panic_try_start() to remove the duplication and keep the logic consistent.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>> ---
>>   kernel/crash_core.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index a4ef79591eb2..bb38bbaf3a26 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
>>    */
>>   
>> +#include "linux/panic.h"
> 
> Can you change this line of code to #include <linux/panic.h>?
Yes, I will.
Thanks for the feedback.>
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>   
>>   #include <linux/buildid.h>
>> @@ -143,17 +144,7 @@ STACK_FRAME_NON_STANDARD(__crash_kexec);
>>   
>>   __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>>   {
>> -	int old_cpu, this_cpu;
>> -
>> -	/*
>> -	 * Only one CPU is allowed to execute the crash_kexec() code as with
>> -	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
>> -	 * may stop each other.  To exclude them, we use panic_cpu here too.
>> -	 */
>> -	old_cpu = PANIC_CPU_INVALID;
>> -	this_cpu = raw_smp_processor_id();
>> -
>> -	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
>> +	if (panic_try_start()) {
>>   		/* This is the 1st CPU which comes here, so go ahead. */
>>   		__crash_kexec(regs);
>>   
>> @@ -161,7 +152,7 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>>   		 * Reset panic_cpu to allow another panic()/crash_kexec()
>>   		 * call.
>>   		 */
>> -		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
>> +		panic_reset();
>>   	}
>>   }
>>   
>> -- 
>> 2.43.0
> 


-- 
Best regards,
Jinchao
