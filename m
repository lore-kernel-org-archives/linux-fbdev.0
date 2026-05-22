Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E293A5437
	for <linux-fbdev@vger.kernel.org>; Fri, 22 May 2026 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428983; cv=none; b=sLVUQafB7pF+X0+OpOr6x8xH79vz7SdKBhbRPj0B6hfTvMOeM7qLx44miB8QkuUe3tNF7TveXcQ9AUSDNAsSDANwbA/1akR44Ua8mcIG2Qbupp85DimGqM3WySpYyCx/CMZ8mtziDIaiksjOqolDcAfc+AGLLiTPj+Ke+YPA2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428983; c=relaxed/simple;
	bh=z1tX1iMyFpcdaPOk5hdbTsr5d1cn2yP505I4SiLMWzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7CcqnG26363qdoaG9ko+X6Yj40PgjAQDu8l5qq+xABJzmGkcXuNEwj+F4IX6B4FkU+cyteMVNZ192xqcuMv4Sg7Yw5/5Mmng74Etim6JEJKv3+tLN4q432SV1dDsP0t0wzyPtv+ksDGOs+a8z1gDa3ZlSQQ69vhJESqK/vgPLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYLm1N4C; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYLm1N4C"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49040362e4aso8235825e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 21 May 2026 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779428980; x=1780033780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HhubsJGAdfca5NZ0I/ZtJFmFGZaBjI8keu9ij2IFCE=;
        b=oYLm1N4CM07KpHg0QMSwalWz+OhPsRDaebOEFT8XnWXhIOnjA4R8lCVsZaM3wCdu4S
         zV30cDD0gPUcvwI09R7lbKnwMDN7fdqrVmG4qMf68Zhhhszd4joId/yMi7+5l058rGZA
         m5+pYWZkYWMrgj7besG+QyTUv9GmvF9hDemhbKpD0NRZ9kvL2G3MZjvMwJXo2cDabDew
         wfaQ622WKTwBb0BR0L1/GJukYcvyJOykoTm45s/pFg/H1YtL29nLeAS6Hhn9uGybIXoy
         PdCsj4v+88KPWKCWgwyB5+agJID30rur8UCA7oaDRgWahbzAEKI+AfCzXtQFYusvB118
         upoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779428980; x=1780033780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HhubsJGAdfca5NZ0I/ZtJFmFGZaBjI8keu9ij2IFCE=;
        b=FO8n66b4F+GofsF5bsLP+l7Blqkj7r/A5OaK78oxISRyuGL5WoXvn5lx4ABbw32zJW
         7bxz191wGe3yU5F+450aW5bMnd6LtO8V3B1dAuDLS7N9UkhcNqEQzNXTjwOUJWpPss0s
         yhuGM5G5kcbNvEAVlP2rqt4xXyKsoLWinldAbuU1muLasEFfhnPolvwHog8Mq6Us/pP4
         basTZo5jTGgeCxx1gcuwswd5nNcS8hc6tEBDt4yJrC4svZwu//vFmWPnBWOY7li+gSm7
         klSNe9zz/0m4YFlj7YljjIcpvMX4FL/UsUPYO7HgFjdIrzVZ23kLNYfoDRa+JIg6NA/b
         zVew==
X-Forwarded-Encrypted: i=1; AFNElJ/veLuvr8dTC5buyrI9Vfwm+rKrbfngWjO3KEoBINjq4nytTaToaioiFzPOq9pDtFYRmbA8xSi1pJNmfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+fs/oZTJK+cHBmq9SJoc95QT9Dc/Sqwu2H+rdT2quVh/VR5o+
	DU8N8QyFN6+n5RU5rza/+lFaIHfHiCTqU5HwL0oHQbU2OQbmJdPBk5C5
X-Gm-Gg: Acq92OFgPnaNpnrPzWx+GOe9ja7mNyb5LVmWDweztUDG/+YVc4Gs8f4yD6c4iqOrgTh
	w73pAg8Y3FsOualXSjE3s039QAY2SsvEJNp2CuMhpIRnMs6ri4js6cG+Z3bbm4tAFbRayIhWHvH
	TwY9PZUGZSBP7jnJ2XMGqzMweYGfG37vHztQUgIDEV3/YsR1UMmsbe+BZ97RNRuDb1mtATX1CU/
	cQgolBG1tdLL5J7SwenbbzVoLWfIynsZcBpTb9ZUGfh5zsmZvTVz6apxCP5OzsVYpBGKlvCDzsP
	Nb8Ob+JELn+FpraAsQcvIvRgwHU8K7ez+/MKf43uHV+XdYTufhyAXsdybmIRv/tHi1e5tzyFEAY
	j40qfdyn6UcjOdNmEu/3xNt8e0WfRW55U9Hz29A3nDDLufiDyeAOVcpH7c6x2rbKckrBmsSH3Oe
	141dmqajdv9UJfAXyAn3cu/+Gjaf0uqXwqFA==
X-Received: by 2002:a05:600c:46cb:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-49042482762mr23361615e9.4.1779428980002;
        Thu, 21 May 2026 22:49:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5caeesm1380659f8f.29.2026.05.21.22.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 22:49:39 -0700 (PDT)
Date: Fri, 22 May 2026 08:49:36 +0300
From: Dan Carpenter <error27@gmail.com>
To: Michail Tatas <michail.tatas@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: sm750fb: Change camelCase to snake_case
Message-ID: <ag_ucCZEOnZuJOCz@stanley.mountain>
References: <ag-XlRifxjqXF-Zx@michalis-linux>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag-XlRifxjqXF-Zx@michalis-linux>

On Fri, May 22, 2026 at 02:39:01AM +0300, Michail Tatas wrote:
> Change variable names from camelCase to snake_case
> as per the Linux Kernel standards.
> 
> These changes remove 9 CHECK messages from checkpatch.pl
> regarding sm750.c, sm750.h and sm750_hw.c
> 
> Tested changes by building the module sm750fb/

Don't put this kind of meta comment in the commit message.  Put it
under the --- cur off line.

Please wait a day between resends.

I don't think you're working against the correct staging-next
tree.

regards,
dan carpenter

