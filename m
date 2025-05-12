Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CADB2571D6;
	Mon, 12 May 2025 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036448; cv=none; b=Qw4UPSpAWlxhyHcrGBH47rrCZJjxvP82TYQ068Q0dccg12rYJSUGrhfwNaFJHoYpDg/SavHZOel0HAId+pH3Wxuf9v4A2zYbG5oQPFjJbPp6TB/FWBYzBzWtUSAY9fdCkon8wiW1IuFrVNoMjBYBNvnDx6p7lH/gF5Zx02fc6pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036448; c=relaxed/simple;
	bh=khBFTpkthW4d+LVfyE8vIm9PFgkU6QqwJcvwXtZafdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElO2vuS+/mOvqXRprAZvHgxhp0Jir0HOtcvzIV9MbV9FhdLT6dor4U/uLdceh8/IRTxXD0d6vxwl4x5nTmmdSKduOJFDlc7NzVEVY6x9wgoTEyH88NjBIOSCgP6wwQn6ERJTAyS7oenkES0aFTfIfNcVJDMimRrhcosFaWE0ONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=LRLDN/Mw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="LRLDN/Mw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747036426; x=1747641226; i=deller@gmx.de;
	bh=O47j6L94fVjn/YsaLE+3s3gGRDZgvp+/gUtgpTWTT6E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LRLDN/Mw5/texYqbFbD3Fme8jg5R+fgd0YUoPtl82DLRzl1DxF8onZ4DaN50bGhM
	 UYACIdRJvnPrMnl/IYkm0bNwtv2JHEo8I7avorJV71r34glJdA5PMm3hH9RYbw991
	 TSIv0KXAKMfYF400VJicwPhSTUuEvRFlJ9G0UK2NQE1CPavcXqWzKeW69xFrqj588
	 pN1JDr/C2TYa0MJqJDGoZthCypjdAk0PDKl5mqbaOsEIqHZHa9ZDCoY1WHl+I4E2A
	 LXKicE8T97BORlD7tpHjti8i6gIEh+1GyLdIvD3f29nyM95qN6AM2Zf/EorVUDfAA
	 SY63aSFNc01e/mgAJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1v6Dcb2tSm-00v7s9; Mon, 12
 May 2025 09:53:45 +0200
Message-ID: <041138c8-a1d8-42fb-af4b-4e93a85238af@gmx.de>
Date: Mon, 12 May 2025 09:53:39 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: fbcon: Make sure modelist not set on unregistered
 console
To: Kees Cook <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>
Cc: syzbot+a7d4444e7b6e743572f7@syzkaller.appspotmail.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Shixiong Ou <oushixiong@kylinos.cn>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Qianqiang Liu <qianqiang.liu@163.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Zsolt Kajtar <soci@c64.rulez.org>,
 linux-kernel@vger.kernel.org,
 syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com,
 linux-hardening@vger.kernel.org
References: <20250509200643.work.355-kees@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250509200643.work.355-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EZoYGogtQY3Q6cffV6x3/jC7yJ+uFi7NwsMCI+21arfl49A8EGH
 Qu5kEy+v3JNFZdEnkpxnS/KXZRt60V6hT/Q+jTwQlcBe3y299d0hr6RTieW66r7bKFqCuLH
 cNVPeP74GFVuBsDTbyXEGPX9kVvuaiXkYpGHXg7kgiIomoyphQhTN++zu+reY2QFL9o9OYS
 J+g0Bf6rv5kFMcBF4eHng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eBiVxuQ9pLE=;z2Quw4PB7HlGVwTi+oqnQf3GxzB
 xNcdQhKOgRGf06GJAItPClO3d+0bcZ43zsF5CX42yVtaknZlYV14Jov6QCHg96AGn9lt0zVUc
 4+zv382/aqns4wJWwCnTx9QaEQph+Uj72efzG7VwomJREulSFMF1EKb/EVZuYZMozeqNr3Agn
 +cs6eos6ofdjxB2QW1Gh65bmdYZM/l7WqAekIxQJ/GQj4bOLa77l2+3ZFw8qA1W+b09B/w10V
 Qvr8dw5IAcep4T/ISfdGnmxKTbwfyacPSmOo5WQ+h/3GYg8DVl8mYuzb9gXrIOON0gO9dZbZh
 ipi4CkXusCQomyBK7JilKRt33t6UEHwmXm7baUw3qGaQXOUrJ/AKDgdP9DWztasVRdxrjVbfj
 y8dodLAGnzttjpwEw6iOL59Mx1EpQP6m0rKTMOV5qyviutdHRznk8CiVHRuO3aniKk7NEWSqZ
 ii57v6E7ZJaGNInEq7XOmhe/XSNzKpwRkkc3MywovzLZy+PNyBDHOKx5bA3li2/x+Du6IXnJl
 gvOdlNTbk67gXg9QzfFOGajB1oS4Bl4xgnbmJABVOh3V/IqNbT4GqXyKArjciuk6k49fQRPd1
 HJwVQgsXpESryh519W5aOSusPnGnsXMDVtAZgLc5TZ/hw6L3cOvVqnnxfWxIf9v/OozCkTSes
 PM9g7kVf0AQyWA2YgsKv3Hf54olf632AxycXwiaFJZh08J15UjB02oYjEDQvkVmj9jCThyagO
 8dz6s2aWgA/0uwARDoTMHqA4CwqxmPE6hfamiFdcq63mfMXQiekxsiqaACxYDrlBUcx6u6HKJ
 Zi526Cf4qUw8uadsnMW8nC3FKTwoGCp4zqjpcEx1GE44dDAiIOcDD9DM1ydCJbUvnXeXbrZa6
 xxRGxcB21OI2/OnerZYkDmntrgED+3WI5zf37gNsiaHQH/P6iE55g+3bK2GbYCxibXb9GBlxZ
 kG7V1f+K6crMwlGKL0TUaGdN9ugyqiCNL6Af/q9lQKTSIGi4EJpN94nG1f4pLl1tn8yHfntq7
 BD7OUnv8ouLarFFOFP1mZ8SuonV4FJl41JkycVzQfAV5QX+1cM+yt7UTQH3p0ql41Gphq2Mae
 XAmeFiTA0f/wqhxYTDxMrlepNx4djA68jT1s0W4ZSeoGgVb2jiVkzB964nfaRpjN1c48KHF3p
 upsRvOi42CIxZusL4yk3KpEquyQpyUcU43nLm/gUic8HmAg3X31WJ8cHrVdN1gi2QbwzCoF2y
 z+7b0uzCbrQ3C1raJSepdCqgm+BTdDiATCNqP6KXsi6ZLb9sMVgk1JfIK5NuQ0gWK4J4KvfR9
 dkFuyPx6F1ThTcIN3L+bwNa36C7CI+eSJ9glae319SzrDMa8jjFrgVmLz7jBKuIdaXKYw1fpt
 Icpk37IP8hxkMjWHoZVb2IwnjOM5Ma12sWQ/ixqI2TA+BWwwu7bP5TLcGC/DWmfbVTMKv30RL
 wKWzJkIH9SkVY/jktU6u/izQf4sxsY4GxVKJrn0m50E5KbBdNO+ok2GnsSN4fwTnIQbWvY1ro
 bh/7q2IkIPICp/n3mQNYF3TNKxQbCnKOf8U/M6X4fvvqUi+B2OuzrFoAZjTDuUfZN0Dsje159
 KgwcM3vSXpvHsfE8fXvzgCezinb0Jechx6mky1cndMNjAvzCnT1MYWfhWPafBxjrmqJCiQCM9
 TEHLnCLJl9M3Wed/oZP71t998gU2HwyLgS4km5P+I4c//SSlTS1JqexNV82Jd82gONZ3DFKIx
 PXNzLl4nzA94VMBs1Q6JaRdMkW3H+hrVAcUSkU2yDzqt6S+vEyNZIUQexJZ3tUUKLgdfMYn7x
 +/v1YrD9MH1dgT28mPTPa0i4WSZQYx0TNqR9w13kN4FRgL2QjGFmX/puxGZufrMDfn1wrZJZi
 KMws7/nJkRNL1ZAUCUbJshiPju3RF6A1vN28bmYCvNSDG4vS1aDz2oGKCo6irH0KhbKcd8Oxy
 b6T3wJMV8KOnieVP1vmHHjoAqJgHATe5KWQKD5QF5FJUNS4SxBRNPgxioIMpfJekAme0OjKL6
 gEDh3Y6bipJ/6NdWfwB+vxeJSxu2VhffvACqcMrZfZEMNWvaWhpam0FMZsqrdFd+5UQU3eTSA
 yxbUtbGzQpm/c+reS+pnZPE69CFCHzUZYtuBFmYQLWAMOnlJfJUP820DWfgZCYkITLhBgt8vq
 1YRMNKdV9Z3p14R0AgCDtBADk13A+GgQu/XFZejuMSHeb6fMfEueT+DgGjwHQiy+bxtVyEwYy
 4M8Okq7TJxTlFfCd/6yt4XwxHE2Lng6oOBO9OPuwMQhbAYukAm16MmJ7REXN2OJH5OUqkHtKk
 EIDKKy1/8U60CanJQwXERHuFMeLJBP0PTz5sXeUVe8TJkL5qkXHeqVumQG7/WNC9Uf0cFM865
 YM227ZO3eMzlh/YdigXWCEYmZoAXbDX4eaZjDKlyLTBqDo3xXfoTq57fqwkqmIWEOfMg6mJ+x
 7/0UHtIAR4SgbxjSM120Q/mmWCnw/ExC/4boqmUC+pXiqVh4OVa63wnPzhtZcj5DwzmFm2oJM
 qUlYRC8+ng+JPNqA8hNBFqi4JyZyrlNnOLQHNMf6tZyKmj4NowXb7WdaLeeFUobo0ZQLilaAG
 ScO2XHNXgforo/HrXLQxGJpBBCQXRErgNFaG9+GU14cKsyxUG0HbWYya1LSoS6k5raP6Qtsd9
 mrhuDwL4xQWGzP5hdYFTPZrLQfE9JV8b1iHGDcVVIGkZ+fKf0ykgD9/zPwOve39gh8wp+POCW
 Schnv7cMbcfF5ndkoRdXiRMocNyqBAYz3bzsYcqXVnkqLoZPWeQqcsJeTDGy8KbmHFZsfpsQe
 CoRAEHc2s+j2ERq9SjCBTOH6JDB1RGZNf5kwJYl7Ww0f1b/Bf7tIk+6FcgGYIDh5FQi1MGe81
 vVYwktuhWgMIZu3SgqwijAe6bq6bnd5huYJ2yT8NccPbhz0shqzwgd4UVR9dMzvg7JbtTkBvU
 Q9+EeuhYKoRqR8KZlg/VZWFhqOUTrwrtfudQojHMiiAT42+T/3vDlcvfAa1FzUKRyVHhFkbIF
 zlFP6Vv1iH5p3ai2hGn2SnpnSVP8jRLluEcKGdzJhQXK/P8j1rKs4TcWQ0CH939ZYD4uA/mXd
 yI5FBrPuPEt9Y=

On 5/9/25 22:06, Kees Cook wrote:
> It looks like attempting to write to the "store_modes" sysfs node will
> run afoul of unregistered consoles:
>=20
> UBSAN: array-index-out-of-bounds in drivers/video/fbdev/core/fbcon.c:122=
:28
> index -1 is out of range for type 'fb_info *[32]'
> ...
>   fbcon_info_from_console+0x192/0x1a0 drivers/video/fbdev/core/fbcon.c:1=
22
>   fbcon_new_modelist+0xbf/0x2d0 drivers/video/fbdev/core/fbcon.c:3048
>   fb_new_modelist+0x328/0x440 drivers/video/fbdev/core/fbmem.c:673
>   store_modes+0x1c9/0x3e0 drivers/video/fbdev/core/fbsysfs.c:113
>   dev_attr_store+0x55/0x80 drivers/base/core.c:2439
>=20
> static struct fb_info *fbcon_registered_fb[FB_MAX];
> ...
> static signed char con2fb_map[MAX_NR_CONSOLES];
> ...
> static struct fb_info *fbcon_info_from_console(int console)
> ...
>          return fbcon_registered_fb[con2fb_map[console]];
>=20
> If con2fb_map contains a -1 things go wrong here. Instead, return NULL,
> as callers of fbcon_info_from_console() are trying to compare against
> existing "info" pointers, so error handling should kick in correctly.
>=20
> Reported-by: syzbot+a7d4444e7b6e743572f7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/679d0a8f.050a0220.163cdc.000c.GAE@go=
ogle.com/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   drivers/video/fbdev/core/fbcon.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

applied to fbdev for-next git tree.

Thanks!
Helge
