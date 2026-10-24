Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851054;
	b=3t1pCvNXNn5yN0WnugOfhSYgEKyW3x8rJ6QmWTt7AgeBKysK5zmBZH+PJbwvIwVnXJZB
	 86UltWqGJfWfz0YufnrmdG6rHuJkZWD/O5YitPREsSguoIe5d50wpOPVj39pzF08u+/G5
	 yBgpIZu/eDlcxi0niXCcaFPMAZYXCP4CXFGweRoOWbzMVtiqTiLVzXYkk51fX/44WfSZu
	 XSRNzH/w39iVFZoc32dUltIe7mc+0AJtC80/tzPePUJfzkVlLbmdTSnmP+yTMGuA3Wsix
	 RZtpRUU3h6BsgvZt9jVUQ8Rw5W/ra9uat88NI7tP6fcbhFECYhNAg+ymztLnbWigu8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851054;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rooLqVXyeooPFB49xJl5CZBUAzmbO1HTbYDkbc4qOtA=;
	b=XlIqUADlxEHSAp+t6Q87lj5m5TrdUlVMdIfc/Uavl9JAwPxvYhI4uGeyD83iIrP0Nff+
	 d+HwStjqfY5g9VI6qzlTwDXJtg41uMLwI7tI3BCzTmrpQUBbAQkQnsoy367lmYNPrt22T
	 LQtBuk2vIGTSajv6S3t094BjUcLJ2giGG7oW7vhoopcNcbKIvpPS1m4W85RbqvEQnt7OP
	 /mwdn6iTIZ+RByTdHLYS9myqQQCa5ykQ0SpN8247Fa1hHOlSQOSpDsuYQup/6yFIdhsej
	 fyqTzYTFhQoQVUiCjRG9YInDD7IsCPXirc+wp3LjvDHqooI09+Ybsr2yO+FkaeN65qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wBpbDCsE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDC606A31A;
	Sat, 24 Oct 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wBpbDCsE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6512E1F01825;
	Sat, 24 Oct 2026 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792851052;
	bh=rooLqVXyeooPFB49xJl5CZBUAzmbO1HTbYDkbc4qOtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wBpbDCsELpqdzwz6j+5kit4so09j2vuscgqDddx4L8xEIJRDoHbWpdN3b1wCm5jKk
	 RHu5C7RBiT/2nAWDwsRFzXPUGY0WPDyO4qlgpIoXbnt2DO/XeIikjSsh5U2HPuNZZs
	 Io1PKSfcacaMLxIBXeYG3gBZD1rDEsVNYg51BuwI=
Date: Sat, 24 Oct 2026 16:10:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: clean up PLL calculation code
Message-ID: <2026102447-exhale-overarch-8ce7@gregkh>
References: <20261024073549.29531-1-himanshu.bakshi478@gmail.com>
 <2026102448-tackle-footnote-9ca0@gregkh>
 <CAGLmz9+J-s98cT_ZFHF5EU7t=beK8m82fjq20+n5dmncdrMSEQ@mail.gmail.com>
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
In-Reply-To: <CAGLmz9+J-s98cT_ZFHF5EU7t=beK8m82fjq20+n5dmncdrMSEQ@mail.gmail.com>

On Sat, Oct 24, 2026 at 05:20:41PM +0530, Himanshu Bakshi wrote:
> Hi Greg,

Please do not top-post or send html email, the list rejects that.

> I found this while reviewing sm750_calc_pll_value() and looking for a
> cleaner way to handle the PLL candidate calculation.

But why does it need to be "cleaner"?

> I tested the change as follows:
> 
> Built the sm750fb driver successfully using make -j2
> M=drivers/staging/sm750fb W=1.
> 
> Ran a standalone C differential regression test comparing the original
> and modified algorithms across 2,010,084 test cases, including
> frequency sweeps, boundary values, and randomized requests.

Ah, you used a LLM.  You have read:
	https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh
right?

Sorry,

greg k-h
