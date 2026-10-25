Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952354;
	b=ZMHlEhg563QixYgtLZARDvoRYrTK3ht1PMtIV1gNjvhb5CqA49seh09luxpCmp9FvnmQ
	 4c4Vo6oD8hRJkfEzk1XmtUk/escs7dR/YfObInjVwk21PPsJLu5FzjXEjaNyuh+fqtgo1
	 ruvwwESWhUDl9J1locJPkPhBta/fi2AAnbZ6Zs3EBjJcNPLKORrT1UL/5/ppFFo7SG8AR
	 XMWbareQl6c/a2Ewr9NAlsCih7K+UsOssK5y5cJcrApKVWQND8+IMR3qzIh7DvevDJylg
	 o44T6A2sW1IG9YFBOK2fs2YHcpF4aYCV+jKPcQdRPCQA/1jyomuE6xr+FwUd0yZOSnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=zm2aYmxX6SYlgH0yTM3NHAOca1bMdwRynpuDzR86ld0=;
	b=a7aBFjKxLXUXve+tUP1bn5cpAVhflVfORnYBFjzRwFYMGUeHF+4sQXDmsd8+WBJtM6yH
	 K77ueYYkWXEJfw8FhJQktpr9Sf+r2UcC7p/S9Fbnsbdfzq39QKUthpWS12a6p8AveetJD
	 SJSXiFlGG6aly8OPq/FJAvfINjvPDXsDOrXEWP18MOz9qO+ENS+DDSgwPsAK61bQy7kwO
	 TVZKsA7Q4jR3KsLJVt35lVQr3SpuzkVvZMHh8Tne13VxynX9EXXrIfp+0OjjJpOPZ0Y69
	 icd6loqTwLnsXC9Bpo6Zh0J0yETjAKlEZHMELPoVCNz7yQ+Z3EEctfVDagGIBuOXlbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="oaWL0hP/";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AC606A31A
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 18:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D90AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oaWL0hP/
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so14774765e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792952352; x=1793557152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zm2aYmxX6SYlgH0yTM3NHAOca1bMdwRynpuDzR86ld0=;
        b=oaWL0hP/yXSA52dIc4x/zUCYeMbaEE0jCVb3zOcP2bvASkpqyPrWxkEhROsB5KSLTQ
         J58vY9eieREt6Uj+QOFYQln4Z08eYw+9SFfv3irAuvMpcRbHan2+0nR18M/EUFB9pEI9
         sLRb1B5+jgKxgvX7fAwJtW+N4gxz5JjwC68aa/rLBU2PNSZ/vDwfyDwwBW+zGbNq8cXh
         9KGonJZF7Pl1OQ6WzWp3olyi7obQNUx9hqfH4gQLm30w1DgFkPq2OwvQOOTIlUxwxJCY
         uN4QOdXeaBTe67PI1zK7ZJdHHj2ggng2fBfBiJlZ4MIKtnmXjvjEVxStYOfjWMC+q6nM
         Lr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792952352; x=1793557152;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zm2aYmxX6SYlgH0yTM3NHAOca1bMdwRynpuDzR86ld0=;
        b=uPrwhoWzZYoa19DNaPaTL/ah1Y3bkA0hSr0GTEUFIUJiwZBoK6Z/LcDItGsoJrpUGU
         /LnjPqZWCtWUerB0GeHAeAEC+6OACMSTFhfF3q7aDFhjUuHtKyxMDnt3CdOL38BGbuLS
         jo7+k0BQpb9aoaL3vUxPzcRE3rhsc7YA8ZsN+A/2dGyKC5YhdqM0NO+/YqjJv9scFbvj
         ozBPSUR0tqRgQ/vo+VapKP5g7ARKj09PitSedIqeLTCPpS6FX2GYLjVYRZS3ZdhrDIA/
         5tS5/+ZMcczaN9rkdp0S1z6Mk5wFH2uK+hqQlkSDXRbh8Zh3xwzFP2qHDGU1LnHkvbDv
         RJQg==
X-Forwarded-Encrypted: i=1; AKwUvBxerBqhhTMiy06FZ3UL7JMVQpgrgx62NAGdFTFowQ+DGgQKXM6Moj48RgjLvLUR3BKpkTxisxoUV1r0rw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJiUryb5f6PhxzSY4sfJuF+2vtGpPCHcZ5alFwkcdRJURr+VwSv
	I2cZtiAMMaSq/0bcAdo0FcEPx1adVSzzTJ2TlY31+PbxLIM+RQMPY3jS
X-Gm-Gg: AYBFou1o+bbIUUu7dV63Eq9kNMYf2ZSRdCPoifMk4iCW82Z5yc0BGrl+HD5Jazux/RB
	Yto8r4naQL/G335h+uqkHbXq8ZoJuVb8rDgdRbUn8G24l7t5LHv7s66ybR5IM2cRFJYQu5JhrgY
	LG0Ff7nWUHEK6GOIV7jToiNhqKMLfU6rjkFDjlAKgz6JLL5vC96R7A2cbOOHjhVDSGVzAW/5Y+2
	W0V81ADmzXljlqmMj1191YWgz3Y0wT4nireY9tqM/kcVaVnmHYwanPDh2tOlhGeg6kpGnRPS4GY
	c9Zm1P9aSgZQvCESGEOq11yyRPlk3TIi/hBuZuSkqnHN4cL/588eJpOnUSMaNweYn1WOO4a6tdO
	cL0xBkNs+0wQ3Guzp9ZXAO/bg5V0qEFFooAYteuhzqv44pEmHtl99+KqExWC4NGJr0Og9a2UeqZ
	NXvBIIw+wbwJPDQYSRCIWzXd3CSzIrBxooiPm0C6W92/2yvP5nPn4hWI5yDfeS7j/4/ouT6XBoZ
	FSEDRHGSnUPmlxj9oZD9bBU6m11AyXjug6v2q1KEpv5/4KP6sFI
X-Received: by 2002:a05:600c:4704:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4a35acc2ea1mr76729215e9.35.1792952352084;
        Sun, 25 Oct 2026 11:19:12 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a293sm137475645e9.12.2026.10.25.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:19:11 -0700 (PDT)
Date: Sun, 25 Oct 2026 21:19:07 +0300
From: Dan Carpenter <error27@gmail.com>
To: Haasham Khan <haasham93@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: remove unnecessary goto
Message-ID: <at5IG8sRxSA1AFC8@stanley.mountain>
References: <20261025130258.10747-1-haasham93@gmail.com>
 <20261025162632.7186-1-haasham93@gmail.com>
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
In-Reply-To: <20261025162632.7186-1-haasham93@gmail.com>

On Sun, Oct 25, 2026 at 04:26:32PM +0000, Haasham Khan wrote:
> Return directly when setting the mode timing fails, rather than
> jumping to a label that only returns ret. Return 0 on the successful
> path.
> 
> Signed-off-by: Haasham Khan <haasham93@gmail.com>
> ---
> 
> Changes in v2:
> - Return 0 on the successful path, as suggested by Dan Carpenter.

Thanks!

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

