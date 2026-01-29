Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262AC371040;
	Thu, 29 Jan 2026 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672522; cv=none; b=R5mb+jdikSLXUAQGf/vyEkolnhbJi9eLFBl2Fd879Xs6FBXNIwPfjYxm/nl2BVaoXw4npw5jnBdoNLiOOl4WHIvrJT1MRpkGdu51aS7z2HTxQoIzcyObHhxCnOX2CnMipq+molpvIIr7yzVDIANslr01IrLw38HHtztVqGlWkZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672522; c=relaxed/simple;
	bh=Qq0z9q6Y+KQxDVHEcH1ZFQ9K0x+kjnxlPiluywqssgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHSw62VE8bs+6Urx1stwEO7vRneiJkjebIX24I+oy9rOi51mfuEiAFBAvmw85m/xZao9Yjfsfw11HYtQb+ZVY7o82+2Iu4SJotE/2/8lKQVSL39XgyP/ic7vB7Ke8/sOXBb32HTMb85iApv9unoTpPrco8VXwD4ZsMyNGDW1u+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ftCxteQ/; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ftCxteQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769672511; x=1770277311; i=markus.elfring@web.de;
	bh=Qq0z9q6Y+KQxDVHEcH1ZFQ9K0x+kjnxlPiluywqssgE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ftCxteQ/W7thsUjcOP+JuUfAM2otJU9wjOzn8Gl6rYZH8aXmgS08+K+f926+0q4G
	 xdtfw7+44RguGN341GHo+YLlfCUNnJ3Osn9MUp/o7/G7+SAXGgzu5asQM9xXoKOHw
	 xXGrB03Y7JJXEmzhtMUOW0B4DbzhWO6NWaEjSqykcG27EdLvdRmjH7LFgYREJTAv+
	 JF3UkhMfiJogkAj6oqW+q+eBkdXoSzlWpAG0+H4FYVFzhl/Jpbxik9/aRei8Sm9HM
	 /AEpOMZyo6rLCmvw4LMLjbDDAlpaiBg6oGI8DU6N5Aqx+U7ae6LTRhA6m8nXeFU6v
	 +GeqXfbbyTJzsg8Qtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MadzU-1wHwR62Kx0-00l5tg; Thu, 29
 Jan 2026 08:36:26 +0100
Message-ID: <d19fc825-514c-4ab4-b853-6a12a7517479@web.de>
Date: Thu, 29 Jan 2026 08:36:13 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: au1100fb: Check return value of clk_enable() in
 .resume()
To: Chen Ni <nichen@iscas.ac.cn>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <zytpnyodschvn4mmpllxp62yg3o77hjl7l5nyckoxyuvucjyaj@xsxbybnyzd44>
 <20260129040714.2772522-1-nichen@iscas.ac.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260129040714.2772522-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KwpxARyH4lajqCnAhtubBhmdGLq0cOhC8ZdCRMBwfSt7gTZIL6G
 rCyUz3BjCicKwjPr990zDihFPXnE5gyulndu9Ybxlc+L94xSRTSX9/fusic5wk3xcg5QPdy
 +wHmq93iu25ruargVhhnltDWGE1RdPr6Xe1V2MGY7IRqx/6tHeNX1HQtXb3TTphlNdxPaDI
 8INoQ2JTxk+tyEK7j6z1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+z2Se4do9gc=;9w9CawbeVjSXe8GhfBLNplaGqXn
 hVTIB59mA8XFDWPu1dYGxaylulgLGz8/P6U433aFT8QZApv/JSh2dGeS5AafPZ4u70T/xqyYL
 TBUCkBrGF8MFTGRif+KnnN8Tq+Rz9RvfXsAzu4uij0GUO0S2M97zWV/96ag/SIv2xAA7QVrEb
 TK2Ts/8o38lycT5hrKwYExHCRNV3M0rAVheflX5BYK4PSLNmkmMM8R+9jW/yl8jD/9PcJBTH9
 PYwtAKhQJC6C6M6DpcWohFl0bCS1OvFbSmUdXoIQwo3rUvMyaiIT0kuEx9TrW1UeUIzNsskcO
 4LOqA8YuxZzass8au+P9gQ6LxS4PaKQeHr8LSQRQqcrOwm82urBUERhg2rpX5Xf8uDpS0ZJbz
 VdZmFyqoghYQ8lOR694fUizVLaQ6QARmuQj9mozS4yEqQ2I7jMlB8vjRIgg6hgk+npeZylv5k
 jRn/DlUVUQhdxt24szszp/3ZwrlGxfdr28m9TYi5HHbCblQDy9+vjB2sFQwVU++JpJ6dOP1xV
 J1zLhZgWTMZUDOajdiUW3AS0paSFAqAOTznik5MLfmacNZCOk6S/XYqhNYg0TUS8q1k8jMkxU
 uoRI782Bssz0OIIEHIKrFIzgqShvrWYwdX7z5YkA7JBGB/W4Rn9TcGZDMapAAIuyYBGzZn8ZD
 QziNrY0YV19oBvO68Bq7XUZbsxpLIaYl+wE0Mh9rPC2D6J1DHUZio3JzMiyk+gaYFThViUGQq
 CJXMCwzFFCaB9mnHB1unai451cvKPAsQjh/T5tWgIiFxLtsCE0AKnlDxWgSjwix0ihWNL0+yR
 YBabsRl7/fQlzQy4bDaP03qD8YjvlXPfA+z+Dw7OrtPbgw3DuxdYR8Nk+6z0097cws2Gd5x0T
 SID706e1iUgtt10B0JAmnK2UhVIX8si36P8f52/bKQ+bFLGcordYezD+ivulRYgLK7YFroD+r
 RnqdBA3bsXA5q1js89WQhA0bqoTBkdVraGRdGm93oXjb2wOpppVjx17qkcczJxT7xABTOnZ+p
 3ujKncw6zdfNepQkSGn48pRgbp4v1crtOUTTAoAZTyqBl5Tz0C3Q/9XNt7210KCwcZznf+ndk
 S1I/F3/TNf4xCbQ5pYLOcCffHyS2Btz08geL4pSUf50GA965dgQLwj4MgNKEMHS5j4tUoa3I7
 /+8BUD2n2102QBCGBXXlPRwWBYJO708dATQdEAO7uWjm+nEyOKzeZTO8efD2S7ADxwfr7qNJY
 5UoE46LxkLQpRuh5OC9IOqApjPeEmV2+6det8X+SdHucebzDm4hTjWV53xCKMmnFl4qI4zxNK
 Lyxz/RatljUTQ6RZ/XJbPl6E/E5rDzOmx5+8GL6TooViYGyS8WZigLZoMOUFarvKvUK2mCJyu
 IGAsifejHuGfJt6+I+v+QkP6w0KYpSHGA74dijkN9hNakFpXmftMnuGYNiwU8omePMbG0gSs+
 QHlp3ywc8IfBk608BkR+nPoWJLcyr00TJatGHRGy3Aojkv2bzcNFGI7eYE2ieRndjwLsOOXyI
 L7TH5nDxMJExSDmMVjRQdhjjZEyOiDDkSJO6a3GrGZEpjmcxEdvwSEoc6XpoquG/wQ7ATYW5V
 0gml6FOR/GLUNygtn+1iDYNgE6a0XRDvIuiLZBqJzmR/TKVTIVe4CBupIQvBlZVhB1OCjY3vY
 nPqhSZ4jP2PfKllG2c7f8FFDMphlvgXgsonz8jNOIsEbiwDATlvhJPMV9E3mzgWl3yEWGdzSv
 tHEE3sqh7bBc3FZqEoLf1hfrb4sAzBe5Cyacf9DEQNhTW26jogyIKfbT5Pwq5mTQY+wYjTL61
 uGff/l6hc3XiRPxYmxX1a6W3RL4F8VZcwkm5LnwJDj2+DWHuxmmA/g30Sue0rYVmOu4r9Thog
 7QxFACV6iZRk1G81KdKubUmgolOj0mONAMkZZRzTAzkk+cIsYX+tYT2Eo+wQlJKG31M2mA3vI
 vLHR3cAYj0DSqNPb+oOxw13+0X6T569uJOTupNC7rZz0trEDz0BHudOZN3xooGCCW7852VaCs
 dM0DviZD5CQRyxw5Nv0G+jmXTusNLjMid4PtUIZs8Zmsrp2iTJONDCS01v1c3Dyf3vX9HAuTK
 rQMseOWM9qFfO1pQgo13+3LDVXmT0ayfD2ic58+6XrcMXsM9jNidqoTFmjmVTuOdsAhABsu7M
 JxRdlZ+AtdUQ/0GJRg9banhLA9R7zLSGxI+rvqDuNIFUOm/FSBfQcOsH5pwNMrQBUtGVfmfdl
 93TkObSiKSbzuLGFL0vz4uJoa+6COLvVY/GBmLwYNRkBntozmitqzIM5yRQT1VBxxCMQYQ0xK
 G5P8FZfzWGN+qudh2YYQi2seX9u51KC/f0At2MAOAXLfm3zN0v4Mc7bVZbzljLM5quc5Qv20T
 hfkWv7kHDKGAq6ItJ0ZyniPdbIV+1JW6YpM0PmnMhWrfvhYlR5H3ZsGxBzXeZYUWnhGCqTijd
 uakqPkkTx8E6YIZQGeh1FL3xdA5U5yxhUX+ilSxiSB8dHijMFc0TJ4cR0nCbnbQ/mt7iQQiHb
 Su0J/z9ED1jh9bBpQQyoP5vpsqXWZf85RQ5h2lPtkojnGObf8CrvIruouMoWaLP3bl9GD68Dp
 z1xViB7R/CZxZ8t4B6dejH3amyQiee381/sxLpmIPG0B4LowaArqYrjtqd1hxLrsI5+Rft6YZ
 fQzCz3O9bkiSOjRVOshVGUhWr1j2jpljVfLaKnLXnpa/iZZGkiGaI+np6ac1PYHFqYhjsIlS/
 ljFaIp7pHKN6Yi0aTDXjSuCp3Vl89jQlee8B+6scApiLk31bpuomKQDaKePoVGXyi/ha0/WvO
 I1HXMuVrdaLDJRHFrCCGFX/8ft5PYCakmB5h24bw1YFQAgNkckJDs4N8q1nHwPZtm5Q2Bf4h5
 dkTKJwDd6O6I/vOt87rUt/xnD1oqa8OPLZxdd0bDfZH3zalRn8NkHpBlQvyB3TDHdg7WjBTrR
 wyEgnBgPHpT3OgQWkIDCW3WPc1XwGA6ft/9Ea8p1644M8zYFT3AdzCkJFGRkMMqKQwK7obMKQ
 xTcpmGrzvgAGhL8KNW3/nyvbrhqzqlhGBxlHTt0HRpoGNkBkNLGzW9iBb6oNyHqdktBWMLoyB
 Jx4zG43gv5aBGt14c82oFdfCRYWnhg5W/LexddxzlOj+VJYglRs1jhiY1yg4K0s09uMlX8i+8
 XsU+KU/VSuU6DMjT5B6iUVZ/h9HOTMRas4bdehgvYOX8RTebq7CX9pI3OfD6doVOVdyr87q7I
 N2q3dgXBL0HQdF90MQqziJKRUs1HtzMF2Xm9ZbxrdJJRRMd/Mdsg1vBNOOqR3qp8ShLntF8v8
 QTOGJfIeriPVyYVzGPx6whF0FM7Z4Eb8H8irNhYEKC6ailWRRSXmEqLTdaukRplFfpB8jiacH
 2L/5nTkhH9F+yRhzcVCGIfqUbJaOMBmt76+d4OjcxivXxCJghL1U3P/Fsx3d+3VuisoQGz3sl
 aEOsdRNBwcz82l7uc+QD2SXQSmK82+EKT6EaA7UTBdFS4+HDErgzCEkUoszR4CyQ3xHXV3xUW
 myhSPuURfVaAr7CNsjhJSXtQ3ihuWgxBxd5S1VuIKzj+eRKtp4rzS7ReoxEJKjDCFmuk6oQ9u
 PnkpmL68U7+6mojy8WRO4yUzNHuiZsMU0411SG86G1fKqnbV5Uua+4K1Ntz5tzZipg+DxRaaz
 qpAewLpRyE+kPkzHmk9mNQQu72Ge+JZynAmmVAqs3FXvqSFMda/9K+HBzjaMXe+BrlYL0hVaa
 QpcxZhIX8vb2xYHF11F0xjiMs/LU0q03ZRsCl3GTK8B/BU4alVYgR+GcMUWoHX9dWrPn7u53x
 wEdSO4kQp7lKHmg+Otrcv1JHpeflQAHekN5I5i8Iqg+a2qQCU7lrtRgep/0a0/qF5xGs1DoZj
 a/QwyhAMfe2gTcQJnU9yOPJ+f9CHsZrdANZEHWiYAldPUyOqS0fB+8cI9KkDw116I4U6JCrYP
 LwMXfZShWizuqFaTziMm8j+7ESvD0zctM+n7Jp6wty8jKqbi2In63W25ul+8ercuTll2MWCaX
 wkqOUJX14zshHih3bd49zeQ4Wa5M+t5tk6GKjq3wr9ScwbNMP+8B6P4D07aAv5+QFeyvC2/Zr
 CGEePhkf6itV03K330LfdBs7J+A/q7iF7LTzwx9n+pwPgmt1Z8wCrPCdGKsmSPgRdbLcbYoM/
 olaoIijAcWz/UKtiXJnqv5U15NJFwjb4F6js1GE8L3SoMuAiBmIImH2FPUGqBwjApkEZA9Alk
 qXYyYcGqK27Np70wTSbIiyH9zXjznTlRKjqLgEz9bea6pPseARADfPLMfvatC/rq6B6uNNAnM
 v4/LwScRmU6ZScLSnvJLGxAwnwFl+6y/SRtMgNI5TeWVkKxZcuLsoY8/2hylAHRqUEoOxV6uJ
 dao4UW+OykwjTHFZQoCE8I6CQOjlxDIGRo+SHp1fZNOzBsniKQa+Lype24/HiCJhTxo5y9Ayn
 ijXRLaazAeRN5u5YLFxwRPgbkWAyDny1fkx8DI7GcdaiVsAX3DVzKs5wNztFv1k4nYU+8VUGi
 zdYiFlY7sz+IHLCWGxjcNT+Wv3yM6MZxG2vlq+3w7lZIXUnqfjvSzim1i7lZdrJ0CX0B8HqNI
 tOZbV4pk6Epquh/hWl96lDy51wUrJq7tFE7xc+pjZMGKpaY7ZfbA4bxYtBY8Y4Lhb9Vn9+XEj
 yUXrDc17mAujMlcNQbgWs9AYXn6kU+QCv64zR7QNuWFDkQeDxBpIksRMISp4/0KkIKOOSfvfW
 7AvmJFRO8v0hBifIKe8h36horsXCTxdWS8D8Tpz9r7boIfa1R1Wl+4qMiGSg9KgZ5tA5SOPl9
 kNv6Jm2yCeOjV5aWSzmh8HA0ynqurpuUF6J9Bui6JaaJv7UL96cZKRVNDPNfZ9/kic/ZGhzmU
 D7dXYyAf2gs9WmDNENyiNgRhy1nDibNCtlwgny5JcAxBCxSD1Nep9oYDntl58q65wDeaSe1eZ
 lNmUaAhCS7BJfcjpKLx9ZfH6+iI3U6oXcsuzY+tpBycq/9RzCF2SKo4WzdNRFvrOW/4UhxLvk
 21cBX6rGOi//1KpOXeWIIxuXRR6Rs7kCKOkoqzi08Y3ryebLroe1CWgkpXkEj076eovbUzGtl
 WwnZIJG+dzG+ltBA6X6cfsirgNYjq2tVc43AmyuJL8P6Pn+c9h96tyYSWR5PfamJq8JOEBLaq
 3F3esQjHb/X/A2uGSfEYxHq9CbbH+

> Check the return value of clk_enable() in au1100fb_drv_resume() and
> return the error on failure.

Were any source code analysis tools involved here?


> This ensures the system is aware of the resume failure and can track

Ensure?


> its state accurately.

Did anything hinder to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=
=80=9CCc=E2=80=9D) accordingly?

Regards,
Markus
