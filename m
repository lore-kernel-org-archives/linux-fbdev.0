Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B619EEC2;
	Sun,  8 Jun 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749388340; cv=none; b=FtbpmPNQ78LXXVnmZkS8ayWjUTq83cbYZTAxOF65i/P6dztZTh58IKh2xHaQADkat7BBA7DUWgeGlNFF/eK4ZTk2+LXdbF6VX/ZNQeqe6pbb6EoqMga+RPA3KBVCU1DtorAOtr7+9oBYLHf87j9snxhTFGxiqjOl2ezmO0TjaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749388340; c=relaxed/simple;
	bh=E67Vujbkiw31Tfi4vuqWbGJcHLT/+bRkVkU6P/jQrvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+KZGpkzDfkNwmsqXZkLAgRN+XlQ0xPqJFjqAsvxSv3T0AaJiZepri6qgcLlkwL2P94dGWqPxvLjaax719BaF4Fsni++QJsqyW2RLv+bnBgTC3KFJPVhyDQ5yBclyXxWFwqjB/zi+yI5Vit8ukoTx76ygCDfVvDWTn1caOuz68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=oM39LJ3i; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="oM39LJ3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749388336; x=1749993136; i=deller@gmx.de;
	bh=62pR7ZjXswN9oSVWvZB3gA99ZofQlDnhD67435sehVo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oM39LJ3irlWDvFQ6sYb1cdF0kGxH4ogtLYFw18h3sEBBQ4m/Y/+2zyDGb9kUhZsw
	 F00vUwZqE0FXn3AJweYqFSGI2kvOBDO0P616pEih1eZtvrlPu10EhILL28Ge/AXl0
	 lJz4E7OKoxzRMdJS9ETrN/xCermeqmqQaFOUIIluLaoyzJSnDocnhLO5chs73I5NU
	 6Fz7UnS8GtfBQhyE5pBOIJj1qyEjKxiBnX1QpQk0m4M3tGC0mjuFNYFBIjDfWYLf4
	 W0YAD9UNS34zW6kq8sjqX+xcLXWyfnqKg/WCo+NjiBUScoc3EYxGGtfydY5VF6pH1
	 qPWBDLSiNBOQw0c/6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.171]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1uU2JT0bdP-001i93; Sun, 08
 Jun 2025 15:12:16 +0200
Message-ID: <ffaead6b-e9d9-46cf-ad08-aa6a46dbe74a@gmx.de>
Date: Sun, 8 Jun 2025 15:12:15 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: pm3fb: Fix potential divide by zero
To: Alex Guo <alexguo1023@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250607194959.2457473-1-alexguo1023@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250607194959.2457473-1-alexguo1023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KiChRPU2fCErll9U/cYDgg49Hk+59W4LumbQcwmVnJqW/NEnr46
 4LBI+I/RvH2AJPHmlLmWk5wDcI8aQjwtdSYxlZugAxTvvTsHrTNYaoMkJ1ptiH6MMBjyULE
 pdQ8wBrV8xVwUmGa2bOyfJhF/KSD++suyoGpO0in0zDd4zCDHJOKIbnKSHHUyF0wmOYcdpT
 YB1MOfU3TAZ4pMXDRr6OQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SoK0c1l+z60=;8hig0QFHJFB98ASzbfd+ZSKftjG
 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
 zN/82OLCIW/v5SkO61uZNSAjF

On 6/7/25 21:49, Alex Guo wrote:
> variable var->pixclock can be set by user. In case it equals to
>   zero, divide by zero would occur in pm3fb_check_var. Similar
> crashes have happened in other fbdev drivers. There is no check
> and modification on var->pixclock along the call chain to
> pm3fb_check_var. So we fix this by checking whether 'pixclock'
> is zero.
>=20
> Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
> Error out if 'pixclock' equals zero")
>=20
> Signed-off-by: Alex Guo <alexguo1023@gmail.com>
> ---
>   drivers/video/fbdev/pm3fb.c | 3 +++
>   1 file changed, 3 insertions(+)

applied.

Thanks!
Helge
