Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366713B42F4
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489779; cv=pass; b=eRWS6p/fuESWoRxVAv0fL2UV4O4TjW1VSEgnccPin4tBq6eC3Yt4M5OkMVwFplw2I7Zy5zEWWHhNQsVfl6tm9GYuIMKz9gVP5gnefHIMFPSSoE5c6CCWrQnN4txx7LsleHxzm5v6G/zBiZRM6ggtTkMwl8H0LAa4KkctmfjQgNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489779; c=relaxed/simple;
	bh=BPBPlELSCeE22IoU3+/4TogNXuJ7tB9ieEeJ9Oi94U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR49SsXO+vpQi48agMqxb/SBC2VxQ05ZESMoQDr2R9B6p+a11pEVGsD8V9Sg7P/wKXl8VLNSDXO8uFhDre+lxJ5YaYBrOqN/4sYRsmaFQ/dMAjEakSXB0nCbH5/G+xTyUisotp2HAzed59Wy0WMqVs8QSFzzZdJMyybAm/V7JiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=vI8+MH65; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="vI8+MH65"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso643592a91.3
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 02:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785489777; cv=none;
        d=google.com; s=arc-20260327;
        b=oc7uRnEkh8bscCbaFLY8vic5BnKBRnZdVeQ6x8CHocExXDgtiVzFG2IjE37/YvsUZ8
         fcJgIiDjjkmq8bdvCPpyOeTV4ZL9NnNTiA9Yy8/co8hEdSY6sGmj0UEUNphjvuFl+krP
         7kjn1d5aOxO3E5mOMO2BSwuYZvms4PW8+7CFDtoHYULruZzS9i+pvKOGbfXDdvcRW4fn
         GP8AQFrbJT0m3kovI1MhpxRdmMoIJ9quqk89W1BNEdul8TLfegO2qvuTjJkYwvtDU+Ga
         aJOjK1+E7v/4tG+WY09z3CP+ihA5vvKgYOfU50NrPayLvOl+WR1LieVEn8NsJ1BlIEaq
         zRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BPBPlELSCeE22IoU3+/4TogNXuJ7tB9ieEeJ9Oi94U0=;
        fh=01r9iC+3YrIiEQofcNh04OxrgxMNhT9XikAmBUBEm0o=;
        b=qGqWJPoU1HADTdJlm1DHSI4uejLRPApArK0seQFv2yhC6Ty8Ud7AFljLo2c6Dx5Lky
         nliPT4gAWtEUqX20IUM/asR2g0rIaj3qO0LgeX65PFmeyIpuyRZN1q/bQg8cILIKzhd4
         q8bPQ5H1eBA31XrjV2pFalL1LC2iEi1PqY49lLytS3GHfc93pvTO8SJkY9zTQp5ii2rb
         jHRXSIEZRUSndCI725C5eB6etFRFBgyXqz5rw6stIRVtxQyhObssNXXyYzUwfvbzfTHH
         XWmA+t1LOxL3SRxG93V/UfLvynaz0Zx84y0rJM9WYaD2zTMnkYTjX0ioMCQ1e8etryjt
         HQQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785489777; x=1786094577; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPBPlELSCeE22IoU3+/4TogNXuJ7tB9ieEeJ9Oi94U0=;
        b=vI8+MH65AKjkStESz+gnE11fdz7nkZUakxs+ps34Ofmdi/K1u9Z5x5e4zr5LLNjloW
         nPHCbY8TsUDpcdPjqY0EHjbB+HyBpEwtAFIsg0+eDQiHXdSioXBO7dlaPi18Qvw510Gf
         3kfrQzKUrdBs8eo9kP22D+nt16u+PHNOSPFzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785489777; x=1786094577;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BPBPlELSCeE22IoU3+/4TogNXuJ7tB9ieEeJ9Oi94U0=;
        b=XtQNs+4GQUR6bGrq3RJlQbLMB/JGmarjqm8wNX7i/hj49xUDhPLEP+pqYKpOiRYQEH
         sUjq6+Kt7jo75dyn6xjitizg29YDlkTq2VbAjwnJCrtEWUI1kOTkt2uQfA6Bl6ScSLfZ
         iyyeVfYCEfXDqKYqvfHlx41+vaFDGCKqZ+d77BMvNPwXWywqMQqaR3tk/6o8wkhVJVqq
         l7e91+W2ndZXdMMYhqDPMZK5t52RvGB07hq4rxCj5dJyTl8lvJ3VdHfPxg9KDGbA5L6f
         Uc+qFORP1tEeuWVeKfI6hvd9r/2A/ZyVULRn0hQKb35NZHI1oO/6iKw3OADOrfBagYgt
         KBIg==
X-Gm-Message-State: AOJu0YxTZ7OmsQTk2Lx9ZIQejF4q+vPgqmm+ppKVMvIQ8Co9aSY6uT3H
	c5DuWwD5CK9Hk7ofANvfesk+07OPjUmCWJDpyzB4XK28ioNVoHN9PrTdnyxKve1VI+ySBpUB1uO
	6QuuMPEDDFSJMt3QnG6H3qzjlGos+dV6GCbjUBb6yAQ==
X-Gm-Gg: AR+sD12xzXASgnoqkrgaNyKQm+hdyBw7tJG+q/B0sKe2e7ZOZAvOhDXzqvWFQwY8jr6
	p9UFNehOAsIKNs0yI3gGGJDAaVxRnVKQEx7NVD15jNLcFAZqmkVF4AkMujyj5TxzF3IFt/3We6c
	bImXCmSveYQ548a+hDulPYI1HVjK6gB3bCmborhesww5N+ZmpdwfLWuBwi9bQR61+N0oyEG0sBb
	ZqXc+pPwg+udmynkSiBPbyS0uA7sn+65WqCEP7r5kbBQmfB0WqhtujiJZhiGEq9S9GZGd1wxp/1
	+30uf7xGsBTpkIYMcSX9BbwAOEYbyzQv9erBQosexKMyxii0MQDhwIxO06O1h+tOk1+KfZxf9pe
	kupg=
X-Received: by 2002:a17:90b:5290:b0:381:5a08:6291 with SMTP id
 98e67ed59e1d1-38fb140cf5fmr1166898a91.20.1785489777410; Fri, 31 Jul 2026
 02:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730182640.2808572-1-daniel@0x0f.com> <6bbf7e18-92b9-4d18-beb0-0c9812fc7ba8@gmx.de>
 <CAFr9PX=JX_s+J+5twareTYC_U6SRGazXo0XDP6e4r2R4f+q3CA@mail.gmail.com> <e21366e9-6ca6-4607-a54b-cf30ce6e5d1f@gmx.de>
In-Reply-To: <e21366e9-6ca6-4607-a54b-cf30ce6e5d1f@gmx.de>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 31 Jul 2026 18:22:45 +0900
X-Gm-Features: AUfX_mwpdylyx5h0RWS5nOxouYDwdQMa7NA-FmPXoBBXrXXK5SNnFDK_OPxCpLs
Message-ID: <CAFr9PXkDwHZA-0X+FQQ9_fqceMH1M4Nneky9Hr7bj5Lm0Oyzyw@mail.gmail.com>
Subject: Re: [PATCH 0/5] fbdev: tdfxfb: Make "unbooted" cards work
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Helge,

On Fri, 31 Jul 2026 at 18:12, Helge Deller <deller@gmx.de> wrote:
> > Sashiko flagged up some things that are valid. Should I send a v2 or send fixes?
> I prefer a clean-up v2 version.
> Dropping and replacing patches is easy for me as long as they are in the for-next branch.

Ok. I'll send a v2 in a few hours.

Thanks,

Daniel
