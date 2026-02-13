Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60BA2F6920
	for <linux-fbdev@vger.kernel.org>; Fri, 13 Feb 2026 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771025811; cv=none; b=gS3O+uMDIRDHgFtONXwl0ok68RPxJwIXvRaW7YVTn6jO1yYtzjA5Spcq/oSi6KLqk9tfmgfConUfbIBOZ39XDwurCLJOKe2fx325Ggw9lS1tzGNCjpbwBTR/d4MRlQQv06HfWZtLq5d8RqA0GG3GUmKtbVhTqG2VfRmTKFBC8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771025811; c=relaxed/simple;
	bh=dQ7PAAK/uBgMQmRMuh76TGAZVvMWjI3NugKBqmwfRp8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dygDbA1ROivzp6hicBBBO0Mr4gdLZK7kf/FE4YDg65Mhwzohg+AlAn0ptyF51ljSRLTG3LUHvgzYoj4J9ZLiRobum8vZ/fCB/W3pqtNKvkB8IsSilZhGqC84yJnDPo3F4TD1Fzmz+Pb8dBQbVRhT3Ah706F1DJJThCyy8npanzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMYEa5ku; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMYEa5ku"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794fe698e36so15021397b3.2
        for <linux-fbdev@vger.kernel.org>; Fri, 13 Feb 2026 15:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771025809; x=1771630609; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQ7PAAK/uBgMQmRMuh76TGAZVvMWjI3NugKBqmwfRp8=;
        b=iMYEa5kub5I1Y+R4BqzrHkg0//7H1mmj9RjSr2pUISUIw3KHp97ACDeILRxDJp9VF+
         TJ9jERPn59mroOQ0/W3achxVi2oCbM951pUHONX6t9tcpUBqc9P01lTINq/rnpThy2+s
         uAOq4ySU16/ZsPc5YEswGf2IVbVTJg5a+/4ztQIXZgQGv/TlErsQAL3pHmDQnfvm5FmT
         8ammwh0XGV1Ah/6HCiSDZoUpYEl29l3xvbeFbXTl+aQ8CJOrzTdTvDmNCMDKUeuTGk0H
         xxXY4b9X5zCydIdu8aOhncuXGNraryxnrOXMu4okME834DlUYiQMfuMm/ot0kpP9ol+T
         TzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771025809; x=1771630609;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQ7PAAK/uBgMQmRMuh76TGAZVvMWjI3NugKBqmwfRp8=;
        b=VoMv7EL7mMxm4xIEpqWu1eGIfmpPYWdgac/SxkQlk7LynxpvTcuJo9czsm422AZUOI
         lgmkKVkPRbAIMlfzTj3QfPadngacIlWuxypWZpccfAyICLzPc+jf7R496rhn7FzHKbYk
         vd26dSO0q8YW8G1OH5PQSLVyyxwH4kW5PZXWuiekABeRnH3H5DPZDM19y86DixiYaJSv
         YAT4iQJzKTag3m71199X57U2tCWNWJsGkUovs62+KbF771LGt/OGVZsWyITI94Q58Kdc
         zkJ0NxmVydd0lt2yOpXZD6SPayKeecAFVJ17lWzUYTzgahhAM32TKTpe9QAVc8GurH2y
         6Nmw==
X-Gm-Message-State: AOJu0YzKwRnpeffE/DnBJ5YjArAI9PUQ48NioIorGG398BB2I3o8qpGF
	CBuwISJI2OMM6SfvPLoX9OgUEhPuQ9K4JbwDKNQpM2+gq3DtzEbmyumE
X-Gm-Gg: AZuq6aLPxeayl8fUHLLv0JQA7nKIk48WA+CLBfXVe1rWD4ZV4wOGZ9mPlk/b5tWIVoa
	yssvELYcBB6ouMx+kZAv3ndHP3TjLQQuffqyqlZXREin1LLDOy508jZwWIy4BIS136EojskA040
	4CD+gGz1i7i4u4bJRfPy80QcEHesrbHCPQyQhRhN1j5/vi2vOOWu4QBgjnNjG46hwtngzqzSCcb
	7LxDUfrGMW3o087rIHCokOauzoRTRSCcw5f+/FXgxr6Ef6IpY5zcS49h3BHEt+5Ckd/GjPfFjWH
	7rxg2+3FhBMQN3QhsUEeoNENKpIqIlxRta6LHMov/7NU3XqrTljeu0oPDy98HY/U0A39HQywWbk
	PnbossznpP5aOC6k5PLwYrDISHCuUs4b7ZezxVI0MEsVcDOCseV+b7aSSc/hvqGIxLToOX4v2vy
	O1ICv8R0+8lX28BcAd+Tx68xfryV5HG295uuzEeJUcbV7otqW9exOjNmYTUvJcs+i7UzSjQ66MO
	wVOef4FqznsXa2RQlpWDy7qAfpO+wZrSDv/B6HehsN2I6gweCa46cNsYqVRng==
X-Received: by 2002:a05:690c:101:b0:796:44e0:abb8 with SMTP id 00721157ae682-797a0c69eb5mr29435987b3.31.1771025808917;
        Fri, 13 Feb 2026 15:36:48 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c267f4bsm76265707b3.50.2026.02.13.15.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 15:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 17:36:32 -0600
Message-Id: <DGE88XETJ97W.1LGV5U59Z9W9Q@gmail.com>
Cc: <linux-fbdev@vger.kernel.org>, <linux-staging@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] staging: sm750fb: Rename nDirection to new_direction
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "RachelOvrani" <rachel.ovrani@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <teddy.wang@siliconmotion.com>, <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260212180402.69356-1-rachel.ovrani@gmail.com>
In-Reply-To: <20260212180402.69356-1-rachel.ovrani@gmail.com>

On Thu Feb 12, 2026 at 12:04 PM CST, RachelOvrani wrote:
> Rename the variable 'nDirection' to 'new_direction'
> to fix the warning reported by checkpatch.pl
>
> Signed-off-by: RachelOvrani <rachel.ovrani@gmail.com>
> ---

Hi,

This issue has already been fixed in staging-next. Next time when making
patches for staging use staging-next to avoid submitting fixes for
issues that have already been fixed.

Thanks,

ET
