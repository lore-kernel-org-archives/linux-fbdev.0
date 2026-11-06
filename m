Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793924536;
	b=mg4B3R5NBFFOZ/wWpMolNbuuK4DXNpNAbcKCYP2UnvGufIcxVH8SZCcFf6wnAudUyXCs
	 VHkdPdSniD6KSUSYzo/pG8nJK3EaMHZT4RxvguFfkVs6V34sH8IVjkE5Wj6VRvk+YTVcv
	 akFWRA3Vktnj7+sJN5/hK1Em0DJfA9qCLVbTTPqNkbG1IvIN3u6w2ZaqWS/uLoLde4C0j
	 ILha9a9lQOU+p1YaPXsCKHDY6g+Yw0ztSrix2eFSfWqz+vMVzhgQHn1q/LuUPaC5RxY5A
	 zhY75rUM156orfTrwtrT4dgTS+FuQpVLjISPx6zWOGp/p0fPj1cE2wpbDc7QI535Epw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=sUCl/9f3hEKU1jzVhTQT9nv09NWVWMgehGoFAgkpdGM=;
	b=anrrVfd21712n3vrB7rNs0h4xuCOdCwMGkPfkfRL4pjJ5Atsyy3ubt0iQjU9lbi3iSux
	 Suoso1x3Oew019O6Cy9q+q8wSsu/hCLPF4cQCOxGWLhjjHkTuJgqdQlkmkt68c8st+wcl
	 p6bO3lT8vF4B8J5BKpUc63wJiH5HDYNfQR410E5bOt8rFgXo8cb6axLoeY91cOJVGoZrE
	 0g9e9Fci7Kvnhvio3FtWYl/jSFoONaNk034EVHY1bR8faFej73fXZ1xqb95oN/pIpKfH+
	 S45/QQ3VR13exlXi7P7iWYhWs3wRcPlqYmmngCv20ySj7waV2IhfCvFTCzMt4zK290A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yAXWY+0k;
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C3606A329
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Nov 2026 00:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 454C3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yAXWY+0k
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-679aeeddc6bso111313d50.2
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 16:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793924535; x=1794529335; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sUCl/9f3hEKU1jzVhTQT9nv09NWVWMgehGoFAgkpdGM=;
        b=yAXWY+0kGHY1p/NXLSl9GlvtEP9NhJRmDlqYEQh/mZZKvYegQ3M2Bpp9xHv2Dr7Px+
         jlsaQB4KNHNtKa5mn6EshVTqhoNXU7dpj+yqZgoSnDAD525hnhbW3XVio/knfFqt/gbh
         z4rSMEug5KI6vhjltlV/geCl1R5w9GcfhVT/AdNdc6kN79h6XQsTqBkSYgLJTUJBulH6
         +alGx7/gu1KW4SzwjTzl6n2cJsgFW1z8fYy4qJVsn34KjKgmljzaTmguG/h7c4GGOFqs
         ntjw9nR2ADcbqsZEzGV+ug9JDKCqKnuzzOXpK3tCLh3qcd6q3giZyarb9n57w8fDy8Cd
         OaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924535; x=1794529335;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUCl/9f3hEKU1jzVhTQT9nv09NWVWMgehGoFAgkpdGM=;
        b=zH3KCDk1bHrJls2FmFC3PTh8VYBn+l7un99M7iO/2K+tQxAkmvRcuMYpid03eesYVo
         iZMWBa5Dd0NTv1t0m3OhrmXU8FKMJl/PvvP3Vp0vWZ4NJDgkHaX/9H6ixIjAH6rQTq0I
         u7J81NCJbHl23Q3aJo3sPpCrZggWpARYPzmQ8DYFJt/lLYpmV/R7VSBZbP5dHtTUtWoo
         98A3RovjnyRuc3fRf/I71RstZ006IqTxgOb04M5DCcmQy2de5P6by/P3WFHbO5dY4yZR
         zxyl2LmtLg1/tjESyFGcDxYgc3dbaXVwPTZvEkonmF4ZvUm6VpByx1/nQ88cK/hGmrVh
         UIcA==
X-Forwarded-Encrypted: i=1; AL+hErGxfkc1L+Mq7M35XpCfRHjddzpgo/k+DnWhMniYD9DSygr2Ji5+PEc5ev/He0Nw+Xm/JvhNF2lLWXI5Xw==@vger.kernel.org
X-Gm-Message-State: APuU4Z90RrlRv2TDZLY5SjfoD+ppkKaeDAtaCC2XgZwV+8boA1Ytnn9C
	hBJLkiy+6trPJmMVQMz8yR/ASFPQj53nUaa2h3eyKu4Rkom1xKZZLY+GyBejkQ==
X-Gm-Gg: AYBFou1ftGm2wRorqzLFqmSwcIKfgIqKubGTNEIKd9Mit3BZhifvF8mXGAYJEkqhRwv
	L2rh8EYtUG0WG7SCsOeXzdE5yeIXTHeXuqPYBWxIzarHwtpQfAgGJ6KrwbZrQuD7UApMykXH1nz
	J28+CTz4pgCgUQKX0uKhYryy8RhrfohnV1HV9J7Dtk7l+Uqk3hQuYpDoZt9kt6gHZiZ0KSJ5oJ6
	42l7e+p7A7jx4GaWQXnw+xPHBT6Xi2p9CA82tyvFZIQNOa0Ph7Ff9N0+16Pgow61ScouL3eoFUq
	AHQ7cqcfXSfkKLBpWOo17P9bZQ4LQaab2gokSsuK7gYXSaKoxQRxNOplNWe9dDPEZXtdBmkjQzO
	Ceb+1VrFYU6MaMhF80rBa7QyP7SIOmx+Rd93hn9dFQo+IIvcG2fWoqJ2pqlYbVEM81g+ZfubLGD
	Oov9Psufubyea0LW+NF3H/Ql2moaEhxuH1nueFjPHJK804NXbFVrIsWrNSkVtr+ETjvzwZJ9D2q
	bXsDkDjmLxsC6oEPwKb/wg3LZuWUXK9IKVuwYRbLpqlNS4rpwlVI+M2ab8PrWqDbJV3A52AipyI
	WQhAsWxBFT6UQklm
X-Received: by 2002:a05:690c:1c:b0:8ab:415c:d733 with SMTP id 00721157ae682-8b34178baa9mr3874997b3.7.1793924535092;
        Thu, 05 Nov 2026 16:22:15 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:135::7da0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f8394b9sm7441337b3.31.2026.11.05.16.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 16:22:14 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 18:21:32 -0600
Message-Id: <DMNP5QPGP3Y1.2V7SL7MODHHC5@gmail.com>
Cc: "Teddy Wang" <teddy.wang@siliconmotion.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "open list:STAGING - SILICON MOTION SM750
 FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>, "open list:STAGING
 SUBSYSTEM" <linux-staging@lists.linux.dev>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode constant array
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Francesco Giandinoto" <testata.nucleare13@gmail.com>, "Sudip Mukherjee"
 <sudipm.mukherjee@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261105211344.17532-1-testata.nucleare13@gmail.com>
In-Reply-To: <20261105211344.17532-1-testata.nucleare13@gmail.com>

On Thu Nov 5, 2026 at 3:13 PM CST, Francesco Giandinoto wrote:
> The g_fbmode variable is used as an array of constant string pointers. Ad=
d the missing const qualifier to clean up the source code and adhere to ker=
nel coding standards

This doesn't compile. Also, please keep log messages at 75 characters
per line.

Thanks,

ET
