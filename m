Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53562257459
	for <linux-fbdev@vger.kernel.org>; Sun, 28 Sep 2025 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759102164; cv=none; b=qKc3qrJTh0jo2k5NYcfn0GMlgFIYmF8aVOlhvgoSxnVLR9rn1BkTw37bCXGUm7X8o/gOrq2+CRGrvcLoS09OTW+MH9iciYobj3qtYWcoA0SAKprWEEj94AtQa1q9DlBqHEA8P3+kyiKwDTrRBwAr6O+zgqCnkIBvvwGXm1wFY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759102164; c=relaxed/simple;
	bh=V/jzRpqEcOhYwBw3Dnxdh4YkMwhb3CbO4cM8jjUKGXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kbw1dChUh/1rshLXrDmpppnP4WxwWSWw9nJZzmOpUTAi6+4UVZ9DaUPt4Fapw43/NI2bp5B76S3F9dtlDRv5aNjaVDXV1+BZc0+GiibJDXaDUWoABdL7cQAbDSC+URMCb4k+rESHgaUgbKinrwOJwZ+wfHiq5hmQHI148vdZfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4AkhYR9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4AkhYR9"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d60157747so42278607b3.0
        for <linux-fbdev@vger.kernel.org>; Sun, 28 Sep 2025 16:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759102162; x=1759706962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVT14YXhZO/vL323RFIMRVmhhyNgiqUs7sCBFMwP2Vc=;
        b=O4AkhYR9CT5jY/vm94Lqqq1W72e+5ENmIgOwLjtPBbT8tvt2l90VKut3ehoVs/l+E9
         D8fRyhNrUIWbqf3yBCTNWyzJZFIu0xkXS5/DioT7nLqmvv8lo5tbeYJjEjVPt5VUlFYv
         KR6mllloIcJ7fG2oUrLu0t/Rvl+6FmT889RXfPjENSZirkkyThFZkQfzjc95ReOIaOiX
         Arht39dnJDtE9CjEiLBlW45xmxaBHrBfHmmIMYk9NVa8uthi6KpvtH4MshkEmOC7Od0v
         Y3zw6ZUZwqN7GtzZkCHrIh8sXvtgleVDPSEPRVogRW6m6hjdmNF4Xm4JB5W31zI6sUkv
         ORsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759102162; x=1759706962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVT14YXhZO/vL323RFIMRVmhhyNgiqUs7sCBFMwP2Vc=;
        b=GfLzb8gwerxZDitfYSytAgI5UypYhCuPfJI9ul7UOW8eWroPFqDO7iiGRjdKjLcVSx
         QxKUzzKhM7Iik2PLQ+leusGtTGEGKfpxFkkjdVb0w2/CUt86sxhtvluuQNwnFyfuJiLl
         u/vocXJ6yg8GejUmqbMMnhBpU9T3QaMeBpunPYse1Oi+tXLoNhKPBbb2cy8AZPyv/uxY
         3/a0JOB0xaSYv/KVIfKe4JQ5pe7ZzkDVsvZ5pQHQJ2jbBHOEp6iHJ0hO69eWo9scoygP
         +cqlyOREYTxjuDgvdPWJL7JIffKh71Vcgpnx4ZD3liEJqTHkpapmGorERq/xYlMCA26R
         OnmA==
X-Forwarded-Encrypted: i=1; AJvYcCUerE4OQqRRAM2CWlZb/iDzF46eD88YlbOGSy/iTda+6jOqIkyRgEci0yKsxNggU0/4gO/Dbm9se/w3gA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/EZaeRsqnqGqOR0Y48CTpPN+7FNMKL+KgvqYG8LywUjaWl7RR
	aqacNXDSK+rqA3XCexhHA0hbzN/seRyB9dvmWWuqIs0jihqZyY0EqDb1
X-Gm-Gg: ASbGncujRR3RLUPse6+TV6QHfAo+wUR543eZ6/Gf79v1Z2y2TjC7XBzWnaZibnqXnEX
	ODzfcRBv+Je/+ZdfhAOsfMYxjjgQPzud+ruWRuxFYbsBLkhOIE2aTkgBI+kqIlFWE4g/DKXhJNp
	qd9aoyRAPdB/JzF1+Rq0U6P1eGHDkEfxfj2ZOnq4mEp0sHcJWm3ZiALWMjiV1/6D8gAhfpbbCS7
	adv1XPY6PDPqe3zkuGmp8NNYsEWjE3uhS/DOZ41b8iEeVXHLbILhNDasezxGRgIXpepjgjY2vYI
	TvN9/9ytY0ejGSvZKCPz+DknLfCqkrfK70wIlkRx0o2bH3MOF7h/X7av+Lnd1PfJR7FaDAqvWv4
	HpmxJdNmfMdH8tTYAlni2S93im1tvuP8MTt1HREuq
X-Google-Smtp-Source: AGHT+IHskYhayDwfzsV8lkE/Uops7xgSMHfw6Sw7Fk1JVYa5Q3Ma+PAZWIZOs7Aj8ggB//5BDs9q8w==
X-Received: by 2002:a05:690c:6f85:b0:727:1d96:46aa with SMTP id 00721157ae682-76405202175mr180066857b3.53.1759102162293;
        Sun, 28 Sep 2025 16:29:22 -0700 (PDT)
Received: from [192.168.201.155] ([76.200.76.117])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-636d5b1d960sm2016142d50.31.2025.09.28.16.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 16:29:21 -0700 (PDT)
Message-ID: <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com>
Date: Sun, 28 Sep 2025 19:29:15 -0400
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
To: kernel test robot <lkp@intel.com>, Sukrut Heroorkar <hsukrut3@gmail.com>,
 Helge Deller <deller@gmx.de>, Bernie Thompson <bernie@plugable.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Randy Dunlap <rdunlap@infradead.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zsolt Kajtar <soci@c64.rulez.org>,
 Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 skhan@linuxfoundation.org
References: <20250924175743.6790-1-hsukrut3@gmail.com>
 <202509272320.3K8kdDCw-lkp@intel.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <202509272320.3K8kdDCw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/27/25 12:12, kernel test robot wrote:
> Hi Sukrut,
> 
> kernel test robot noticed the following build errors:
> 

Did you compile and test this code before submitting this patch?


