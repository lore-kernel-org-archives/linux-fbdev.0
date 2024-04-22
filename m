Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0152F71
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Apr 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776074; cv=none; b=cxFheMC2R9RwBTGeoSaB4N14gV9IvS/jZWUiKqeTO7Mk9hKk+426mx4P3+bX0lhTM4//RQBHOOOlZH8CFGbDWLo3K1NIODZJbJpY+LWlaWdrkGuOnDSrizEjcC5aIjyQJA42Ve8QqSzChBdJ7DQKVtxXISGNnwDy9FJBGpfA190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776074; c=relaxed/simple;
	bh=Ojlb8Qt0GEEE4R5EwrEjmiMm5jfeRBt1cc/0bYnuMEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNCdd6o13zz4Baevxp8ewVMzpF7+66BKoZMMbqWzGvRGTaaSLBvco22cbl2jzM3CiFVqguNnVu+v1opVrCpqdqkc4KX4XbKCxlW22AoCLcAEkVPjjG9AQKEtLeutUCC9L/b/U2EXg9QPpdGR8nWgPydKb0feIIP3R6jDzjk7Bbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJPvJdYf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJPvJdYf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a7820620dso2299005e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Apr 2024 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713776069; x=1714380869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ojlb8Qt0GEEE4R5EwrEjmiMm5jfeRBt1cc/0bYnuMEU=;
        b=LJPvJdYfzCOidJJq73BMPDAC8MQv0mpbRbL6XNN/KyQyssMb6hl4aspFxewZsgCVPK
         tXoG2vlqumypH7N8F7/fva8Mm7LmzK8/5qcOU9mpX25/4XrA5iPv8qViXE7Rk9zDLlqs
         yluEothypDf3RpGU4vl41PbGGe3P+NXXPIUtp8nT58OtjjOhh4oC+QOZIMVl+MDw45Y4
         WBrIBYnEuCI2CRaiHAsg9FAK/XNmmRPtKNG3r/Jmw6xuvXSzfaWwR143F7tOE5jxF627
         M4NMqW/c55JA+ThSG9N5v81iHwSkcI5huLdvV6N/TwFFDLsPXmdbYGdqrpmxEyFk/EUh
         BQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776069; x=1714380869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ojlb8Qt0GEEE4R5EwrEjmiMm5jfeRBt1cc/0bYnuMEU=;
        b=oXCcxIuwi26sr/pzD0yXI06t76F8xkHfR5TpZ8xRQNJLH29zOY5ao6iHQdEhUInfGU
         8Du/TNyr3vGRjWgS6o7zd2La5MlMRQuKSltb9c9nHfxGmlzMu4QL7+J6G1oeiXGU+jKi
         JVB1Z//cKmguV1MnG1a/m95qykoul4/RqLH/tI25eHfZM6HlEAaxr7QM31OzQ1BIKO10
         BxCwvhM8j9DGEgL9BVPL1iNZEGNMSZIxRS0Pw/dWeWr4CjadJ9zMWLy/tCJakq/Evbun
         JTxzPz7tAX2a6lR74dCJ0ybrCGDKg8isR6P19OgDYpq3vZ7zfCIJdhRzpbj6hESlr0kV
         qejg==
X-Forwarded-Encrypted: i=1; AJvYcCVZkwrzvr7JS5Ct8MUMt4L/Qsh+q6my/HllYvczTlUcx1ePTAIs2dJMkE41frImlu7JVVu40d/aJv3Zk60gHM0/9HlDju9Uc6tJkc0=
X-Gm-Message-State: AOJu0YwJiL5Gp+A1tW/fJn0IGGwqH640j20OVj2G2kBSGbCr/5CiNooL
	5QyN38g0O/sQAxu186r3zzCq68X1Vu/VS5VVHgNwSFESNCXaWT1R+hIIK21SHLY=
X-Google-Smtp-Source: AGHT+IE7k4brxBhxy5f7GNJIFfsaxDyj1gLwlLlyGFa1Xx9lcO7UuR/zgUeMyHEzAhs2lPsesXwQ/g==
X-Received: by 2002:a05:600c:3586:b0:419:f447:c323 with SMTP id p6-20020a05600c358600b00419f447c323mr5006365wmq.27.1713776069623;
        Mon, 22 Apr 2024 01:54:29 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jx12-20020a05600c578c00b0041674bf7d4csm19372412wmb.48.2024.04.22.01.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:54:29 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:54:27 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v2][next] backlight: sky81452-backlight: Remove
 unnecessary call to of_node_get
Message-ID: <20240422085427.GA1290623@aspen.lan>
References: <20240421104916.312588-2-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421104916.312588-2-shresthprasad7@gmail.com>

On Sun, Apr 21, 2024 at 04:19:17PM +0530, Shresth Prasad wrote:
> `dev->of_node` already has a reference to the device_node and calling
> of_node_get on it is unnecessary. All conresponding calls to
> of_node_put are also removed.
>
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
