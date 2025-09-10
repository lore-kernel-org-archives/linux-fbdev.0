Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBF317707
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Sep 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502569; cv=none; b=PDpG6XgWVEvdlUpWVYDZpL75pcAs2N1LcoH+MeRi8vUhZrIvahr/XEUTZnqA0Gb/tesUG836XPN9UYE677+eelocNI5KUpGvYyTjHtc+09iumWfNBjB4x7MrsUiucMn62nfy9NBTxBo7oDJBbBsCtlsoJb4QSFe8pgOR2jYiyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502569; c=relaxed/simple;
	bh=BQ2XtYRwei+F/8LMUKBdKEm+z8pxUaNiGAkH40rNEKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aZvocAPfDXgTzJEaNUUtgARKlpQEKhzH/Fyo5fp+1Zeya+UCegMHuH8B54YlE92ksoxPZ3+NBVXtUooNztUgNJueN3re7KxNPoDrA49hXdZzEMtEWM6HipiCckyQnyXQihVeLfZAs0kCfxfx7QuMGrzW7pn9OQHPmriqCQxHCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPrk7u7Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPrk7u7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757502566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEfKAAgF77B0N35cHlVCZR8H3qoPVBq2FQNy2mJIamk=;
	b=HPrk7u7ZaSZTh4jOKCdVu2CnJAdddbfTonlDn9pyM4WMafX7E5oEWXm8mqB6tzoMd7gyuO
	aMaN1cJ1xNMdsleooq3+qUUKACcPwc5fTaiGYcJ5FEbGVPplqOa/3tDv3sTlm5//S6SIiO
	9T17r9ff6wJ37rCrBAMoevDMWYWH74c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-gdrzmoAhPfi44bM0aX3GJg-1; Wed, 10 Sep 2025 07:09:24 -0400
X-MC-Unique: gdrzmoAhPfi44bM0aX3GJg-1
X-Mimecast-MFC-AGG-ID: gdrzmoAhPfi44bM0aX3GJg_1757502564
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3db4cfcc23eso3478130f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Sep 2025 04:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757502563; x=1758107363;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEfKAAgF77B0N35cHlVCZR8H3qoPVBq2FQNy2mJIamk=;
        b=VpZnOY4lRlvlu2UzNN5dD+mfPvYDhhmo5qxa/R0DhYUFnsQs2PbEGevbg/oZkHWxo5
         hXekLDoSp4mEC5koGm/bDbDEwDMe+g4jF28Dho7FURwotBSDxymuabYqMIAM0seexw5G
         5dqt/l73i94lTKQsJpwEAHwlcsOLMRX7kCeGsM4jRjikhbShM9q1h5gMkm9L4SURRo1j
         4/Me+T0neEgJVl7x/CEnYkUdHnQPmzyI5uEX3egiYmBrdLhNRijYSQ36CSQbFRyjF+S1
         Llyua7t4zrhddKWOPDuT8sGsdDFcOcWbCD+sUrN6YB2U5ZatUb1bj0TenudMCn1YRCsO
         jRvg==
X-Forwarded-Encrypted: i=1; AJvYcCXbEzT6DPBSriSdqZ6leUPjo/9E7bHf4lDo+0NM5up6HUn1fE2KCTvhfBfgjEKllpAQGawmNdYIVMnFZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJLsbfO346eW63R23aptKUcquE+XRh9fKP7IpTXpT1t8WrcYa
	4VUoo6uRIwXkxG3ngDRGfnntKKyXIwIu3FzrnMpJx76GanxEmpAH/mru5gXRvZ1vkKBztfLdnom
	inntFnDDx7/JvpnWEtG4ETHa7X7XlbaAJAQHIBKELA8VEpzKRcSHuybUH9pVr6tz7
X-Gm-Gg: ASbGncv78Bj8z6cs2NwoYDnMp+qQmhf7EmAxp1psBv8ur3hWEqoW5MjgC1/NHBznmhr
	OuIXF3Rp7ifr/IAQ3gh1nV+XZM+3jm4O67ieYrfD7J7zEhvhlSOo3fZB6XDYS981JlbrSUf4GMr
	r1DLHGaJflwmQYUuxrpUlzmvsDle9iMrKMYLrPNy9d1xmMKyhIHUlySmLajeq6NWWrT/qooSpHe
	Hj0UH+ie8SE4QRTStphcyx057CbQ9E7P8Ik5C1zvRy/LQRkuQQPnuqxtBrB1XPtrw/6QrHiRq3U
	ccJ+01UfYph9TK1RMkrK+03RV6pKWuD55EJosZRf3aywNrCMa36TkSioV9+zyGR0ILAwRO1xpNA
	KOo622DFltiW1bN/W+DdmjQ==
X-Received: by 2002:a05:6000:2889:b0:3e5:50:e044 with SMTP id ffacd0b85a97d-3e643555859mr13543081f8f.45.1757502563475;
        Wed, 10 Sep 2025 04:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtsE6TP99LwCM9DefOr4NgVBIR7vSn0IU371t63+HnR3UaFYs5LDu32sAvz1H1Dto10pgN1g==
X-Received: by 2002:a05:6000:2889:b0:3e5:50:e044 with SMTP id ffacd0b85a97d-3e643555859mr13543046f8f.45.1757502563021;
        Wed, 10 Sep 2025 04:09:23 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df1ba282dsm26332925e9.5.2025.09.10.04.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:09:22 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, Helge
 Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones
 <lee@kernel.org>, Murad Masimov <m.masimov@mt-integration.ru>, Yongzhen
 Zhang <zhangyongzhen@kylinos.cn>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/1] Revert "fbdev: Disable sysfb device registration
 when removing conflicting FBs"
In-Reply-To: <aMFYeV4UdD7NnrSC@karahi.gladserv.com>
References: <20250910095124.6213-3-bacs@librecast.net>
 <20250910095124.6213-5-bacs@librecast.net>
 <87frcuegb7.fsf@minerva.mail-host-address-is-not-set>
 <aMFYeV4UdD7NnrSC@karahi.gladserv.com>
Date: Wed, 10 Sep 2025 13:09:20 +0200
Message-ID: <87cy7yef8f.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brett A C Sheffield <bacs@librecast.net> writes:

> On 2025-09-10 12:46, Javier Martinez Canillas wrote:
>> Brett A C Sheffield <bacs@librecast.net> writes:
>> 
>> Hello Brett,
>> 
>> > This reverts commit 13d28e0c79cbf69fc6f145767af66905586c1249.
>> >
>> > Commit ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
>> > removing conflicting FBs") was backported to 5.15.y LTS. This causes a
>> > regression where all virtual consoles stop responding during boot at:
>> >
>> > "Populating /dev with existing devices through uevents ..."
>> >
>> > Reverting the commit fixes the regression.
>> >
>> > Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
>> > ---
>> 
>> In the other email you said:
>> 
>> > Newer stable kernels with this
>> > patch (6.1.y, 6.6.y, 6.12,y, 6.15.y, 6.16.y) and mainline are unaffected.
>> 
>> But are you proposing to revert the mentioned commit in mainline too
>> or just in the 5.15.y LTS tree ?
>
> Only the 5.15.y tree. Sorry - that could have been clearer.  There's no
> regression anywhere else. Mainline and other stable kernels are all ok.
>

That's what I thought but just wanted to confirm that was the case. Thanks!

> Cheers,
>
>
> Brett
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

