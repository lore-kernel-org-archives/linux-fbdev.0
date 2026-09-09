Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E2560AB3
	for <linux-fbdev@vger.kernel.org>; Wed,  9 Sep 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965700; cv=none; b=A/skIRpFksaz/Eok7af4cpY2wSjSzn+YlrAIE4bU46XZgd0DcWqu7UyvdPHLrq41g1bgp9JcJTk7FPeakAhwP8Me0OtykzAEE9r+ivQXVDsr/JUI2H46UVrRRjDKge43eempxQbxMgTmgMk5Aj7E82EIGFetliAtZDCwYtY3k60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965700; c=relaxed/simple;
	bh=3mrzF4PFQcJ4DbH3RGaSc+zm2PljjP5W+lnaM84CL3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKe+zobqGTyZjN3SnqQTZoP1NMrFVHgL+lrweqstCoZMXEF3v8fBRWrYsZgUx0k1HXXeNJV7pICGGLvQlNvHmMG8LSPgpc4rYBE0FPTmutrXsCQG/zRUKVGV+oDvHs/ZLKnaGJY8QUCQftm0lxDKsND6uK6Xtof96dGAr/Waah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IffCLY9U; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IffCLY9U"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so9931655e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Sep 2026 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965696; x=1789570496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CEnAlwwtVf98S0MQnKDx/a7P5qnwKuSWE+q0EOlFqn8=;
        b=IffCLY9U20m06r8jq41Wip3wbMxiCRO5u98+gwJ4IShm4wkkg7X/pL8ySww6J4XebT
         8G83o+T8HV7UQxDY3AILmU5PPSPuO0534vpsVpgml81WxUkg+jSWdlsrkZC1XojQfCR9
         wPEjfOUTpu0aWTpyHsP2JLI4iJJRVFv2sABsgKZDRr9k7CZCff9jMvjKbbYGvq36IDFe
         m7IyRHupa9IRPB9ER/5GcA3V13z7+3yeRCUbOWz3N6E2aXBB+QFxpxYsIAmSR8V60/bn
         NLxgbMrD38xmDezTXGpi3zHNw6RU9YnQGWCE6LS1nhtK5eZf2geTo1QVmBir/zZ28I2y
         AQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965696; x=1789570496;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEnAlwwtVf98S0MQnKDx/a7P5qnwKuSWE+q0EOlFqn8=;
        b=I2QbJBrZxRPCgHNeNd7mkbU+dUdUzl7Di2+FiSGNyf+OByko6jvBpTIZ2wGoLc+/HS
         8ExQphQsZyHNlPXCwHKHBGCNK8mcxBXg8VxmuYFdOrxVcfHrMnjRl5shVfFTwojGZvXI
         2d/RqANu5Y/ZrXbGb65N29c1DrHRkA9GIwyPpgq1enT9QdC9NC5s9eAqUpj/QZ5tcIyT
         lf39hSOdEZ8nUhLKn+D7Ku+Ka/UnjAyYb9vqIJhDSs4Yt8NWQOTC8YL23+4IizhfZDJq
         +HLcY9g4DsL9cC2vGVu6QLSG3+DS3d4PDty858/tBTxt18PQPQrHNIvXVCjI8hOD6tvb
         cE2Q==
X-Forwarded-Encrypted: i=1; AKwUvByF1QhyhWav6fWnb/NJbaNDVWkeFJDPofnkvYG8q1o6nhHVD6rKLZH1MRlb5uDEtDaJS943K0FO1FisUA==@vger.kernel.org
X-Gm-Message-State: AFuF++mWL6UuAJGkveNM+bvcFk5A5hQvuayZLptVLWZErez36BnaggGo
	iuRpjuWGtq9myY9pqyGa4uNKew0RmdwkYq/Q88Det5ka65L5QSocvSom
X-Gm-Gg: AYBFou0PO6oGsUY8BMyf9jPerwhVMHBYwqRAGxMjmgBtcbaxw4eDGbRoeKmI9Wa5z3b
	AUj30N5kX+5+Ar/191E5GQpWQjvjUsWIk2KvYm/Av3QXxe4BgsSqZwVJRY8zXGlY8heVPmSqTG+
	pn5929F/GQmfnstQD9dDTdlYfcmbMYavMHHL+8ROBD5Ov82O58JU5VEPITYJVDd5PPSJ5l9RP5Q
	BdPGRQcJqVLfNFRdqfxTAmffl8N2pXP1LFYHzJ+Xq4MYm6aixPfN6xsVGM+2FcYdrY2iYz9wVGL
	IwSIHEv0tgk25++70k0vIpYcGRWL6r6u5UtkDFSMgzHg1mBhTpGU6IeVxcIbPXl6jaHJHuCst2q
	KN/JHLrWG6R6qs+V0xBXlezCPMdnx0aPF+niIqR2Eg2K/rd9E8NZf7jcWXLnjyuziAyNqaa+Htf
	e8GMhQjQ/VdEQg13syRJsLyb1vZ+R2f3nTPT/IHO+/H4jo4qiXyaix1TmmNiqpN5z8Ttx0llTo4
	ZH32nU=
X-Received: by 2002:a05:600c:a01:b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49d1916215amr117005945e9.8.1788965695566;
        Wed, 09 Sep 2026 07:54:55 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm384918195e9.13.2026.09.09.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:54:54 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:54:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Breno Rodrigues Alves <breno3011alves@gmail.com>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5] Kconfig: fix typos in core makefiles and purge
 defective DVB debug (v5)
Message-ID: <aqFzOFa3ADXIBo3G@stanley.mountain>
References: <20260905003005.118245-1-breno3011alves@gmail.com>
 <22707a1f-970b-4309-905d-13ac794c51fa@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22707a1f-970b-4309-905d-13ac794c51fa@suse.de>

On Mon, Sep 07, 2026 at 08:59:28AM +0200, Thomas Zimmermann wrote:
> Please stop spamming this list with revisions.
> 

Generally, the rule is wait a day between resends.  Otherwise it
becomes pair programming and no one wants that.

regards,
dan carpenter

