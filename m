Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7E2DF144;
	Sat, 23 May 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548825; cv=none; b=EKmJD6HaEe/748lLlTb8e1IDvtjku3j+J1TjNeRyFi0NyAikhKZw2UrZg+yADX1CT0j0lubhOF/ST0VmR1Ri9hWF6qJ9dXm3pF4eE3xtJdXoesZNKCpT5xO6niPNFdLtAfU/+WYQiH9AMEXDSbXqFxNXpG/vdZUVlHb4f0wT/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548825; c=relaxed/simple;
	bh=j2IppVOpweqQVhe2dXtJ1OCa5Ga3/OrndaEyITUPZFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nyiqef8z5uwOrEKsn34preeS8dW3hwHitBEiKKH5fg/dnh1xD1jensEHr1VIZiLwsLpqTNKzAqBJa+RJ19Lc+QkmxSUENUUdtTMH/ZwagUKWaNW8r1pInSyh8Wh/tVZA0nHiBWqEL/+gIcFKSuW9hzj22sDcBENQuhN8qL3ZXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=BU80NdUO; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="BU80NdUO"
Received: from mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:908f:0:640:1b72:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 61F95808D7;
	Sat, 23 May 2026 18:06:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net (smtp) with ESMTPSA id m6XJFJJoJOs0-SG1YRLjJ;
	Sat, 23 May 2026 18:06:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779548812;
	bh=y6NdCGG3AsLnD4IYD4okWiiItYiNTRHeS+ON2X0uG4E=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=BU80NdUO35cZgJ8aqwP0q8N1BdzROx1gTAQHlLlQOQ1kXXmu+3WnsYOY0a+cNJIdh
	 /ndvLlRaWWCdzLdUzcXz+yF3hnYl9Wti2xYH7jMYQMvRByIRYCo4OJu8e4IDYQMSsD
	 yhFp+ve3GwvQMm93ckglnsR6l1YTCL3WvAZT4zb8=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <bd5810a1-8451-4e1f-8b6c-aed630972736@sezginduran.net>
Date: Sat, 23 May 2026 18:06:48 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] staging: sm750fb: use ARRAY_SIZE macro in
 fb_find_mode loop
Content-Language: tr
To: Dan Carpenter <error27@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260523051509.166152-1-ahmet@sezginduran.net>
 <20260523051509.166152-5-ahmet@sezginduran.net>
 <ahF8dacOkX0tdxGf@stanley.mountain>
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <ahF8dacOkX0tdxGf@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/26 1:07 PM, Dan Carpenter wrote:

> I don't love this.  As you mentioned, there are two arrays and they
> both have 3 elements.  Why prefer one over the other?  This patch
> makes the code look simpler than it really is.  I would just leave
> it as 3.
> 
> regards,
> dan carpenter
> 

Fair. Going to drop that and send v2.

Thanks for the review.

Regards,
Ahmet Sezgin Duran
