Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85F40F8ED
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376057; cv=none; b=Rpw/tykZYumpxua6e7m9/aS4Zl8xyFgT42nR8JmKO9eCfE/lI5cF/WSG63fynBijx2SrKko1sgv6bcFijZ/VXmkTzT8Fk8XPdluggpzFyQdUIWidM1uaFCV1GBkU0L3F5UrNjJfepmCNfZqQUM1ymfm40Co5bGhxYAIaKFnoPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376057; c=relaxed/simple;
	bh=qFnrZ7EQGr/Nuy+M5wyfqqYr8TfZ+ni22DbJJQ8c36I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWoMwbTzibICMtqPqCu5kHOSrvZn+LSOoCdTkjWX2su6YyzIaHIlv28IsCaMfWRcdYAdTJk28/KVPBXYpaHfqbZIIjeVLmaqyZQDmpdRSBzF8SqD78AoCInXEcXACyJAcqqDfgCA3sWocCjTtHKrF7bpbhOym0vaD3Sn711kq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTeOOUfv; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTeOOUfv"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so256298566b.0
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376048; x=1789980848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wa0N9b93v2KYOcx/Yzu42GebihJotfz/VPHeWZU/2n4=;
        b=QTeOOUfvnMJc65Jxu3+9WpewRvq5oTQRW7exJmTc4udDU2r38KsrptIHkNtGiEc9Np
         1z3ie3aueF6yguPULgNw8dHY9X4zCoYq1MLyYyW9pwSjdG18l3/YWDh8oODm+ZXjb+ak
         2PaKu631LWDKhAeK8nk6dpQpytnHzb1ZUIQ6n7iZNjquRZ1QyFeShcpwEdS1tX4s/2Lg
         LC4TJLXsmastJOs7JtMMtOVkAgz1lqEvdnS1LQGrR6EbFxqzNivvAM/rt/yY81U/O+Lv
         L3Uc+YqLipgsu6amL5gv9EJxhEsSa+yW6pXmDhpyKU5D3BCmciyLev4UQZU8eFg1SezS
         FXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376048; x=1789980848;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wa0N9b93v2KYOcx/Yzu42GebihJotfz/VPHeWZU/2n4=;
        b=g2Noai7tQGSZJ98Htt3mBcWSm0dOLUUR8hNIupYe01n7xOMN8AMvqZF2fAybXC6hMW
         em1LFYB5NPwkBBVZtprmhLtxzv3VFlTzdCAPN/vUmBW5tt32nB14yllMrBdLsM0mhGU4
         pf1W2qH19ZF95BdAd383HKDlZqaSt+GjG5rXld3k9mChi+Qk91YYmfjsc/HAOz9NBVuK
         2FzWd3bQOawpH44aTAxN2yA8ULAF37DGQba9Q+AcwuUz+UlqO+tymPOab8g4ViV9xBU+
         sr0Gortbk6dmVVgFjaEakFJA1ehcEuGPEmkMPxKU/lqmCmOnQDGzzCv/2TxjtsZ1bQIT
         Hdow==
X-Forwarded-Encrypted: i=1; AKwUvBzZyhAlCNOZ9rvfXLgPQ4yaj7mH/JfpgQxCe3OX4YxKoF5LwYe61btxqRaNRHZVyjr2X7IGFqON2iiqTQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nFfFM73hYDLuOAJvTP+huSyn+TtWnRaRFUMZQrs/YYe6BHouaH
	3F72jJ6zWoby1+CiqmhSKDg1zFgbaxCDp2voPpQyb4y0d+QF+vUc3gds
X-Gm-Gg: AYBFou3U85oAHfOLuA4VoPyXo948IWzL/J0CjPrisfknSThHbY2koV1qAXby2DsOUkT
	wjr8/1dgSQ+ySeM/gdG5RFz7iwee0ed+78sOMRkEeTAA/gGJXDl9Sz1mFt27WNnxhizjgLJ6KF1
	j0pRtQ45ZDP55KotOb/2853m3Jjx+djfRjuc1viI7g3oCjQVjmJye1G47p8A67O7MlgUfKlES4n
	1gwS81lni/GBzJCUDmNeJ8xM0yP1rgIFCijY0HI/H6IZUlJ1wP3WjjLEM1cDsYGl8Y4o3SL2A5c
	cPagbyF/MOfnZr7F/gr+IvfJmXn5KrrV8Ltsv5s6IplU7Pei85wHZsj28KdWJ/QgctGmzStogPA
	pppDyhRoB15gto3tIl+juIE34Qt0debAEXJ2wMaKPFbwGaivEC6V1Y2eY91cVLMOoE5UAlss+D3
	UpvXD9CT+HcLw40m60xT0lBsrbmorO4PBIEwlP9LwEd1VhCj76FG/hek2sy44iD37Qww0P
X-Received: by 2002:a17:907:7204:b0:c26:2751:3da4 with SMTP id a640c23a62f3a-c29b86141e3mr110973266b.13.1789376047594;
        Mon, 14 Sep 2026 01:54:07 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660234dcsm394388366b.21.2026.09.14.01.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:54:07 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:54:03 +0300
From: Dan Carpenter <error27@gmail.com>
To: Gabriel Changamire <gaberashawn@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: remove unused definitions from
 ddk750_reg.h
Message-ID: <aqe2K0nVppBFSidV@stanley.mountain>
References: <20260913040140.4517-1-gaberashawn@gmail.com>
 <20260913040140.4517-2-gaberashawn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913040140.4517-2-gaberashawn@gmail.com>

On Sun, Sep 13, 2026 at 04:01:40AM +0000, Gabriel Changamire wrote:
> The sm750fb TODO asks for unused code to be removed. Of the 1203
> register and field definitions in ddk750_reg.h, 1046 are referenced
> neither by the rest of the driver nor, transitively, by any definition
> that is referenced.
> 
> Remove them, together with section comments that are left with no
> content beneath them. The include guard and all VALIDATION_CHIP
> conditional blocks are preserved.
> 
> Build-tested: all driver objects are byte-identical before and after
> the change. No functional change.
> 
> Signed-off-by: Gabriel Changamire <gaberashawn@gmail.com>
> ---

These macros are just documentation and they don't hurt readability.
They probably improve readability.

regards,
dan carpenter

