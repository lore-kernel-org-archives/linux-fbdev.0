Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606777;
	b=450wSJDcEjcAymFFzW9Z5Uh/nflX92zTwVrBP7XZ45K1nBhY87505HtvuqJfybq2p7T4
	 wb6ddo0vk4mBjNnSNWTgBiZM8eiOCLfhLr1zF2tiBVx+M1ow0NlC9I2f3DJGT3sGPwkke
	 6iwuEwseC94Fs20qmMN8cnATKM4xtgIk+KyVXg/mGtxfg4nHiB/BtuYK5y6ajRp5dgKr8
	 jdOLst7+ZbNzEalXyaMA7fXjpfV6ivySaiGs0El2JrjiRTDVxT9b007j+wmwnnMgATMiG
	 nV/KNW+H0jQUfkbNSAwoASHGPGeFSVmyt9UZpjJ3Fj6QTPzeRHYluc+055E3qKe3Ckg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6ChYiWXtgGQBl/u4nMCQKXDJCoRvRajQXYwkXLNTCVQ=;
	b=VtMwOfKRyQzMcwnPqaKSa5RTght7MdO0LFHenqjL6D+c4XeZazgWKh/swYro16EWq/M8
	 US0PlRcKcFkY71qea1WPLQ3MMaDsbZGIjngNLoIYZU3L8WUCd9nXlE+f4ddSpgghA7DfD
	 FylLQOhhk+CEfGDSnldNi2YebGsouZnJDFY4FJWz1gbuCFxC52OFN8y0rc/9kLzoO+qOv
	 aU3VYBUorOrwcXkum9Ka9kElwWaD+7iye7wx3BdXCIM2UKj4ORwQjPuQCpByDqpmPrj7q
	 xh717Js7nmaIlKznKPlMhutb2WWbA7saTm0JuWu8b6j93z4+dRurSP5Qy7AbZH9OobA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kN6ojt5f;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A674606A32C
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Nov 2026 08:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A674606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kN6ojt5f
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so1366848a12.1
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2026 00:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793606777; x=1794211577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ChYiWXtgGQBl/u4nMCQKXDJCoRvRajQXYwkXLNTCVQ=;
        b=kN6ojt5f5ThR6DoMCc9LycxLXyROLCv4XieWb6HZi6HaKkgYmHDnYmu7NiRHMHnQgn
         Td9qzoxcUkC41eMom3bmcyc/cDAFjG9VH9o/qmi44a3pSGSFMQBS25el1G67b4nqTjxu
         71S2FKmY5Dh9Kncq09miU+//WFBw8zsST8suRC8wfMBm1uNCh+9SlosdYtgCUbcidLfu
         W/IjpzvP2ShoccT/z+XzX9drcS+ZI1+v+VbEgi6PGRA3Bqw/VVaO4JLhEmxjVVlFQol9
         to1L4mMR5ItvwzvGOyXuTPDBAIeJHHqc2YC5qdU1OPdoaK1Fp43gF8qn6FnlCdzETu7u
         bZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606777; x=1794211577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ChYiWXtgGQBl/u4nMCQKXDJCoRvRajQXYwkXLNTCVQ=;
        b=cvqFrGCzidm0BCVNA/xIO+64MQhaHXS777OeXiqnASqMz2JL9QTx6fo/fF523+Xkiq
         JZWtTD/nODJjLsWu6YpSKcK0i/RCddRqGBzeRKS323lVuX484SaPsnGgWBI532ZMJs/t
         YD/9P7P5vOPTfErluHfEOlJODE3Uu6Y+nQAyGMdGR42gdEQZ/xlMOyUHRce7ZwrrYQK3
         weAh9SEZT4geqB7Z67aRllay4s1m4veDfGs79NW0zBjoRXZrOVibF2u68jb4WIDi/Lmj
         GXbBtFMo7auxwKVthLfKYEFWFMwdB01BNHTSc90vvPBGY4n5n78r+4jVDTopGxqdsKSq
         zVrw==
X-Forwarded-Encrypted: i=1; AKwUvBwUOzgRlGjcWt73u3H7wg/M48KImr4FezuxmPgwMMIobhTZySoOcMdEg+ZCCespJ19MnaKmplzfENZngw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+aDjPJqNmHh39hpimaHN/TSHiNWATNcYTmXAXnvbrm+4j5DQ42
	5xQbEhjjNaW65E52mQ+GZrLVrWoFnZ2uKT9y6dt5pCvWz8hWNc1vpWls
X-Gm-Gg: AYBFou3597I+zd9b0Dpz8asLdn3tIGVI1QkJ0aiU62Rt8Vf4GXmKvxMY0MHmvzFTOzg
	IJ3pUNEF/DKEO7JA5Aq5MEWOR90uT2fBIS/NrNvovw6RBq3CtDoLfY/vRGwvs9qZy+BUy/R5x+3
	T9w2PRKnagX+GPxkSxzu8rO3EdFedGQ6R6p0MIf+3HFO6MZcsVoBf2/kmqgvJRYMEohwC8M3yGR
	6Enl+LzOWLU5vcr0F5ZrXMFLNT6e8aZui6yaH0pM9fmpwowLv6mMUgvHt/z+3T6JDC8ow+Zl60v
	c/NqAYK/tYjDDy7t3y0YpTrLeLIVlzjqA4PsJYOumh4ycCPUSe7pv2KB3HULezw/m6uhoCPuxQY
	aUSpFTkpMFuXDLJchPBfn6ZqyD0KW8KYEYEUOHBXbdkTkj6RmWLwq7WCJAaFHh1a3oxD0JCPpWL
	HPpBUU+wRLRr4WFdeBnGY+ER/kEH1+/4dyzIy1xTzVscRYjI7E3huYgoO4rSBAmvPrSdDIh0wdt
	xZmO60pRGnQIBOZXR03WcU9wr3pLv3IzlfzjQfFLe5/1+KYNHBApSg3sHsfYemph58RJSy6OXw7
	ZwkSZaoWXBgailOBXFYpt+9f/oYaXcxHJT84OMkrp9ntIYekCXmv9f883GB0yZvbnzxkKMOpH76
	RTQLL/Kseng8OwvM0FYmXJSQNQGkHEVfZePcejVabVXQ4LpcFAMls4hSGMuk5ZA95PGzJ+is3Ke
	X0bpU+OKweHUdVPg==
X-Received: by 2002:a17:90b:4ad0:b0:3ae:3e9b:5265 with SMTP id 98e67ed59e1d1-3ae897585bamr5292232a91.26.1793606776740;
        Mon, 02 Nov 2026 00:06:16 -0800 (PST)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a6f0sm13214894a91.1.2026.11.02.00.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 00:06:16 -0800 (PST)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Helge Deller <deller@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev: pxafb: initialize IRQ completions before requesting IRQ
Date: Mon,  2 Nov 2026 16:06:12 +0800
Message-ID: <20261102080612.1469981-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2fbbd0fc-3f5a-4bee-9a46-1c313a96fa6d@web.de>
References: <20261031003424.1796478-1-matthias.goergens@gmail.com> <2fbbd0fc-3f5a-4bee-9a46-1c313a96fa6d@web.de>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> What did hinder to add any known tags accordingly?
> * Fixes
> * Cc
> * Signed-off-by

Nothing; v1 should have had them.  v2 adds Signed-off-by and Fixes, and
sends this patch in a series with the other pxafb fixes:
https://lore.kernel.org/all/20261102080332.1466689-1-matthias.goergens@gmail.com/
Whether it goes to stable I leave to the maintainers.

Matthias
