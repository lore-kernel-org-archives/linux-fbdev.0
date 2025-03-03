Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E91EE7DD
	for <linux-fbdev@vger.kernel.org>; Mon,  3 Mar 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996517; cv=none; b=jZM7nga8VR1LUeIQfx8T4zVF1q1gcfSvNcv89l8/QLY3FRzg0fbeHMsjbxKgc3RY+WLiec9Yh/lm1xkBqplLRGrLJtKSfmaZv/18eE2Q8w4JjT9OQgmHx0o8psIChecCm+1vwK2P+2Jew67lNIfpng3+MDUpkns96vro7M9O7sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996517; c=relaxed/simple;
	bh=Fg0PMUf71HrKqLcTdAMEOyWnPDpROLGy0gLEnbMjfIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE68A+dSrZFvdNon7RALCblYlPsmyzPt9UPWHo4XfwY+Zh1Z6bJYse0ZAUebvuaZBdPOZae0MmkLVomkcy3/LJ2hwC4ffoEXyKiQpOvKWplKqPEaIzFKxyN5oj1H11w/3LLtmOwrOT7m0TdwyQk/WSnWroWTDFlx56K4S/EjpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KFB/Uj9f; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFB/Uj9f"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso6653692a12.2
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Mar 2025 02:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740996514; x=1741601314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GjBFcA67rMS7ZHAwLBuRWTDfKIm2qOaBa66RMYQiiBE=;
        b=KFB/Uj9fe1HQqhfh294N7SmosO9Bl0Uyrom98f3vxF/vx2yjJcd49hG6tdxfHMWVU5
         avqx5k1KEL+cioBmDPZDYBcY3fHa4pqfLHTqesF5N+tRzDEN5JX+DTE19/F0dIaWX1Bg
         1apLKX1lxhh4vsZJ0nPSIE7BeSuddlTJevQ76g6uIZJSyTMov+O6lVpC5TOQ75pNhhaa
         Q5BrDlFuC64Tq1NRm66fkV5+HdF26K0hz8dvDIT/caMUDpQy0afbpNHjndM8L3T7ttob
         BP1kSbL4dqIG2CddQ94zMRKZ4LMkHJEZhsTWBAkJtm4atZJbn2yU9iM3UwEiDXaGiUn9
         MwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996514; x=1741601314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjBFcA67rMS7ZHAwLBuRWTDfKIm2qOaBa66RMYQiiBE=;
        b=BswEMHDgDDTROpQ4qsuqwaZB8fch52DArDvv/Hvl8jA/3C5bDDoad3nkPjZol3Y2nm
         W1G0P3Huw9/LY/mM9x+zqxzvDRUJ4q3rUoH3zd6Z7dzGPslwD+wVPyWAiFPYsEyngEWU
         bl5zttgFj1HpST0TMfe6h6YXbOZQS7QPg8Sy6qJhdtB07joQjGbVbsab0YY3jocvGbq2
         CZhid3HLAI4ryCqzg/FRER1XhRQ8awyqgFYjpbhxFxvdQCRXt3gRVADCDeHmgnBmNnJ6
         g5iKjghrLXr5C2uN+5GkwjyD8CUWHYNbx/3wKPouAbDbI3+Gl3n83AsrTstsx4kaEEYp
         /T1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKZ4+qHl2S7K42tNrS9fMr+86hM4oysOJtq1OylU7jUxY99wCqwT/Cdegci9FzAHuyzdd4VuGtfjYyOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bLCdOqC5t1qtMwDqnIsNcgXRs1sVWwVLwirVcWpZs11cvBi+
	u4pyzAzNEf75e01S7K27EN0QzcKSkXm0ywf7wXI04ynnZMrWubZava6cvkKk4aI=
X-Gm-Gg: ASbGncs7kw/tFkDiiG3Yb5CVOvJgi9AH3z2b9dLwB1PdRzy6pCa/bgtC5BkZV3qCGg8
	I/fGqkypLJ4bddmGuhkEsWo3W/R6TKJYB+7bV2T+9rHsTgz2xbuZ0nEJrOFkkMp2W/lxX1djbM8
	qipJ1L1UuVPTknVRkjF1pG7Ko8UZjkxc/blvtMeIDg4lARVJsRGfrX0JKR1hWsWB+HCUkiGCNlY
	QPJCJYufU7PGDNetajRKb5fmHUeTNikAA8turtPbabpzlGNBt2XeyKj7gP1wMUdlU2yKBZc+kwR
	BhrfbcS1MAyEe/RVndZGpLn/pwkkCsGugWYTXQpMZrTrTfHHqQ==
X-Google-Smtp-Source: AGHT+IEPxlHoiKz/rey+mSNj9p6SHZuD3oFGIyaUPKEFRRWxafVAlE/vcmhJEnz4DfJOlevycDZ6wA==
X-Received: by 2002:a05:6402:274a:b0:5e4:c235:de10 with SMTP id 4fb4d7f45d1cf-5e4d6b7b21fmr11376850a12.32.1740996514382;
        Mon, 03 Mar 2025 02:08:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e4c3b6cfd0sm6648394a12.28.2025.03.03.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:08:34 -0800 (PST)
Date: Mon, 3 Mar 2025 13:08:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Yihao Han <hanyihao@vivo.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] video: au1100fb: Move a variable assignment
 behind a null pointer check in au1100fb_setmode()
Message-ID: <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>

On Mon, Mar 03, 2025 at 10:19:06AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 13 Apr 2023 21:35:36 +0200
> > 
> > The address of a data structure member was determined before
> > a corresponding null pointer check in the implementation of
> > the function “au1100fb_setmode”.
> > 
> > Thus avoid the risk for undefined behaviour by moving the assignment
> > for the variable “info” behind the null pointer check.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> 
> Should also get
> 
> Cc: stable@vger.kernel.org
> 
> to ensure this is backported to stable.

It's not a bugfix, it's a cleanup.  That's not a dereference, it's
just pointer math.  It shouldn't have a Fixes tag.

Real bugs where we dereference a pointer and then check for NULL don't
last long in the kernel.  Most of the stuff Markus is sending is false
positives like this.

regards,
dan carpenter

