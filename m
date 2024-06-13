Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0113F449
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271661; cv=none; b=sJrCEb3FBHQqTQ5xfoCL2+TMX4HM7hJf/WiDL851SUrwS1dcfcx+jnskjVjMHIBRd0cmDYVXOPA9rgpr7aMS9BpqTqzq+7z6N3ag4D5Cfzqa+6+abdKcMAyhVXK6MseZL8DsGqFWJnBN9GVxKvNtvJhc8opF2ONJps3IbHAZ+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271661; c=relaxed/simple;
	bh=YOytXWDdRlPJmwzLwAtAe5shaIvMo+adYFsmo9/kEU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjIodc9/N6YzBeI4ye033avQa4pzX0lhZVVdKk/sfR5fh3BaqtcJ43Dz+R6z0ubgO3zS61BtZsN+YOK8WpMKo/ZKSqKB89PSIishiBdSeljy0FcUi//Fq4vtIvKhCmMn/IXphG2Do/CllwrJvIQb91vY6GOhWYyPZev27631qo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsApj3q1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsApj3q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718271659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEj+uvSIhUT8SfPd2YXpP7/2kVIVeHtDz27UcDHtNpg=;
	b=SsApj3q1l+XkX+qCRlVWZwhdAnsBQiFklP0RwntLpW4HcQtN5NI/e09y8MfS1PE1ZV0Iy3
	u7yFKbyp0zlUxdXD06y9CPy0S//oRd5Bac1Tnf5Ei0GLgozwe2E08rFrwNvB8fCnaTLveF
	ibBv0/+98+BI+w91dUMZJ00gnqrKQc4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-UvE8DP_hNcaa7u1tAY7k0w-1; Thu, 13 Jun 2024 05:40:53 -0400
X-MC-Unique: UvE8DP_hNcaa7u1tAY7k0w-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52c944cf9b5so622180e87.0
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 02:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718271652; x=1718876452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEj+uvSIhUT8SfPd2YXpP7/2kVIVeHtDz27UcDHtNpg=;
        b=PbyO1ong80eIq3DKNrJO/BYZh77WVEz9pjSYDzeaPirSxjrNLPsI6jSQbSurb87g4f
         SsGl8QqT5zu7FpjXYAmcB4NYBhh9vknwhV6OSfgw8MgqWAXC1CSW2pzt1RprG03QDsRx
         5FrMQoXwqLD9LPAJGAzUFzAuGOchwxXu3JmxOjc2wdRcSFKbAtvd6O+lV4Px8jU6dGA/
         sZkxDA6O25Al9vcEe/j2lUXY0wbrpXsi40v9O/mqirtUUDBV5ylL/lbQkWrc5eAy6op/
         c1BfIMxJocH/HkwVxP4gGl8fISCt3OLMbcXNhDA4H8yeMs7Q7xuCOBKNFrgJIV1ezlug
         LHIA==
X-Forwarded-Encrypted: i=1; AJvYcCVUZlXlvL82aUSBk8d33XzLumSForgbzhOCgi9zvMh4eMzJOKgagin8CxXmvNjdJS6NJ+oo1tTy5ZWyl6V700ziKj3riKXIAGJTlKo=
X-Gm-Message-State: AOJu0Yx1JNMzhIftsS1Juz5a4bAyJ8pj9mo84QaTqIGQ5D1mJj6GPzPW
	9z11gVf0C/mvy6TMeq3jLV3YsMbNY9VNaOUy4dQ3NKd4w0JPUxfxk6XpJftVPxzWFJIs9+P6cpx
	wdwFRrLyn6Sr0kIE2eYLGoPOByRZbU07Qjbfzm1gisx4a24Qx7absVTBVv5vu
X-Received: by 2002:a19:f70a:0:b0:52c:9877:c55a with SMTP id 2adb3069b0e04-52c9a405889mr2286584e87.67.1718271652195;
        Thu, 13 Jun 2024 02:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBNGP7iKfsAHm55vmVrBNGnMEfeibtOBQIkxEvrLJ1Nz6ilL4x+HTLkhZyBmXbxF6LpZ7juA==
X-Received: by 2002:a19:f70a:0:b0:52c:9877:c55a with SMTP id 2adb3069b0e04-52c9a405889mr2286571e87.67.1718271651756;
        Thu, 13 Jun 2024 02:40:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075c6fa4esm1034757f8f.67.2024.06.13.02.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 02:40:51 -0700 (PDT)
Message-ID: <cff14393-d702-4fcd-8a13-034692dc931e@redhat.com>
Date: Thu, 13 Jun 2024 11:40:50 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drm/panic: Fixes and graphical logo
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1718199918.git.geert+renesas@glider.be>
 <386a229b-6904-465d-b772-921f99815e8c@redhat.com>
 <CAMuHMdWy15T1JPH6w=xLyx_-zpHJA_VUe_Mu+h5zNPXEZw8+RQ@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CAMuHMdWy15T1JPH6w=xLyx_-zpHJA_VUe_Mu+h5zNPXEZw8+RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/06/2024 11:32, Geert Uytterhoeven wrote:
> Hi Jocelyn,
> 
> On Thu, Jun 13, 2024 at 10:38 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> On 12/06/2024 15:54, Geert Uytterhoeven wrote:
>>> If drm/panic is enabled, a user-friendly message is shown on screen when
>>> a kernel panic occurs, together with an ASCII art penguin logo.
>>> Of course we can do better ;-)
>>> Hence this patch series extends drm/panic to draw the monochrome
>>> graphical boot logo, when available, preceded by the customary fix.
>>
>> Thanks for your patch.
>>
>> I've tested it, and it works great.
> 
> Thank you!
> 
>> You need to rebase your series on top of drm-misc-next, because it
>> conflicts with a series I pushed last week:
>> https://patchwork.freedesktop.org/series/134286/
> 
> I had seen that you said you had pushed this to drm-misc-next[1]
> before I posted my series, but couldn't find the actual commits in
> drm-misc/for-linux-next, which is still at commit dfc1209ed5a3861c
> ("arm/komeda: Remove all CONFIG_DEBUG_FS conditional compilations",
> so I assumed you just forgot to push?
> However, the latest pull request[2] does include them, while linux-next
> does not.
> 
> Has the drm-misc git repo moved?

It moved to gitlab recently, the new url is
git@gitlab.freedesktop.org:drm/misc/kernel.git

and the drm_panic kmsg screen commit is there:

https://gitlab.freedesktop.org/drm/misc/kernel/-/commits/drm-misc-next?ref_type=heads


> 
> Thanks!
> 
> [1] https://lore.kernel.org/all/3649ff15-df2b-49ba-920f-c418355d79b5@redhat.com/
> [2] "[PULL] drm-misc-next"
>      https://lore.kernel.org/all/20240613-cicada-of-infinite-unity-0955ca@houat/
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

