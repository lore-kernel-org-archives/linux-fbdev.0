Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39E489FBA
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394133; cv=none; b=JRj6netadAWjNP1no5N6DCv3Mlc0s/GfPEdUURlijvuE5DeubKkVBLieAdQ/8h3laZklxtLnaWbYQNPyXLvPAgxHjG5J6pDCjIauVZT43k8Icj7Q4A1EBcvMZcl7J9G9WbBmqthFU+hsrSd31CY+fF1seNGtLH2D8loSLBGL2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394133; c=relaxed/simple;
	bh=euPFOSxanSFPi2Zpw8qrz5T/8Lck+/AaQ85OLuB2GjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+Vvhe2n+m9M4wG+45DMZ08E5yKe7PXUQz8QAA4fWl+ynVFg/p9CAJsLB++68V04QXFnT+pVruylhYLcx/hDLXIslUXXc6kC5fIORkMS1lKk2r4MjiCT1ZOyavXyyRtbpZ1+vNKxiU+MLGzD2GcGIzevoUzWjpbjGi5jX+4iAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpPLG/AX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpPLG/AX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so18994405e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792394130; x=1792998930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lh/rfye6OYmPn+uBQKUoMnQVrTTMgM/f0x7DqQdwTJE=;
        b=fpPLG/AX6yoNyg5VCeqU4BWdJzCvxxyZiSyv0UawbPrST4yjFouWr7wmMVeHvdKISc
         25X4BPUVTVJhAgKASEeIhRo5u3kXpb0m7z4jUW72kqsIWQEwSBvkB1k6OPnhMuql874i
         MzctTMqOPeWLrjzws+BQ8C19M4r6uKGxmo5tk3d2u5OyT/eFqY6ijdZVNftl3vE+UysR
         /Rm830Vx4Fo8eMrn513vWdN5DdwRUrW0Veljxu5BGCzvrhE1c6SQqf+IgwOuJjsWaWkk
         tvLbDzxtJF5amMzq6UxfQkcPTsaLG0nn/2Gkj2lTObM5HoARt4z6II+ZgvRhaD6T8wTU
         klAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792394130; x=1792998930;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lh/rfye6OYmPn+uBQKUoMnQVrTTMgM/f0x7DqQdwTJE=;
        b=P5K1rXOIlcCK44YWJSbH5HOlwsFK3NvLMFl9qwZugvkw6E7licbBM5V3WjugxaaWws
         2oMXxcSy8/xHRNOQsxSUzPR+1DGyNDizYYpBBZmLj2dnuruO1fyYgzIOSg1wJ39tBX8x
         mR+NEvIGeMfcFq4TyZ1fFv8NQB4kBVamf8lPZx73WHiAIJQRkQYnnHXaec1CCUSUQhzh
         9/olwWuiePNpxPrggfs0fExsonjHjBpDFGL0wJOQy5+OgXFRZiPWkMup2XzgA3Qa9NXj
         QrzIrvio2jVkkD3SdXrytaeFO0PDYNiFbITqMh0SK6tFMX1Aed3/aTSkBqLPR+VBO/sU
         qPwg==
X-Forwarded-Encrypted: i=1; AKwUvBxAu/bE8EDAhsvnsk1HpvTvXr3fsO6P9kkJdO8J36JlcQBEllf7UxxDXnYgZAyKrpczXNejQB44b9bFOQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJnNV/lsB5qeJLEb/kr6T5cG6eLWH5PMf1Lsywo/pOPRcDX0Tc9
	xn08+JsNYU4UCm4JqWQpwfh4DMjb9xGzHwIPX+U04jkphTMAxs+Pq2d4nldEI4LbsNzZtvjj
X-Gm-Gg: AYBFou18+zlIaN8RfN1QjED0Bn0yK0JWecypVL0fzbTVmg59IM4rozzt4A83zV5YMWv
	OZvPygZSioH0h8NAY+GWNROA1Xehd0J7WoM7A+Za0IGkXF8ZUtPDsFKCh+jXtrQmF6X5L2OZirI
	7DAbZWCDaCoWxz2i99WREKCbuh6Qx8a+oLhLERoARO8CO75PCWzG1BG9LEU0UM0RFF2kwTRx/JY
	ZqX1g3ZJVaT1RuVQ/pAVUzEX2ANxMGY2+lH3gO6gkEBB0D98596BHCw/a+yp6faXdM5jqaDRTAw
	dzqhNQpqbLz6AJjlAyMjwnpuGdm3q8zTEn1hsLMzYWt++f1KPMVg/E29jAtTrl0lcjfzTin6uHD
	X/3ryxznl7PxQt5qTBe8K3D93g9dbQVbGOWy++vGbtXeCZ8/c3TNUb2pknj5/jWg16Q0yc3WzbC
	GzRNZhROnHliCaWlKWC9Bchq+7KaujfpVwbeT7XjCrk4+7H/iE1q/eEUdG6l2uZBm/W4o=
X-Received: by 2002:a05:600c:348f:b0:4a1:e774:370c with SMTP id 5b1f17b1804b1-4a1e7743940mr39926855e9.30.1792394129754;
        Mon, 19 Oct 2026 00:15:29 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cc642573sm208220875e9.2.2026.10.19.00.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:15:29 -0700 (PDT)
Date: Mon, 19 Oct 2026 10:15:25 +0300
From: Dan Carpenter <error27@gmail.com>
To: Comfort Oyewole <coyewole7@gmail.com>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, outreachy@lists.linux.dev,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: remove trailing semicolons from macro
 definitions
Message-ID: <atXDjUmhI38WQhaJ@stanley.mountain>
References: <atTnRr-JGIb9eLQR@ubuntu>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atTnRr-JGIb9eLQR@ubuntu>

On Sun, Oct 18, 2026 at 04:35:34PM +0100, Comfort Oyewole wrote:
> Remove trailing semicolons from macro definitions to allow the
> macros to be used where callers provide their own trailing semicolon
> 

This doesn't match what the patch does.  I'm surprised that this code
compiles with all the semi-colons removed, honestly.  :P

regards,
dan carpenter


