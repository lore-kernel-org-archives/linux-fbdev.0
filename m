Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47415E5D7
	for <linux-fbdev@vger.kernel.org>; Tue,  7 May 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089363; cv=none; b=HJId4bo/sD0NvEQbO2XovK9wgRUZxtjl+ctyQg8wcMyNWPAdpxdGJzIlpFkSpuwNqBEO3weO4fd1Wg417McBKRVVVcfYzzpirI6AO6Xbqhb2pzXF252h5PxDdxRo6zzW6rJ3UjoUtzvZK79MmzbWrUKHuooJATvNJnM0Mk8M2ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089363; c=relaxed/simple;
	bh=RNmcCGwn/9/Ko6Q/dYPFgq3QsYqQcfCFf9m2+RNV4HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCCXXJwogVbt3aKadGwEfQVydqkQRhMUEdgqBy8+bVlulkN+g9QR+M3Ho3+a+xoi28CTkgF8rrbiIU+ITklQx8TpC6/de9tLTktpB/7SIs8BiEDJ526OIo9LkmXaEQgAnM1cCEytjS7Yt4UUVaedDIj9qu9XL+6w/uZx2STMDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EM6D5uBt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EM6D5uBt"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f72a29f13so3846510e87.3
        for <linux-fbdev@vger.kernel.org>; Tue, 07 May 2024 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715089359; x=1715694159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofLWh7+7lynH4ssD7W2H3GNyThDD7FYWFzKSbNNIGKY=;
        b=EM6D5uBtVlEU+n43qaoL1hr3JnBjtUe/oCp3lglu3n33yAw0HtWVY3NlfGPmQURieS
         OCbbGGcUn2rBBiLtImkm0KcGmtxr8+H/spSJIIFVhvXQk+7EZ+LEdgq5z0K3+w07NDuy
         VxFKF5Dy5yaJLpxPlG1ZBqDn66m8FEGWZBn65FvFNnDOPhmdeKe9WXjl4V+rsg4K8EOc
         FKz/x5TXTWId3zVEk60imGeaDIwnUSDhFjdFDbNE5IbwhhpGu8OgNU5/ZKv/jgRyOIVo
         Uf+R8YQY8x9tlE1uivrnJtxP+GxTG42YoxYhszRrbCZkIWWvnyVUzmxTK2AFHh+bEMKW
         t3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089359; x=1715694159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofLWh7+7lynH4ssD7W2H3GNyThDD7FYWFzKSbNNIGKY=;
        b=UOdxNHFzLuZ9dweVK/+5oM05DcZHBfCB5HdC9TmdlpuBt4FGMQXUgWWvJ0h3tOCXUk
         lBxVt5ePmbyKNdtCa+zFYF7ZyKyTxU0R36guy+ONz2s3PA5/zpDgc1ltn3aft6/8+1T5
         K3TmV+8ztV8ae3a29ihn0TTfOvDWCndFltmxMkeN9RAnotE5DKAiTJCHqxq2a182hbRj
         U9hoJekI/8euETWqEMVe6r9ScFWA+TZ2oWZEAM7k5IbypLm0QZMqFO8E5hB4gQjEifSE
         YU8jM1v0wCzWUV9M0Hgsx/afKyHjAiSdJW+WIfDiL34G9FtnQK4MDwjap5612DNqJTlD
         sd7w==
X-Forwarded-Encrypted: i=1; AJvYcCXl4XtULTGNnjVUjCeL6jts/8Wjw0UC6H+zYqmF1rBHwLgtQWDQX1dYE3fJUrUUR8vL2ZwZl7jKx4hJrR7AtNlXsY+LaMszN5kyhLs=
X-Gm-Message-State: AOJu0Ywp3sEwfUZBaatOcUgXkstCR5qwbGveDCPmuTgy81P4DkLsmdzG
	0oQMDwp5tK4O5cB81BfBOJu0RADhdfHnMh+tenQHtDXUgr5dYHxMxhEJtkirfEg=
X-Google-Smtp-Source: AGHT+IEcEQ1M88NR4vmUiqGMt8ZxsM659IZuZ4CO8gzi53YrJgC5MzydtewGy6QWY5cBxG7eM8j7VQ==
X-Received: by 2002:ac2:483a:0:b0:51e:11d5:bca3 with SMTP id 26-20020ac2483a000000b0051e11d5bca3mr8661395lft.18.1715089359358;
        Tue, 07 May 2024 06:42:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id j6-20020ac24546000000b0051da3abd6c8sm2109596lfm.150.2024.05.07.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:42:39 -0700 (PDT)
Date: Tue, 7 May 2024 16:42:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ashok Kumar <ashokemailat@yahoo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [RFC] CamelCase can it be fixed per Checkpatch.pl script
Message-ID: <uewpqrf2hkczmxftsl5pb2lx4tylxcntxqn5cwmlcrx3w54mu5@bc7nta7chbkm>
References: <ZjmsAVlZmA5sje/Y.ref@c>
 <ZjmsAVlZmA5sje/Y@c>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjmsAVlZmA5sje/Y@c>

On Mon, May 06, 2024 at 09:20:17PM -0700, Ashok Kumar wrote:
> Found some files in Staging Drivers for which checkpatch.pl throws a CHECK to
> +remove CamelCase.
> 
> For instance in program vt6655/card.c find the usage of CamelCase as
> i) Variable names eg: &priv->apTD0Rings[0]
> ii) Function names eg: void CARDvSafeResetRx(
> 
> Note: some of the functions are
> +static functions
> 
> Reviewed lore and seems in some instances removing CamelCase was allowed and in
> +some case removing them was disallowed.
> 
> Hence wanted comments if we should change them or not.

It's better to work with the corresponding driver maintainer. Generic
comment is that functions must be renamed, while variables / fields
naming usually depends on the maintainer's decision.

-- 
With best wishes
Dmitry
