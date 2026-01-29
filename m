Received: from smtp.smtpout.orange.fr (smtp-79.smtpout.orange.fr [80.12.242.79])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D537BE9A
	for <linux-fbdev@vger.kernel.org>; Thu, 29 Jan 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678368; cv=none; b=dw7BKlUJTx9uzGUVDtHe4BWVDvzax10hd+kC97hMZ8GcbKSWoXMcX3aih+35R/tvpkGHfWh1PK1k/4LOP+hY3HLyKhG5lhV6RKYkoAyXlVwRsZ3LJANFHBfN56QwhcasxgDyR9gwkzPCBmbLiu5saMnnelCCbnKzikpnCeA+7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678368; c=relaxed/simple;
	bh=PcMmVx4vE1I280LP4EFKaqGr5PyhcnobQHkFr/t1ttE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAA54ZAO6+o/EKqyN0b6wpTm/juWHSdMWyBGq5W/jx9v17XIUHjAopQzm2Zy/qlTypwrkK6hn4K9WcUc3NkJF1QbP/TNQAyJPn18vpWn2OOLalne/7lkeikjXws9De49Zkl8VpYFa8Bj1yXMXEsMbLdDdFbUBd+Yyg/utzX987o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=orange.fr; spf=pass smtp.mailfrom=orange.fr; dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b=QyJd1PQL; arc=none smtp.client-ip=80.12.242.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=orange.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b="QyJd1PQL"
Received: from [IPV6:2a01:cb1c:8326:c500:bfc0:b7c5:d0ed:4f38]
 ([IPv6:2a01:cb1c:8326:c500:bfc0:b7c5:d0ed:4f38])
	by smtp.orange.fr with ESMTPA
	id lOAIvMmdHENaOlOAIvZhsQ; Thu, 29 Jan 2026 10:18:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
	s=t20230301; t=1769678296;
	bh=UM8iBqMDsUWhzMzQ9Tf5yBcRW3jJ9+1KuJO+unr000U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QyJd1PQLKzY43wAqv62nST6MyzBHr4Q3QvKVl9G3WHhmN9AW9He384fcZQJTpEgeS
	 WzEczwkt1FtLrQc6zTFSCPoHs7eLRTpPFOzF8Z4iaatgjwdDm2eHESQYf/JdxH2VE7
	 ZMKM0b8ViLwH+RNmorDev5XkQLth83aMRj+b65SlwFZhkvGWDBfqV7obbuQmA+FEMD
	 xaTJwXBBiTjru+mcAyqXr7lELGpZRMAtO4ZsPNOqjFmUOkWpugwjlaIFucQR4EbPmy
	 C+RxumUSqiFUfxARNSVwjMxDaqQVa3hHP89DVdtbgqxfMmzZ/LbQe37nHDXkUg5PK9
	 mi7fpswEb5Wng==
X-ME-Helo: [IPV6:2a01:cb1c:8326:c500:bfc0:b7c5:d0ed:4f38]
X-ME-Auth: cGF1bC5yZXRvdXJuZUBvcmFuZ2UuZnI=
X-ME-Date: Thu, 29 Jan 2026 10:18:16 +0100
X-ME-IP: 2a01:cb1c:8326:c500:bfc0:b7c5:d0ed:4f38
Message-ID: <6606a440-546d-4b71-a244-86bb7c819d49@orange.fr>
Date: Thu, 29 Jan 2026 10:18:14 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: fbtft: use guard() to simplify code
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Paul Retourne <paul.retourne@orange.fr>
References: <20260128212644.1170970-1-paul.retourne@orange.fr>
 <aXqI7qbxZEulU_GO@smile.fi.intel.com>
Content-Language: en-US, fr
From: Paul Retourne <paul.retourne@orange.fr>
Autocrypt: addr=paul.retourne@orange.fr; keydata=
 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
In-Reply-To: <aXqI7qbxZEulU_GO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/28/26 23:08, Andy Shevchenko wrote:
> Sorry, but I don't see much value in this change.

Understood, I see the problem, I'll try to do changes that are actually 
useful in the future.

Thank you for looking at it and taking the time to answer.

-- 
Paul Retourné
