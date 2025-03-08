Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB31374FF;
	Sat,  8 Mar 2025 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468343; cv=none; b=ONWboZNVqliVwjKccU3cY2w5VWgd7W1JQqybMH32+FX9Yx+F7xf+BuREeQ8OqRCGumjd3MayOxJRsD5QKgmSXzkR7TnrDT3vK5PXk1wGy8idvNbPfU/YXQvqGjRpe/mq048fG6s79H0+l1mdCXy01Jc3szNqgsQO38RBq/z+NPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468343; c=relaxed/simple;
	bh=9MYZCPeQ4Ddy+A6nU/svnt+tx+oyOrBxHtMxw216f+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IejrGcY9etdtNYxSwPf+tAN/oBjrSiUfCK9f4hYZ7z94JB/ap8sEGWoOVef9G3un4BQhNMQRs0ZetIBSUOqYKSdj9EPva27xaz13zpXQ47wMU45JYPSZUfREee106g9OQd5afc+q/FR8S6L9bFaVFiLXAJcr5OyGegMepE83xnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=QHLSo8vm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="QHLSo8vm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741468338; x=1742073138; i=deller@gmx.de;
	bh=9MYZCPeQ4Ddy+A6nU/svnt+tx+oyOrBxHtMxw216f+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QHLSo8vm5chxikRuf7VADrqvMNUigMwyGYjPlwyXoHP3ClI0hAcLqpO4mdmY0t4X
	 gW4SmH7E9ymACWaAxvz5u/Cj+OGjfRUErHYl0T8/RVnak1fhVcJR4aRmkBPmmxkdR
	 z28cY1NIhHdA+FyUhNL69ILFx3NvGdFzGAdQVAQlWp6nXEEFn6mAfHHCAeWVzyoJn
	 pvhAEJ90AAzISUzFaUHTGyWyuHJzm7boGDK/gqnPukU6b4BARXPTFWL/I34tqUyUJ
	 RB5kwuvBTabgUfLlOWoG8ZmaA2Y7vMYNW5/zZRAbNH+Y+rvMU7ALkI5JLJ4E2wMia
	 TZAXMuhKfrtfGVCpbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.121]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUUm-1tRY0E2xSO-00oEsP; Sat, 08
 Mar 2025 22:12:18 +0100
Message-ID: <6c211340-037b-440d-b5ec-b4a5e2bd4ef9@gmx.de>
Date: Sat, 8 Mar 2025 22:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: pxafb: use devm_kmemdup*()
To: Raag Jadav <raag.jadav@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228071009.150971-1-raag.jadav@intel.com>
 <Z8Gt8fg07Y-bFPGT@smile.fi.intel.com> <Z8ywEzFvWxb59LqK@black.fi.intel.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <Z8ywEzFvWxb59LqK@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5ONv1VHv6g9JJNUAgFVZ2OjmEiMCvj+kJ9TONHZKBgYc43rHikg
 sSUtZnTqRXO/KXe/leNtT3gFQe5utyE911s22JhXSgerGj3KG11jH/ZU3rp0Z/qxCFfYiLv
 xnlkHw+/VID1sqb09y7Ud8Kju/qhHzHtvfSwlbYhk4nQcL1r6dPNBGCftOkLAhOyxM31E4Z
 +CK7B6+iIQG8xe8JvkXlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ke+G3/7dzQw=;x8xI9NH0jACcHJL7EvysHSy/yWV
 pkQwbFFgPkHRD1QZ3W6FkIhCoBSIF53/I0VvsB/Pu8QIacS9V2iuTxuuzbCHbBCRRaT1uv2P6
 mkukGUb8aGOmFki7tMcMsKib8Rp0cwExjbTTOpT8+93d/votWu7Lnp+ea/H9xqHhYfRC6IYXI
 VPT1urdZMt5040d0ud+8TIFqWzhiDbx0hTVyUTJNOGHxTVuGV+d1mUheLLuzZX1suwh7payJV
 bCjeHJ1PVw4Gu9YtpfvRlL1R25u6newhxyGPV8J/2P3zAxsSeSGCmfg9VTg7Eul8UnSfnv+W/
 SgZphZjr3jtq4XIi7qmgNmFtQQWLSY0LR3GlVbclin5TBl3Eojg89QmfUfS9fNPdmODKhLHD9
 wa6qmMwwLiEJRjhz/DaYMdkDXKJtpvzKrttAN7ENzqOXKsepYhhx8wS1GrvDwDTD8kAfqXAfR
 WWAg+eAWu70zC5EvlgGgGlsZx0lBzLkywRT1OALfXKhHvlzeg4GefmNQHpLFwI3EwFPAH7E2e
 OyvYs+ouUgfabOniY8+wr9mNWfVyEXdEhLAzw7HrIBpcZa2R/pyUy640IfCOazirzP4ckgLJ2
 nOMm2e3dGslxrdWj9Vg65qI4yVR2OoRNz+rqEVzXug6/W/tkSypav2Gbe9KIPHuyvNs/AAMjg
 3QGCiKWXSlVVZRR5iRK/UogqxyrYaGhCRblmjLBZkqkgYJ2ulYPgUkL/R3/YhbrNxY7egdJxi
 BmuiUdCz/AopfVHmRXYSVjXgsq0ZY8OXWGP1Q7zi9SxgLkYJy4qRhlo7LUbQede6audWvEhvn
 fvuaNFJcSnzDCdEYSLcMKOJ5PN5qOvVDC65tFi3aVkkX4+FHFr0xw88QaVj2bO2Uz3aYCNfHV
 jYb+dXPRQlyf44xZq3W7aXtndgcFPEAyfVwuC6XEqe+jE85JV+0XLrjPRT/7lSIPQlDRW5mcJ
 xIF58FbZU/RHmeDR40m1F9w2Ny4WlVgv5WOYl1zEcyTG39ZsnJsXyytGFlZTR6pdyoX+onaX0
 Pk89dd1dgKkCNEvG0O+ZM2LxVO7wDtwJM2ZYGEd9Or15o6Htj6Pb9ezZU2Pf4n01uFeKEP8Xy
 0O4sQvFalzIubpfzAdB0qSgUP14vs28UOCGsJqnx8oCFluQTeLGEV6VegWw53OmxSsoyk5DaZ
 nFeH20RlPn0lEAIfjaVnXgQnd7u/WW9kSq5BmoZR6325PlCc1N9BnRdGyYavD3N/MxMtyF/TC
 rJVex8wWDIOxHHzuM9qAC0Vr86Yld7AIhVDbbEtwXg7ZExUkbjotlJ/NxpB5h9C2X+ZDfrwEz
 3Vx1fDKJ6RteVLKcRgQX8Px1OhrTWBNffnnr2hA0p1WNyg3x1ElZLa4HudM0TcNPUxbmZ010+
 0V2n5r3Rb73iI84K2EINpJBTnE1mG85zupkyG2SZt0yQlfnGj6oxotLq52

On 3/8/25 22:01, Raag Jadav wrote:
> On Fri, Feb 28, 2025 at 02:37:05PM +0200, Andy Shevchenko wrote:
>> On Fri, Feb 28, 2025 at 12:40:09PM +0530, Raag Jadav wrote:
>>> Convert to use devm_kmemdup() and devm_kmemdup_array() which are
>>> more robust.
>>
>> FWIW,
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Thank you.
>
> Anything I can do to move this forward?

Applied to fbdev git tree.

Thanks!
Helge
