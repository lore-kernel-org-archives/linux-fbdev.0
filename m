Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8296E4689
	for <linux-fbdev@vger.kernel.org>; Sat,  4 May 2024 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714821491; cv=none; b=u3rrYey1WpXqVcWGtW8Vxkn8ewD1yaO1xdjQqn84e4NPE8daMRJDNqZEcX1wibZLCcyyx+Bjf8g5g9UoUJTQaTSkY2vfGOGwC/6gUJCnItrGYtyw/+abMv30i70r4JylA6NX/H8KjgsGOPuK+HCB0pGp5Mjq4VCFlH6TBiGTitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714821491; c=relaxed/simple;
	bh=smELU36PpAU3prIkce0be7IjpSNr4t5xDRxPzlw1+z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDDewyha8aWnpdEacbXBr6lmbtyvee9ACnvxuzayX0gCRX5Jv0mbDTU6yNbAdqrQAx59+rOVdcQMdUO4gKF2sQT27IYRBWaSi3v8xAEWs45k92PrpmNrCk+3MGmXpg6p5bQ1O2NNDkCYr9K4MvDZfiw0TdC50MCZoIMyH10rddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i1aTwC4N; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1aTwC4N"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e242b1dfd6so6085921fa.0
        for <linux-fbdev@vger.kernel.org>; Sat, 04 May 2024 04:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714821488; x=1715426288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yv9FzWOzBDzyrTcS40BSQArXvrw2k2j9CKdjQ6IcHqo=;
        b=i1aTwC4NEW3INdzcaNBVaLUCr6SdSrcrrvlIKuqGTwswEUDUB0w6G6n2TGMwp0RsBS
         bqj0RroFlXEq9ieRVn+8HIdc7x5wUoJw9fJZMpO3MJsJTscERmSk78nGnzXGO23oiK0M
         bvaMVmlPHhdJP81x5xKg4dLu3hYkdTTwI6lnm/okJ2Fvqm1OuoklHiMuEEMWPr2bnLdG
         jYJoqsXrQKDqoEcEkFC59LhbIqGIy+/+5NAkp0M/5aGwzPiX9+/3grjZrDQek5pvimmw
         30pt/FqjTW+xqExwaHo7dpuWZG9bCw/j6A/rTKb0LSr9Hk49qoU7iUB5xhoOGMl1U9Xa
         Z+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714821488; x=1715426288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yv9FzWOzBDzyrTcS40BSQArXvrw2k2j9CKdjQ6IcHqo=;
        b=aLfmYODRXAYbbF6cFU8LjVm8AsFyW9vxCAhSzf+Ep8pAnferIcGWXp7eGApzrX5Y8n
         ZThJflA11oFIlZrQKYY4aNgsyLyR8MQmtRxj5J0pSE5iOSlpYjm6KlVYcg3JbFYbRXhy
         7MLPltYnSdrHbDud3kTJMYYMxnKSzs8gD3lS80eb79vjwdb/zXQnhYpTgSKYh1n1Dpkq
         cG0spBer9UdtoF8UkWr7AZeZYy/YTR/W7x2GtWk6hSCZK7mEr3X9lZdujdzXChv1P1YP
         P1hatKGA+c8JMmtSN5rfoldPoL8StAFSARCkkIK41v0+VyBWU8lUgSGpqpOzXSVSQtgS
         T70A==
X-Forwarded-Encrypted: i=1; AJvYcCVmXxG7MHn4PU+97INqp+XXDb5ypl01Sss4fgATtirjLA08AFMiBIKh677tVN5N2HBIHiemYe7h5EWP3EVrsHdlmtlZ1pf2Kdm6wGY=
X-Gm-Message-State: AOJu0YzYqEo2kzMMtMxObrKVKOz6wf0GJwMalQAHXu9u+p1uMuXD+qwM
	dS/fW3ighK2ro4a63+q0+rZNZfPuISXpFEse9wD9KIgL4KG8kl/nC7oRLlPG928=
X-Google-Smtp-Source: AGHT+IEggVHErInNqsEkGN4lf9Fm25s9yd+oVBzpPNb90IQ2CCo7mKtWyU3ysBaUz2WYQTnosuIkqw==
X-Received: by 2002:a2e:9dd4:0:b0:2e2:2791:9842 with SMTP id x20-20020a2e9dd4000000b002e227919842mr3499876ljj.44.1714821487428;
        Sat, 04 May 2024 04:18:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id je8-20020a05600c1f8800b0041bf28aa11dsm8916105wmb.42.2024.05.04.04.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:18:07 -0700 (PDT)
Date: Sat, 4 May 2024 14:17:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ashok Kumar <ashokemailat@yahoo.com>
Cc: Julia Lawall <julia.lawall@inria.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"outreachy@lists.linux.dev" <outreachy@lists.linux.dev>
Subject: Re: [PATCH] staging: fb_tinylcd Alignment to open parenthesis
Message-ID: <45366e52-47e7-4e9d-a2a2-7eede9d3b450@moroto.mountain>
References: <ZjRDUO6/M+RDCcQJ.ref@c>
 <ZjRDUO6/M+RDCcQJ@c>
 <c8d24241-1763-f7b7-4491-2e5aa3ea3be@inria.fr>
 <1389558595.6771301.1714753224419@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1389558595.6771301.1714753224419@mail.yahoo.com>

On Fri, May 03, 2024 at 04:20:24PM +0000, Ashok Kumar wrote:
> 
> Is there a list of exceptions to the checkpatch information that we can ignore in general.
> 

For Greg's subsystems ignore the warning about extra parentheses.
You can search on lore for if a patch has been patch has been sent
before.  Otherwise ignore checkpatch if it tells you to do something
that makes the code less readable.

regards,
dan carpenter

