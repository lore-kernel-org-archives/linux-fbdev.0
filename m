Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2F3B2FE2;
	Tue, 10 Mar 2026 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160600; cv=none; b=k9YwjovIR/LNTJjEP/22m8OeJxyLom1RADuRJeMFJhKBoW+go6xyCz43q4fGPhQF/tBXDauOjzVLuxUYZ0jAs3mCUjf4nIbj8j2I2GK8CbT9iOrpsbjSHLJRta+7bD0qONk2smOBGapM4Ll39Gy4dRjlPn3110qZLR1hKfdedik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160600; c=relaxed/simple;
	bh=VRbwwaX3cX+GBCVQr9yerWGCcdr11Yq7nisfHW3fiJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uh+uquDMvSzgXum5QHt9g7eSIGUsjRt9mkZXXBmLz8xXX18SpwvD5ykKdZ9zQ+Buw+w7YfezXHK9jXZiXXstFcblSxgwAU7m5svtTecGNswZpgmdJ4YYfJz/uBEXvsDR7gSG3U1ge8fo9P2D+kt8nuQDI5yMW71bzu0yCns4U7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=RB1l2bMQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="RB1l2bMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773160585; x=1773765385; i=deller@gmx.de;
	bh=7aQBFA7+bdvkE509aQprNTYrqICGki7uxVXnQBwf8L8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RB1l2bMQw8xTv5Ql/3ZhZ31IBTeABCLo8BjiP8FeLoPm9irqRidbfeit0MnqAnKe
	 QbXwzJ2xrVoyh1qD9FPazidIYd3SvimDpQbFrUdPKGZhGz76UhazJS/5cmt293AgC
	 W4+kPhVEDeZ5g8iHX+1lDR63q6dDQXO+TrkP4s9SPujkUWJrh2wJChLSw6z5DuboY
	 vogTkxKLyiIn1tWoGavLPSEYyplaHRif+bGEtDCeH/PdrPHUqxQocMS+s0STJM4I4
	 i6SsmuuoAlHNNWNnzKN0TZKSMKqSQv6ThP3/UWWFWXWldIlksQJaQ1XdVXwBzGJlZ
	 5LgFkUOucExiCPV5qA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1vj1Pn0yeY-013944; Tue, 10
 Mar 2026 17:36:25 +0100
Message-ID: <7fdc2a60-2f7d-49c2-b18e-5c5510c9c7cb@gmx.de>
Date: Tue, 10 Mar 2026 17:36:20 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video/fbdev/via: check ioremap return value in
 viafb_lcd_get_mobile_state
To: Wang Jun <1742789905@qq.com>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn,
 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn
References: <tencent_5706A404B952870FEAC83A04EEFC8348A305@qq.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <tencent_5706A404B952870FEAC83A04EEFC8348A305@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYlqHtjWmOOYZmbtjATZgVkH3uFF5Dz78GnsS82vO9yIzJ6h1vY
 2ZUi0awnHeqLIH3hkjGuR7tIzarngF848+D2Y/xfdToFmiWglyxJUGMzZrU2qBBUq4olFQ2
 6pzukZN3jOI2jw16wv8xtq6HZqcQmW8gzKdEto36lEYxB+MPg5wNmzVhXdciVAXC4ZVeMjX
 4wYu5E2RLT8OTnwTLqowA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LSYOcON6l74=;lp+hVQ8L4+jVWPEcOmopddzTJQW
 F+I24I3al/h+5Eefnd3Fs5I41yfSjPpHfFDUUTIJvWEgAOAP+TWv69VSn13+NCphzG3iVLW0V
 6Ox+/z+nCRXGfemtpIvxKJJFn+x6zItAeL6uIPYjGb+kud1M1yGDlT2XLjFoa28yH5EVRPi8q
 jSW2gR7svVjVgaA/ko+SNYCllPQ1jHBkcQQSq4R8+v3Uq+PHTCpZl+rkhOzjOJyqhQqYYt6BX
 rX4VHTrK8CkxDCgSMHwt4St1KbrPtalt3v42sB2qlvRYF1pQ5Hw/n8gW40NzYGTAPGbP3JIA1
 vYsBoNjkBj1X+jlytWrsEA3rnU7yfzN4OZ5ZKCqvQJVU8l8ycSdCHen2y1ue4+vm0w2wFd1WH
 UvMGSyqOWl3/Cuki4DcwS+N358m+O8oFW4q4wKpNCv8xdquoxr7Zi0ehBu07xpVWFtj+797+A
 D0cqLo/qG2TXAA+jCj8N/1USD6gIIiS3xKWxP0JGyDXrHsgiy81Z4HvgDD8dxGb5mBw4BUhyn
 MOOwXc8+OJAFlanH5pjo5HnPvgeEJ/ELKmdIErJJ85qrUpswJV27GRy+WM3L4nF0GwAmVrZ/8
 h8CnvDiJGJlfo41usysNf6RLxJ0+n9p+a4LUWOfsF6abo/FhCcZEc74J3mnhfXhZ+0Tq6PnH1
 CWqiDkwp+k2k78dMT/RBqML28iTHeQA5lVKA6aJI+YzM/4UHZRdpPrnpRiAb3roo4mNLtTv5F
 AsROdFGo1wvAtieacLSDo4Wu0nxEWydW0ACtfTDBZsP8mOD7grmcOCxpN3oV/YGMhMnkAzMp4
 aH1gYbOHtbsuCPkuAdBeh1KuNOXGPlupArhFOl92p0kL5a0FyhdCT+w6JYVK+Dol6RHzVokD1
 rA7OY5twB0IvCdM6ZePT8/ye2z7FPX8CTEvFx4r4j76fy9+4uneza/3/6Y/Nsha/mErl4n+5z
 S6O69Dciz5UKvghZ7+b5RIicpGnuOFlLg7pC4W+9jE5BO8srqAiUfm02tQqHoDy4TptdI2UvY
 DBTcDNfkB+xcnt5WKQlk6iiwJoJ/d7PPsPStPktYElMAg++Zk4h8M3RxODDLJ//pY74FoA5av
 ujvS7VILcbQ2cR4aSqVfkAj0teDdqOpEcc/V+Tov5E2Q071YEzrrgL7jq6YPlw+jJ1xTqjbYb
 NSqAkj7BNTpfSDF0ifHS+ihqKPCle0jA162lQZEiLGyLAoTpkBzwXdoUhfS1KEouG5XKf9QVu
 6oJZfSt5gywKQwUWfoGD3qT74JWgbdIeAd3u8eKqkC/9w6eaNtm/6ZMOJ/762n5fLc/Z7xFod
 qhZJhusA9nicqnDfJkd++yMfndVvC1Pf++Ab2AhuV5aRbolXPGaOCJkLDwbtooAXD2QsfpTti
 7VXQIVnv6ZG3J2Z3iwV2sB1gPxnXFL6wPJSw3ablaWx13IB5s5Uw4h33FLtF5RM5SzKjT0GgZ
 ldAvog6qjd/0ePlWKO9O2FXjPHMhSOrNhRmXloBCwoOZq8q+4X+Yd053B6RYCd93moczaULI5
 /tGrBu+1Y8tavWFqQKAVb4+Wb6qKxKA++gtXrW4ZKXz7OaLRHJtPpHVRqGMmpc52nJOzRApvd
 FiYforYTgNS8EVixkMheL6ynrYTMYeL3I5C8BTGqttA3jpgpgAZWWXPUETb7jiIM1c+1HKc+e
 PJX/n4L6pTxfi0j5gXxHPjeg0O23Qn3V7TOJoIR/sOHGWfdNtKLOC493QoNnI47+gsAw3mZ2C
 lEZkCvtQxTeWPXOAuduZB4h1khoopv3KHFSAjWo/HqiQKs7BMjmeSiNY2RZoipq0yqJkvSun0
 wFYFHQc3mWB2kvxPsuxe5/+gsauSEkZJiykKRd5d0mopkwPU8dXxH7oOruWQTtHkbVP+HcHdK
 LeyPNVlztUkZYKBUsrBw161oRAgPzog6tENay5E1qifgI7q8HH2Yys1xDPCdBmBcSFbFb19UA
 LHTenBvGOqnzV3OhjHcW4UEAG9mSkl/hFHQy41mSgfk/00YL4vvWAo6qKKFhudJ27DCoIUb9E
 JAuovkkaTv7UrpHLG4z3C80bQOV/HB0tQFe7s+veI2Fr18gZrpGYUBj4Ow8C1aLgdnmmbPEfX
 vW+mLBG3whXlt0AyEBMXawU1dcRqzedyaqRKFcDGdNYevMALnwOCjCXUhMUJnSHXQhQxNPyBv
 2xNgJOSh9PR8Uu+UN5rpNd9J/yuFIvs3Oc9aLsm5Maq0CTMhjVdVBWVW1cSlgiBmGbR66dYUp
 J6X6IFxl9SioaKzc+Gf0Hquz4cnbzOA8Y6iagqBl/69oBqu2qOY5A9gGNQeUUOno/DUck4Yar
 Z7iVzE0SeUz216UsW+xPirhX8WqezJVYmByI7pF1r6vUPbGUgqmt47QfutiN2oAnUWgQxZZmS
 yFqZ8m9VxbF5In3MgCQH4JhV2282dVtPWxzZI5VyYa8Q9n6aLJKmfSBy31j9xvhpqDccE6wYJ
 7mHv7yVAjfGQ2EYGRP5v4DismsZV+ikTOnQ2kb6EE7TVkqluPLg+NcVeYFCokOeZVJcVHzwTB
 51RcCBJYn4LfkAqfgETHkhmEqDYdbS15S41J7PBSMXh5EWaYz/8TTVPNvOTLgiUULYs1v3wZH
 2oWVhNzzqCjP+yhwvDzhagGfzYEXThmWz6JnS/2Xif1RmZZDwyVtDPcXDbHWNLftjMoiyXCkP
 Oli9oEXZbk4T4z5etBEMGE82OQvuQuLrElUfQoEO37MOMmsGpmhyB1uK1PfUuQjtOkpEIH/ry
 5DqC7QK93qiXFKGMZAsv3FVHy+LhfxF0gWO6UwtHeLKMbO/sedid31kldNqSMheauWBFnhwrs
 yZ/L83jriA5ZNtLnVyJsuJVY64KbyN7wmnoGvql86jUodVu5T8stHPQAuijdf4V14zoV69xoF
 TPBrev9IFt5xDulFZ3hz0AyzoK2zEAvgRjxJhv0sZgBntH0rAvNboNOPllHEHqThNNv8c4vZk
 RVW7rQK3zz8Nhd7Dy2PxlCpaFyoSSfgvx2pLRQPtipgMnA/tu5j6E1/uEAu3eaVvMz2hS99KC
 0hJwe3Xz3s9cLPFqtG0LsmbLlrC6SGByY5hIzJZaM2rH2OW8i3aeO543v+yCwgrm2w3OkL85G
 6BmuM/lsZBHL1lWglAdpix99klbqbyEwP40pSjJIFZ6T3oj+7hJsu1XkwaK/gC88scLWKFGwf
 NL75cLEwRlz2OffxkK1WJ4VPacxLEPXyTrYTaCBOEfvHsSIsSRgxnmCQdJuyg6WED0c17e9VN
 cp+5KAovJUNw4/grMNaOGztjm7O3zQqnIAN7xuxkCV8PRRqYWlSeMvYxsWtHldqAMBt+Ur+J9
 E7HCPkwyrhTWhzuZ+y+2qeuBP31biptUm6yMdF608I39+McZ9cqhll2sbXCKVu0HHVqeCOqFg
 nLTYTaI0xZSBb6kIAP8PT0z7EYVEuke0F1KMt6KgnqgQJYj1QgVT8UcRUzWY0IQfBckAfddN1
 PKNMxNMfVmfriOhSJ4mAoiybcpZtYNUbKbzPNvE5uvOKcrFRw8fDUtiNGEKZXWmzbI23gjaUN
 pQzvupi6D9IlSs8lv+ZYg3106I189NSUn8e9NCW/FzQoX8ZshQIJ2EvQpnY3n+x0RzmMkh3/5
 PwtKhZASgNmN2JdlcgsYEcQp6nWmSIVEUU5I2gOzj8ZDieVqw8HbCb6bQUilcnzZfg/0S5wFK
 ESOTy07lB5JPc8HfkiAyUek+hy1PKvkCRyYGZha6qxDREWJ3W5+EyzD7g1C+a/nNxpBxsjBND
 8BLNkKA2Pv2Q6jZZOLNtDDXT+YmZtW98zZ+WtiOy25ExwL+Lsisy7JLfPLzqGG0uF45zg/MrD
 Z9JOoE6Ot4too/+0rdFdn/PadlQNEbLdeY2T7fy/eOj8YXWFgRnAl0crdMeDTNNIjGw6Oclsn
 CgT3IhCHrNVx+CMRj6AKhCUf8Ifu/AR/zD3B96sc0eqVlSvfk50shYuahVLzmc+0/AGZCNaDN
 wtte28gEW/vzSXxjqRoiB3OfBtvgDiC6ElRoSewcIwoV8AheBzPaCBk6gTHhse68vj4QCE7Oq
 vx4b1AANxMMAKXaqM6z0kLBAV2kFX2e+BcMq1GbgRMczL6gKZpKBTBDouxRxjOF/hvBKAYKVS
 nP0RjYT1jCju19lgJPYqedMJRfH7aqrydwKtEQA4r5bMUEiVA3VN9bYHLSxCnQfnpVfajX1oW
 Iv0ZbvYjsoe7+DBPJU1YXihZSPW6xGY1S9tflNEC0dchpZPpxQDyUtvsGgZLlwVFR3nARq1OV
 NYR5FXc/S/zg7X0SmEk4XbP/GWsOH82niLTkkVD4ULCqUrNuJTB4LAPE2932kEMkQH7oYsOzK
 fI0vNb/wzNvdlqm8cGKYNuOvEzwegrHEiBEW36fDq8X+W7r0mXEmwU97dM0OPJkFIJKG2stto
 XAMAZ1usivOjXNxa8u9pK5khuywbUnFO88Xl2Pzj8wOznRH2Jaek8GSwywvjE/TYprB4NHqcy
 GhuRCPwGoLQbk0W9cMWHa57y+yong5mT1D1CcOr9q21PThMYaxeYu3e5p6Z+1twQtIqZehnmt
 29Clc+GnkboQj6pmpYZmTphM+hnoduBu3i8b1yFxLTz++i665FlLL+1pA/bkZhEn/1S0z0vEX
 4VeLY44Tx8E+AHsDTlIGPp6D8F1reoVT1Xd9sxeJeT1U983YQUqHcEpDRhEih37vHH05Wz9yl
 zVisBeKpen7IjP25GLcYKU5AEnlSKEQ7CbWG9EIYcZSpS1q/vx9R4vDfJ+qZSS0nwUrcfg3lS
 N1+FWNK7oJqA6Koz86F2DhPTbd5RtM0w9ZrzTKZhpYHOAGJPlNVBRL2f6JSr7BGrc7RGh8xZ4
 ghMt6fTLgjzbmtfDLGGTg5BCCOQEJ0EWp740inKzwbNbrpdiWS5icHZ4OV9Fe+WtrRdX4OdkO
 WvGViIGi90rYE20UdzTntbn1yIBgclDqIZ3CwqTAzba1ebSKrkJf1s3DQO+lZvAT/HezoTj3t
 ohXM7GQ0TDh3Ns8qgoJCi8WkFUto3tskV86MQBfQ1IqwFbRTj9QQpPNKLyWQmPclSrGeXX6jg
 wDMBwW4K7meUYW4MwLeolWWYJWNA1GFSVeFDQ0dfv4dSi+sXxZQVyhVLqaWldlAKVHteA5tmb
 6+lDUt9hgUpuWbS5G1L4zsaPl8ntNay/Z/SXtd331VO0AKqnShy846m3lkQRAMf+1+dU4+/o8
 LY+WDe4k=

On 3/10/26 02:14, Wang Jun wrote:
> The function viafb_lcd_get_mobile_state() calls ioremap() without
> checking the return value. If ioremap() fails (returns NULL), the
> subsequent readw() will cause a NULL pointer dereference.

correct.

> This patch adds a proper NULL check after ioremap()=20

yes.

> and returns
> -ENOMEM in case of failure.

You return "false", not -ENOMEM.

Anyway, I corrected this, dropped the DEBUG_MSG() call and applied it
to the fbdev git tree.

Thanks!
Helge

 =20
> Signed-off-by: Wang Jun <1742789905@qq.com>
> ---
>   drivers/video/fbdev/via/lcd.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/via/lcd.c b/drivers/video/fbdev/via/lcd=
.c
> index 8673fced8749..91359d2b64fb 100644
> --- a/drivers/video/fbdev/via/lcd.c
> +++ b/drivers/video/fbdev/via/lcd.c
> @@ -954,6 +954,10 @@ bool viafb_lcd_get_mobile_state(bool *mobile)
>   	u16 start_pattern;
>  =20
>   	biosptr =3D ioremap(romaddr, 0x10000);
> +	if (!biosptr) {
> +		DEBUG_MSG(KERN_ERR " Failed to remap BIOS memory\n");
> +		return false;
> +	}
>   	start_pattern =3D readw(biosptr);
>  =20
>   	/* Compare pattern */

