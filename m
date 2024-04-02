Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A676026A
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Apr 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055833; cv=none; b=j2WSwAo9edNLzBs2vcTcE2tvD4KZw70Va4Go8FjC+3L0pEl6ur7kA6HEKFp4UGBKRqmToHwoKMv25ksxEMHpwYufJnxWiIU76pqapkv5a67YqOqxSueWxwftDgCIXwugGl8JTvePC/oA4ETt/a0j7hMealKAF5pZWg2u9ZbxMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055833; c=relaxed/simple;
	bh=pkXDCtAWQf5f4/vhlPOEJz9BIk+NlDOJWtNC7X7Jx58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1S7ce+/9XLDAOp119DV9b2QPSPUfMAGCrdzawS2HZa8AYWLULpC2uhqnY43RO7l1uvFG3aSRbjuyf4emxtMI0mpQRQ6yy/tVcdQTev9aFfLGyFWSKf0Sxk9zwWzrxXv+amyR7mf3hLlnCETbOdxUp4k02YEvTVzCM+E7YGGeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ss2lZzPR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ss2lZzPR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4161d73d876so1812155e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Apr 2024 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055830; x=1712660630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkXDCtAWQf5f4/vhlPOEJz9BIk+NlDOJWtNC7X7Jx58=;
        b=Ss2lZzPRZLa43eDZdwqZCT2+WzmP1/LkjDXFjGTemmXm2nGhjlscvaJPpasAYFFtG6
         FA6hkw1lH0qdHIakNBm2tJDOX6mFToKGFtQ9WOGNJnQE4MX3npM1GgQmJti9vKJB2Ovq
         QHzqCtZkDxEwAanCoeFr1LlTAqRzOv1KSZCyUuRMqtdyd/PbUysOaCEFL85nqUAtRCbt
         8JePERyQwIEVh91s+5MPFuo+2y/dUzXsn9PvVjP65oYPXCipSc4koCkoR1ku49z1lKGB
         yfaZ+EUCfTTXmcU4n5SQxTI4g+IvSWFVoCGjfstEMlbyV3l48CaA8RZBQkyIt0/++0sT
         IXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055830; x=1712660630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkXDCtAWQf5f4/vhlPOEJz9BIk+NlDOJWtNC7X7Jx58=;
        b=CXdwueIpZdlEAzdDbfcuo+bqUk9ksRDN3BPLppAMzJaxvKmymJ/fsPgRDrrHxI1Pdo
         AEI4qIbY5ycoH0tt6WGCbv0n8+dIUVZKFr21ujz0P4AsBF/6AxTW/7ZHn86o48IVK+Pq
         rdaTzl/vyvvPe4PQR8kkXRBVd+E105lYY7bjx5ofESsfa8oUf1i+SulxDBIxhEw78/tl
         umaGk9HaAw6L1inceWhMdhxEVJMPW4FwzW8zkH97Z5zhY6g3Ws5THbSxy/mRMWzY3yvb
         0k8COaV96KYndcIX98p0zM0wWJBx4eSzNqeKZ4RPTeDW6qm8YVcr0UTCPejMoXWkMVWx
         uTeA==
X-Forwarded-Encrypted: i=1; AJvYcCVt7ytyFywO53Dm3Hn9KqScpQWBjV5P3YHfyDadwykdBf8LCz35B3plQBhhOfoqPPjM5ht011WsrnEa9MckSg0Ljt/yUq5goqC5dDY=
X-Gm-Message-State: AOJu0YxGyn1HaleA8Rso0zGBieM7FyEAaqQIlfH9WykKkeo7c6lt2z4h
	ezCtG6KkKEAFPbzh1NMvGWtp6AHJ5qw1rksuZRtP31o8oMzcXJ6m98aEYO4K4mA=
X-Google-Smtp-Source: AGHT+IEufhh5jSbZqDrpUvGWVHbbF5VFV6RhofXz9rzUdYYsBctfugfPGPViWxk05N45/wOGrEewjw==
X-Received: by 2002:a05:600c:4753:b0:414:7bd1:4060 with SMTP id w19-20020a05600c475300b004147bd14060mr8803238wmo.2.1712055829600;
        Tue, 02 Apr 2024 04:03:49 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c3b0400b004161b8a0310sm1466450wms.1.2024.04.02.04.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:03:49 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:03:47 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: backlight: otm3225a: drop driver owner assignment
Message-ID: <20240402110347.GB25200@aspen.lan>
References: <20240327174714.519577-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327174714.519577-1-krzysztof.kozlowski@linaro.org>

On Wed, Mar 27, 2024 at 06:47:14PM +0100, Krzysztof Kozlowski wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
