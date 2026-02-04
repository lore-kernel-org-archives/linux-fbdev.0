Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034423ACEFA
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197467; cv=none; b=MNpyy/XXgts2rp8YwKiPwSMmeic4G3mDQw7VdRcBMoaLAteqA4KFQOVzl/8OCwHPkx0J2+ZFjNrpb+W7FIrTxA7cusg8L15f1Cvx75qTU9BOoLkgKKzAq+8kXY+eIkUufJ8KaEFgyldI2/whXhLyN3UshtAzanE2rS0WbBBsiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197467; c=relaxed/simple;
	bh=9pctG3bqLouoV3h2Sxss2fBOoc+MN07XFIMusz/S9I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUl9ndwc4uihMB+jReb7BYxHLH9jSpX7UW1q71NlyuJWAJHgHEOlgmeLWsg2EhyfZmLbL70t/nSFdPgCMtDpjRHmFQMVauvXMPYQoVUwAqeKcFPV2oPIc7DWkfL8RVoA2kyx3EPVkg3oEYZmvYByIfJyTE2bNTvOPcRF2XkimyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r1iA5coO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1iA5coO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-435a11957f6so5114033f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770197465; x=1770802265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KG2GKfbQvjEW2JmZRuLJwTnuQG9bribyjhWUk28KFDY=;
        b=r1iA5coOXtbNhfGoh816nvb8F1DgWKbSP4Arebfl6Ht53yWC9Ygst1V3qsANNgTVtO
         BXXX7A8QXiCq760KR8GVEtj76ThX+MuoCx/NjQzgob2bD8OYNrXs5iUJ4ZDNSyE7iBAt
         yiOMwKJWiB4Wz98kyF8yHewR69ZeKYJtKgkxAEtWq47bp6cMWdKYkez0GW2yCEnjsj6p
         +3FBFR39/CPwuAOg73jcza3g9n/rxHET8UGM1VnJoDlLJdIbc9hN7UnI8vfpggHsu/rS
         l1PD5ZwMGPN8/wJE9175j5ucKm1mVNQoC9CuqwJ78WA34KmLudDo+2Z8O45iwVWY7yDM
         Zq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770197465; x=1770802265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG2GKfbQvjEW2JmZRuLJwTnuQG9bribyjhWUk28KFDY=;
        b=PQammlSlQYXleFrc2y1xuD6szujh/+ILO+yPm7SQchpMLeKOvHVOggnuiMdn2gS4l2
         O1eVJf+DNwvHVcsYmx6MK/HWcpbXHwIFH4Ai1ck3nx3TkvQrrc5O9OkZlIasOrhPDml4
         u+umi3rtVqFIYMhJpsdkVmT0kRMIJGkMXiB7mC7ZMOc/ow4VJOHFjjaRtdUDtv/p+cvC
         sdUhDyC5toN344OeKfUa7c1t8jYoVwTopzoUhdz9zu5uU+alUMyKT4M6fw0kN7vDwEkw
         ZOoz/BYPiXcRbU/DsXmSR0LuhrijwdJtcFumEQW85dScNWUhvlegpv9Hi49YyLeKJHdn
         d+sA==
X-Forwarded-Encrypted: i=1; AJvYcCVu5NvcJBF907y3vsmj1Dbpl68zCNwzRGlUezy2dC9dEp1Ts6NLM4FT/YxupeR01lNC73CCRDDuenGaIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHc1XWxfA0KBkK7/+FumPgLWYwndTyQ8/4pr8k4MQWKVQ1qhfr
	7Ki6h+ZcVo45l9FAAEeU6tuhk+IVvElhemtwUgOdb2eQtLE3hJ12eJ+xwMtGGZyo9dc=
X-Gm-Gg: AZuq6aJya3VAKALlGp9WhdlzM/2lJfGcXZmUN52s6sgnotJDfeNKKs8GE2+JgxabIqV
	B8/MBwlf43+GsY1gpdIfWJ4JZYE4lW1IdmAWzav4WIfFTCbniZAlS/fOb3zzIcxKCZQF6xq2NXv
	wXm3pBdVSnIsGtk+NXQvhBYldqcHyyMMQjRe4c2lKQWCNeeWg1x5SG36fI9a+DNdTqlGND4CctV
	58r8UydzuCN/bCm/ZLUM3nstGSUcOYl4YEMd70Nhm/Uf4FhlKtfBjKP/S3LEK18pmH1IoIDvylK
	lu7kMwxuh1Y1FziAA2jBti5vuNK/23boxO0R8vUlyij5ibDK7niH7L2m2JQNuDqgbIb6KfOnzAP
	pCrWjo+U6xeDEp0WOKM/0KvHz5SEemVtKl6iA/fXa2fp9NIkYIvFGxw/2fILy9kRuGIsoWuJ4vR
	0adOagHAhUP9QxpeGI
X-Received: by 2002:a5d:5f45:0:b0:430:fa9a:74d with SMTP id ffacd0b85a97d-43617e3fff4mr3072034f8f.24.1770197465047;
        Wed, 04 Feb 2026 01:31:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180588bfsm5307015f8f.26.2026.02.04.01.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:31:04 -0800 (PST)
Date: Wed, 4 Feb 2026 12:31:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: KrishnaAgarwal1308 <krishnaworkemail1308@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "staging: fbtft: remove goto from
 define_fbtft_write_reg macro and clarify empty modifier fbtft-bus.c"
Message-ID: <aYMR1Q-Fifzts8gH@stanley.mountain>
References: <20260203044728.23774-1-krishnaworkemail1308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203044728.23774-1-krishnaworkemail1308@gmail.com>

On Tue, Feb 03, 2026 at 10:17:27AM +0530, KrishnaAgarwal1308 wrote:
> Replace the goto-based error handling in the define_fbtft_write_reg macro with an
> early return while ensuring va_end() is called on all exit paths.
> 
> Also add a short comment explaining the empty modifier argument used
> for native byte-order writes, instead of introducing an identity macro.
> 
> No functional change intended.
> 
> This reverts commit 6eec69e273e124dca8549fc52b0958b2953085ee. As per maintainer's feedback.
> 
> Signed-off-by: Krishna Agarwal <krishnaworkemail1308@gmail.com>
> ---

There is no need to revert the commit because we weren't going to apply
it.

Also checkpatch is going to complain about return statements the same
way it complains about gotos.  Actually, I'm surprised checkpatch
complains about gotos.  Does it differentiate between local gotos?
I can't be bothered to check.  #LazyWeb

regards,
dan carpenter

