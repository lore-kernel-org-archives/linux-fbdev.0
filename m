Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0E33ADAF
	for <linux-fbdev@vger.kernel.org>; Mon, 25 May 2026 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731980; cv=none; b=iXze07ux/yOyd71FBefRsiZuGfaCM7wNApe90q5w1pvn7uin9XAFnwXxz3OZqK1XXDYFbCBSMcHe0rfWK36CvRtZ75wxEe7cIhJhtVA2GD49XFXtxTe6hfBTr4qsw5PleyzLPKjyXKRTbWAUf8eRSll1UHIF+nfeRKZ81UYmTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731980; c=relaxed/simple;
	bh=S/xqFbtjDgfEvzk1IBW4diLflB5UVwH5c+jheCwIM9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1NDV0+iFglJnDtzXMIWV7jhu4A8UgTQKQdKQUrviSlEIaH1QbG1kxafXmcTKOdnFv92ENoZhqRp/ujuFasygmQInZVZaZYDPpHE6UZZITJwWkMq/Z12IkjoH4H6W3tSOj5kZ14IMsu+L2zn/rGwzp63y8SiM/hIYYJLWfClCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFqNEEz5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFqNEEz5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49050bfe053so26463295e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 25 May 2026 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779731978; x=1780336778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3GG8UhS31v7SJSxB8IIgM3kHMRCXi6lEwoONMAg/rE=;
        b=pFqNEEz5xm5lxiuorW0g8JyexTMgCgHFLvcY3oq0w2zWFO1BoHhcNUGSwXaPNh0N/o
         kp6CE2BTBMm7k71lQjUDjIfXHH2ma3kW/82MNNN15x24uR5tn/jjYjnW4P2BdUzoYlAg
         ULQ3yXajg+tSJzdsENMWTJsoUkjORlyNhICEHbgfdMZ2xlIyR7Av/McoOiyUy8b26MNx
         3HZnBLhi9xB+DZKLxZsVXrUzqG7V7oPwV5rotKiNvkPV3eFSIFpEYAZDVCzw8nC9trEq
         oGkY7/DAav4AlEwV9aGwWkRj/Kg3V1cGO/6tRzCIH+7RQLaBpvpxcxUuFnOhBDOFnlLv
         Xp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779731978; x=1780336778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3GG8UhS31v7SJSxB8IIgM3kHMRCXi6lEwoONMAg/rE=;
        b=nqrbRsFC1IluVs2mM4RuOI1Zh9PVwtnxnwJZPYks4SA/YRfHCKrefuEiBHcPJcppus
         QVh/uo8bX7agttHmYUIZ9tM/2Eyd3WaIdVUV0jB9Lq9RvSjxcQA8iL5JEaTNuJm5GeQW
         vandfLvalilAgIHsPe2Mw3zbzQ/Y4R6w2W7iqrwx6ma0/kF3ZzLrcnHvXA6e3FVJ/085
         byQik5oMOF4JwiDY7Tapg1SDeb5agnFwqYeXo61keWD/5+8L4Izpdx6L5WLlQ1f7/VHm
         4Fa5b7QHNK5hAGfUMqdOSnGunDksX6+QEeRiPC2NXzdIQnzrQ/txxqkn/2MmGW27iO5h
         /sOA==
X-Forwarded-Encrypted: i=1; AFNElJ/pCWHIUhOpf6UeM4Ypch79GzpGuBxJMQlNhn9zQLkw/q+gQmP47geIB6+27+0plxbu5lB6/pkoy5qieg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PAD+CIdYFP0ZdVJPaYJg/Ir0DFByO5IQ++9eCi8WO9F2JUr5
	GCLJaIyXc9p2Vg/ox8CqeWUBmkZ7UkmKyTCM3edoWZN7klq2ILHDgzed
X-Gm-Gg: Acq92OFdutFQpOo3W6uapfj2ZxmQna0zT712pQ4jgshMsYM/E51Q0Ag0ApsTmQZ7rCB
	qln/wVlgZiCZJsCCvSuhANOrWchIyPaV9MEVyZlXKHHi9katLlromFqfctmUBr8rqxqjAaqskij
	7K85ruOM20l0ADzMpcP5dwdMCJTj6WN8TeDji38wwrV3T/TexKzExU06/fwCSB2URQ88OrqqfZW
	vA/qq+o5pS5Q+sOsdZcDNQPkdNTj44ZaS5fNjN8MWLafJNwjrJUkBRszJ/qh3tQJgdLSC0hdf4K
	XCGgIFhMoN2M1JEwA9HcuPSfASxiIKIw2Ub4hmxXFCPqSbRLIWDcoTji9rUD4HXOHsCdm2aRYID
	ucKkL4PVwm+Dh0byWmkqBSFriFAQdp935fhrYefSEYUxKxuDYaTg5asBPN1bgJvXBWsErb0WYLe
	q1P7V0nMwCachRtYA7s3X7iqk=
X-Received: by 2002:a05:600c:821a:b0:490:5cd8:d21c with SMTP id 5b1f17b1804b1-4905cd8d437mr138639585e9.14.1779731977764;
        Mon, 25 May 2026 10:59:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527dbf3sm251200325e9.6.2026.05.25.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:59:37 -0700 (PDT)
Date: Mon, 25 May 2026 20:59:33 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: sm750fb: deduplicate fbinfo loop in
 suspend/resume
Message-ID: <ahSOBXtMU93GY7tL@stanley.mountain>
References: <20260523051509.166152-1-ahmet@sezginduran.net>
 <20260523051509.166152-6-ahmet@sezginduran.net>
 <ahQB8C1gTr7LF0FO@stanley.mountain>
 <86216e7d-7867-4041-892b-aafeb39781b8@sezginduran.net>
 <ahR1O_dF9XyVEmPo@stanley.mountain>
 <6a5de920-b246-4568-8c32-626a696c670a@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5de920-b246-4568-8c32-626a696c670a@sezginduran.net>

On Mon, May 25, 2026 at 07:31:33PM +0300, Ahmet Sezgin Duran wrote:
> On 5/25/26 7:13 PM, Dan Carpenter wrote:
> 
> > 
> > I thought you were going to to abandon the ARRAY_SIZE(cdb) in v2.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Which, I did:
> 
> (v2 link): https://lore.kernel.org/linux-staging/20260523153459.177488-1-ahmet@sezginduran.net/
> 

Ah, right.  Fair enough.

regards,
dan carpenter

