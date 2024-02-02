Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674297C085
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869690; cv=none; b=AvZNjH8n0rfha0JNa7nnqgEQhubIpzOrBOkWXy1MGR/seFjTjcQ/z7zLvwFXpGTPhhdPvZGE5Fq0fQBggQYXNQjkSQoLKd1b54FRxMKNRA7LTZFd6t0qugxJWv+sK3ZZd1BoDp1CiSdtwIm5qkpN4KrZH5XVKP3fziXEjG1odjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869690; c=relaxed/simple;
	bh=2/Da7iSAM+hSEJQc2pdJinoCauC0NHyaf2M4fIa9JHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHtUPEeK/dr9Nr8x+zNEoVqvK3Z3vgKVohabI2g7L677wnvZWTUqG1MR2G1uHpA1yMzqUHh5TGVmUM28izUoHK62z4BaPCPIuVyANO6sDsmEtSyB5xQT2H5DCTp9X4LaOzfazVjpVcIJOTvM9v5790GwCpZlmhJLkCYvBGzYvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIRQ63Dl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIRQ63Dl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fc52c2ae4so5588185e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 02 Feb 2024 02:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706869686; x=1707474486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/Da7iSAM+hSEJQc2pdJinoCauC0NHyaf2M4fIa9JHg=;
        b=LIRQ63DlLKShu93wGq7RWHEzrcvCwtzcbFOKLkKU/QBrKSFCzAJwJ8Q/n8wylgpGuT
         TS6juX9VryLImHJgevFf9Q6Rh3KDqQfKfe9hy8WgLo4gP0tiG/TIoQm27TeSd5IUME+6
         TY2HZncudsOu4AH6tQ5E5KSNme30FYfanKH7IG16OZqain2Jlj22vCM1GyGh3imGdOLa
         bhU0PGx0mPOL0KLyxgCyouamchbzXezkIBh/5cGQ0fvSlexGGadezCVarS2Mtgnb3aMh
         QT0E4LGVaX8oe6KUWMZmhdYxIjL52DJv7p5LDKczF4h9Ug79BSlEJDrEphXHejTeGHDs
         VVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869686; x=1707474486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/Da7iSAM+hSEJQc2pdJinoCauC0NHyaf2M4fIa9JHg=;
        b=ooq0dUIefjfukgYO0IXJIFnpz0H2OM2I6P+NcYKUraNvoSME7x2f0JjnK7bOoGc/lR
         p79rNt9BNNNowCL9oimKb6GXxy2Kq9Hnvr8F6dP5U80q/OUmi8+yHFsadN+uW3qGhb2R
         +wp3KU3iWbFZsRu6oNmLT/gZkkxzRN1rwnrgDjoKDCHg63JBV5OfQkDVNylcKjhjvO7g
         g3WhSs4XnJGgCJnJpqoXnrlolHGpAbuUGnW3P0GjMdntapMHL4dFY8bqwr6rCDAloBwt
         xt3zvy+/AcsNSJHYVkpw1ui4DeQXrYpmRNu3FK47ghc8CTVdxBY+mrvahyM0hybZI5wW
         9K2w==
X-Gm-Message-State: AOJu0YyBnie0avnGXkD3kD417ykNwYXnY2ik+/iiqv2UtSBAmo1VdX8m
	RIT6RyjeMX4S0zmAjb0mJPrax3rnqK+ayxhKEPrpe4MlYa9v19R3Bl70pwHlcOg=
X-Google-Smtp-Source: AGHT+IGMXT3XWWEvbzuwMNynntW34ELZHTsj92DyKaerKBIwfmX+aA3iAPap8FTJGJYfV9xreKUstg==
X-Received: by 2002:a5d:6906:0:b0:33a:edf8:b8e6 with SMTP id t6-20020a5d6906000000b0033aedf8b8e6mr944364wru.58.1706869686647;
        Fri, 02 Feb 2024 02:28:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJu5T5IJIGw3K95vPY/OnQFF082/yxjTHdqHpiKr6aXt5Wqd7f0jz3eHk2ffINlj212dcbw3Ip2XBI4t96uchzHDi8w6ar+PYoGSp9EsKh8sKpBWKkrhvMyT58AqoEUM1Qdr/nkeXHcg9fW5bM2QgwXF+x3B4WAS33wCHMmd8KJnJ9kC/ag++Jrgq8K/gFt/7HEPY2VHx1lw39QfN+IRw+U5S/z/2TKmAkF8I9LARFZ9J2ZvCJ2WYi6vmrg4dIKg==
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600000d100b0033af350fb88sm1605304wrx.25.2024.02.02.02.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:28:06 -0800 (PST)
Date: Fri, 2 Feb 2024 10:28:04 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 1/3] backlight: mp3309c: Make use of device properties
Message-ID: <20240202102804.GB373571@aspen.lan>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
 <20240201151537.367218-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201151537.367218-2-andriy.shevchenko@linux.intel.com>

On Thu, Feb 01, 2024 at 05:14:13PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Add mod_devicetable.h include.
>
> Tested-by: Flavio Suligoi <f.suligoi@asem.it>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
