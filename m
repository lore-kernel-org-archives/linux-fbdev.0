Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12863502B3
	for <linux-fbdev@vger.kernel.org>; Mon, 16 Mar 2026 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646935; cv=none; b=TDiPtE3PbwnshHAsnaF9lScociWrSlWu6/QWZ32S6wP2W0c9m7hI1AZRWtb4XvjNNijKhqtZm2t+w0rj8jRv3JVUcWwACkfmPFXkEbDW5z0BXUCAM5aNiFGzUZ3CcwvDAbPbweZ71WR04R17gk8gCbMgw3ppzQhAlAn/qDcTwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646935; c=relaxed/simple;
	bh=FaAc+B1nYPdrCyBNRnJEU7eDYxSk4ST+r0OhJnpbQyc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YW0tQ0Y6hrOSODUE9nQNfi1O8SHMO7jhugMDEzfwq77bYvcli3cpG/T3rxQmsNcTNo50bmfOJxtOng6DWLd3fgpdZSgN8uhdJkDxMEhpihaocWqDFc/u+Qr1xwFSHYTFiYnT9MEVhNgCqFvFf5oVM/0nFGbJ27wCOWvAqBUH5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MURoxvI6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MURoxvI6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so37614495e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 16 Mar 2026 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773646932; x=1774251732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfdA3fJWYtAoxokNTDaNIvgn8hvi0R/oaJDnwwTowl4=;
        b=MURoxvI6DeUQVFScIr5NQMyGQAueneKB2rkrWxlqiiHgwCGEd60492AB5pryo+a38g
         tVXSoovIfyTjGedMgcfnPw/xtrTr0gAAZB3jGAv5ZvGwoKk6Xs4ZfWWRARFf8CPPDfsM
         +bAFA0eN7JJsZna2VbnaUhvVga9tbFk1X4STVo11acv8lr1Qugf1uAeJN50pHfbE99oo
         3AzDXurHZxIf8uKQ4u4AfYoGiVlWC5qLzqfWuDw7Wtv+6j4SZrjrd5fN10of9QD9UtE4
         fZVGcsR5Ch73L4rq46/kzoIaKvtLh7z6+EF91NRHP/pmBAlqGoVwDZ2+YCwirjrLz2nT
         NF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773646932; x=1774251732;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfdA3fJWYtAoxokNTDaNIvgn8hvi0R/oaJDnwwTowl4=;
        b=P8VDPEKcdTFmYubz2apciEPbVny3CULp4DXzrAwo8S7ssgdlqc59Lq79OHvu1hJTJ9
         KH3DUMBrjuf1xJmRS+3T0QjNHtmhjNt7SlPUYRRE2C/ngZj4cW7AoAQ7FM6a8I0Negv/
         CbXC76bNLSh7srq32JZl6GGi7S/OFIDSetjTJ3a3WebrQ0U1SOEKl9Mytb0rS1YRLDrw
         mKSUzDS96k9hpWCDpBIVgSS1yLlv0taYomo/Je0eo7bH8GyBL3vIuLmzph6ecbGQiWuD
         sMZB5qDcZ1f7AkghL158B7/Cs7yCx/6pIpaxCTRJ0WFo8dKtC+TGDZg1qWMuXQPYT4s4
         zqvA==
X-Forwarded-Encrypted: i=1; AJvYcCU9etNdjGHS1ESR2NAr23tSDsoNRLm1Va+d2LuS3bLU5wDryee2rKiZABjuIIpWBEAQLoRXEay0nXWSkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo08ZXTQyvpK/4TKWQEblFQ3s6+UXKxLKTLBhciHLy9dkMLVzC
	lHW9uvkoUS4gmS1JqsD/PA6y+IfdTyGJ+B4lbAyxIZBX9oYynhCJu3Bt
X-Gm-Gg: ATEYQzwUvm9sOZlGXkOSGznSJ8AkKxCqvCqgLUYzDaMv3XfO2dt5OCjrCZUPhC72tKm
	6nCkwhPHEQUpjJmnIMxMfGOVQFLPg3u4ugYgoGe7PdHbpyhKA3jFG3TUWFj7JA7r6GN1eTTOAzJ
	fDcB8KOLfa9jeDYuVEpZ6+j1Y5ZOCMFH7U8ax/eVHdXnl2t5KYPYRoZXBwP1aycV8OpcN1IFom/
	P+X+fI5tdbiPrmlYVpcgG770zXW3DM5p/iymrqwgqVsWFbnGfRDl8kD6MsCO9OEuThAjTD7ZGPX
	eJGvisWCAhXI9qTmTirzwcv4A0C3xV3tAhTyz7H78AXEX+rqT7ZJjWxyKgqKEpZkhhy/T+DjO9x
	QfWiLI5uZVQu+38/3z201DzY5JqL/6f6tXfWAl4IezDvAqHJnbm/yjkzDf70WG7KWm2VwnggEGt
	i3dANAfT7z83GBVKjrPkWlZvoQaZEh
X-Received: by 2002:a05:600c:3106:b0:485:3ae3:b394 with SMTP id 5b1f17b1804b1-48556711ec9mr223828535e9.31.1773646931869;
        Mon, 16 Mar 2026 00:42:11 -0700 (PDT)
Received: from [172.18.0.1] ([95.179.249.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ad1e4esm500719945e9.8.2026.03.16.00.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 00:42:10 -0700 (PDT)
From: OaroraEtimis <oaroraetimis@gmail.com>
X-Google-Original-From: OaroraEtimis <OaroraEtimis@gmail.com>
Message-ID: <495a2eb6-619e-4ad8-b550-678f7334819e@gmail.com>
Date: Mon, 16 Mar 2026 15:42:04 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 1/2] staging: sm750fb: Replace busy-wait loop with
 udelay()
Content-Language: en-US
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260315232042.231620-1-OaroraEtimis@gmail.com>
 <2026031626-semisoft-attic-8b37@gregkh>
In-Reply-To: <2026031626-semisoft-attic-8b37@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

Thanks for the review. Sorry for dropping the historical comment in v2. 
My only goal was to fix the -Wunused-but-set-variable warning and 
prevent the loop from being optimized away by the compiler.

I will definitely restore the comment.


On Mon, Mar 16, 2026 at 14:11, Greg KH wrote:

 > How is "2" the same as this busy loop?

It was a rough estimation. A 600-iteration empty loop on older CPUs 
(~500MHz) took about 2 to 3 microseconds.


 > And why not fix this properly, as the comment states?

The comment suggests writing to VGA ports (0x3ce/0x3cf) to force a 
delay. I didn't implement this because I don't have the specific 
hardware or datasheets to test it.

I was afraid that introducing direct VGA I/O just to fix a compiler 
warning might cause unexpected hardware regressions *or compatibility 
issues across different platforms.*

Given that I can't test hardware I/O, how would you prefer I handle this 
in v3?

1. Keep the original loop but add cpu_relax() inside to prevent compiler 
optimization. (Safest for the hardware)
2. Use udelay(2) (or ndelay) and restore the historical comment.
3. Migrate the driver to the standard i2c-algo-bit framework (a much 
heavier refactoring).

I'd appreciate your guidance on the best path forward for this staging 
driver.

Thanks,
Oarora
