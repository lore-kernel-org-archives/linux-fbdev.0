Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67F39C62F
	for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784971341; cv=none; b=LdDI2EYWXQ4goMto6ufxA7ZWwE0AV31Ywr0PQpbKzjqm7NOZWvQoymljlXFT9UZi6SCjT08d1xBbrxUPNf1xa4Fmwsc0L9UJymtg85+lZUzvpduYHet28R9+0GAvsAs7pnAt72AscbBdgq+Fm4fir0Q06GOl3ssIBTBxd1/eQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784971341; c=relaxed/simple;
	bh=vLtnKlLR558kkLw4Vnro/1D4DLDqf/ycb8bYPU3aI0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvYoCuk+3guHI1ZEA4b/HEcL4rxjimknrT/1f5N6xlqMhRO+0G02jOxdKAcF6n9dxH5/mSCNfwZIEOuzZmXmEt5LMcma/5+5H1Hpm+5uoAWEtQY7GlZD71cVhlmLMKaUksgnkbpek3DGKx5hRaOvZPk2IlLGWTLqT8GowiYegHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR8NWsv0; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR8NWsv0"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38759bcd877so868702a91.2
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784971340; x=1785576140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sTuqPKFq7mh1Y2qEAeGPo3pQ2Q0OiViZEunk17weov8=;
        b=hR8NWsv0yLMm8RcnNDrj3yQ6EIDXlTgW9yp58tt8i1xNujUXXJ4TTzohmCBg0n31T5
         M0G9RedGgYzj2xIHbGx5qBx1BwchVo9zWxn4QrtQ62pjegKoOU98MpW7fRk384NVzMoP
         QId2ysKr4a8QpqsX1SOH8SrMPExIrNaoDq/HreM1gMigkHNfFz0eWwbU2BTekcSfF3CA
         Tt0Zy1zgEoKQn85IUo7YTzNMJ20SrDOJMG3DKtjba6gb+BzvvaiPuXgiQJ0Nz7xnkgk4
         RdYNL0ZAnIgBASyeabF5wYAQgu7JhaGSAMe6fayyr+Cd3ztigIjEv8KrlcORtJ4i5eww
         cZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784971340; x=1785576140;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sTuqPKFq7mh1Y2qEAeGPo3pQ2Q0OiViZEunk17weov8=;
        b=qVkjwZf3jyDTWuBz7nCt2jlFzMhTa5Z3IYPFr64utGBSnFOcunBwvuz72Uer7Uxg2+
         ETD4gj/5Pvr7IT/ch98BqBA8m9mgpToT/q8El6Z6HtVRuCsdNHqBUja0HBooVXSPZRNU
         laJOGzggkJs5UHT27zK1DMA2dENhTZ2lWxq5EEfhRt30/23L+wyMCnmg3cYIpv/RJJSP
         3h2WHeZG/DNwn3iPwux8+TASj7JMLkwiiRk6dO61HQOrVNf6xzpXpUiogEiMXXoLhRO+
         feqTNwXbp2tp+QO6jR4g7SIpeYW8w9dtlnY9Yqk9if9yVzv6P5IUhSfI2iL46ACfxiVU
         r4Kg==
X-Forwarded-Encrypted: i=1; AHgh+RrBFR6uB33xq43ufQogbysgAZ+o0GxEdru5gj6N8Juo2YN2jPgZokzRSH9fvVFZC8l+58HXNMjE/4LXPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzElUOzF7Se8FJi4sPELoQEhfutmfWJVi0KF6hrD46bqBJKHBUY
	bN2CTgRS2Y7hx7J8g9l+fOwqQcBlbcHwMfD795vFTEogezyzjkUo32J+
X-Gm-Gg: AR+sD13YWRMyO6Gx/HOezEk9+9of9ZEf7GFqlNsMPQtD9H/1BFYAy9qU+W7/lc7U1Bv
	PKDdVSyhQJ2h731+6a1CisepJaac63WrrPRpDAScLmppFHGeTs1DHpCm3GSZEvOl5NtTX+n9bKZ
	b30iqTKUO2Ocwxv4eS79iNna6UD9iG59CmpP1SLdVsUeULq4akFDgqbX3/qg+lrYK0RrTVuBP+9
	nKNnZ0IibOvg0bCVbmfutLEX+y3zTGFKdr2y0J/mdJxzuEHf3Es5HeZN5Qj/vFfCr6HpySf/RIy
	Sq87wQ0Rl77+DOZWBT2J+vj/rylNBbTSBjwD6Mf+D8Nd4SyQCBn3DbFwR7kvHDNnDUJRsrqu/Pv
	KyJSq6d6mBlTshzv4Ipzu5ZUu/ZxfUr2kFMzKQWjD1VYW0I35sfoTsH34WaBSI/ak55VGsoKD3v
	MWlJKmapQ=
X-Received: by 2002:a17:90b:398d:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-38f293a17b6mr1913634a91.8.1784971339675;
        Sat, 25 Jul 2026 02:22:19 -0700 (PDT)
Received: from localhost ([172.216.252.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f08df8a94sm1249949a91.2.2026.07.25.02.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 02:22:18 -0700 (PDT)
Date: Sat, 25 Jul 2026 12:22:12 +0300
From: Dan Carpenter <error27@gmail.com>
To: Mohit Mishra <mishraloopmohit@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: sm750fb: Remove dead VALIDATION_CHIP
 preprocessor blocks
Message-ID: <amSARNiX3UpPVY-w@stanley.mountain>
References: <20260725090750.113598-1-mishraloopmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725090750.113598-1-mishraloopmohit@gmail.com>

On Sat, Jul 25, 2026 at 02:37:48PM +0530, Mohit Mishra wrote:
> The macro VALIDATION_CHIP is not defined anywhere in the kernel source
> tree. Hence, '#ifdef VALIDATION_CHIP' blocks are dead code, and '#ifndef
> VALIDATION_CHIP' blocks are always active.
> 
> Remove the dead conditional blocks, keeping only the active paths, and
> clean up the unused macro definitions.
> 
> This addresses the first task in the drivers/staging/sm750fb/TODO list:
> "- refine the code and remove unused code".
> 
> Signed-off-by: Mohit Mishra <mishraloopmohit@gmail.com>
> ---

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

