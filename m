Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004711;
	b=DkRpJZLJ/s9KaO7+7NEculRpLOLFvrP0T3nWgetewhQRWlkNMXUUzqFXb/4Yz/VQ3a+t
	 QDwlcbfk07xnpj/R31JU1qQchSBTNdPIP+eMD+0Z+mY5TCqnqbfKWP5aPxkQnVbLVnR2Z
	 hymHpLjhr3tHKIqPOKFPoag9znpHPsFouu/JIsX5B47UIDW+uHm09V3W154th+bx8o6e1
	 RJj4kJKL6BMS+sHHSeJ5y8o2xjUDw8/GoXCO6eHRgslz+YQtTD5wrY2B3JDg21u/3szIs
	 v9fQApPbqplNxC4k1d6pfIH9m23Yej+wj0mmU4+3PdMeXVpf+hCynmYOczwL0dXXTCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xWiTlDTyc6PTyNRCBNyeHOu3tzSbgoo2LUTk5932AiQ=;
	b=CTjqjFoqXKFNz37g4PZ6VA0iBerAGlQrfeCqJumujqmrf9jCkiBtaHRRvkurGiy+f/vL
	 P9udf+XsiA4A3BqvCV4M8xRIg9T00wgXuI5cnpxfO47gCLpxNpDU+5wonT/yV+WidgFD/
	 JUAd9iljwE5CM/2U5YmWRjOfyEiL7cYKtdR67rLbqmGmhsc8isXIuzgjf8wBEZ2XIEtc+
	 LcSuSbEDi4YlhDoQwuZ9NaFrwhW6ydUUrXhHjC+ySzl064y51PZzY7tnKB0xgyOvr9uoa
	 +hDmxzA7nO9U7tj6FE8DXzZTJE1O1OeXr/W+sXMKSTBl/8V/U2izTHyGcdoZk4gB3jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J5ysOHc4;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37451606A327
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 08:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37451606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J5ysOHc4
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so8072945e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793004709; x=1793609509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWiTlDTyc6PTyNRCBNyeHOu3tzSbgoo2LUTk5932AiQ=;
        b=J5ysOHc4KnG16Nsx67Jslwk2ZoEGuq3b+fT/Vmj8nf4Ee53HTT+mun/PygW+NpsNvm
         JCwYAAlcSpxpHR2LfJ9/IaQf+4RPMz/aC6rE575ITFbduv/UTAEmY7ZyS89vbIRQCQ+L
         eiJobtD3vxxRluJSDSIhxfsRkyZHxUw2DLG5qDqE9i3fgrAdN34M9kx3/arpQdJPdVUF
         FWmM4D6k4OYrmvDe2xOR8FIWXxB/GJCoZDvBxwCT++ls96c/hdqi1fzTM+IHqzID6kYg
         VqGP8b9ryQRCNstRFjE1p/+gqpV+4q6E3pqCP9LsmcxPjWv1ujuvms2lz+nqCHvHH9u0
         lnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793004709; x=1793609509;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWiTlDTyc6PTyNRCBNyeHOu3tzSbgoo2LUTk5932AiQ=;
        b=ypoefHu5RRknjtwmqlwoGVEm4FlAkalFVH7GLKtvoLIPMeBZRES2fedZ9DcOPnVi41
         CZEKkGkvfBTGYnStvNdMHfUtL9NRQ1/o7wiBIHOBm6wxSLJpH5DZxu5smUMeCUHSsERu
         H1lz5MPmd67FG5bhV3WWX9SgvFKfKQuk5gL8OxZhqC12XKT+7X/qlSFch1Jit4qJcAw2
         sPtql4iVaoN3Ay5z6l6HHg2J9J72A4h/FCpGIdEPjEE9EuiqcL/WJDD+T8z4a6fUgy8x
         nuf1H8OmxpTeB1m/NKvnQl4c/ssfYjHncLWo4TEY2ynT3T1QobiMG8C+j3RpxjdiBqCu
         6xDg==
X-Forwarded-Encrypted: i=1; AKwUvBxc76s/ks1U0YCO+bDarsfq4DjSJTprEniUsvzaRXuDYptEWyUH/NkwiOq5HeP8U9SudCwbUpRAgJ4tew==@vger.kernel.org
X-Gm-Message-State: AFq9FYIya3LJpmEJcPtFa35ezbtOqIvHSv1L6y3V6xuY9m3aN172rJHy
	M6ICcdn39qke287wNkgTOWlxgAzqDF9vYo2X/aLRi3T34OReoqmoj04c
X-Gm-Gg: AYBFou1F7mFC1U8rQZRnQejok9qqGrvDUm9t7+k5Zgj/U8JwEpxb0qUNq5yqrlMNe2I
	GnMtknsqT6s2uyReld6eo91BuuFc4fT3TKgKoiSLQg1bxYtS73x4Nd9pLoOSUm8XvyCnAwVi4UR
	krXT+ndXdJ6rvidenMODZ1MKXYBzkMs1gNA8d5pzLiSRyRU3yR4QpsKrTLWBBgid4ypQ5ZF2a2i
	CqIEAN3h6hUozbyt8T3VKR/fcYsuk0RZ3sdy39n9pxGsFbdHbJkeCavGalQA+Ij2AIv/Y6COTGX
	5IpYx9/5Fuh1FXDS80glNEhFeVsXTX7Wk+Y/v3KhadlqdkU07exQ+xR6I9Z5HaXxbZWwZU9ybHd
	NEzvF06x35m3me4slgQ65U8xJng8nOSyaTXz7rp2PEqDIiZrOuL3iBjVFoU1x7Hh7YkdkDtYYDo
	tS/fn3lWzotK+ltpyPj3Bjrfkk6avOkdG+xCVO2+E07X3VIBVYOMf+UtGmrFH9Cg3IfO5Fx6nJ1
	t4RELjU98zREXsAPqvcvnbVzjsBA5Y9wCUsRQON+txYb4RW7/oL
X-Received: by 2002:a05:600c:630f:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4a35ae9e071mr121463405e9.12.1793004709351;
        Mon, 26 Oct 2026 01:51:49 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa0bcsm224781085e9.4.2026.10.26.01.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:51:48 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:51:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Subject: Re: [PATCH] staging: fbtft: Remove unused macro
Message-ID: <at8UoLDzrO9ypMeR@stanley.mountain>
References: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
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
In-Reply-To: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>

On Mon, Oct 26, 2026 at 01:48:32PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> fbtft_init_dbg is not used in drivers/staging/fbtft directory and
> since dev_dbg messages are good enough, fbtft_init_dbg should be
> removed. After compiling the driver, there are no undefined macro
> issues.

This commit message is sort of acceptable but a better commit message
would be:

"The fbtft_init_dbg() macro is not used, so delete it."

1. () after the macro name to show it works as a function.
2. We care about the whole kernel not just drivers/staging/fbtft.
3. No need to discuss dev_dbg().  That is unrelated.
4. No need to discuss compiling the driver since that is assumed.

Otherwise it looks fine.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


