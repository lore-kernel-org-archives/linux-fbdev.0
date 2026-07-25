Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A13033FE;
	Sat, 25 Jul 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991365; cv=none; b=l/Q9kVMJOo6tTmK3Na814T9tKGmzkGml6WpNssrmbNH0UOz04Osf/EShKf6RaRFsqzaUweVqbTIUXOowhSusuJFizORVsYGCV8DGz5YSlm1ta0U4if9MpT3sKVATG8Ay4YISre3/gnqoTAFsVhnjRQ8qQhlFNP+Z40DG6Z2aNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991365; c=relaxed/simple;
	bh=15ucEWalsWqvyGL5WZDc2vIfTVkUz/cLYM68M4qPpDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G3nGX73e9mLjwH84VSRH/rRMgiwBEkB83YH+xLPqmk8bvvkxAxoDb8d02knHFrsBa3G7f+fvmLgldZHfdbC9+h//Y9pGdKayy8laBtJzE/6uFwBl5Q2cF8cYdasc7IDS3UH8R2nAMJqfiWNahrfGX0fBDUbsYHUioOKA+36VxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=eDh5uHBb; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="eDh5uHBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784991352; x=1785596152; i=deller@gmx.de;
	bh=gVb63ObrzpkNThW0aSkny9wedAuX+ciejvnOQqS0Gnw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eDh5uHBbopuF+HMmJTjyXExlxMnEofPLecamPj73pd6OiCSlIcXxDI5iL6lIDqON
	 L6N0ag070Uc7M2BiP5/ZZor87kwOGG06pjrK2JNcBJJpQE7Vxejudp2CPztYiPD2X
	 iKXbN8DIr+D0d86ne7BaCIkYcD0Pwe52EQ6Jy5ByOMHQf3eWlS78es8sciocPnkY5
	 sQxf1TnsU7cSe0f3vs4RV1qi7hlQb4u6QjvH1y7wFmzGQaSZk1/6ZliNqVzgEN2FX
	 WnF/7hCYhqzIQipUkc5xGh/0KewFzR9tk0AxBD189rBiu7igU7rBtgYubbzlzB5Og
	 hUnutClbyW33vI13Yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ycr-1wqejD1VyF-00GpwT; Sat, 25
 Jul 2026 16:55:52 +0200
Message-ID: <448f283c-591f-4ed0-8931-ee658f4673d5@gmx.de>
Date: Sat, 25 Jul 2026 16:55:50 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] fbdev: mmp: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>, Kees Cook <kees@kernel.org>,
 "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260722075803.570532-1-panchuang@vivo.com>
 <20260722075803.570532-2-panchuang@vivo.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260722075803.570532-2-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cw36yLhiA2a1W3B/M+VduK/xcYaA0XRDNzdKAeEpGeDgWGcF0zk
 fGXZOSE2c0yZMCqhg84q+Cj4s9NpEM4aLZUPgwFUrfYjg01Q7NtI9qWPviyjrRRvd3V9Twr
 IxL9EWMRG+VpdYbM8a0PBG7Q2b+cagVYlH/VNV+NxoBgGJ5H2kcxGiam0aPAaZGtSOxR7Xk
 WEsq61QzHoytguPgi99Ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ss49/EwBBrk=;2lt2brii7vf7RkPeRRbfoQ4UaS5
 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

On 7/22/26 09:57, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() call.
>=20
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>   drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 2 --
>   1 file changed, 2 deletions(-)
Whole series is now added to the fbdev git tree.

Thanks!
Helge
