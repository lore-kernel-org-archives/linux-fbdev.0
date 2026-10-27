Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089368;
	b=rKScIBd2wcwV/OpCYIMeeNBaZSLJMvqQg5E3jiU4K4XblPS1FpZtVGuYJfyCRSffLYmt
	 TPYOEPc8M29a2ZCIQC3nhOB5ogXYSWUxme/veyHfb8GVolhKOPhgiy7CXJzrFl3/ZJsbk
	 5XTY9GO1MDBLdCxlPZDpUHpR7nUfztRWbjG+DqdfpDERtc4Ds9f3oQroOFB+2gniYRSZY
	 a+cJIyrTPeEgcQXdykzztCTwZGc0tzsoSudby8y/Dl8eaTeOzkJSAr0hsAvnie5dIYRuu
	 vJUdwp6OOXSProUi3iwJp3f1aEP/lUObgY1980SHsVw2a/4RL67WbqAOPtGf7cS34ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Oxzp5fPcS3kqgnusg3EHz+ARzLMXQsnr8kyVgVxlMPI=;
	b=2y7ggHCTYBrDjczzgTt7ltAVxngzbKCRGE77N0P4+a4RcObSAFNGi+GPzpGOG1bSJQTK
	 LCB8aesP/AdZOOqQzHlLrqyH2rmsEGKZMzV0kR2FiwFTYW1oOliQ6j6AKcWOkK1fFHNgO
	 v8/xp/uKGiQJ+J3xe3/R4fLYk1JnE7nElhmfWjgVnh4t/wmjf10d/s7W7dnFZ6TnoAdjP
	 2L8obPyYJurWPlsqnd727OiARdZp6XCrp+bRnuuVdHLLHQNVHsEs5b7+38704AvGOa222
	 RT9lQs+jDE2lGBwZNU70lBdbZAW2os+ToydDBjpFiAVcf34xicxpjO0yprB0uSL9CgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hayvxmzx;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6910D606A31D
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 08:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6910D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hayvxmzx
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac749e0719so934659a91.0
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089368; x=1793694168; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oxzp5fPcS3kqgnusg3EHz+ARzLMXQsnr8kyVgVxlMPI=;
        b=hayvxmzxWUNkxQZOcUXN0qwsRzCsTin/m622IWJBdtGoONQ4VRwrf3pi7aAL+T1CTG
         ulsqZAcddvKOYf2/ClMFuj+IlU7bKnnHMc161bYEfz39L6J+qM+J/chect4a4bTzHW/V
         HUXhN1koSC0WgHZ7jXAZCc1j75ygzTLQcU9Hx5XslNYpwIWNaGusoczP3SJGjTOBFncJ
         CY/wRMqZAkmBxqJP7YQqazM51ZlXEN66EiyheLaNRXYHJP+GPF2wvrpsBEHYfcKb/Mk3
         bu2PCc053cEFkIWrPYSX3/yV19Rutmpp47ownwFpzk+EQk0I6B5NDatVwF/S1+wTVU93
         kJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089368; x=1793694168;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oxzp5fPcS3kqgnusg3EHz+ARzLMXQsnr8kyVgVxlMPI=;
        b=TIPGw3Ub7qzwfVwxgcktn0ntKKR1tqZoniZeiLMQZBfSimL8656povX309WkrQJLJk
         5oCuqqDFEKKC1l1oIzLTv2EEkllk32PSeevlI7FtblH2RVCrVC1JALnQuvdGbLKULQjv
         f05a6exkfC67NpzGru+7HTMr7rL0rEyO7Zpu6AQHBiHEOl+y2CMTrBc++HH7gcq2Zrm7
         d0RrdPenPXOXWBAwYDEMYMAhLAs7/wZdxWSiohI1K45o2/SvwvHFHEOpgAqHEu2IYsGS
         BEdNMs9mU7crXQP3s/D3ExNMO0tzVnQ1OVrVXZvfdgEhJzHtvV3z/esp9JxQvMSQ+7L1
         mxxw==
X-Forwarded-Encrypted: i=1; AKwUvBwEoXZ2JRDNEGLu67/qUd9xT7BocFY5o+LIjOsTBMsGlF6ci0TGye5zfnMto3EOoCO5Jp8pMquzDzzS9Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLTz6ZEQeFNQqv5tA1ybrI1+EdoeMAggjVH/yUpzZyntafvq+SP
	+iaDpiugb3fR3SGl6rA0p4nFb3RNWlPtdOsed99doXlXBOO152og2YMR
X-Gm-Gg: AYBFou2ZgGtqMLG/Lwp7gXkRw51IvSaSqe7zXoXDBHmpPb1B5Yj2t68H8nVu66Ma/JC
	QBrPawM694ni1Q+xTxSNYRnp9mqId4VYnUObRX/mRh41ZYAjWFQymKvcxKVH10vNkEAADsacZgS
	d2snTcaetkZ8+o8uGi3usTz9zcMEaIXYYluuO3YuPsfeGqav/SfuvtKGRaZilRtDFT6/9oLblYs
	iFi72bxTAOZyZAh35L2G2skl/h5Fstz71QtQ6A65Zl0ZijOyGX3Md03RLSwqEi4HFnEGuPA2a0r
	nckEST65fSgAASRt6xb+CHyTj9OnOo7XrSmGGTN+ppW3KRgt1bK9/5Q5giphNdY/mjVcBQ57eL7
	irUJbejWT1q5dkSbvUUsmJbRMryX4qCZssjIdQH/L3AmQR9F/T/+r1sHyrqrnf9h3URGUHQl0X4
	Shzuf5Kv3qcQlQOP5v+/xBlWYD2YZC0L/G2lNIey5y85eK9YmtZTm0LxG5t6U/cvV32C/7onas9
	MpnHr18D27TkWOOQwnhyzVAEHk7vS0vycnN1Gjzo9uyUASEWhblwUOLayW8cq5+vrP7ByFHzVIr
	CG8SaZGaEyY+Iq0GMvsVGuH5mW5/mGg1tZvHQHq+38v4IG8LM7nWzJCSWWh1
X-Received: by 2002:a17:90b:314a:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3adead4f73bmr6882910a91.37.1793089367740;
        Tue, 27 Oct 2026 01:22:47 -0700 (PDT)
Received: from [100.64.227.9] (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm8137375a91.1.2026.10.27.01.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:22:46 -0700 (PDT)
Date: Tue, 27 Oct 2026 01:22:46 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject:
 Re: [PATCH v2 2/2] HID: picolcd: Avoid framebuffer last-close deadlock
Message-ID: <179308935900.645289.17780178981863221787@gmail.com>
In-Reply-To: <76cddcc5-2cf8-40da-9139-e78353975e41@gmx.de>
References:
 <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
 <CANOyQmHF-gjvnLqTGEVBcU6+AWj5ha+7tJhE2E_Cv9aj-gRXdA@mail.gmail.com>
 <76cddcc5-2cf8-40da-9139-e78353975e41@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Helge,

On Sun, 25 Oct 2026 09:20:36 +0100, Helge Deller wrote:
> For this patch:
> Acked-by: Helge Deller <deller@gmx.de> # fbdev

Thanks for the ack!

> I'm not sure about how to handle this patch series at all.
> There is still a review missing for patch #1.
> Shall I take this patch (#2 of 2) via fbdev git tree?

Since patch #2 depends on patch #1, I think it would make sense
to keep both patches together, perhaps through the HID tree.

Jiri, Benjamin, could you take a look at patch #1 and let us
know how you'd prefer to handle the series?

Thanks,
Aveline
