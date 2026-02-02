Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D92EA15C
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062506; cv=none; b=VoTq8eMSr981cXkm/CYUEhn4JYm1+Dn6cSJyAPgq/wkx2ewT35QyVz5wVH1iuuO8jZarMRouCAeh6B7ubLalaeoWcRU3sxT7c7w4NG21T+NIGPNCCA2S+MAHaq1uaIbSaIeeTXtt+WNtURNosi85IC7/Jkx1KsqW6BkKCjwnyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062506; c=relaxed/simple;
	bh=jNgUwMtK2RUmQMG3k47FK/HbS0lmCnI74aV7EWKk8EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTnhNdsW9GalaSnlEzgROn14WgK2JytsZZDOEHr+QiMV11Wpuqs011JQH+WxgYuP/GVz7ITq1rhHJZGu56vo1Lm4oIloh1/8bhAYvmTK83PuXgB/npN4hOxrhl7T9KBjQf1EAWDZlPXe+Z81HT7svshXnTfDkitIynZgU10kUKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AwZRDuGQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwZRDuGQ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so3409581f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Feb 2026 12:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770062503; x=1770667303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hGFAoXoGcmWys+uUjHRPMoq6GYRS4Iplih/Yjd1Z5o=;
        b=AwZRDuGQxjgtd0EejypW9eBFg+I172zVLyDdHnrWjwu2P6pr9HJLEv0crWNIwaA3Tw
         mQPB5zUygKHQXBpK/uWnpqMRi+lB6kGdSR4jdUr6odCjT7lnG/CugHKOGOkprjCCj0kP
         D/8kTU1geAy/iyRmALdl/BmQd2E/eZmOr05MrcfAvRdTa8gvd4xb/B1p8A6uhv9BSx67
         wDhf65U8yXojpH8KyhsYvofkpzi4wxbwCFxyVVK3mE/Ow3cV8W/2kSRZGPSDy5MRSfsb
         z8fMbor2oQRQvJZ6+RHQEGsuBV5XvSN2n6wKCE+bNQUTAtD3lXJIeDfy04qcAcG4H9ub
         09BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770062503; x=1770667303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hGFAoXoGcmWys+uUjHRPMoq6GYRS4Iplih/Yjd1Z5o=;
        b=vMdUaLpfsXOia+rajv1f9a95Prqm86LJUetYD6Ppyhrk/E0E3iolZJ9bUdIJTq5g1E
         3A9g3Chs2bBof/CpatGnm7F5j+GJmTk5GKtZLXsImVdC3YBP/2BJtZAlFK++kgTIu8GF
         xWY7UgrYMEH4jTjPE4AyZnpiU7JQHttreHufM6qMLXemKZds4PFrDv4MhQH2CRbZM8PU
         LmRWmXurh7yyaLHBUqNil/0YEFUt5yM22mo+r7kgRrg4HD0acmbuZlpbWQeA2hh70J2X
         ky8swkr0cGBeXNoJNMc0iBOGIJ0Gf09TFcQ/QEWos5t6bpcyv+LiS8N7SG+3Bq3PEd2S
         VgOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjyFTGq0yxGAXFJlxFiS4AwoRrKCskvlb3hi6i27UURoUaqLqnnvrcuTh3sn6L5WNQe2dFO/U3BRNlkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8AuG8Br9vkWKGKX36/PYFiCemmaTp0V2lcBEttddlA8Ezqa7u
	Zm5cuJjsWSQ8gebDRksJTl0cujAXeaP5YPtfJNgKzlOP4TS0Y54oaI3ixsRVy2p12ow=
X-Gm-Gg: AZuq6aK+daKTz8L6aW4twBXd0zzGKCNHg0emyNE31/W8b+//RcSebMp/W8lZI+zixj2
	sEPFBIE6OYP6W5H+/c+IYbc93RvL/nNeggXclKRIaaBs5SwGuKVmfMERi+mvLov3sVRLFXLsnY5
	XLe+qvKAN5Z5exq66EwIoJj0n2VGyLJMilItwdbhre+6qp4VfMN7GxHTUeDQeCQ9NBbqfZWOXrB
	0bhD/nvAHb+S9RC0FGdcNixvmnNKORfu1F5JyjxCajJ7PQariviPg1YMEUbH4j7k1tiwRTsC6JI
	1UMhpbImRukAx0YnsRMmSrqNOi6/QdmQEM/p26+akzep+lXdxrJsT05W18BQpZLuQ8uUXtiiJDt
	erELuVHoVOGbOrZIj9XSr1hei9welsdlzjpmDD3zpqQJbDdyyRqeR9la+v3OmbS/1hEQ8NRP98F
	RadaCl65EAldWd9c7B
X-Received: by 2002:a05:600c:c162:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-482db4ac5bamr160582205e9.15.1770062502857;
        Mon, 02 Feb 2026 12:01:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051287cfsm19591905e9.6.2026.02.02.12.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:01:42 -0800 (PST)
Date: Mon, 2 Feb 2026 23:01:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: KrishnaAgarwal1308 <krishnaworkemail1308@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix macro flow control warning and empty
 macro argument in fbtft-bus.c
Message-ID: <aYECoy7Apjwgzr9r@stanley.mountain>
References: <20260202162826.116739-1-krishnaworkemail1308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202162826.116739-1-krishnaworkemail1308@gmail.com>

On Mon, Feb 02, 2026 at 09:58:26PM +0530, KrishnaAgarwal1308 wrote:
> Fix checkpatch warning by adding identity modifier for define_fbtft_write_reg().
> No functional change.
> 

This commit does two things.  It introduces fbtft_identity()
and it flips the if (ret < 0) condition around to avoid the goto
inside a macro.  Only the first change is mentioned in the commit
message.

I have see the fbtft_identity() approach before and I don't like it.
https://lore.kernel.org/all/20250718191935.5918-2-abronzo@mac.com/
The name identity() doesn't mean anything.  It's a real word and
it has a meaning but it doesn't have a meaning which is at all
related to this code.

I think I would be okay with this the macro were called nop_endian()
or cpu_to_cpu_endian() or something.  Or another approach is to just
leave the code as-is.  Or maybe we could add a comment?

Regarding the flipped condition, the new code is badly formatted and
uglier than the original.  I would prefer to leave it as-is.

regards,
dan carpenter

