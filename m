Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792993730;
	b=lEe93Pao2ZxHERSlyB5mpn2keQHqw4/cmixd63SE2akoEoq5XvsXuoW9sl8GRfrPp+/t
	 B0qr1sp6W2ZGxs2nvm6QJPoRjT8Hn5uKPodly2T0RqA285bYsJ8ImSi5xsSV3kQbc85yH
	 BCyHD07U0ttBsMQ+xLQwFMLME3YuQDh7qlvVCu++iZcN1rh0cieExPrkRco3cGIjqhbEA
	 TH63wu20fKEjIV6Y0cclZnwUMzcG5xSb9DZoos0iGwqMUZmvQCbfa4V4ZLMrk02jdJ9jn
	 Ie8maxpUhh1B+FTYt+rK+YjSrW+gMCtf+Lch2m1W4VUgcEwoCnjR8Ox3SnlbhdqGR6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792993730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RYAYmmDh2YKbl8OgItUgUWB8sbjY7eRAlNwNblYFtjE=;
	b=2thBScjyT3ZKX16rwXrE/mcP1cTVkNAz5MNCRzFsgsPQyyWyUMDW/asgBKWLJRPrf4CA
	 x/hLwvUSZGgVxPfBf5HKwVOAn+z+zhVDDJntAlXJdlO1rvPbf6FJKMEXZz6AbABId+roP
	 NmbE9pO8jMbc6usyfjRytRTc9ZT8DYfyNz0fqJsW9KymnrWkC5OnnzUf9q/rbqi/SbMGi
	 i2H5c4/HVuhIqijEnHA81gTf2EKtLmXTLbr/OMiCGbHPBVESXCZxivQYbIC1malhjsrmk
	 5Uo/xLkZH+fBJ6ljzTjs//excQnmHbzKLUlMYXSKD0KhTaSn73FcvFNyOaqAJqsCMVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XWLsYV4u;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D07606A31B
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 05:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9D07606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XWLsYV4u
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so1556445f8f.0
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 22:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792993728; x=1793598528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RYAYmmDh2YKbl8OgItUgUWB8sbjY7eRAlNwNblYFtjE=;
        b=XWLsYV4uiHkUfWr4Q/biUnve12vHb3l187f8nBcPpVIcfi6tUCwW/CadSRqpyeRfiA
         dH9iWalQFr7XHBQnkLQ+d2/dZrCYkkUKtvcaQiPRQzSvLmS63AUzt5AfaFOeSd9eqWNu
         AheBWJKc6d+CkJ0UJS94rN+tS2wDqy7R9ZAEYia15ERZrecUcXjq2zP5/dU56/7Qjm3E
         kibvOTNqbm18DDAOVYWyl2bctFVfn8XG/hQLIiXZryxLf1MT5S2pA1/stzMngM/aIL4U
         KM3Gf53CMGo1rPkcJjJoxdfSV5aFeP6K8HJq9pduAOkpr4V+S+wIx3iqfTtWFvmtIsWy
         V2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792993728; x=1793598528;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYAYmmDh2YKbl8OgItUgUWB8sbjY7eRAlNwNblYFtjE=;
        b=GEeNQNueFHXgjtuIaFoc+Kj7AC3n21nFovFdlQfEWHh8a3SzIZZYp3Qx/XWZ5uO8ak
         yC8+kdfb7KmeiXyQrU9qbLm+xKRKB0TEFU0qwN6bmBo826pfSfK0fIs5BO7K5vDHN/OA
         AMYSLBU2Pd1Nm6tayV2Y7+YwXdoel5eq/Oi191/8rNmNUMJSKjLqhSCN/OJlT4mBdqXp
         J7Y20Q821DDxXzlwi2F4d3tSgvgkjurYB0bsLC8NyS+Z9t7mK60ltUPh9he/N0N5l0fI
         zi2RD3M6SzlR08cjK/o/okfKKhuZLy3tzsBNuVXnrBmYBdshMZhiTAOV3DLS9wLYcnU4
         /wFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBa0DQ1IHDzaLSXxWLz9S4JSH1fnb8LdgMV55VZL5hUQPlxQzOSQM6Njf0fluNL6OGfJnQFWsOC/a9Tw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI8HhpfLhOg4sM0MiVQNLi7Wvfl07eTmJYURLRFyaMoajKmCeEN
	y5yBMk2oWpBGdTDsthH++QsEaTaewiYdZzusAkXL61AZLhb6P24C5++r
X-Gm-Gg: AYBFou3s8iO/u/QWTbu+DOVerWWX18ZYSWeJDZhiiMXwpJzEeQIo/Jxfe0L6Z1SMquh
	zbjT2CEJlthdx0hqHGg26n8rXOSZYMU52qGn0+bksjkEGER0dITcnVzeOuggXZydfTc/O7h6WTc
	DrdRwlGdumZanYEMxty6oH9z8eOqfMzyYpfJPMVT7oE27XsvqGqgGTcl8xkq/QQkCC26xvk7x/D
	Ei5nAtI9+8O860N56YmBeOvqkUphl0H3XkecQ2WCLnofxFeDta3/qSihxNV+uCt87sd8MdPQUVE
	NAYqxepujZ3d4g6nvIwgy9M8BOs4B9qTlgL9UOsD+JmoKqTp0y9Hb0uTq6RQoeFuV2iHAkBFUU6
	nGZ56uFhgoY4eXqzPBfOIwmJpl5uZ+MF1syMdThDL5IJHCeTQgLMklLQcPODrLvB0eiOPsp54/l
	c6r+8A2Osx8AUCISYyjQdC84F03vngewQwo6CnX/DBbqvIxiCAV45GmF44D8B1+lmS6+MMPnaao
	M4q5F7Pb9+gdLGiXlE8LlxwnhrjDzPwLZDLqoA4epmaB/+mJkwxwVsslqvMK/d+ahh1cqCYmA==
X-Received: by 2002:a5d:6184:0:b0:48e:22fd:1ea3 with SMTP id ffacd0b85a97d-48e3eb93665mr8333616f8f.28.1792993728187;
        Sun, 25 Oct 2026 22:48:48 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb9cesm14713554f8f.27.2026.10.25.22.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:48:47 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:48:43 +0300
From: Dan Carpenter <error27@gmail.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
Message-ID: <at7pu4hldDTgZtXy@stanley.mountain>
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
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
In-Reply-To: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>

On Sun, Oct 25, 2026 at 10:10:03PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> Hi Andy,
> 

We don't need this in a commit message.

Also I would prefer to delete these weirdo debug messages.  The
normal dev_dbg() messages are good enough.  Plus, is this even
used?

regards,
dan carpenter

