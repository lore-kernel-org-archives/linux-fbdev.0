Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEDF134AB
	for <linux-fbdev@vger.kernel.org>; Wed, 20 Mar 2024 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710911303; cv=none; b=TWX+ab56LGmPbBlCv7LL1HrKrzBd2MDzhnPfVKw2rKGt4mrCjGZtyv8gJWA2XUIGtnKlCfzZ6+ADSoGx9FAWcepobLbHbWdDQNXBSKGRUp6wnmgAxILnFv0qYgEx698YKYRzXdZIfkE1iyp3IKaLxjhrYtfRf6De0RhGqnJN0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710911303; c=relaxed/simple;
	bh=A1dK1FDTClBBeiIDvehBrkcgKHtbJHgy2lmHel3n8Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVTOCW3KkJPt6yMEXURlsQwijrJj2D17UDyRZH7TqE+BNTc/605/lPeJO0732OWE90eQX55Tjw/ti6dBH0CKxdPqrBbc2aN3sDqXbd5CM4wtchARNGu0oMZ5sI2TDoOQ5eQW5t/0X8LUHXpbg5fyGo2CmbpkNyF7An/ZbccpSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DuLHqj6W; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuLHqj6W"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso96496351fa.3
        for <linux-fbdev@vger.kernel.org>; Tue, 19 Mar 2024 22:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710911299; x=1711516099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDbezmp48NlomGRK//vO3jPNjuF0l+ROTMlkX7vEssc=;
        b=DuLHqj6W1YbmyNs1g15iazEbCojzBV07d6eorjVbB/ca8Oc+Ju8bQj65li77j/8VKu
         TrFotgday53zih+GRo0bq5746Y18XKfT9GEmD+pdu0yDsZtvNE0kFNsOXJwC1Osx16kL
         FS3oVZbYuOuPtAq52ljQff4SHpA0QyYW7VnJtDR9aE3jnDuPBBeB0PK/hy15hZY00zzB
         k449PxsDSXW2WYwgAUQlWo5USKzinkUB2UXqv1n3bCWfWcPu9nVX6lXAvlgOryqStodX
         PecJ3cn0A//6c2inmfc309ng70/57weJoOqRl6tUqXW7q4Fj8r4+N7PJ6+JaVz9qyY5g
         lsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710911299; x=1711516099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDbezmp48NlomGRK//vO3jPNjuF0l+ROTMlkX7vEssc=;
        b=Sa80Sziag3NyxKXcO3lSOWQB9qZkOe2KuxwSRG6C6njQHlsfLcNNVT1r+Sz0Cyj/C/
         +/5EMNMIdUifHhuIZWesbjBrkxgJuLSwzMHNlLo+yFUbMawccN9/03jYmftjoeEkMzTX
         RwtXrWRpY6TbnzdpdbgI9vIJ29RG+5fRPrTIkzcmC+uokF+7ZwflR4Fr1/il/V+9/y6E
         zn62sww2gusHQ4R6kVdwvRbMVWJUI6KS0ANv7s3iYMfxnTD8TkjLnsezv1/M2uWRAwHE
         bKdDwwN1uC95i7x3u0YLJU0nAdQhfmZDKbOqInxTIBmcNaluMceumnLqoKFxBdN3eOHP
         1uOA==
X-Forwarded-Encrypted: i=1; AJvYcCV7x7qZTkeD5eHMrT5u03BS0bM+moQdF8gCJgugypnm8CxDu0IGdbP3F30oWqAcLV5Vm76mGBRW/7a7IS2U4WbaTn9D+sPUgpJah60=
X-Gm-Message-State: AOJu0YyDJScdFFYFmORVTPdMNHqFilxbvX6BnYH6UZRZLEBT4pqtjatS
	8gsjFAw76016/Hw8KuyC73l1k3B5XTkzSgS4Se/+3vA6OLx4nP5onrgKu009i1Q=
X-Google-Smtp-Source: AGHT+IFHREE/lnhx8SjTOBAgPbDyrtU66YBCV4semN7SKN8NIdNLbGqeziR344GPCdUdj1AZEkyvFQ==
X-Received: by 2002:a2e:a724:0:b0:2d5:9703:263c with SMTP id s36-20020a2ea724000000b002d59703263cmr2766745lje.4.1710911299145;
        Tue, 19 Mar 2024 22:08:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c4f0d00b0041409d4841dsm912164wmq.33.2024.03.19.22.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 22:08:18 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:08:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: sm750fb: Replace comparisons with NULL and 0
Message-ID: <c4a5e9e8-214a-4ac0-b8ee-01a9e7a1e5f9@moroto.mountain>
References: <20240319181735.366565-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319181735.366565-1-chandrapratap3519@gmail.com>

On Tue, Mar 19, 2024 at 11:47:35PM +0530, Chandra Pratap wrote:
> Replace '(foo != NULL)' with '(foo)' and 'x != 0'
> with 'x' to adhere to the coding standards.
> 

In your commit message use "opt" and "*opt" instead of "foo" and "x".

Removing the != NULL is fine, but the *opt != 0 should be changed to
(*opt != '\0').  There are times where comparing against zero helps
readability.  I wrote a blog about this, but I had forgotten the case
with the NUL terminator...

https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/

regards,
dan carpenter

