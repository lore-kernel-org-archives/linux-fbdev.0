Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9543270540
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784353459; cv=none; b=hy+GYoDVTnHSBSK+4si/XDWox2K/MY8IFaJV6tCnXylpFjatnoQHeVHCzb9/0tOKZT0zK6ZbfqpOPrqD06LxxnWdXMC/aCETXOIlPm5RNR6fBWaenbhgXmrebpN8V8beGQqMDuWLYs/XPz1enCCLzsuCKvAP8nNzje+948GEsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784353459; c=relaxed/simple;
	bh=v3COTV9+rSfqp6L59u01sSvvYHm7zK17jRrglIjfiyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHVnUDjRfi1jIfkV7K09kPNtctUmxBFR6aZ/JRDu+w3n2Is5WsokzY4vn3tPBdIdOyYYsn2zG5JtWFw4wiEwjd5eGGzoKif3pkTTI5w0uaHYdeXDF92mGu5f+gU2M5NDbLYYkoWWpIhP70rAatTLrSWB2xJUJWuE+Tro94mnO18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKeLC7UX; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKeLC7UX"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so4009975a34.2
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Jul 2026 22:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784353456; x=1784958256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=71HbJ1PmI0j43ZykPUAoW9mbuzTezbVtmIlABT7/mPw=;
        b=tKeLC7UX0d/hkz+RqOk5FzE+YnMZO/lv2SUT5SE6U+zUbbwd82RN4A92WzByDehwu7
         tyOKqtKSq6O2aLravzXIOZyV9sZtUa8o6sChK8MafVOhAgLfscNM2xZVQCNaXOS3Fa14
         GqMpgbz3arQ06eszJWY7ZonNIXWvhVekBJK5DgfK2rm1NcJ23UKT8pesrpXmY/Zzx3o/
         I5Zal5qlVbSX99CNFREFIIfdUbl759dkwa58OtTenftn5ZF50l5OCcaCUp3IwN6sDDTL
         v7GBW0vMOpFIRjzT7WyyHto7Yb4D+EdU5HJ6lX2jPs8d+CQ4OiqUdjpwLZwjN0AoUP/6
         yUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784353456; x=1784958256;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71HbJ1PmI0j43ZykPUAoW9mbuzTezbVtmIlABT7/mPw=;
        b=h2C71QAll7/vtZp1vH4z3MLU5CTmKMYSWTVrGYb1rbMhSpOBdltW8BGAQb3Bf8ZUlz
         n72ZIlgEl15XDJWuwn1z5GmZUXl8wcMhXJMTTm4GsABDarhbN+d4RKN07e84VVxlYlTS
         BnB/3aGDceQkIUjMrcEJKOMwPWbtCoG4wevrQEWn13DGw7t42BmWK3ZKAXuKjvbAz3eo
         y8zCLanecyF8jhdsfcac+C880C4MDnL+ayTi9FvYsJheR7IpgI2WbB2m52aWnoKxsaf4
         qDZGEYtt16CVIn37AAdDYfuaOqboXcPT+ej3hqw10KTsucz0M3uPNAXVHJr7y7lFESz+
         R0Kg==
X-Forwarded-Encrypted: i=1; AHgh+RofcsfhK5brrodVqHvru3AtDXrM41gWHynJssa2eIwPpLujlgY9qTuKV+UzI4Hja69sz6lKlcskQXTPJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmue288xJka3BVwxGgQsr8SzFY2q/D5GVhgACNqDogs+CazZzO
	JpOIvGyAos676aZDo2zmqHGKjSlCOtBAs2oN6NZ/ja/bA0rwgpVQlLtI
X-Gm-Gg: AfdE7clRJ/sLo+64hpqV3uOhGszcBLic+t1exdu/bmynEiyWQ4d2pkxAF5Hb+vqaKww
	9DaD7+iGKfmszDJ6xrWbLyjG5OIxYtAHkJMR4OewkkfwhwvJ8YXelJZqW/muJrzAbGyGRFto3Y6
	It2shBAfuISKDaRkRC+U5wo8jdlF3dPAiAL+fxqsjQqoTuiNPa1X9N2HGX+IfGS/vy0AWofH998
	ccuT1vKhweGltv4QWciKLeYtIDHVOoJ0l2SEdlc5YyHfobN+sd7deBxyXVQ0rqqbWci2bwDp2zE
	dGpaTn9SBr6Pin9Np9lYi96y6caGoekeehVK4e5HYogG6qZNZAWTM/YwkpewA7gBntCrIe4I/On
	Mq4upQxQ/oGNSxZX2juySVp3a5Jskp1QnE+SQGym0/d1Mmjcx3+R68loHh34N6WNsPcnkKQ==
X-Received: by 2002:a05:6820:150c:b0:6a3:7e5d:3e26 with SMTP id 006d021491bc7-6a536896826mr2682171eaf.46.1784353456605;
        Fri, 17 Jul 2026 22:44:16 -0700 (PDT)
Received: from localhost ([74.80.182.90])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a51a2225c8sm2857440eaf.10.2026.07.17.22.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 22:44:14 -0700 (PDT)
Date: Sat, 18 Jul 2026 08:44:07 +0300
From: Dan Carpenter <error27@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix mono image source stride mismatch
 in lynxfb_ops_imageblit()
Message-ID: <alsSp5tAe8tunTeG@stanley.mountain>
References: <20260718045641.468640-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718045641.468640-1-meatuni001@gmail.com>

On Sat, Jul 18, 2026 at 09:56:41AM +0500, Muhammad Bilal wrote:
> sm750_hw_imageblit() advances its monochrome source pointer by
> src_delta per scanline, and computes the correct rounded-up stride
> internally as:
> 
> 	bytes_per_scan = (width + start_bit + 7) / 8;
> 
> Its only caller, lynxfb_ops_imageblit(), instead passes src_delta as
> image->width >> 3. For widths not a multiple of 8 this under-counts
> the stride, so the source pointer falls further behind the real
> per-scanline layout on every line, corrupting the rendered image.
> 
> Use DIV_ROUND_UP() so the stride passed in matches what
> sm750_hw_imageblit() already assumes.
> 
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

Looks reasonable.  Add a Fixes tag.

You have this hardware and are finding these with testing?

It would be better to move the source delta calculation into
the the sm750_hw_imageblit() since it's just width rounded up
(or rounded down if you want to be wrong I suppose).

regards,
dan carpenter

