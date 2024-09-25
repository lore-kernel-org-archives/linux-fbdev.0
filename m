Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1524B5B
	for <linux-fbdev@vger.kernel.org>; Wed, 25 Sep 2024 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278116; cv=none; b=SdxzZfoIGVSyGFWrAyjRE5lC3pC8RVSXK7DlPe0s0Gsf9994RAA9JIRR33LvWgxzDlaikwfcoWhA2wsAa5hHrn5SnqAcdWlnJZNZxIzGKcjFep3YPd8D7tV4Mlv9H26Dc7sgIaVM0MZWxuSsVsTKrOu3cYrnvM+Zzb9ZTfMbMHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278116; c=relaxed/simple;
	bh=/B5KIkZH/dNJd7K8EFl1NpdgaaqQMbqnQYkG9BZCTKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZEbbmo2B3TSg7c8mzWhUJ6elqWqSsb/VW5BoKizWC7qX62YG/Ofh5D/VSz0EeE3udnnSY51FsRCXAC7nON0SqHb7kSUnzL3Zrfgy6Pb2mXqtWHt4waRA6N0+l9q7qIR9utg8uOTbapStmTYigBvlXMEM5bxCspQ4fH27XeTRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gn1G19OX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gn1G19OX"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3770320574aso4449956f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 25 Sep 2024 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727278113; x=1727882913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PSyy4BN71dy5mqHVexLDzboTAsKUKc2hyFTi3KyPtk=;
        b=gn1G19OXvt7rEurdAa8o/mgW1cbswZDlAue5/ctfmtRQnkDA1PZbr8XG69QmmNTOMH
         YBxkygZYOg0nYw09E6kpdKdpiBb9uyWyZtSRlAq/PvGDMii6Di+aRKWE5pz+YtVcEreb
         TD32bPwy5GO+cbESQHN+PCkcjY0XXnbufAuT1QzXvqbSivMPxPLgw427ztIBVVtXdbJm
         y01UAZPFDNDnjdID6dRcx20sj7mKtG+DOzG1nUTNYFG+KKDEF46On9UcrgP0kGIhB0uK
         Ahw9N3fVEz4NwH3JR19ciq4Cmr0jojnbfcc9hCkb2Zs13GWbbRcSExLP2q3r5Mn7t4ev
         Wfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278113; x=1727882913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PSyy4BN71dy5mqHVexLDzboTAsKUKc2hyFTi3KyPtk=;
        b=PGfAY24OxY/Z9gKpI+1ZkgRhXuiqalEfjFnfmCIFIVHebU7IKOBuirtCOPqaMTnvxe
         Z9H+HZjSDWVao94GEBr1a/DYsPY8Hn5qeus158de+mKS6NwEyicR4mygmh6JcTKkHml5
         kplUXuNnNH32g3xymOWN+NQiysSRxz7NFYmVNmJZsh99a/WIR1vo0pY0v7KxSy6gfHnd
         +OpDwOBOgsJ/PLlTKh1xUwFaZgsJ1XljJsHCkVeoNt3hBy4ewvqdlFyN6M79k4wBudIk
         baym9L7coVqI8cuex9RWz2qNjCBOjJckzRE2FeKMZPCGAbiW0wv6KKRn2Ow2jciCWWtt
         tQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCVsd/FXp8del6NFB2zPAQ13UAT99n/o7c6aVE5IXbwveIc6kADV0J8zapfWDMHsR5vPREKFICNiU4+UxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3Hznd9mn4+n4oG9WHvGnwijmJVyyaCsDgTaKNVJaGra9cZLV
	YHpwoCQ08outihky+WZPyNp5g+RBiC7GrpZ+oHfQ7rVRUNBSP7uB867zNb0DdQM=
X-Google-Smtp-Source: AGHT+IFp1PAa7fUkvNR1Hu5TOkbb60Z/zetDN4Gii2Kf3uJUYk6thZOMukVHn10+sCEkHp+fUTfHpw==
X-Received: by 2002:a5d:6e10:0:b0:374:cea0:7d3d with SMTP id ffacd0b85a97d-37cc24c5a71mr2197820f8f.53.1727278112851;
        Wed, 25 Sep 2024 08:28:32 -0700 (PDT)
Received: from [10.2.5.161] (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cc4a57d00sm1747754f8f.64.2024.09.25.08.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 08:28:32 -0700 (PDT)
Message-ID: <da15af17-e5cc-4714-9fe1-4683d990abbb@baylibre.com>
Date: Wed, 25 Sep 2024 17:28:30 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: adc: ad7606: Make corrections
 on spi conditions
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-2-0e78782ae7d0@baylibre.com>
 <20240921-playgroup-regally-f26c17be26dc@spud>
 <56090167-15a0-4386-89a6-c379d70faae6@baylibre.com>
 <20240924-unvocal-playback-2753bbbb0e45@spud>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <20240924-unvocal-playback-2753bbbb0e45@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/24/24 16:59, Conor Dooley wrote:
> On Tue, Sep 24, 2024 at 04:41:50PM +0200, Guillaume Stols wrote:
>> On 9/21/24 23:55, Conor Dooley wrote:
>>> On Fri, Sep 20, 2024 at 05:33:22PM +0000, Guillaume Stols wrote:
>>>> The SPI conditions are not always required, because there is also a
>>>> parallel interface. The way used to detect that the SPI interface is
>>>> used is to check if the reg value is between 0 and 256.
>>> And, yaknow, not that the bus you're on is a spi bus? I don't think this
>>> comment is relevant to the binding, especially given you have a property
>>> for it.
>> Apologies, I missed to change the commit message, it will be fixed in the
>> next series.
>>
>> Since Jonathan did not like very much inferring the interface with the reg's
>> value that I used i the previous verison, I introduced this flag.
>>
>> However this is only intended to be use in bindings, to determine whether or
>> not spi properties should be added.
> To be honest, if it is not needed by software to understand what bus the
> device is on, it shouldn't be in the bindings at all. What was Jonathan
> opposed to? Doing an if reg < 1000: do y, otherwise do x?
> I'd not bother with any of that, and just make cpha (or w/e it was)
> optional with a description explaining the circumstances in which is it
> needed.
OK, it will be removed from the series and sent as a side patch because 
it anyways does not really belong to this series.
>> In the driver side of things, the bus interface is inferred by the parent's
>> node (SPI driver is an module_spi_driver while parallel driver is
>> module_platform_driver).
