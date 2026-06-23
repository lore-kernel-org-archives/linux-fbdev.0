Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84382351C1E
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204627; cv=none; b=lEdGXZf3RUCjLKSS6C8l2zQ7oPgUls4MwBpQv4p/arsgfwCY2ltyK1UWNoal5caF5p2uKUzGBCfLnBIIgltLsdWP5xHikp7k8gg5gpU97NIBkRjXXRpn2jx+7JmMMtcIMnSYGF4ixGwPjRhHAFKpDff7PXfluVe253S0UQ26bHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204627; c=relaxed/simple;
	bh=TZ0+5146xwe6OT/CbQdW0d6uHCZxJf8UjdEd5HflsKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NpMOVh1fCcVYEiZEOAnPYyGrfJXWLI2P3HSZyCXg9mmWU0SrbEu1XlsgsS39/4lYZafPp5hgrsmdF5Ic6CYpuMgr+zv7oHpfaYtjKQafNlvNoIpOxMy3uPIXF9ryi7ezDI2Mi36ptET2EjHavBvIVaRDJgBSgdWBsSJIJsGxKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVS+Hz7U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFRKYZqf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVS+Hz7U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFRKYZqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782204625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BuoRitIZndRdwR/IA+zUZeOYUkqVtr5e2wU2WIH4U+g=;
	b=YVS+Hz7U8F9d9rj7BnA4z+BzVB+g0apBKbVVieZPywox+7O0SzCfGPZ9jfCxdTAVUZ5HL6
	nctU/nkmmPLS801t1bdx43e0OZxAtS1QDxPCU7c+XZ/pCOb6I8Y7L2W4n4SfKP6yUr/tTo
	N+D/Hny29EaK/IUq049Xflifyk0UJ2k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-gH-D00sFPjida6nAhwSuUw-1; Tue, 23 Jun 2026 04:50:24 -0400
X-MC-Unique: gH-D00sFPjida6nAhwSuUw-1
X-Mimecast-MFC-AGG-ID: gH-D00sFPjida6nAhwSuUw_1782204623
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4923411f041so43244585e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782204623; x=1782809423; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BuoRitIZndRdwR/IA+zUZeOYUkqVtr5e2wU2WIH4U+g=;
        b=eFRKYZqfEI4d2Ou1bhQqmi/QNCxjvMsJWN8mPBRzgAE+UqsoMXJj30zi3lY++wtvg8
         ZcaFoJuvUPR/7qck1mL4PuhmQkJ2Wpir85Oi19FVC/PHyxZztb51IvpePSN/jn7ajwFT
         5kOdmo3JYHKA7Dw8QA47JhZpwZAdXSNSq/6VE2ivTR3CwWCwcDJyc2eDCJJPY3NlSEjR
         u/I9RYcGDE+USlg5BXroQOqnyiMdZMozp0wp62IdGYh02oOstrrpERwwToe1hvziW2a6
         hz17mfmC1UDoOfYpARPyPty3Ak6v4hkCGn5GpnHmNcEDC5ZqP+fSrGIoLh/gG1agenQp
         wKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782204623; x=1782809423;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuoRitIZndRdwR/IA+zUZeOYUkqVtr5e2wU2WIH4U+g=;
        b=DhaLS8XWSB2TQv6yny/3rLpmg8a5V2Hpv4qJkWpdU9dJMbiZOMpw8KKbtvTUQzMYz6
         jn9QaRlr2mFT+q5Q/4l2gxSH4xkmFrdkSEnDoCywYajJ4aALl2AY0M6KJFEAbRyLdedy
         FvB/O/Q/6SsIPsbI3R7JBzV96odQPyn2ppG/crtQ1pZJNq6mrHCP+hf31g27utug4vIp
         BjB8x6VRzvaRDNRMda8Zb7uYUUDcd+yovkQTXG9vRSETlWrHtV01pqDirp6kVZgp7QWC
         cS5wytZxQBVDkcy/h6NHvDiIZhga2JXCZbkcr6Cu1ntd3fy0qdqPR5d29YCinOHw1lZJ
         d6LA==
X-Forwarded-Encrypted: i=1; AFNElJ92Riq1pZa8Rn75RO3/1BqLnIt6iGKHQ0fxNEiMX/7zO9nEBlwLCky0FaMSRron1G6a4AS3lr/vkm79SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAk8Mu9WEZn6V9akt6hfn5lI7IRpYUOdzPzZHPypKB3cofbOPq
	H5xOqWwQ22h/7PaYHAYrd4lOkvMtbhBQgWFGAMoSDMcIk6INTpU8mBCm9ASIa71e+LU6j7pVGab
	lWWGINovnxA2Gt9rhXN6ImHvOTyk8aJtf/PGReYwV8OQgUaIdo203tsDk6dc3ey0Z
X-Gm-Gg: AfdE7ck6tD30cmtYyg3IYQatZFi/mr/6WQD5/INbnYKAnluiQ4oQm4jodu80ALvC8wz
	/QLIORpVQQCLPIBHfo971BzZaL4b2ljX6em1yr6KpQIr1gfKJTxY2RJw0CKIMXn0aGzci7Ra4vM
	3YF77nmYgDGRQlU35cD/JRVIqDRx8rAZdhAGOGFH/3OfkhAdoSNTTfDABkUe7CkxrGqpiGXtZfy
	OMuQihI6Y9aTxOepVSrQYjskX49dFpEvBk42bMZkp3EJkpm94BbMFpDVN6nlXOb80zrtqME62/t
	JwS8B+9WQ2cQlpt4g95kXdEf1ohIAQ/+4aUBLPjYP4pOkfwnKRHnUr6YRCAgQljbJ8kzlweVCvg
	kFbw4ZPiNyldpI2WR5+MRMIcWeE1H2FjEeb/ERRdMpjfNoAoWL1REMzkXhmlV/RCjlTMKMA==
X-Received: by 2002:a05:600c:4503:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-4925b3896ffmr24629375e9.2.1782204623016;
        Tue, 23 Jun 2026 01:50:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4503:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-4925b3896ffmr24628745e9.2.1782204622485;
        Tue, 23 Jun 2026 01:50:22 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm389322615e9.14.2026.06.23.01.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:50:21 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Amit Barzilai
 <amit.barzilai22@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 gregkh@linuxfoundation.org, deller@gmx.de, azuddinadam@gmail.com,
 chintanlike@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/4] staging: fbtft: remove fb_ssd1351 driver
In-Reply-To: <ajpGy7K4eM8oJIfD@ashevche-desk.local>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
 <20260622152506.78627-5-amit.barzilai22@gmail.com>
 <ajpGy7K4eM8oJIfD@ashevche-desk.local>
Date: Tue, 23 Jun 2026 10:50:20 +0200
Message-ID: <87ik79iqsz.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@intel.com> writes:

> On Mon, Jun 22, 2026 at 06:25:06PM +0300, Amit Barzilai wrote:
>> The SSD1351 support was added to the ssd130x DRM driver. To avoid
>> confusion and irrelevant updates, the staging fb_ssd1351 driver is
>> removed.
>
> NAK, the fbtft has two drivers in one (SPI + parallel), plus as Maxime said,
> it has its own binding.
>

Yes, I agree that we don't want to delete the fbtft driver.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

