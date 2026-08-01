Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D2212F89
	for <linux-fbdev@vger.kernel.org>; Sat,  1 Aug 2026 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607925; cv=none; b=V1OOH+Sou3HBjTJJ6tv50ZRziyISWCQkl2zfLwy+SbMtlfeoQdq6cUcGBylWoYVnlX/9lvlAcPdXE5g+bdPUR6O7crKXqTBPWu0TyUN9uq2q7PRsNraZpF4FjtWMZ1UDkYwky4ULMnyzTk29tb7gnLZUM+mfn2bvoFkHM9YOflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607925; c=relaxed/simple;
	bh=hD/EMiZZTXqKgxjrDpfBRRAJ1kAx9ywWk+DQrs1OG88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+BcXKFcGbowSZPiwQIItKyEIjEbz0vvtoT6671t3oyK9UjQlncnikQa8WwGfIxFreYCtzgywRQPNxSGmVsmRzyVEUsBu8pC1u8/Rgivyt/RKF8e5hf/qju+Nb8FD0zsbaNg628HD4v4CnX5hsmJ9niE4UxO8d1Y07eVdVZkM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsJ1Mlt4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sA1vCC2s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsJ1Mlt4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sA1vCC2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785607923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuTNiFWTTsXb3gAvFi53MKk8btbhasMaATEQzE79DwE=;
	b=VsJ1Mlt45tmQM6mNKZAcHo/isWyA56noSToIFFAiEhX7/3knzuMXgfDhAbr3VPqzppvp/c
	/zZSF9Y/HB768a4BcH9+ERJBZpUCuvWagHC856JY6oFfcTTY37oNrcxKvU9VdoV6rlITBt
	ldYKhAWnGlr1KnLrsEDLGhVYAlJLsPg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-mMQDW2DwMlmx6pylDNdKcw-1; Sat, 01 Aug 2026 14:12:01 -0400
X-MC-Unique: mMQDW2DwMlmx6pylDNdKcw-1
X-Mimecast-MFC-AGG-ID: mMQDW2DwMlmx6pylDNdKcw_1785607921
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso5390135e9.0
        for <linux-fbdev@vger.kernel.org>; Sat, 01 Aug 2026 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785607921; x=1786212721; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuTNiFWTTsXb3gAvFi53MKk8btbhasMaATEQzE79DwE=;
        b=sA1vCC2sJmT0ew0CfXEtF+3jGOZLXxTRYX5RGg49g+5wRIWrwEjsFZTNGp4urfTyrO
         6rHOOThguVzq/Hp36oRA/e5ZS7tQdGhXTYwL5HlnhX7Ylyyo/615kvOwDyGh3hRLr84a
         URTyA8o/+N6RmyQomvtCWQ/EY7BEn/mpBmn2pnWysT1RZZpMU7FlCsa27OhFVVcnTHih
         ypZYvBIhLlpFpbHhV94VZfHxt5BxwYToEj/+uX7ovnEysXZat9binM7TUntN5P1y4Udl
         dD/qb6SodwnBHXMSZHWitVe/hvpJMv+yg10x6PqIDJM6ZWf15uE3NsJRtOTsvzmYrRaH
         OTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785607921; x=1786212721;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QuTNiFWTTsXb3gAvFi53MKk8btbhasMaATEQzE79DwE=;
        b=gQD7LQ6NaEcOkWgZBOjPPoCyMuwIXLwDz/Z6AqpaIat4+/DsiGWoCkebib7bHaksHC
         M40+vUP2hP39yQp0eq5gSi1iglLQu8SCLoKpTL9hWCujRLr73bAtDyJqRbRO5NYFIiog
         PvvsLf4oqbdt7xHUVl4EXYBlODnekL3vV91P29S86s5Jh4baGOQP1UUbWDm6ZUONy8dC
         XL7qU8la62gfKdvJC5xSx/ygqdESxSP19oBCfXPu1TTsLEw0mp4Mx4oDlMwmDB5gTKMS
         jnfYZlbe6A9c59pZRuwBk7NF5/JMp9MIicxAO2TAAehKB9HDBj0JNnSTVaKJrWiMDQls
         19OQ==
X-Gm-Message-State: AOJu0Yz91l/hD7GivyUa+gIQyCCAljm3yw41M1JKXkvNDxqhjR7LBTZq
	+UMIn0FRBhCjT2Dzlwc688mCcaNHFtThSFboq45AdUSDiuIEbrcRijI0ZVCCPlPY7UHAEaYiyrn
	bS/cTdyGOf90NaF0eW7BHjZz6IlHxCZXhjvRCNSMqYr4aZ6L4xeTHuPeF80GkWQ6M
X-Gm-Gg: AR+sD10xvcgL+x4FihobSlxc0aMriOfok0LLmaRkQvleqWAlDLDrQx4rgen/MOGsbjL
	9FIkwck48TvRv5+wrmcwakm5XtRiQu/ArUKKTedD0/1S+vf4q9jk/rQgFvCTJNxfeA3tm24kB/N
	vge8Ma/2Th6GKjoadTI8Bo6wtZda3r4txiWM9YY448lL1AfpWKTorltctYrXsh7NrFKggHlBY3K
	U7eVKp5rEqlV3pEtUQah/slFb7vwgEpJrQkeQBKu86/vajQeClm2Nq6rOtImupTBxoQpDFKmKMa
	ycqwrZhuEPqG4UjfIclOqlgjIL9vYNQAwIwenK89dH0Bi3HwlnlxF6za6JkEQXvU/MVjAhwHnCp
	j0JWcJThM+76Q3UdwHWJPvygIRjhO9JXiBxYWnQ5Sm/3QKMsrWpsZLnEvRgA=
X-Received: by 2002:a05:600c:840f:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-4980c60705amr64842375e9.0.1785607920491;
        Sat, 01 Aug 2026 11:12:00 -0700 (PDT)
X-Received: by 2002:a05:600c:840f:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-4980c60705amr64841705e9.0.1785607919932;
        Sat, 01 Aug 2026 11:11:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dcb4sm117791635e9.13.2026.08.01.11.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 11:11:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Helge Deller <deller@gmx.de>, Jakub Turek <jakub.turek@elsta.tech>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fbdev: ssd1307fb: add support for Sino Wealth
 SH1107 controller
In-Reply-To: <a90747ae-e2c0-4add-9fff-1ff473d1b410@gmx.de>
References: <20260731-feat-sh1107-v2-0-0d2893e44ebd@elsta.tech>
 <20260731-feat-sh1107-v2-1-0d2893e44ebd@elsta.tech>
 <a90747ae-e2c0-4add-9fff-1ff473d1b410@gmx.de>
Date: Sat, 01 Aug 2026 20:11:57 +0200
Message-ID: <87y0epd82a.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Helge Deller <deller@gmx.de> writes:

Hello Helge,

> On 7/31/26 16:45, Jakub Turek wrote:
>> The SH1107 display controller is very similar to SSD1307 but the main
>> difference is that SH1107 has different memory layout and uses page mode
>> adressation only.
>> 
>> The SH1107 relies primarily on vertical page addressing mode where the
>> internal 128x128 GDDRAM is split into 16 vertical pages, rather than
>> the horizontal/tile addressing modes natively utilized by the
>> SSD1306/SSD1307.
>> 
>> Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>
>> ---
>>   drivers/video/fbdev/ssd1307fb.c | 87 +++++++++++++++++++++++++++++++++++------
>>   1 file changed, 76 insertions(+), 11 deletions(-)
> series applied.
>

Why did you apply the series? I mentioned in v1 that Jakub instead should
use the KMS ssd130x driver that already support variants that use page
addressing, such as the SH1106 (adding SSH1107 should be trivial).

Also, Sashiko correctly pointed out that the fbdev driver doesn't support
most of the properties mentioned in the DT binding schema.

Now is the opposite given that you merged the DT binding patch. The ssd130x
driver doesn't have support for the "sinowealth,sh1107" compatible string
that is being added by patch 2/2.

I guess that should post a patch to delete the ssd1307fb, to make clear that
shouldn't be used anymore since we have a KMS driver that has better support.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

