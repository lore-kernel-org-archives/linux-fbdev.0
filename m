Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE522C190
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753845; cv=none; b=re3NEmYeTLWCb4leRl4vfE8v2NQUW0H8Z6RMCutDEAT3yRcTWPwGkMxFtSdTbvjBpszJw3OXilDnGpldWBblY+5r5xyLXuuKumkZ6PLZkZArs5gjcc8DUlDdlNfrPQ59hac6/4mzpBcsBuAVLZQ0/5hVqbk29txlnxy6JsfQvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753845; c=relaxed/simple;
	bh=HXeG6B2ZIkpjqfiEX0Oj79UwA1A5T2aAgs8tbYybwuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvI76ZS5oQLoq2dvf8CIcHU3Aro1bFiqB0DHZRhylfNWI2Y0/a8zHBbCCKf0gvFGCWxF642xXNlJpQVQ7EdqWhZrdkfI9CnWO8Yi8POGYcXSR7mxSNItCzwJCa/0WWOFikSZU60tGufGGcDCBaQkS1sqlJOgREgcgFei800nEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVNYeG/N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVNYeG/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710753842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/N8QI1fD+bgjmIz5nIr2cRdeL0rDB9RnDP3ak0Rbm4Y=;
	b=jVNYeG/NCdQaPJH2Zob6YGdits5mpKtCK3Y8FX3GeuqdcPMQ+cwEopvqTbnUFEfgR1VhW1
	cTZYOIp2HnUcnlsnCkhu8ZqSBRazcWdoDl6GGIrHDn95OcVQP9+hnOK1jphvipmynqkF0K
	4RPoQ0tI4w21S1vmGx3fFm8lehp284E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-XNGxsDp3O2mOtnNdV83pGg-1; Mon, 18 Mar 2024 05:24:00 -0400
X-MC-Unique: XNGxsDp3O2mOtnNdV83pGg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-513b3ca9650so3417266e87.2
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 02:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753839; x=1711358639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/N8QI1fD+bgjmIz5nIr2cRdeL0rDB9RnDP3ak0Rbm4Y=;
        b=g5faV/ms1hUnEliONYCnYF289OX8f8WVX7z3JjnL4Pvgqva8DlHZcee1WNVC3XuExu
         k2voFhfIg8uodLwt2VbBNDKKvEOc3lcYITqIkBIBhKTGRbiiRCIdsiiShoxLJFF7uB4F
         KLUx+3ktkd+fcc1a0MMcvJGuThhA+Q5h5mFBgKpStpgqqWGh7q8FbEU/ezENSjW7dlLx
         mBTUuoxLWlwr3+KZphaDLBLa4LkDqf1+O4dg37yPXD+Q5nIIZbpWzdwkEez9Zx8/voiO
         y2NVOG8sDA0Q6r6G/EK8kdinCyYLegFDvIY9Fn+txi3fvmupS490zGqtodIEWdg/WiEq
         z/Rg==
X-Gm-Message-State: AOJu0YxlF7NXr444lYnTPDql7pqZa8AdMyIR5aF91/8qIleCbnJ8FYmp
	9tH1dCEDHSM+ObB1e3NcDCtbFv0JhwiWxjLnIwDuG4vPIwIoc6JuGrQJT5PuiyVyXGu6NQ0uSDc
	enD9kPfNpEn87fHvptzfD17bXLMdDwUScEik4TM3w9Aia2Z2vOSQP0GzwqsW3
X-Received: by 2002:ac2:5b5e:0:b0:513:d1cd:b902 with SMTP id i30-20020ac25b5e000000b00513d1cdb902mr7025550lfp.32.1710753839198;
        Mon, 18 Mar 2024 02:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkd8Us4BsgSEBSOtJqvIraSi5b4WjtSpS7BNTLWU2+C3Ui6W+LGv0gz1InPWlQ6qJvrN+wzw==
X-Received: by 2002:ac2:5b5e:0:b0:513:d1cd:b902 with SMTP id i30-20020ac25b5e000000b00513d1cdb902mr7025539lfp.32.1710753838871;
        Mon, 18 Mar 2024 02:23:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c19c600b0041413546e5bsm1270407wmq.0.2024.03.18.02.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:23:58 -0700 (PDT)
Message-ID: <20d4da39-8dbc-4593-87b8-308c75c0fa82@redhat.com>
Date: Mon, 18 Mar 2024 10:23:57 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/43] drm/mgag200: Use fbdev-shmem
Content-Language: en-US, fr
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-13-tzimmermann@suse.de>
 <b35f1b2f-82c1-4c7e-a449-54e29000cfb6@redhat.com>
 <1fb62a54-ee77-46bf-9d38-dcc0ceb37533@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <1fb62a54-ee77-46bf-9d38-dcc0ceb37533@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/03/2024 08:56, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.03.24 um 15:03 schrieb Jocelyn Falempe:
>> Hi,
>>
>> Thanks, it looks good to me.
>>
>> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Thanks. Do you still have access to that broken realtime system? I 
> wonder if this patch makes a difference, as there's now one large 
> memcpy() less.

Hi,

Sure, I'll do some latency tests if I can get access to that server again.

Best regards,

> 
> Best regards
> Thomas
> 

