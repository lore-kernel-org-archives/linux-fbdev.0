Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692348;
	b=ns8Ht/mrk2dfs1foZ8pfkcFLYjoyYhyK//DdPVw7xXT3JtTeoe3EmgChNU5VAue89039
	 +MSpnC+n1Z35+tmk3w0mf1+VTLtCLZ5UdS2eCL/DgKsbQJHzSB2aMvKR0Vwn+8+iO3q/w
	 IHZ/cUqZe2b5NzFz0p2Va03bwHJf4KYW3+24BAgnHBp20t10oJlpolhRF6k3dOLTvbVC1
	 XjZaRvq8OrRM0jm8Q1E17GpD3sEnGoUSv6v0bCPxKvIrvFik2O2VnOI2WSKFLICd0UEc2
	 wRVkdcRtDMS+fZZNGAvvzaDh7sYYuJ3BbmwekaG9GVP/cyhc53jo/pKyH8XfZG9ezyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6R7CNAZpahPnRPALzexY2OH6fEkMajMjI2gkDqsBlDU=;
	b=PjAe5+3EOg0H00WJfo8FotRSwIwaVLRF0pONzhOTbXBC2uDsRbYSNprVGMoClq3a+4m5
	 hOJP7yZirRw03ed4PsWmjLFEbeo1+jBDzdQ+sF5lI50797lP314nJGdDcuquL+SA77tzK
	 UmlIcpajH227qKt3TjX/dYexwweUIn60qG2EFaFUpO3fflZeaKYPurv8d9dRnYZUEVJ60
	 V4WJ7kSiVwhMGcf+alj3xwRHmRYMLzIe3xg7Bez5RwBCJYEBwCnZo5U9mVDVFXaITWXOu
	 rDfsnuDdIgSfTEE0gVKvBVG4K88uhndH1mNMRgNkeNKp4xS47LqFFeEvOdtJvikR1/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwFFhm2t;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808C606A32C
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Nov 2026 07:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4808C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwFFhm2t
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a210470b49so30244055e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2026 23:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793692346; x=1794297146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6R7CNAZpahPnRPALzexY2OH6fEkMajMjI2gkDqsBlDU=;
        b=jwFFhm2tuc1+z5jLnk8sYRGl0PF0y6/Ww1TdQrFosY/eeNTOr0xylurNbVeVQLNlZv
         2CZu1AuVJjMeshKnvR6pMhS9fGTwvqZdnEbDID7huggt7Txf27tIREa0kZIJ6KbvPXyD
         I/+GUlkENCStsCbpiDiekWaOA00Dfz4TgKC7KHzjsdPAycZ9fMIJNkao+YHjzSTAH+PU
         +3gPOww4J5ryq6pbu4zJwbp22ZnGrrE4NursYmlPurU6VQIF12FJModxPj9Q4Y+ohyOe
         puhN+lDJptO1YJBC9+qc3iDZ/1/5lK40wJz1wHBHQgTDaOpE5SOJZtoUR9po9K1bOva9
         83PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793692346; x=1794297146;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6R7CNAZpahPnRPALzexY2OH6fEkMajMjI2gkDqsBlDU=;
        b=pHaIWMeMZq2PBdK7ulHf/sfgCqqE1TSCFFl0u1dVxpg7STxf80RaSKgKrhTKfyyAwK
         NlnLt3TYBCL4J8CkI4R/lTEYWzzkJ5beCbzHnBF8ljKQhF0fY8t9O9ghsdmLodl4ZrMt
         D0udoXtNSmKKUnvis+SNVzOgwS+HfpPnXEKJDsvSbi8f7RTVUVV5WaI0xDTn86V7JX01
         KPuY1oS2mTAxv3lCtrqm8xpiJPi9KxsXfGobM1ZkSr8C4wfr8JsivbSelmBpq84WrR0p
         htk5+JKVxAnum3IZYq9UO6Is/gyxNipeSJjHLgED98yvFg8/weUyd+UqYxbD62k1/ZD3
         WF0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwT0LDxAAcVRNSQIfJQLtYEMwjX9m64FatFBF5A/d9G3B/Q5Nkh65AgXRYf9Md0xPdUzJp3bMVDgwk4Fg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9HVCgaCgdSve2Mbes4hg/yGPfKidPC3NbGiZElnz3DaF6OJpJH
	cKXHda5odu3ucYcmNm94FnCbRK4gg2G6nGZPQvJOVE9GuhlFuUbeAErP
X-Gm-Gg: AYBFou1e3+MnWJoPs/MPOHoQ7cW3pTQF64A1m07zU2xooSOCq/fzKhwxMsl7NANsW3z
	94z+86EYwrVMqtJDtUKCQFucGnOTRSwDLzeUjwkO20cNHzixnR97SfuHadRW0FqZsGZ6Pnsc4to
	vPSB0gJ/Ht8Ss36+fwaMNAOri5P7Cam7cUjteddyabHkM9Q/R1uV2+MIYepUvqolEliLe3jjzJ6
	/zf2d9c6KtlGxO4sd8lc82TMiPC9O9qyGuOvMtzmZtUrmX+1iXP9uM1g/m5HX+T8wxVvTt08nBC
	E7xzipAILLIhNwIpAIUM8guT3LzDQb3o2T1IlADwuhKvNsywdt/5Q+1Wb9RnxC4lTxXoxDgpTVV
	zo2mSlDPq9C6uLXLQGV2iHabGsoPIzr4w+q/+wG2uIt983U8jKEGKS8WS+fhX53elAlShYp0AfK
	DsNy8gzp2dYMu6GzH+/wLXwpzdMcNdDioeqwNoCfrWxAob9Yu3EsDIGpxt4RguR8Y8zCCdq9wyG
	43fV08jrHcH5hiX6FAxUaVBmr4kQ9FQKqJzZY9h//8qLgigQDz+m06W7UNwtbnHNpzrDHzlDArT
	aOVwhp9tEkNOsp/qOYn5G65H2Cb/rDEA34IX2j4ViNsc2LYFdIO8+Qqj1ycdCRWa/fbZutGWjkL
	+9WNRU7BLjUkkSnc6GVOvTMYhyRs/h+bY01pTrqJqDKqpVtMQrPt53YicJot0aCIL3pLGwbQkb6
	Cy8Z/FESON9jQ=
X-Received: by 2002:a05:600c:4e49:b0:4a4:6fdb:cc42 with SMTP id 5b1f17b1804b1-4ac17b2c38bmr299232835e9.11.1793692346478;
        Mon, 02 Nov 2026 23:52:26 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa953d35sm37915295e9.9.2026.11.02.23.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:52:25 -0800 (PST)
Date: Tue, 3 Nov 2026 10:52:22 +0300
From: Dan Carpenter <error27@gmail.com>
To: Eric LI <eric.lee0305@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix space prohibited before that close
 parenthesis
Message-ID: <aumStg3EuhPbWkZu@stanley.mountain>
References: <20261031042315.1122699-1-eric.lee0305@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031042315.1122699-1-eric.lee0305@gmail.com>

I'm going to Ack this patch.  The other patches to silence this warning
introduced weird no-op macros but I feel like this patch does the right
thing.

Reviewed-by: Dan Carpenter <error27@gmail.com>

I don't really care if the patch gets merged or not, but in your heart
you will know that I approved it and hopefully that counts for
something.  :P

regards,
dan carpenter

