Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E77326ACD
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jul 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666109; cv=none; b=iHWiKDlMyDEuTjDddKoJMbGD3S/YzPvjfpPCj0wZ+Q7QA50h2lPtkThJTHRtDdahq2srwfaS/CP6aOxgQRpyjZ2addvYwcXrl0VCOMJZ/rqSwnyf5dmRavHB+U8E0eaGXIzMHC6C19P7Epq6n3dJsi/STfBB+kwc/l9CToJWJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666109; c=relaxed/simple;
	bh=ORvjTZVCF9j9K2/vk8qoyPbvmvm6veJVeNPI1Fl7gRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loeUf2VV4jMbihwnyEZWSTpyPOaGQ6LoEWy6W7ps4XcR0kVJ0CLl9LmMUDxtfhR9xVLVSdPS77W3/Dcju/bQrGdKWdoUUI98JOrnZgLa4Hv2KEV4ekYsTpsMJQTTyFmawwGuNeuPNPQaJbR/xSobAP0dTkEH3pGfZ4u9wp5LFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYOcolVh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYOcolVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721666105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSNEaNP8H5/eGVQlrv1O3IQGVc24IW6Ik8uTzGK8y9g=;
	b=FYOcolVhcMd7wHLzYE3b3dvLrGP/H9ihIBrJ3LiunorIJD5mxYPgphMCxFq2ak5rVynuOB
	PX06eM+9ehdCMAUo3xT7+EQG5JOtz8GB2S7IpZftMl6+i2DmACA2Z2FDAc8uB2NiOwCF2+
	gaNUqRvm+UBOXolV0IkZAAHNwSQwD6o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-4a7n5K1VMruvU38BxAMMaw-1; Mon, 22 Jul 2024 12:34:36 -0400
X-MC-Unique: 4a7n5K1VMruvU38BxAMMaw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4266d0183feso36988705e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Jul 2024 09:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721666074; x=1722270874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSNEaNP8H5/eGVQlrv1O3IQGVc24IW6Ik8uTzGK8y9g=;
        b=UiR5lEOKUsOdwS8PUm4FbMmM+SkzJESAP/dkrjVKnVm50bcb0alt8kbl57AMbcWr09
         e18cHW8p4d3GsQQmoB8/hEboC+azufcWCCGX4Un9zvX9UWdFrXCovQ35vXB1Eaiz0D59
         4d83NA24rO++zb/iBkavRfoFxy5QvF9ShiFlI5LDRlZP4H+Cz2oegRvtahnOv46AYSVC
         6JfuJQ+048Hsd1cACsZm0+QY8Nq9W/jw+QD4Bi1Lg0Mcbswz+LEqiXPBO1OGsT5r10l+
         lLh8llfDcJYImOQQlBlLOoiqKGq3eA03Vfrulw6UhwA3Thx714r8k0M4WepCr0GmLWi/
         HobA==
X-Forwarded-Encrypted: i=1; AJvYcCW/9e5DUwOcn/6WhDu/2sUHt+5q7HUqimI7AAnvSAPDmUouTkBoq8ZhiiOCmKZiALLnoW928B0Hu21aUtieYFJTumSKt4Tgbe/llDQ=
X-Gm-Message-State: AOJu0YwKjryhV+wLx+EmrWiectFnM4rSxCStPr8eNKPAi6HxfMYHm8Hh
	GVqCxhQd0OBXehsRve85fh1F+lryVCt+NN+7u3WhSZD+Ly8sXGhrS2azXtReeL6K4ieZzZexcYi
	8RG8uOlpSgTbYkMfPNkmCxkDIBymE9VwnQawunNdJHcPc9F5+t1y5k603DuSr
X-Received: by 2002:a05:600c:4f0c:b0:426:5f8f:51a4 with SMTP id 5b1f17b1804b1-427daa2815cmr43742985e9.12.1721666073744;
        Mon, 22 Jul 2024 09:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+OrtOq9aqUKQAvqLUlUdGwmwjBvw3l7GhLZRB22QgBwpQRPohFHgOIA2Kt7hUWTLziSUvXQ==
X-Received: by 2002:a05:600c:4f0c:b0:426:5f8f:51a4 with SMTP id 5b1f17b1804b1-427daa2815cmr43742815e9.12.1721666073319;
        Mon, 22 Jul 2024 09:34:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:d3ea:62cf:3052:fac6? ([2a01:e0a:d5:a000:d3ea:62cf:3052:fac6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6900caasm132996285e9.11.2024.07.22.09.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 09:34:32 -0700 (PDT)
Message-ID: <db3609fb-9ebc-42b2-a080-26462a8a491f@redhat.com>
Date: Mon, 22 Jul 2024 18:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: Use oops_in_progress instead of panic_cpu
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: lkp@intel.com, Daniel Vetter <daniel@ffwll.ch>,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, oe-kbuild-all@lists.linux.dev
References: <202407210203.2ISiIC9m-lkp@intel.com>
 <20240722114800.174558-1-jfalempe@redhat.com>
 <Zp5pl4kcu9q6FWTP@phenom.ffwll.local>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <Zp5pl4kcu9q6FWTP@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/07/2024 16:15, Daniel Vetter wrote:
> On Mon, Jul 22, 2024 at 01:47:51PM +0200, Jocelyn Falempe wrote:
>> Panic_cpu is not exported, so it can't be used if fbcon is used as
>> a module. Use oops_in_progress in this case, but non-fatal oops won't
>> be printed.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202407210203.2ISiIC9m-lkp@intel.com/
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Yeah it's not great but gets the job done.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I pushed it to drm-misc-next.

Thanks a lot.

> 
> Cheers, Sima
> 
>> ---
>>   drivers/video/fbdev/core/fbcon.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>> index 498d9c07df80..2e093535884b 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -64,6 +64,8 @@
>>   #include <linux/console.h>
>>   #include <linux/string.h>
>>   #include <linux/kd.h>
>> +#include <linux/panic.h>
>> +#include <linux/printk.h>
>>   #include <linux/slab.h>
>>   #include <linux/fb.h>
>>   #include <linux/fbcon.h>
>> @@ -272,7 +274,14 @@ static int fbcon_get_rotate(struct fb_info *info)
>>   
>>   static bool fbcon_skip_panic(struct fb_info *info)
>>   {
>> +/* panic_cpu is not exported, and can't be used if built as module. Use
>> + * oops_in_progress instead, but non-fatal oops won't be printed.
>> + */
>> +#if defined(MODULE)
>> +	return (info->skip_panic && unlikely(oops_in_progress));
>> +#else
>>   	return (info->skip_panic && unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID));
>> +#endif
>>   }
>>   
>>   static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
>>
>> base-commit: 7e33fc2ff6754b5ff39b11297f713cd0841d9962
>> -- 
>> 2.45.2
>>
> 

