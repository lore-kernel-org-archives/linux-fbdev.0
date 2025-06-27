Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D11E0B91
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751048303; cv=none; b=GwMNLO/Q1/hATzofUUx1V+m+IGRoFAFJ6HGTF9AyK4n0w6Cv62ZFiZFGcQvkGPDzLody4w2jlBvu3VnpM5CzCHlfroW/JGyPX6QCm1jWLK9QHwmf8dNDC2FgRX7rzu3uXKQper90Gga61l111lHnwkKrLynOaL7qhBF2BBz3nD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751048303; c=relaxed/simple;
	bh=KnagyrEME31deL6Qm0/gI5QVFeXMRzRv0VC11XZU6DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdt6QWW//uEqCeHWw6p9pdOoInL4yqMDU/ADpJOHBzresC7BFpONozhHGm2cHEhG55LWHu5i//x0BEBlgYFG25sHw6E/mVnoje1bkJ8MIa/l6XEaADBpV94vKGb+zT9u0QXIerY/6qXWdNtaO4k08QlLwQe/MIxCcghd29Ikh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZqv1Fwg; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZqv1Fwg"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-40abe6f8f08so148453b6e.0
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751048300; x=1751653100; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RFQ6dvglvO57dmQMqJ9TjNqvSIg15aNiE+cHR4uuLHU=;
        b=yZqv1FwgSeK1w99BzolgPb+vZJkZydwvmvnymtRkbTT9AvbZrH154lHQ9yuWO1IdP8
         SZT7NWvSQPc049qFD3uTRp8KwbjMNXbM3bSCh3YXEHOVOGjA+R3jqeZv19pGsmFr8R7m
         QLjOqCepY0EizJ/2RWtVfPx3marJyGjLalZ2eEosQCuCzZaFg4SF6hjjTnKgoWafUY82
         j2surN/9PvgxFfjveOgnDgTjKQ/G30chNiaRk7BDxLT4zHs9NVygPmLnR/1r1OrSrosX
         4Tzs3GODdnxFCMUxcUHNNaqjCasaGSeRNNCsQdH92NMNfESRNdpyoLzl4HJZrYdmAWdo
         0ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751048300; x=1751653100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFQ6dvglvO57dmQMqJ9TjNqvSIg15aNiE+cHR4uuLHU=;
        b=VucCJqIlR6cfW6A9Tsd7qiVXICHoxIpefvcj5LrvAPDK6FdzMYDs6vIAEM/+hWxDgT
         BRyRPpwE5ToeOoXA7NfA0xGHhbDspXxShtZyoMrwnS3rlFevdTw34qtlQYCDBnFAAATz
         Pqc7cInGB7hIrdhCufg7FH0cgWGTQFZ1zipw1ia6SoU86jCROgG2uVvZ5UhWaFHgRPSw
         qv6uVLOTkTT3U9YGm999uqy+jKM+I68i3XoRUsktPcuUvEIhBKO+7znauF9zYHNH+OJ9
         mwPbIrTokf2AoQAQeTkkKNoIFBQ9FHH/4TZDfTLvSgZlC8XQTgVI7yeg/bV8xLvbs8Cc
         4SBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcQ3IlihbLJCTRNU4uTDMpl3X69FB0fwpTBFMMy3twvfSmbbRsydaEi7nTlcVAU7C1VxtggAmyH/mX0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLPOG4s3RKOQKT6hMeU1EKWJFiDEUjAnPFW+M7PZaGgAOXxtys
	c5AwXQm+qYmSBQysR55Li5I+5XUiTWXkH7Dslr7bIPPbg8+7JBinY21A07m/gJwGblY=
X-Gm-Gg: ASbGnctIwyaT48KMXG5aCk2HmOSfJT1mffMylekc3YJ2jXVe/5Z/vRdNj/Y4NsD6XVf
	B2wyQecmGCNcH6BWGzhezO3e1ZQVnJ9V9hBG7CjhAmy77lxe+4oZrTy5YgsTYZjocWzRH4K5teI
	Tvgt0+Bev4FANSWWjKiT2PmIXsIY0OnYpl+G21kk8P5PrhJV/pQv8ReYWAi9mYhODoqOiv+d3pb
	/TeU/Vq4kcPXpE/IOvtScVHZ0Bw6yeUZFKRuIE+CIms7AGurduWZsWhD8umc6BVkey6qSwuLYJT
	6/hnOFFEhBE8TUMdLvIzmzcwkKqlw7sqdliINYHkPK1m5nT0pYnNg4Ae8EwPt/m3FmItqw==
X-Google-Smtp-Source: AGHT+IGNlF1zWRk96uWanb6ceMhDRXk8o9BVkP04SNj4Cv73ZVCCKgq/Ftq8mRKK3WE38/WIleI/+Q==
X-Received: by 2002:a05:6808:1887:b0:406:72ad:bb6b with SMTP id 5614622812f47-40b33e7da1bmr3836758b6e.37.1751048300543;
        Fri, 27 Jun 2025 11:18:20 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:f3a4:7b11:3bf4:5d7b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322b5900sm456205b6e.18.2025.06.27.11.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:18:20 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:18:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Manish Kumar <manish1588@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode[] a read-only pointer
 array
Message-ID: <6059b2f6-4408-41db-8abc-a8a0f38db28e@suswa.mountain>
References: <20250627173120.7639-1-manish1588@gmail.com>
 <c8f5f917-8412-408d-9dd9-6635af8825a7@suswa.mountain>
 <CAAoxDjcYwV9JhRLGJ+opJLEU5j4RHYUt4XZ8E4R9DgF2VqZD8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAoxDjcYwV9JhRLGJ+opJLEU5j4RHYUt4XZ8E4R9DgF2VqZD8Q@mail.gmail.com>

On Fri, Jun 27, 2025 at 11:16:06PM +0530, Manish Kumar wrote:
> Hi Dan,
> 
> Thank you for the review and pointing out the issue. You're right —
> changing the array to `const` makes it unmodifiable, which breaks the
> assignment logic in the driver.
> 
> I've reverted the change and will look for another checkpatch warning to
> address for the next version of the patch.
> 

Awesome.  Thanks.

regards,
dan carpenter

