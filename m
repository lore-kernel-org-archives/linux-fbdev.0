Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415735;
	b=UzNc4Y5uqU9tSdv/kPil9OOEDo5Tos+UHUJ9h5AUxgq+aZVP+XLmHxx3VeWR6iFzzP4I
	 yWjHy5dju2NPUgkPTteNn/gdRY8jJn7DsmgWa13giIO5aNyIjcIdMRaq8R6XWe9lm4nB8
	 R0lO5XjGHBCRuAJRA/2Hh2Kak2ieCoBL8IlrtpNjX08eVeqDoEKU2CaAV8ZHlZ8EdBecQ
	 uKEJSUWuGf6grNTnMt0f8rTCEvcxhPZQm8u5WTvgUOs8gUMr0LVnq3tjvED+tN8nir1tI
	 r3mSUjej+XNKE8n/HOawJNpEXnTtuogM5/5zllv8LGQii12Lvr+mkKuxlaiOTkfcL3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415735;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hIh1oJXmPJn8/bufJnOWwv255cbPbO6RJV8+iEpFNQw=;
	b=JcaE6Z3ZiucEW4lXXjAfRSzbkfefNofR/9zGAF0qk9bRaJrGALq3/M88nnVuCVk3OU+4
	 eRHRHo7z6VBr4x2vfPQKSzHgij1J0Kn1r4JUKWey2LYHOw7Ft9RqECM/WSwuS4NFGEjnG
	 52YSeEuf0nWrNvjHpIkxqYqdCcTUvrNwq2uOFjjIfQSiiXDXFhACnrX/nao4m9/fQlglC
	 N4m59EDb2JQaZDvBlhdNyi6dwpKhQxVQlPPWFPMXVXk82E3AYrNmwN4mt2yvrU0GBJIO0
	 0mFppp405aKxWsn0PHNN59CpTwI3ocn2k1fGN94ZtG0oxzPED2sU3F92SmQomi2sOsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=pereq.eu;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC3606A33B
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 16:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EBC3606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-498f5fa5103so1019161f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 08:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415734; x=1795020534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hIh1oJXmPJn8/bufJnOWwv255cbPbO6RJV8+iEpFNQw=;
        b=2KCrD4dLo1FTPNvNQ5ehtdKnUCYaPaKBrxDo6p9Ls42YRWbLEmBDlyJWYeN6ZrIUOt
         qvdHVKeUh6oSPhFpjYJgVKlACmJdY33BlWLKENGqCn74Gv0/rhcnX1LHK6oooVkcNlh9
         KMuKXIYCZSxIl3+iLv493OTVGofrUhXPAujo+ELAoS5+DAcRZJ61lnijcRBfAZEPRHUO
         fd2+batcU3/j6xwhECxxBg3jD4k+PwBgykJsrfJdNAoQWA9RSbJaWXL3BMEoscdM7Gbg
         eEZkrj78LV2joeGZZoHHq5lNjozw7OXyhKmdnW99uzG5M02Rp4g7Q5p4OOIzxVVP0G0M
         hLMA==
X-Forwarded-Encrypted: i=1; AL+hErHA/653ZRpXE22qXBinJugS3T3PtegKxmJ2I7+LmbZuyOLEV8GjvB1OlbABGyvX2ljsKUY67iOu8qtPow==@vger.kernel.org
X-Gm-Message-State: APuU4Z8hVIW+SV64EMka1kgjPPIB2cXXy1ztNXo7xZ6lQjA0KCC1AX57
	wJhsdQ2jeZMn/4HcoGBZ7PHImMxiSBjn1LX3SQJ+UKic5HHGX1RmR86o
X-Gm-Gg: AYBFou0Uuh/XmuVxt5i4zsHam7DmPUNY8XjnsXvjlWNYTpjJE18e43z+Bk44UziDyvh
	6vyaulCgdMbgdmOaCbtSgqP2g64vsqyx+e6pi6HIdlOcVjs4AphO76pT2W3SOKQHo1qMJ2Vepdt
	ATpimqIvvz72VGw0S4bDE2sWRJdt+Ch7OFQTLI2tvzRjXau44+WAXrRFuKoE9jP2QBCC5CvluZH
	7EKLBPYnn9I+QPoEMRxtPPxjCTL7CU5SFNks8nHSNrtacr05xFnr0e3tycIBF5QEyRPd1HIeXNO
	wn4TK1Jd3wmcBlTe6aebyUsr6RkxoJ0o0OTWiQ2HA3QPZzjhuxuUIeuc6ji19D0cbi+qwAcHbFa
	lqsvAJ/aUPb4mMB8E4rSEF6iygMIjHjhSeEAvXpV/p0yoxw8pTASkbYL2Ph8QScTm83Xcq/rRDb
	6v3FdJB/TVIwi6zby69ef8Rr03IAmjiHosYHy2h+DprRDr/tDNssv5YLZvpzQKaNZkIsZTjiCMP
	gMnbxmBPkaWvmQW8qkcJA98NhO2RyKt0RcfI81G5OqeKNcxxXsecy283tC9Do2F/sQyc8RRCO/X
	IxEOUXJe73A/NPF2/5vKolZE3NwsiehBwOwtPBkRl02KBHAvEaE85bASeCd5ee1+h4pwSLMLOwW
	WilDSy0n90MPGB0PDRU0UZ8zSg+KSBl3vnFk7U9ItnffmX8Wx4mK7r+c//8gl
X-Received: by 2002:a5d:588c:0:b0:499:53b3:39be with SMTP id ffacd0b85a97d-499c8d5bdfdmr5249070f8f.51.1794415733801;
        Wed, 11 Nov 2026 08:48:53 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49944d646f9sm8244842f8f.32.2026.11.11.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:48:52 -0800 (PST)
Date: Wed, 11 Nov 2026 19:48:49 +0300
From: Dan Carpenter <dan@pereq.eu>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, error27@gmail.com,
	cenzhang@linux.microsoft.com, dennylin0707@gmail.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4] staging: fbtft: remove unused fbtft_init_dbg()
Message-ID: <avSccSGIsu1EbwnN@stanley.mountain>
References: <20261111163819.143147-1-himanshu.bakshi478@gmail.com>
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
In-Reply-To: <20261111163819.143147-1-himanshu.bakshi478@gmail.com>

On Wed, Nov 11, 2026 at 10:08:19PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> The fbtft_init_dbg() macro is not being used, so delete it.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---
> Changes in v4:
> - Add Reviewed-by from Andy Shevchenko.
> 

Collecting the tags is unnecessary.  Maintainers handle it.  You should
do it if you have to resend for a different reason but otherwise just
leave it.

regards,
dan carpenter

