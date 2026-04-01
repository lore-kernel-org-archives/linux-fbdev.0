Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D0384221
	for <linux-fbdev@vger.kernel.org>; Wed,  1 Apr 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045014; cv=pass; b=buCs5h9UPBW6wndaoe7XiTRXwSKlAZiiIAkGpaioJR377QZAyYlb/UUT4WHnyC4VHRaeXRZOaNrjwb7Gy0LvCM5deII7IyX3bhnnBp1fp0xftLxHgiRKh+zDe73aQ8BHEjSHMg9UTq9nCw4FANhNc14h6BtaVjlKIVwwG1MBNGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045014; c=relaxed/simple;
	bh=RbYtUAInTbOWZVTgoqVQzmu9yqJiXJe1PvvADpVFPd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dS2N4depm/UPoUeC2a0UUuTXaJFlcvNO3+Rx+lcmGhgbW0Z8xYWKqziumg8S+anzgKPUQ6j94Sr3SPX63xaS3E+5LXFSXE0p5QHm1BMxguZQbyI7eLDUqEC2xVgfGqipF9sZGNt13ZFQ3cR1u7/WUrL1K8xgYkcL9keWqObBK54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlXLaz4h; arc=pass smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlXLaz4h"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so8055060e87.2
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Apr 2026 05:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775045011; cv=none;
        d=google.com; s=arc-20240605;
        b=SmHS4fnk3GW7qpI8nzvv8Sd0umGvxgQINtkgBDh+oMt60pGnDS5ILwB1W7lkDZ54O1
         xsVsFtPmaxWnZaeW7A780Bn9DreTtaaZ4GoBYJg/ik0dWVByvXlWD84OuOsEk3KT3bRS
         h7vEmbtv/oaWHalGEr5haLq3DxmcrUsU5AvNtz2ajfsndMjUretjEp1+ZidbVgE2bZwB
         y1LzbWjHN7Gi4NRZ73zIVciMmqsfEKIFhXJhpavMgVO04+pPMBfTXAn06VVazXIxQUbT
         TE0lCP4xkyLlVXsCqv6wgwGBPat+1jaMGlsksI/XbnYIhQd/JxW+ClOL9QGmo07BkZ3T
         XqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RbYtUAInTbOWZVTgoqVQzmu9yqJiXJe1PvvADpVFPd0=;
        fh=5n32QarqebQ31umz/1Qczw7KNb7NQ/ytW1aOQXmB75w=;
        b=j4gZNt1OYneEZBCZg5GESGwozwv8SNWyqqL5D63YDKH652vKRzr/1YfqB26174Gh91
         2Wb+sJrjTXqS/CcQSPzc4VFfoXZgvNifYL1dsWjAyS4avjwjXGDP/4LuIjd/coiah9tR
         cmZGiZXOsMvIKrnQclXFzAONhjRnOrog1C44gMgPBVSL+SuHIRmDt71CGm5Mnyl90tch
         Jsz3fiZ5MsnEpBZphDhVJQcrNGUvgQN2dpvQ/L8qNKhXuaR+6C/Y9m72Huc5M6/He5oj
         Br3xQqmEblhZXonbUH3yzIJGyId7EVnugToy8m6WlOmO+Of7EFrukwFBvLQIkhW8bVP5
         FCnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775045011; x=1775649811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RbYtUAInTbOWZVTgoqVQzmu9yqJiXJe1PvvADpVFPd0=;
        b=jlXLaz4hhH9RkiMGiGSO+7C2YuSfRmXhfvvraGw4Mt9V8iUD7KUKu+SnEDtIeWboIu
         GzFFOBO42SMQAgIcOS1szxHTNSWUQ3xwFyjVvAoSuKT5AaQhbnq3RG0sT9lWiL0zznqd
         peNYFLwDu47vhxIUqSaCm8oY6dBS8/NSBhTobjiwFjCfYSlI7zw7K/07Lcs4rDlIhFml
         +HYJm7t1rRMuJRy0Wl58g29xu4kLqOBfQh+L4mJQpmtKAb3/3yM5m+XfR/hV527WJ6gw
         BchLGcajl5b1HkmCnuOCNfTD0cF/Cz/D67gxatQ/8vmNl5cPRIN/diolTVzU/2tmbXyj
         7q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775045011; x=1775649811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbYtUAInTbOWZVTgoqVQzmu9yqJiXJe1PvvADpVFPd0=;
        b=ULVHAg/0yH/54IpC0Fj2f8qj2gCNUHZUNWDcBf3DqyVWYcHf1+6KgksYouuzuyfy94
         GpTf2Vmgr9vQGGMfX+Va94M/D1JIzApIJ9u0toi18f6OdPOYDG+LOD2tvblp7t0+HfFo
         PhLKXxE+kxhAFePpdI+bD6XqA1xg0myW/1/Odkj9V2pRgvrLUZEJAvLtAqgOvLiOhtT6
         TtWO1KvmzLUeD6Daz2P+Et4sejDGpeO3Fo2PA7igJKUicL9pkZRwVIjCkgl8mZTBHFRR
         d6Av5uPUGxlmWjHB1XFZXRAMkJY+SEzi3A5+Q8x5gsOrZbpjQ4BWhVFw4zrHWQIzYIWh
         iRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzc3pGi0tDCZXzGdZO/99We4HcezSE+HYWCdKLup6QgyntcgOrazGMjLNfXs1bk0mugwfKChdo+I2vBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSnPPY1Ntpf0jo0xgcYsFQD5FL+BPpE+48fBHaYd7eupotRW6F
	NMRZF6u4XwzvCLPs3BgsrRJzDKCNVVjlsQ+y9aqz6ot7hkaojTeJ8yEgFE3qC56rSDTVJ0xl9bS
	P//00vAqg2m0rxJSPuguj4BkK8QK+KHw=
X-Gm-Gg: ATEYQzz2zMFf4mEWzSww01zJDLuVQ7WC2j4hVtl48MOSIGXEWaSNH+FLcUor9/RuFm1
	nZwyT60s8SVxdiF2/7HDSk9Ii2yBI9ZTdtfwUBgctlnoFQEefM7pxyGQ2OHZYzo55Er8SLLJUmD
	sGxSGQCrY09oEO+YM2dbFMgz7SflS/UJyig7+Kpgv7PP/gF7xqpfa6VBFGZ9vr+fbIQ60MgCfx5
	2Af1rpWF0oF/XgEglXEEBbC4Bg/g41UH4XA52ovjyEAP7xyuv/6JAmUkQMROnraWPlRAvDmcVWT
	5bQckpB0xIfeaCygKoqPDScwoV5R8LFDfeEQ6ow3
X-Received: by 2002:a05:6512:1324:b0:5a2:beb2:d440 with SMTP id
 2adb3069b0e04-5a2c1f196c3mr1229958e87.22.1775045010858; Wed, 01 Apr 2026
 05:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401110333.2535-1-dennylin0707@gmail.com> <2026040134-stimulant-resisting-869b@gregkh>
 <2026040113-ramrod-array-3659@gregkh>
In-Reply-To: <2026040113-ramrod-array-3659@gregkh>
From: Denny Lin <dennylin0707@gmail.com>
Date: Wed, 1 Apr 2026 05:03:17 -0700
X-Gm-Features: AQROBzD4wNeStKYe1zAHC3L_tmN_4q49UndqTobhH3lTKwkAGkJ8Jq3HL-GI7Ks
Message-ID: <CAGEkeHctN_UE4zYqa0TCXqC6RQ6yh5qaHi=fcaVk=ba-8+auQw@mail.gmail.com>
Subject: Re: [PATCH v3] staging: sm750fb: constify fix_id array
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

Thanks for the clarification.

I've addressed this in v4 by clarifying the const semantics and adding
'nm' output showing the symbol is placed in a read-only section.

Thanks,
Hungyu
