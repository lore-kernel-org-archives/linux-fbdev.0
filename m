Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B0205E0B;
	Wed,  5 Mar 2025 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176887; cv=none; b=M9FEw4At/zCA9AqAOqu07laFOxO2uI1rZB22A1SpfnH5t9r+Ra+1BWP9+Tb/CQVfr0aPyijnvor6oNa1QP2uUkV6TGrW61JuckL9OU5m317enGsgTEqVIMD7EfWZKW1y6I+FvlbrxPUDci8r6gcMCMP3bwv3fkAGRk4Vvz13wcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176887; c=relaxed/simple;
	bh=vN9RsOM9w1Ta2OcodrGTCSnu8bj52DWvF1ogcLjUyJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGVNaOfctYLKBoDlwL1t1QxSnHCEECRbpV3Hm2BuXPxQBwEz0v9uBmU/cFlzss1don7Tm3ShQn458aawBfQBOnscn4WSgh20kMhoMGQXL4tv47ccoIN08ooJBMa64guAiZOH1junaDoQEc4NO/AT8bMlpF3DlQ3I36s3urGLnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qVwJPx/y; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qVwJPx/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741176875; x=1741781675; i=markus.elfring@web.de;
	bh=vN9RsOM9w1Ta2OcodrGTCSnu8bj52DWvF1ogcLjUyJM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qVwJPx/y4WCQsTW5x9jGetYyVflxE8dsDy1VFIlVZCLlNM2xXX/BSXqg/LwMt3Cy
	 nxwR0GtcxRhljx5e/DmXH4ErVg5D4LzqfbYp4dVQGlqdaG49x2hQH0IIgzkpEKPbN
	 0ucGZqbExRMcMxdvEdoFCSrB4Z+MvthP0C+WVk0QS3xAwqqS6RbpA9BuPDagJhpvo
	 srIKnZV3HX1XsFqpMEJwZRWLC+1HpDxPbgF8HUXbia4ISXOZ55shnxUSqYJVxATZK
	 5jwoCDVvOO3lJSiQsPx5r/ab1WOIIRvjqFvW/sP3v88rgWnNsYYjBLEOa+yqc7U7R
	 njq4LhSB6ZMWWcobdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOQy-1tauUT2X3i-00Q3r9; Wed, 05
 Mar 2025 13:14:35 +0100
Message-ID: <9d042e6a-6d93-4ae4-8373-28b9dec21867@web.de>
Date: Wed, 5 Mar 2025 13:14:34 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: video: au1100fb: Move a variable assignment behind a null pointer
 check in au1100fb_setmode()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
 <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
 <47c37d1a-5740-4f48-ac0f-635d8b6f51b2@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <47c37d1a-5740-4f48-ac0f-635d8b6f51b2@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xz927XuN+dy2MzwEWFmWxNyf3scK2QK3WwvGUP6+iFc0rGUk62+
 4cBG06YgVkrsQSP7oz2GxkjorzrbEe/+yD99qrKbbrN6r4/IGiNzM2c5QFhdv+Ly1HpAoFV
 o8rtyc4teA7X4Je6sy9ECjv9ObROXAcJv55ghu0oB33hD2tbtVundyy1MzNHWooMwFEFZu5
 CmnGqxkaNfAKVHRpzUZuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Oy7sG1MKKpI=;JNu2zC9KnC1wTlorr60/eeRODji
 Twvn6Tjrl4ER+r2013vtqMYFWVlvLZXzO0mFQHQfyjI9f6lVP6Gkb0dLwr61wUah9a+fRo6KF
 CQH9f+WuwktSsLCezC9KSIWt74cIqVMecpXzmTKQwf/HAspIHRV67TvuuE8jN0uZbKAeej/+z
 k4vozN3jP6fBUz+KgntPvDueV642U0/djQnAPKVUxRPWpMHdK+iS4L72u9HelQbvCxPZGduYS
 DMiJm+a4CIayWj6kwQEhCWadgxOZdll4RinYa27znlaEcYEZhNvl8oOC1V5Q517Jw/bKLphRd
 +iT9jjowUhXdNe1gpaW9LU7bqar9wue49Ds9Sw5OKluJ/tYI9SaYKU81NHmY3gTNw9Hii6wyM
 uHWLZezEF7LLauwnwW2fiDGMbOZVs7AWkXI3eKgEzUmjPQiMFoFGMAxrJ8LgonMePMEFcvimL
 BMD1Lr5JU76qouQy+9tvXN0+36/YUfuV64mBzT/9eSXhTyovsnKWwkLKZ7pLlVM8xO7W7eWMP
 SZAe5k1CjHH1KvCkOa0aq+P3inEo8GOAYh6Z6KbdKIL5UAu+CIMV7Qt/cjMhfYY0rvttdZtn8
 yeTlgCEntMkGug43gsgV88lWouf3iUhKA+wZssgGAqT5yiVhkgtslUVpE7PtNRTnXuRv0g0rM
 9UH6blSj67Wgh20slE8jaiZ4ozl3VWHwsEZTWyk3c8W+8gFvHwEmjdNMgVFcTPUtPuz3tu057
 +5tw+5H9JRqiXJeakXtbLCJz3opmeQUVgrMz+z+rsnf3jcHsob+HvlJaED1oQJWmRIHPrtldJ
 fQpHfNld4/1kM768BP6JxshhNTUuzTyH26YvOsq3JACnjh18PIJ3hgJokME8yKdO0uy0ydRDZ
 iedtvaJbEHRvGO0k/ga/jzyvKYLF3VOi8U1jhdFHNW47e6v7MCZriGhwXBDKYDs2q7diyist2
 DaP2oQT7wTnUjfbVM6sS4dLuwe5c85UEGEIfAUkaqb5OeDfiaKN/jjtvEsDqUSdSdm2i67jrZ
 emCa0gwpvqExfAQCAGwzEcI/vKhxwRHKW9wITHzXDovhJ1afLYCrKJL/gY/F0qwXpUeL06uCp
 jBRSfztoSNVtpM/ZxewybtJ+BJLELgDrcoVKEUc6s0Gh+sG2kOQVGIGrJpBhvS7i71OkoSwmm
 w2Mj2QTs7Y0r+eeSgAG3z5gU0ADZ4FK1GtsYOfYPsq+l0JbdSGB3V7YX46ohLp/iZ/Wmc5yjC
 ioOqMs9hXgm54NBaTOhHJLsdfQv47MIeeggCLQhAksjnD+cdktcyyuxsihlgQojf5WVDA8t8p
 9y3ySv28w/BgaIcb3Lk9AjaaOS2WfPOPncDshEqdi8aGl0mkGlMEZPOQt89zDDKoem1d8pPmw
 hha8NFd33dxZva4qDJ89SwxdbrRz7LCZ4GNmUvBeVUoCbjzMLtw2VdQRPcstdxL6r7GtUoSLr
 t4QRoLg==

> Anyway, none of that applies here, because this is just pointer math.
Which data processing do you expect to be generally supported at the discu=
ssed
source code place (according to the rules of the programming language =E2=
=80=9CC=E2=80=9D)?
https://en.cppreference.com/w/c/language/behavior

Regards,
Markus
