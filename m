Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E9212542;
	Tue,  9 Jun 2026 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013729; cv=none; b=aXt4pJ9z6zkBSIhMwWXllD9pkUG4NjhflJApi+tjk1cMhybvLFKpkO/0WzN5NTiiWQLpDMFIEVhFJ4O0yFFkenet06LXVo3m1L/xImh41gAvn2lwdM/TvZcKOAuRnG18FXowqHgNBdnbUjziFmxPkIGVFEN/HJFHoZ3sW5wrYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013729; c=relaxed/simple;
	bh=Jbg7CLBsb+e/4jMLfGrCp7kE6JtSkztzQgRF1upB+Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qZ/O1ZhNhW9koYm4uoqeKeY5ludoq2N+MiyCQOU8/EehjoUkv1/GD2tzzFK+W3oy2Xk5Qk7mSoBq4hZ+JWV3/tODnMjWbEA/FZjtB6ntVz6Mdq9+DW5RwYDdLYB/qb4NCEzxsIKIDOdB9Ow+37OS3NsaSR85QFSUsPTlXx0JGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=mIyWwJOF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="mIyWwJOF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781013645; x=1781618445; i=deller@gmx.de;
	bh=YZq84qv4O8uOJztwUacoN4JhJBLRrEzC6CTvPVPjhEw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mIyWwJOFP/jvWCTiDI39KMOMFcj1vh5lucKw3XuRM1gTyVq/tjjuEW2JSIBEALAD
	 OPWQnPC/ywjER31oBSea+/BdZrC/4ZKzhEZG70FUSxKCnAlYWnm9G/BR9pbt28u1R
	 8uos6OfQrO6V9Jo6xRuQ1K+EkqWHNivuw5bN3mCO0hUOpodVjxHRPgbCYYKXGi8MA
	 w5E0ZbFiIASmLD8coohoQfCgNbBH56dmcDYzSIY7cbrH3UeSvsk10Levzwq/az4xY
	 JWfxM+7gMbklIX8101wpxEghYgAGD5FFCaHmZTUTirwDr2gcGFlMBl38x3FCm5y/l
	 qZ0eoXhHS5EBiqvoYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH9Y-1x5AlE3dGe-00oT4F; Tue, 09
 Jun 2026 16:00:45 +0200
Message-ID: <7edb6d84-f63f-45d4-b2d8-8e136880860c@gmx.de>
Date: Tue, 9 Jun 2026 16:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] video, sm501: Fix buffer errors in OF binding code
To: David Laight <david.laight.linux@gmail.com>, Heiko Schocher <hs@denx.de>,
 linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
 Ben Dooks <ben@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>,
 Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org,
 Randy Dunlap <rdunlap@xenotime.net>, Paul Mundt <lethal@linux-sh.org>,
 Danila Chernetsov <listdansp@mail.ru>, Kees Cook <kees@kernel.org>
References: <20260608124242.13164-1-david.laight.linux@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260608124242.13164-1-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UkwWJXM6rpv27oQvz0taF2ZAjn32t1xFBSdcvt2s9KzQo3CTzWN
 EqWP4nI9nbofiZvxvK5lAef33ZzObemRBbz460PGWXafZ7VxL84IVlq9DEbTlmJuTLghQrC
 8jKd422TkfqoBw4IIrOmUrm6LuUPTyX9qC/emYxeZEe3EZLP0SEpwVbgAhVyyZRkxAp1y8k
 CwVEykC/wt67wSCmHq7EA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0YdFM0S4CVM=;N4mrt4eOOu40BXuawTHh1VgJ5vY
 1AfiiSsqXgK11yj3MB/hdPGp5ruAyahXU1/fezJG9eW3z4wN3HL5tgUakCjZWk5Fm1dRRjXJo
 Fph23iNx67rJ9ayzjsaFr1RhEutKfGfoS+OyQqqmgVCfWDwf0BmwIe+CT4eh7eJxR+KO78J5k
 7a/jMb8gOXZTcHUQYaQCLpm0X7HakuS8R04rkBNFIFOxdD61PgABs92Jp6UqDHuJ1EO5tdpJA
 NesJ+CFFQjMvhiiGEaExaPSkAprvebudqYAZCJ95U6w+x4bCUe6wrGb8PJZ6cRtwk43dFYrFl
 xL4FJrs/pqmugrvjBzEiIWJFe70YYTUNonjtfxwgwDiUfHRgSc0lGwAVvcTPjHjS092f1HWao
 PZByfcnI4JXzfkV6Cwn5IHqCXEJaym3Jw8IAPIhg3kn6a7Zsajh63BdsaltDVoN9e27OFlPR4
 qAF/yLQbr4M22bASB92C+03RWdHY2WGMpYbQjaTWjqvPoTCdlQfp1bcXeWmD7/V1T0rOEwN4Q
 4pdTsE2Wdwqv6UBC+LRP/vz4DE928NLkHFgsRqrRqZOc0PVZm6if1C3tBGRZyPZAzEj6JcLYv
 Omex8f/EVfMKMP9IhgCFc0b0yV+AS3FMsXkrIAxlhWJCiGeCSfgULMJ5lQIsKv8BU39HEL6zO
 23kjkKhOQ+LGwRuuH2N8rPb5i+Hs7AlImoQlAUyaLDoL/ECQSGwzCbdTdweSHZRpu7cgWAp9d
 iofHYbkHpwUVGNBNjkyJyXKIXhkEKOzEIow2hO6Xga7U45QdPgL7eEsZXZumMnN0jLwFe5LUj
 KVaD6vqO0H6kj3baq0HAP7CxeMj1qvJeoxxwnDEHv49jsAuO4aBWIlvTbHH+wmdfLBG5RpLNs
 nX/yKWnpafiZ/kTt4weeUR0NaL067A1R0+BYtgVhO4Noq4owjcENil6xarowzUUw23xg+PVsT
 mjOaXoTrhtfB5uaW9tSIEntJLZnMhorZ93GQ1VPi8iyhbAyycUKCp+JLich2yi9pHrzuSmfXs
 joNx3B7UOPpT6Uv28Uh2F4yJVoFFCTCJvgnECMrHPtz93vxeUm7sHoo2I9/eg4eVQko/dGvNk
 +GYRS8wZlzGLXy3/Ym+RFKceiCQRsaZj4/9knuNUnaqmQKd0TgQUezWFeQvxecpsM+neykewp
 ZHLstrHPVFtTHWZBX6iv8Q2aTj+u4e9X+8tFx2a7Dp93wZhVai1BL/VsBep1mdrNZ7y9/2kIr
 qE0i23PnWVhprDHrPftm7BmQyi7hRh7K/oe5svo5sIfopoGMrkVi/rZBQ8x5NRW/fzP5+lWgz
 j4hkHWj2o2pfxij15xgFhnnOZYS4lo+YWZeyCMdVQDao3+YPwLIYerKcKPL5G5kJycg3lgwCv
 3dRbiyYe7EvVnF+2yBqoVlytSOxMm8uRuDq4BIt7fs7PngiHC3MPDT71JpFONkPajkibNIHDm
 /z3dsdxjyriyHCveJDq+Qfbe3JrNvsBMng5oshmDi1+d6qhlo3+W2qBFhHzGNMhubE16/Pgdd
 +QCz7PU53Gx1uU46DLic6Sugsg/23aexP1ogRgkK6ieaprkN8kwBfMOCdOv2db6A3Pxh3C1oG
 gpHybK115ML9OlhbuMvwVaqJpyoaMRDuuqaGT9mUmd0T4ni2XS0mDZuWiIDU6Skb4h1Q86H2W
 gyEN/xzzNqZJBcvRZr3KnbIOMD/DuwofyMLyeHA8Q5qc0ZrXDhmxqi9lJXGiYVyVnOLITPMf3
 J3HrQ7SSB5K4PpXhL5nPi2fqVbcUfcCevzN/X0XpM3Jsmmfq5X3IMWcfTrphqfSjBOtXUUD8J
 sIr3C8nc6184LQKQJZlTX/dSOuH60fH9szxJ5JYFVlWC39zeCSKaqtjQBjCmosraXbWMm1pYn
 lO4K9+i67xGs8yJObJDVpdV7KqaMxObNpRPSImKZv2RP0wtlry3dvSCOB/1oSl/tt+mVWtE1s
 E3kutRAM/NmPuY/rthPa9ci7AOTE0gxsiCkFPYsZCOUY/gMjylTC52j3Ru1Kwym1uGomRSxZu
 PHngQACtLgPQ9eU2+KLR8+/G9M7NvRtGabO3YB0D9E9E44uwJelVVhKEBT7NRJz6GHM/ymlsl
 qq5ITmJKrOPoTrqCPwBsKsAZ5hemPs16Pkio/kY/769SSYmrHALJsge+nmjMQbOlR6dXKRTdq
 wUgahdZZynvysBMkpcU8Ix07FJu6nOGkgQN7/F+Z3956W/R1kMG+JufwMDlQAo0pqUbAxMfcf
 2aZx8LpYVGPiDAUFS1PMbAnpcI5xbEZlQaYemv2uQNs/LaEPOgTE7VSRIX/lu8vpjGXVuzjgX
 +7jdlJU3ErK5i29cqXHfboHelCWwrnvlks55RWSY6l/+3qhBM2ejzxRzn9VTyEZXpSIDTQ4dX
 7HKryW/0yL30i4umlHTH01Iy26/VifO8tj596fYnSyFu1Fk9Ng1RT6sJiWazPvrsU4b7Z34kl
 PZJP9EaT0dxyccBN53j7hJCQT5TjzhjL0JSebpkTyl3+BBkYBmR4dpOSZx94AoPR6klt6YxHU
 saGwxG0i4q13iFcXiZXCw3DEoOcqgX5sq5jbNaZ/zO8Ws4/b+TCHIQxoX3f4it6tGxsQMB5x6
 riVEOpUBaVa7RbpSkdbUbohTudI0NkMznRlk3MatVpx9GDG89x9hM5tvBDzrFD5Rc4USUIKXQ
 9R4vJHZDzLQ2/09YkAeH2ec88x7zD8oxyIm4vRIo3QiR1mEezdlOUF5O/q8K7eUkJhA93d+cD
 sBuDaSK3lRLzrG8URHWLwXUEhy06D5O3NqbwOL0AzlC92/8L/yzH9rTBbpzNNkKYXvt44dOSo
 MOYTq3VsLSXuxL+s0YeiozM9azqQENwEDq3R1UEqpqQF6LbA5JEbT+iIcirgDgavPr7y/P11h
 q8eRMB0tOzRnI1HQ0niDljXRJYCp3giYf16es7fSpC/QTVNEyrhX/Dcyi4BYuCSG3GbcsOxI4
 rpD18mdpR1O1jvDI2tpNhovoFrkgubxY3SzJQqTmaJANRPZWvFoTNvlQMK325jA9YSiSO1bgp
 JyWs1EiM6Ra9r/9dAiUtLlEVU2mwbIqQe0chA9n4oZI7mGEKQ8UscRPWHsYOaGspGxGs/sYbL
 BdimXGe3X4De0vakGtk0hXHYa9RUquOSAzK4EbyaW48A+dEXbhaS8EXhpcqjWdHpgDLX+Z10g
 EOnswYe9Q5ajG4kr3b5h9g8MeB5H0QxnMfHalH3DvoMPUfSazucbaGo1YA/uwlOTqkQb2nshE
 ETyfPAUssa3sb399lnpkrcdPvVwf9R8lMPUTdfFnM+Pg7kHWM5ZvXvhWUgSNhGk3um4bGKKrL
 /1wug+Kv63b2G+a6V3HmE16ksOg9mOAZ8ASewXmu6d5Zbm/YZuiOEL32eJi5KRB4wHigy5Ej2
 TNPlBuwWh3/P7WwTDEeyA1sPeq3uq4ODydZsHZ3wwlFxgKNLZl2ZXlIkzYHt4oBM5jrWzgtV+
 CpcNPL/Fme3swFDeW1VC7jfyugJWVnBqwRsSgGSJ7+fCbPudyNaeMzj5QNR82W9O6JdQu57Un
 fhhfkWme/LlOLW+hTXeECr08mmN9YrolNSudVHekXtL4XGpSu1cMszHNQt1Any6ldiS/NsDx0
 ErGOa/wMVGj8SowABQngWV3iEB9wsoezQOCDB4Ai3VEoo4tL8Bwn0Cyl//lF43umeqsEUXn+G
 832nZnPmu55MdUfUk9wmxYekagF81M5Gla3UnQChYZ2NzVJo3yhXnjvPxe3qV47MdZxslVXTL
 560RYlLiBk6zXhYKSsTDVqjdZyd1PleyyADG1Lvj0EB2d5epYIdGn78SihcIlKZfozLcRDTFG
 I3M+Kk2tfOqqVDqbjO7njDoL8v1nbvTfFoTEkBsaHKtWfBOw2X7wgiaF1JUpYR/gj0eLWa2dz
 ULPqLyKo7jiQ5IICtNcvWgV9qdiboqVjkiU84yLRp0lniwfRZcHX9+Fh3XkF5IkmfG15EwTfr
 GC9Qb8RY4NtImzwOGOE8Jpw7Z8/9xbOJ278kQDNUiZwIrgDhgL6oRKCBd5Li0XcbISDDSJWyr
 CgOArEAEIuxqfCD3Gi7fIIix1zKE3APVLBG+kwl6p5zPruwvD1prtMOnr4cz4uhiSTlneAYQN
 4iHf27DocupcZOaVFOa3AHWmYJNqc6M5IOdgT76V/cmkLAzkE5tWEkKbbXIbMrMawUzUehbJu
 ru47F4G78m2Y5bURDx8SRQ48AVFtRNWyVDKxbXyfLc2QidIoA0s34Z82lk4+qLQ6dRYHSV2XW
 8evNNWG0v8p6JHGQ/+RykEOHdheYdjFrMpzBAnnRgjJC1ZGt5oEOZFGFbjL0Vi1I3UT/9B9pN
 bYzTDRZUEiAW/y8YsIh7Ie5t6iarcQJ0ZImTHXyFhHi/sOgtumqLU0xYSXdoH7SJoTyDgSkhE
 YVQ/zoywHunAkB7fnq77rq/Z+Kah7E1BJJwwYiyRP5v/kX1u1O1siphUtIZV/FuD+IgbTqRFo
 kTmxSxr6sPhYIV0+r0z3wdQ2CEto4lUuNT+FvYB5jK0bK5NnYdxQ2OWIadv3FeRY1Y/xzBBxc
 mbjPm7lhlJ076bVY5jnhMbynFoZN/1ti9NAXegznqqKXs5PIIb4G2Q72M8BUnx9Y5/D4mlXhF
 tmEPXxNuJ/DFYCgI4sUG2juL7kJsGkI+MLGuypVTQ2LwdHz0AhOAP0VSRdRRnvFjOe0EdvEd2
 Sx0+CG4cuB0DrbxALoWPkmBDf7QqamJhuFresi5oyIqG3Fqtk3wW/Owtfns7Y8nntVS2YSnNv
 BsaVYgLKrMtejiua5D9nWe9OJ2aWYI8vl65I4hnc1BHRPj9B1Owv6HmdKAdJo7oV10PuGTn0n
 sF1ime3T6866z8szr9QiFUfLuvH64OcMY1wtIirktoJH+A7UmzOgpfbvATdHKLayIeyPsFByo
 i9aOTLeqcHiRRqx0uJQdUi6SFWiEW6CAZfDBczLCen2RLwoONSmQJwoDlEWSqfmQQdNUvBlwJ
 d1E5VUeW0wpBMtaNDwKnwSEJ84TXBIakiR75a5y1SwFWlEs3j4TyagXWGsTSHpbAFm0ZEPhNc
 KFs6CgOPtpFhvLm8OqgV1KSYwFmMlD9Q/L5wDVjriYssSG8/EmPGFLJKOdLJxYp+icRzF9BSv
 +bZcnB8YetUSlAGwwBY9hlx5u8Q+8cIpwcgTEZcVItt44nqN7UP6jXff+mVRC4wIJ9ym2Ynti
 rbhjbtFWGbpSDIl1W8NnfWz0Fa9+ZyjYHA8Y0ecddrH+OeWgUypNSGQTlZF/iF1O2YdhxDpAT
 xbgnHkErwj4/NoZBJSqs2fQFALgt0b5LbtwuXEc6T/9taWUmnIhY9EHveS4X8gwIIhseDaNAX
 wn7oPHaP3QIodR1Z4VMFrr2yM9dEjcbg4YFslFTtMnztqOgDD4aE0Xhaw1BUwSTWbrQIhUw22
 sROJghLpqsrzXcJ5TShd6Ih3rFYh0PjEItUny+usmMwExmjNf/xAyZNC55GZ5dwQ8p4kSlgBR
 1J64N1Q1tyolHKIg86vWqL5Ls1bLmZJA2kbZai0J4bO8Gne3J18PpFssWlHPibLBH8lyhn/sZ
 RrnlLA==

On 6/8/26 14:42, David Laight wrote:
> The code that gets the frame buffer mode from OF has 'use after free',
> 'buffer overrun' and memory leaks.
>=20
> info->edid_data isn't free if the probe functions fail or if
> pd->def_mode is set.
>=20
> If both the CRT and PANEL are enabled info->edid_data is used after
> being freed and is freed twice.
>=20
> The string returned by of_get_property(np, "mode", &len) is just
> written over either the static "640x480-16@60" or the module parameter
> string without any regard for the length (which is most likely longer).
>=20
> Use kstrump() for the OF mode and free everything before freeing 'info.
>=20
> Fixes: 4295f9bf74a88 ("video, sm501: add OF binding to support SM501")
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>   drivers/video/fbdev/sm501fb.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

applied.

Thanks!
Helge
