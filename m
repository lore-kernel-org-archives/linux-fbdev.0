Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010583;
	b=QCvbMjpLnTBz2ZlGk8U5zjtH5D0s20fH5Nr3lHSMmNwP/v1tkVDo1CyUIv1DiJ3xwuff
	 8kFa/hpazq+xTU44J0QCkNMiEDBSgDJgP1Yy2S65X11Dge6lqYKznCB3bSVSe5c9x2F97
	 ZV2rgvyTmh5GOqLGZl+LeFqnTqzZ/6SWg49ol1a2tWMs/KLT2s+ciJ3n6oUYtrOOoDBlY
	 1FtHU9UwmGnqdlhkH8o/K7Asaqr+ClmcIRSvTaJqdWH0lMAo0Be9o14PCdUiM6PzLZZM4
	 BjM5ghi/vQzeriUGAcKLHlGob5iu6PHoLIiZlvsNobXd8gvG98Y+tuB6bIwBNRfu7tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VZ9A0GT7Bc+iwj4opPu/rDKXsQb5fk01pBmT0V91WnI=;
	b=Iyy9fxuatFkLCzvcGo4Yt0lQ3H2T4X/Mb1k8lLTMNcmXUScphNQXUtfDngr1Wg+qh1z4
	 zOQimoNkhWe+XEp6hHS26O5b3RuIP48Ok/lNHq1OR381RR19CHSplNM3myK4janBhOrKM
	 /aQcCrxOu68yyyAO0b6K1AO89phat/5Tu6/c7M5KpMO1saLM57BwQW1LyCN8XiVA7X+5t
	 TzrXHaep/z6kB54PwJ1b7WKDLdZy0e55b9DyKrAPuvPBBOBUSlZPs33CKzBIqT+ioC/lq
	 o3/nq0GTarHxrllB9YIfyOv5jtdcMMSL9atVcX2aj14cKZFHM+FvEMIRb/2wO5ZGxSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PdrmcN0W;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652B606A31E
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 10:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9652B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PdrmcN0W
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a215e64962so20089655e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010582; x=1793615382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VZ9A0GT7Bc+iwj4opPu/rDKXsQb5fk01pBmT0V91WnI=;
        b=PdrmcN0WTGsFVolzHZ392hO9v+sbKQEarF5LDGgdSCfl1Mnk3HTCbBcmw3ocRbUXFp
         RBjDtplnRz+ctu5MOh+fafaSdUcglxOuwax6df3yrUKzB5IINuKRFIsYfl6uhRuE5nrz
         2SxPcLQ3NXBEKxtfWcHUmRlXUDGc1+aJEKZLL0I2rlhFh8D4fyTsfycDwOYk7BzYrkvX
         dzt5pXOjLFpMl9Uo7Wv11mUNPwInUjyRq4dt9bT5lo5VFYVgxd6ERtdDSSYDofTrLCNv
         fZud7/auDjLBvOML1H3KUS+7gO9q33Sl9POKJs65ekauJLljdWyItJvt3jblJhwhdOJt
         tLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010582; x=1793615382;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZ9A0GT7Bc+iwj4opPu/rDKXsQb5fk01pBmT0V91WnI=;
        b=MpNzY7SEvd9FPetjOuvO+FjFrrL/YoX4fZpSPbSBLrEJdf+cr3BfUuRTmG8nkMkwBw
         AyUb+NLEzO2BJlq2yaqMJkpA/BKFcCgW/m7metp50VpINx5+L0iAQR0kY1Kw+b+5XsfJ
         EUqoIsKqM60X+GqkZleZR3jiTsJAbhTUH7rzlR362YCAu/6aafJsABXv5pgAthdwoB83
         5eSJ80+E7T4wTYnY52aPgSQMHtK42TGwQk0r4S53eclfxehqm3bb2p4HVDPfbqQsoLlm
         DXCBnalrSXhjUgdTBKPjUTJH2N0e3a/lcmJOn2v/EW3HCh+2PId5wDGuuNPGo+9nRQnr
         K3pw==
X-Forwarded-Encrypted: i=1; AKwUvBz+4Tk0LdFf6uNMBtll0IxB/b6M28JvxtNemvuXPrNMcgrMvCBYUwrbkIgew/SnN+0NMkPhmj9JlTHxpA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIkefQczMX4FTfBg9NJGjBowQM1akLSyzR43Cnc7NUrUCGne40I
	Fytq8s6rJjeAByUCTXEtBye8auBGDq7HwGTfsTFu1pnpUt/LtaLdSChyed8PZdRzAoVqWlvb
X-Gm-Gg: AYBFou3n/r2SM8wY/C+jQAoIBSyD0IOR3SU2XRU20IsUlLCTjaJd9a5wVtxKgNk30LP
	+l7ghJAUv1qftgPRoLYuu50EE1+A49ExSs8L+k0sQ3azFL5Knfl50KkljXKy0iZ5oBnUkl1W3iR
	U6Y6FwG4FN+eYSDZX6Ix6VqgIUyxtt+5UDtIrcvkAg92QI2bzhwJRJ/b9ogNzl01RLtYdd6i3wq
	eDdPzSHCvEjz9KNquWZblWVbXEtWovi+TOl9cnwfCpDElgDSgjCdha0fD+nsIs4+OsjVWqIWBm6
	9f839hw2Ja/C22HihbisJQNfPd8fCLWpeKZel0Ny9e3qB3/rJPnK5gMIadhxCRiNt84QH2svm5B
	1m3Xwi27tNxd9NyYcMwzOv5TuMLHI3B+DUQDharEdYyrH5vaAT+XEz1BCqgKywB1C33bX8CLEQ6
	f//0mr2Ucv2stZtXVT0e/WPX6lFmNtVu5tJnljd88nW3z0vU7WdM2UNVPVW5FA1M7UTSH6djxQF
	KKN+dnsHAizk8/mwCCFlNkbP5yLcHqf+QtOAuUD93hni3nTqAumR853RyxGZEBYvqHxZi5Ccg==
X-Received: by 2002:a05:600c:6095:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-4a35ac99412mr100451485e9.12.1793010581925;
        Mon, 26 Oct 2026 03:29:41 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f4f20dsm129772185e9.0.2026.10.26.03.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:29:41 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:29:37 +0300
From: Dan Carpenter <error27@gmail.com>
To: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
Message-ID: <at8rkdbWrz6uei6K@stanley.mountain>
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
 <at8lztOr7xpvHEdo@stanley.mountain>
 <CAGLmz9KAs7oKnmLv8NK6Z8yBQyrdV41oiouoRrNBY-j-p_H2+g@mail.gmail.com>
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
In-Reply-To: <CAGLmz9KAs7oKnmLv8NK6Z8yBQyrdV41oiouoRrNBY-j-p_H2+g@mail.gmail.com>

On Mon, Oct 26, 2026 at 03:52:43PM +0530, Himanshu Bakshi wrote:
> Hi Dan,
> 
> Thanks for letting me know. I have already
> sent the v3 patch, so I apologize for not waiting for
> a day. I will keep it in mind.

Thanks.

regards,
dan carpenter

