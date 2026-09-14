Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438AD40F743
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376089; cv=none; b=WNudL2WYgIoc8xzQYcgL9+utxwydHg2RLOMTiekBFqU9IhMvWeT0/r1bPyKVnmXzKq39VdjUfW0Zz5ErGNaowOBfHBVrOeJDt+GDGs1yMaLEsRS48sIEy/MoaiU+DaUyi27scFrMKNLMog5OCeClcpC/0A7YxRqUSD6ZbudFHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376089; c=relaxed/simple;
	bh=Oex4lP6M1jAXUHgnrRyELQLIdsFXA2FcI8B6FYB04/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA69PWqcCplmeFwFInONBK6mG7ORKJDcDt3VTS1lNptrlqvSeF8K9DFEY+Qz0ow3oFIOWJD7rmi5h4O6GXH8qfamVg9dTvjqWUs7+L6+IHTxSsephNUhS/D7Ch2m1XgkA8IwrnBWMxd5XL5sSYtlRgizHDC4HNcGLm/RSPKOaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8Dh/H9g; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8Dh/H9g"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056be4d1so1400904a12.0
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 01:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376081; x=1789980881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=61OP6MUp9ANJJBq18hSWE5M/OYvgWHC2avjw9EhrCSI=;
        b=h8Dh/H9gyyLcDBVnBPk858zgxPocqSfXaC0BWIMAtTZqT1GZpkI0h4wR3FqKIzx/X6
         HMnbebPgCx+sH3Wv58YNmLZ4p6xQFekmD3Os0tQ84VUr0TAWLxwijyQ6+QLWRVMm8IWg
         ZtHMnwBP+ojBTO6rjvYGT9weW5kBmpgjben9j7ixEu29i3djbKejqsXwv0vI5lcWi+JP
         Chii9V7obH1y3W3P5d0Swiefyz67kOqIpylPI0pnDQYXtMecyE+Nw6EP3zGL1QPksyVq
         WUeHmqZ+JQldB6oKHtw+XHFIzZhW8kAlHnKwyw4YTTSkdNKJhhuPT+qoJgxHFp5G+Z3r
         o1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376081; x=1789980881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=61OP6MUp9ANJJBq18hSWE5M/OYvgWHC2avjw9EhrCSI=;
        b=Vy30aehztQt16H4oBNNYWhg9cZE5T7UNAQQxItb7UtaCkiZl7b/BDqrR/HW9W8w2G9
         gJiVWcJFEtOyqdFRlOYvg8ARHMQS3k2qQNEclLXoEjrXCwH/3arEYBfu5QdFOVkV3hzW
         eM3y7GrSbtzHKKc5yonZSR5AkbX6KxRcFqfU/uCIrHpwSIRKVD5LI/NGoS+B5sJlHUWt
         zU/YGCQfhOrDbSkopb+lnJkiZbEUnW9oAo5KRQahlBLzSCJ0u8oK8OuMDI1bDfy3h/mA
         fXhpEoWVNnl7xE4hoUlnwgitj4wstnPGoNIlDaNBf/5zCieEqUbWD9ecQAujn8yq5cTN
         yOyw==
X-Forwarded-Encrypted: i=1; AKwUvBx2aKOf4g8vQlKIbWTsHQpadi/bj2JjArl7e7St037uLItSqg5z2k3MkvBl2yRS6AAolTVtymOhxk2QoA==@vger.kernel.org
X-Gm-Message-State: AFuF++mSCk5hVBPcRDfQos7Dc0GTFtnNGlKjaElplBaqYnYTg9PTjvhX
	kdL65p+p2Z4ZnWS4PPJpK0nisWBJ2mApn0LYoAfCinUFrTqIwNRfFnfp
X-Gm-Gg: AYBFou13tXRCe0TnivIU6EaqAKGKUUzGPLDm9ehTnz+0r7QO+viylteNU4wXj9ivB8X
	9S3T8TeksdvhX8ZPvt+MUDLTrY8i1Jqau6+z7ABMs9zaaJkZlfOYdRfHtMqcCZZ4TsCTrGI6UzK
	LLNWFT0/X/2zW9RMLVplhBqe14w8jsQPchUREslSLKyXY4ugfCsvi5BbxX60gK56ObZ433tBYeh
	zeCZx80HZPWJC3W9rka5vWYmHh1sIQkN2fd8AL36Hpon+jPnSYlQfT9O4vZuTgiWEVWPiICfPpX
	6dvhbnDX2Oc3+5Qc7ueDQJunZ+H+9gxxu55tLJ6VG4QdnH4tbWBq/M+KQWHZ/5T8HPgg0QxLBOG
	YyV14cmz2RIcBrDBa28gYZy65qAaBvrhcjtow6/5gb+lJyu5vTvMBWsLkABibazGaVDE2/uKk6m
	sCvj+VuDY7SdBYq5CXYLTDwA+29T9861t6unx7xi4Dhe4Y2oXo/pIJQ5eeGecQgbgliYNFr+Uws
	Zho9Q==
X-Received: by 2002:a05:6402:450a:b0:6a6:32e3:9ba with SMTP id 4fb4d7f45d1cf-6a9f652d7e2mr1058343a12.10.1789376080524;
        Mon, 14 Sep 2026 01:54:40 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9bf18d240sm3677157a12.6.2026.09.14.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:54:39 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:54:36 +0300
From: Dan Carpenter <error27@gmail.com>
To: Gabriel Changamire <gaberashawn@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: sm750fb: clean up sm750_hw_imageblit()
 kernel-doc comment
Message-ID: <aqe2TCpR7FSoykOE@stanley.mountain>
References: <20260913040140.4517-1-gaberashawn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913040140.4517-1-gaberashawn@gmail.com>

On Sun, Sep 13, 2026 at 04:01:39AM +0000, Gabriel Changamire wrote:
> The @start_bit description contains a stray ">-----" artifact -- a
> literal copy of an editor tab marker -- that leaves the continuation
> line "0 to 7" garbled. The @fg_color and @bg_color descriptions are
> also missing their closing parentheses.
> 
> Replace the artifact with a plain indented continuation line and close
> the parentheses. Comment change only; no functional change.
> 
> Signed-off-by: Gabriel Changamire <gaberashawn@gmail.com>
> ---

Acked-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

