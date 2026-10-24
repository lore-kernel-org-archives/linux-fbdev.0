Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.134.164.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792884936;
	b=A0JWSyaIkigEHSTwrdVYqxHwbJTy5hh0kbTbdGtCm17tGhmrOzbmsz521VFRUijGZA4A
	 +7NU1Lz5wXzu8WV3FAUxti2Q4A9DPFWGX/+4AMwqMgL6doBfA50P7P3eV66MDn5okZFQ4
	 ZKgg1Dh0ARNwkJbFVW6IGKRCQXTxbuLHencmORtvAxkhw1XnGRqzM3KunqpODhCwfyw0l
	 oR7nTUdDINgHIfHFPdWIDvOCI+N/dsN3NmOh42X0w98ZZTCXJBtq/um4JatosIE0Dt9zt
	 1Xl31elTKC425TBeM9ISORB3hRAlZqAQ5DwV3qjUfkqOiD7y5LEV/ipYqjkSaRtwDUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792884936;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type;
	bh=Ytrr+uxGRP24yFtKG2TutOCpu+EELEvRDLmQWlLM4K0=;
	b=JG6PRC6JfQJ4UhqrCIam/fNzQ8mz6o24txYWY+jg9n1NECJmZoeb52EPHI1f2Xsjxymh
	 CxUUCiSAz+WOuKcY4WoZDFm5SwcC2Ktn8TnTYU+QBU1sodB6EacgMqg7VI6ZYnPds4i0B
	 9TYvzUCEaKqyxMF8BfBya7OnhjNhhENw4l9v7XeYdHh7e4F4wDmvLv9NMwi+oyv9/97O3
	 N/eUHYP96dJNZuayK9CQFtthT095HcDSSTiMdYN+9astKl3y7WDEH0UIk/tasP+lRs2WJ
	 /MeIIH6mPEflSZ7tPJ6+IykOtULBeZzN0q7HbmxJWz/ArqBUsg3Ew369vdr/88Q5nkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inria.fr;
	spf=pass smtp.mailfrom=inria.fr;
	dkim=pass header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=fgQ762zB;
	arc=none smtp.remote-ip=192.134.164.104
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200F606A31B;
	Sat, 24 Oct 2026 23:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3200F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=fgQ762zB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ytrr+uxGRP24yFtKG2TutOCpu+EELEvRDLmQWlLM4K0=;
  b=fgQ762zB6RB8v3UH/r2RAKI9a001jYJ2pBpLbqDP9GoXXItMRHMIzHXo
   t80MS/E59edMUVDj0fRZwSIRlcS/DadLbYQ2eCUFS1+WSV5gbJcfztBxm
   Z7s/X5jTDIhXkATDyUt7K7LQqczGkV/kmsVtZW/B656jSzJ/xkuLhlMWF
   A=;
X-CSE-ConnectionGUID: IMYaHfwfSAOU1AxqeZ1RxA==
X-CSE-MsgGUID: HbsAwueeReOB2zJSIpkrvQ==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,177,1787004000"; 
   d="scan'208";a="160785023"
Received: from c-76-123-3-53.hsd1.va.comcast.net (HELO hadrien) ([76.123.3.53])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 01:35:25 +0200
Date: Sat, 24 Oct 2026 19:35:22 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
cc: andy@kernel.org, gregkh@linuxfoundation.org, outreachy@lists.linux.dev, 
    linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: staging: fbtft: fb_upd161704: Replace udelay() with
 usleep_range()
In-Reply-To: <CAHxSwT8=ZA2sFqXNjfX2=Bf369+gNRLfCO+VtVmmWiTzenLwWQ@mail.gmail.com>
Message-ID: <792c90f9-3eb0-eac3-72ab-94dda18322ff@inria.fr>
References: <CAHxSwT8=ZA2sFqXNjfX2=Bf369+gNRLfCO+VtVmmWiTzenLwWQ@mail.gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 24 Oct 2026, Abubakar Musa Samaila wrote:

> Hi Andy and Greg,
>
> Please find attached the patch that replaces non-atomic udelay()
> instances with appropriate usleep_range() bounds in
> drivers/staging/fbtft/fb_upd161704.c.

Hello,

Patches are not sent as attachments to the Linux kernel.  Please read the
first patch tutorial again in its entirety and then try again.  You can
also look at what others have done in the archives of the mailing list.

julia


>
> Thanks,
>
> Abubakar Musa Samaila
>
