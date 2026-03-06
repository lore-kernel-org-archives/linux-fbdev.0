Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6BF3446C6;
	Fri,  6 Mar 2026 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788820; cv=none; b=bPCpUi5iM2ARE2Drv59iLxXDHGWBt3y0B/t7KRajKJsZetwzYuwPxT/bliHQ4nY6y3Y90qHhAcTH4DmOv7AgHBhB5UcIto7j5zY1IKmH/uoOr2srLRwnOOiT4P6XnvqfjV6mR82VT7iAa01qemsozVAFlax+5w2Gd8Tal/VkD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788820; c=relaxed/simple;
	bh=JdjcfdWJx2tUyGh6EfJHj14sIh4aHJ57gIcxVLEkkUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTuL5Na04yOxdDvNcg6lKx4E55z4oxaD9bjNpGW9WDXXZMQXZ9mR91HE9yu7K2qV/Eom0c/sRE931Q+Cb7sbUyFtspX4dLUr6k/9xWq7cLu8NmnC2Zw5lnC6W5o2PYq98SyEF8wNC5pSylAUtKjLNDOOGPVLhmvIAWJd1rMcWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=pLlLwVtf; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="pLlLwVtf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772788812; x=1773393612; i=deller@gmx.de;
	bh=El5PeZN58Jvu2IRJ97MzEZy0kMI5BWE/U2IdQNuwxLc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pLlLwVtfwaVWJRJKzPiup6marvrrHhHUXbw62D5J6Fmj/6ALyJ4JigCn9jV3qggk
	 RGzkRfRQiteYkx3WzDhYIHUZWJUx6BpTf2smtlXK7uKlyga1A6ltrj7Bvpy03AvQV
	 1FH12evg+oiC7Vb6lfT9EcCHkExoPgT60K/M3aBuFPgZw2AVbil49qZ3peT/+pWwL
	 2P0N+mYOH9oM4BH7LVKC6Jh/6IyEFG3UYBzL8iVTPPalGGrKLHeoVQcBZ8H/fNMSB
	 jsQem9MwBmJyscyMuLwnJ6E1s/p6WuycFE+5pzBoTcKUxsGcHbFaTIPwzcCA8O53N
	 xTqaXMOqt82gHEhXAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1HZo-1vvgSf42jy-00AwZ6; Fri, 06
 Mar 2026 10:20:12 +0100
Message-ID: <2c1ed16c-a456-422e-846b-525b84f54efe@gmx.de>
Date: Fri, 6 Mar 2026 10:20:11 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: macfb: Replace deprecated strcpy with strscpy
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260305103919.158067-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260305103919.158067-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x/95cAcBJk27tEaOnKvYoIEJmdEx3gIWIFNQLDOOpj+BY1qS3kT
 QARn2MswYCCCOW+UQLUW7SxT9WMJEhFeDCx9XTZa8rQLe2AwL8jCuu9HsrQn56cDOKWOiTy
 ewDeKZQCUkVZyEFw+9Kq0QcrwDM6onwHhcieSTq6leSmP4JrlmjX0S7qg87sfir+Rkg0fcF
 e7SVeh8VnrBjdHuM2EiHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AcLhyXxlwz8=;j2E8pkHlI+sK9nkfM/gfwpjk/R1
 THCkwnDbN7da2ICQ+kIkM3sJ03lCbYpv6NF1WfOPbU+EJDBUvFx5d7La5SLc0STbX2tOsPvEK
 6X/755AL0azwz7M4p5QFmZmzb21+bFa42H1wN/AGX0iarfMDqf//ycsiCVkImCixYpEqIHiKK
 qhpq8FfMfPF4WHi+9O5MSGhPqTSSLHtwwSYc6Udx1O51NVqXoWShcKPp1Dz69ljlWNaSC9xvt
 HnLEJqZdC1x1uUtUAz9mWNqcfi4wVIY888RgU9BIGuvIKfEZBkF4FXeK3v42WBTxrhUsRwZVd
 idV/uYF4NFSDtJYXfLGacGt4JTJjrqOnfz/SdrZ8nfjhXq6SWjf6GV20rCBQPyqlk8FLNHX+/
 6xpXMlPsMCfKMLdXRntByi13xFZwsCuchpC+a39V2Ca+mY55BqcfU2qpIke4rs468REErjnw9
 mvlZUijr4gMkIgMJhvn8JxrMQba742eULXsK5dRdoCFRuqIl6qbSODaxjhA8SV0mjFYCfBIgL
 xp/WBgQuTkeaR25zONDzcVtbt0+OQnb/cuTNAbOjOtDAPTpwZvC4YkAWoVltv757TvqRaCZ1L
 DR3Wh9gzjhuK8WR0kDE0StNwsgMdlStZmoOVzyVJGd64dYW0/ABJc+PU2vABrNuwyHNMtsfqO
 zyzCg/u/Zu2JD2ZndSe/jvNmJEsvA/02HVNhxxBZ9ftywQsbcj33lUwmZ+NEHUKb5DJuw8JW+
 pGy3wF4jrNF052pUezkFbvE261r17G58phxqp+jxZYe2zD1gOTzncbXxlHnUqGffc0rraZOh2
 RxVor3f9l4qKtaISvGGz8V6sEtzxGUgrVf00+Wx2sun6GdhISgyDbbCUTSdmc4NYArhKqVCug
 X/YyvAcuKpjtp7zc5LfrFgQPmjEVYG0MvqpL3eb3NpyVkrCsp45R1poOhNhJTREHXU1F302hY
 41iAya+7Xw4vQkD6H2PMfJWIQOY/Rw3dr2UvrrulZnU26eMT3+ioY/UOVAveifyecbDlgcHRV
 738qT/HK6Gb/Yt2SMcg8R2chNplSc3aBvLeU+ROyHibbSKIOS122prvJqqJeoBm/Rc9ySdRGI
 jL2OclEcrGyv5RaNiRXvoR585eut+aI/rCvrslnJed7tbJTLATUEMGkBVRAy6yMtvLzdX22CT
 m4/Dfo2yF5kLyNxLMzt0yGZ1/WLeRshT7n7iDRiJAL0y0Z9KxCDd6M+b6JtUSGCu10cohPr4q
 hH6NePCwfV+Ln6T4v8zcCIP42JECtJPx4STXbvRr2gFXVZq1xF7sJrXczBuO0ON+BK+qmBrGT
 DGZ+Pb7oypsjQKRjVhDphTCD38QjTM44rW6uV6PewGx/wq4kvx67JtED6uoF6bfNGOR6PFC4P
 7jqGausihMgd+Rw0dVMIIdWJTKiVPySIojsF5J2GL4lJvVs6kUuyvN1Tm3WnN3uyT/HEcWa8I
 YAa5+FsDD51dm5LFWiDdKqVxtlVj1NkOs/KgNw6cJMDV/ZmVV1D3uOC579iyN8dutoekAFFyB
 NlV2drHikOnZYoQGbqgbSVhMy12S7xOxmDobECtq4Jf9ZJwnadccbsNzf7PiRJWf4aqtApnlv
 gTHdFQ3vA3McxiHZzVXT15p7yOUvWTpMlqsQsBb0s9cdgxirnNTb8SwtHIYsO7uwdNOrQfgq1
 ks4To+GEziY06u7A4VhMsM8TNqXzJW+TubQhOKH6jIlrLRck5Ig1fjbNCuApyKfWqd2nmt9M6
 mlBBog8F9+JwdsfdsakyGOOHeCtG9K0Gv9tvlPKvvUEwSPjWkuGgNt7iQwBe5rAW1O5/LV625
 c3h4d1FDwtVKDRpPj+HCExclWJzFzhxmS85u30iF0IKq88/YA6sulPOS0Q/PxXzNDkZO2CspF
 E/IrMHLDa3ZHdZEgvLYjEveCXrPohWyAr9Qdu72QLTRdVO9f7YpWBoJevQI8IRZvdarnFYrix
 GCzD293U3KzlcQXbwc1X5nrn/n5rhaoaUZa/1GWl5u/UJaBe/A9kh2LsT0VQwkMOO4UMiqyUC
 Eemrjvo6RZedyGn2gyLaqdZVhHXvMtIXoBWwDN9tCweO4FM5AnhyLhhqzK8bawBgMMr4Rk1x+
 dO4p0jyBRdjrZAbZw/ywTFFODr40esfcY3UpeGnMRKzAMjSK0OpJKHFMxd5cXkKDBfms7ztK6
 EkhC4DfydHGooPWxgNvKd85hVyCmmcGzdcSRyTD1VmA+Mh2L2gpfu9oqUEZHcUABfm8O1BJaO
 bGXW3MSRjiSJBNkhLUTb0pOE3s8lULphWUusMWJvQzQW7Cxbj6TEkuh08gERc92kG1QMsOqeI
 4YhM2q01Nti/OunQwnTemqC24nColHs4AV2JuXxXSWsBmilV6tycdajclu6I3K5OnCbiwsQMs
 Iat+QARrBqN91haDP+PoC4ueAwu+QGJEzrRVDzG6MGBaJyrUkrrd6MEenFViaQQwqzGQNmKMU
 +E/UdyLnCERWCE9p3+S4TIcuTABQcPvXsN4P8SfKdh0q+N96h3n0RdPdwJEQf0pB9CbkIyARL
 qEvxXqNf3CTuYE3bQLZFcnkNUGSnrwWo3K0AbQnZcGjn5zqkFvroGGzBiiU8ajKOaUSPS5H3o
 qN+Gz50LypjRwlm/xMeolfO3l3dbTXYUp239XUCQ6A10Ejxe32EIcNjsKF1iyF1Cia++szYWX
 +WIOIotGNt+Q1rK70BW1eudr0UlOTPxP3WWT9ZKpkFRNk6Y8gUEvFazEaoaDDh2Dbz18VcWap
 UB8tzpkSRt2FRiiWkrPUUbK/KEGixNUvLIYFHhMrj6nboQ87XdVI92ucyc/fkRbsdn0Fr0WFS
 pW/Fu+n7LnTqreFAO9FoRLfiRV8zOGr7j9I6GMM7ZeDxwxTKlsTLJLSOG+JkS0nCvaVbI3f3S
 t69BDERuUzyb9iNxfAHtHMHswYKXXXFtGRvaB8gJsRY4XsF497lVLpxXlmX2oLkYjLt63Y/WK
 6t54yiDejY/nW07NLthvVKfo4Mw9oeXrJxu96q1M4lC0hfHC78IfBmiEWhL8JSHYTQb1ODTSY
 JKmzZXMihPt6Hkr23MKDG/KrUPD6Y5xkVMEVuWauhr5VPlkwfrxh/UkSA754dZ4CummbV4mS6
 l8FXRxiBm0lb+t4HskuO5olm9iaW6uPGscPYbp2nYhS+JIAlAuZ6y/NbZQqkB4QkGdBzwXn2I
 saKXKNbLVwBqV2CZHoLf47DK/0xPIjXTPUy7i45jppvvkA/wa/q7LU7cErlOYqgzdrIpE9Too
 I1ghCG/MZfbVxy95WjbWRGt6x9RwviVG619SDM4y7MYEOOVrja6IMAoejcRJ+zAO6ANTZzxpz
 oWGiQFwwWNz1YD/HjxmK40Lc4GgCdHDrZ6XO8cHDenS7czuxO29fwdnrKS3YbbnKTuK7xnCUg
 P77EASv5SvGmQ6vab7X5QRAZKGDf3PYqJThQwMX84H6FPqbBxgR26l2s8sE5w+dPHdNQEMewm
 ekTWcHmxkk/UdLJ1zT94xBYCSqf/vV5g5LAIeviDT7C2O6hZwJ194A4/0GN04jVj6a/verrcM
 o8Mjc7N4XSrbs2jarf1gTjCq8hnqQkK1jeJafe/JsEKd0TDof0SqknpzXQ07O1nWw1vZfgmEt
 ha3qrqP9yFv2xNBpf7ObDwcx2PzxpLPlJNoQAC12+k+5P+cV2Y8j57v4TGIhjS3ADTQ612/WL
 gZzqSh81yC/sLCmY/eB4IMUj5V7Aa5gpZ3rHNrpQR2W5X2XKvQx+PecPgexU4rF2y9U4W5Cyr
 MoCph5v0XGSDu2Jj8iT6Uo/lgR6FjnIsvsP2yhPwl4Y2ug8G2hza+Y6fktff+Q/y/SikBSvPJ
 /Tt7vwnuv/HX4HmolIXwcOxZDrlbYlLKCy7CbvRQGfocLRZJ8k/Te1856FNiBQGGdSO6xvf0K
 1h7M8xtjsjhKvRuN2pyyraQ0QBamkrBISFjFP7rAPDoCT1Y8NVgtiFJCz3I6GWHx+XDlAiUw6
 D+NuYSrWH41BlAkIk+7m0i/u6BpucELUcbhEJT+70C43kuSCjMkJjIey2+zRzPpmrOxs5TsSm
 DsY10cOF4J6w0J8pnQW2hQJUXFNqrsmEqIsW/ZZGn70D2Br5w9w4fM34eN4XmFk6azj2vBs0L
 6gkGDOzea4++yf0BaU2U3Ic0Ql2GkbCeOc1SI/qZKzmeMaiw9ew3Ge59XlCk7WXEwcd3pMxnN
 Qv3PP4crvVa7ItSJqo/JDivn0VT+fLAQfH+aci8v3zOuCmQNwOCYQ7G8Gvq+h0DrzY9KIuvst
 qfwd209BDggV/GhBNxvywVeeykb44xIWYZwxXVy48Z8uATnBy1CFinQ4btx4eZa36iKANvRN/
 OtktJ6ihqrKyNTU/6Yoi7JpC89usme5/SQF/Ht4Xb/YiM76xLVU7G4eDUCdQMfN544jyiKUFw
 BwQlnrG0+r5sRsk96fCim5tdrUCjD/zKsR+yHI9T6FBmF/DTSwrvZFyyAXogHdRjNpnAV3gpU
 R7gvxXzqUjwrUSCqHXNzpq49p+mIO8PsBcG/WcILzjRHspdFndT14uEtO4n/l4YhQUkZkLmwU
 J9rWUxxzO8LrNip/Edd7aqq5MFT2hStbYQ8eiRJbTGJMxmr/bUeri9z+tDVhLBUZuEK0cFWN2
 OuKl8MButgY5pRqKRQtK8Il4gXW5Umyo31YYBIWgl/JKDbxXd536wx1IPzGuXUL6HEEUYBHt0
 1w8za4lfj8OMyvH/CR7PyDaHKTvWmKYdpwagUd4yzhKVckR+cCmS3IOPvt0rO0fCfkDhD7lvN
 3wvQ3WtQiS5kqknZFSW3zvECUvuJDvf9R2yKDJ1YVi2Xifjye83Vpp/lg6llnD16jq7ai7XDi
 jRvq7sEyjPgBMPuEGBQT8R51fRv80BeMvFW5zLROIY1ufTFNphQK5BOGSsayJRmqEWKSrHvin
 JT1h56JhIkSdVPaj5jFhVzMO45mEgLF+eV52EMtLYv9seDV8XjKCvuMYtwvgHNoAp0VNCA6Uz
 9szvLJcSUYti2NstWVMWuVh15+jkNAyxZ5YuwkKrCURUVYKjDmWQQ/+MZGyP6MhtPSYzlD4OB
 Rmik1ume03QD9tWpIq1UF2TurL5erYn7B/3HVIqNy6eeP7xN3pE5X+b2PZbsUQZblMYcrD3lP
 G1i9GtPtx86jqkFe4DufBIWkHY5rdAEPw0Cwu8poN4s684NTaBHGM66oXxJA==

On 3/5/26 11:39, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  No functional changes.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#str=
cpy [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/video/fbdev/macfb.c | 38 ++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)

applied.

Thanks!
Helge
