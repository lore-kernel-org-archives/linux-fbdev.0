Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475242C1589;
	Tue,  2 Dec 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702347; cv=none; b=sn+SAuIKeS5Po+bky0R8FJcDRfjf0AWIU9IOICAZbn9Iyhzo3DlHMVy12eFg+M4LD6gEh0oCLWMKaBuHCetQaU7iMGdfMRvsOYoeS43/5MnET9CLOv2Xyb6UKBRE7+UtIPYB4L+wPXoCPkLiKQ3Wy/iSO/8ZrTp9ZRMPLsjZw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702347; c=relaxed/simple;
	bh=Gsff47WzEI40KYDklrcbGBhs8pnNQdmsK9cfPhc7XqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwEFAHilGo+Axgw0m9DVw4MClUzVho9KnWZghzWZOKWg+hQY31fvk64MOkVDXxBKhseIn8qLOXczz+xR2SlKgANHyt96XUcVxQ+e1/t0Tr10F7iUQjkGLJtexrGUoWVPcFkIOHH37kVMXBQwrbN0KyLY4xFGCxDv6aufQpn6tdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=oP4QFhPf; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="oP4QFhPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764702335; x=1765307135; i=deller@gmx.de;
	bh=Gsff47WzEI40KYDklrcbGBhs8pnNQdmsK9cfPhc7XqE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oP4QFhPf1yKhhMidIM/n4RSrp8F6en3Qyum50yVVInF0jMpfuN0TP1viy4TPVO0u
	 bsjAm4acEOe49tmavhLoN8MqdohhpTIqREnNO01JXi9xcONmeZ//SJGzY2ZS4WVQQ
	 Ota8Ectrzpg0zS19WDbqGmt1ceeBOnW1DXrJ7I6VnmFoBBspxpaGUiK5vqgf/mRyk
	 NXwU6wDmOnMd0HnBrL12cBW+qBCakf6zTcOg9mDLv9EKKYEQbIFLUvOhl1QfD7oAd
	 yTxRdIfhP5BBQOWTJyH8xI7l5KzxQSInBk7EAlhXgUXyV/aibILt/U5sjjSHxeheH
	 nlwQQy2ZpWfeMI5wYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.47]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1vQlbF3zsl-00DlkR; Tue, 02
 Dec 2025 20:05:35 +0100
Message-ID: <a4fb3f2d-df6c-4f81-be96-d23c72c94688@gmx.de>
Date: Tue, 2 Dec 2025 20:05:32 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fonts: Add Terminus 10x18 console font
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Neilay Kharwadkar <neilaykharwadkar@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251116192029.2490-1-neilaykharwadkar@gmail.com>
 <04b704f3-9f89-497b-821a-5622c1e1b3a6@suse.de>
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
In-Reply-To: <04b704f3-9f89-497b-821a-5622c1e1b3a6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1OpqWjoaBJ+0t70kvEjD4o2gQvLB6k6I5lbHhs5xIXVuRO5kRDy
 ZocgyLia7iqTznZIsKse0EeOZoWXUogHDdQ10CDKmTGLBc025odkV1/qTXaqgF/wVmuTowb
 tChgPVF6N53lN1Ee6jsX3HiypAAxPWSW5kYm0on6lv9T3cC9V3YnwmedGs+Unh64VAJdFQi
 F3PZPVrlAVOYTqM1Tbt2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tJqewmbanxU=;jjlDsB6wiiR1n+l2Btd4fqiDFZa
 NlQ0ssxHu0nWRHtB8mljicRo4z6jzzt90TpFuaJirB2CUVEfM01eaAcgfDS9LR5VXyEeG/0gx
 uy3UR5q1rGh1aBHlehNpYzUOYgM4mdrurEKZdY5Q/g+qlmj9w2p9nYqicnRO4MEVfgd9E6k7C
 odAE/M+/fbxpDSZwxE6VFr+yv3RrM71aH7kz/GJ6TGUlHVZVx5Oi3udmbSjUrFiyFgW7KcHii
 1tyvbsqLBcN3yUvRUoHc/x5Z/GdlDHzxVO71rL5xpFxC0Ue6KrwS+HCdw+1VaSNMIi21XI8YE
 RFpB/YsCwasJHgkq94KHJ4ZAmU2gmSkRUAWXQh/dkeToG6Ea82VZzuBzqnzL8pxH/9kCeoxQZ
 9neBFGOQw88Kq39O6G8GeCjqdbJeRLQMJPGAi1AEEsMGO5RYVLRiFFUr6K2sBqyQYVIGB8iK6
 HBcoTeynDZRUcikut0F9V7nD6IuXgEqxmtfDer2AzWS34j95SGSKwO7P1zkCC9aIB5EAtWI95
 7AfdAsqi3cl0zYHRoUF5xLEsZUtxaU7YmBi8OCc4stcByWI3sZCPCtw/rF4Ep5obDWhMjlkH4
 MjqViLMPeF2mgx2u8+xXtlhAGkKKmmT79HHLAlg+mzkw/UF/smoJEI3LZ7Ff7So+wmZ46+e5y
 D2iAfsGQGrjZM2Dt0eh4P8j6UR0z1pPBW6OAFijHAmUM+DBPOWXkLt/04K1wngZ8AdfC7ECn7
 +1JVP00eYOzUKJMBjd7S5xR59nUodr4VG/2g6WoLwpb8zyqqRhnnHp0VhNfeJxxRHXwFMzQ3B
 dKFM7XX2dCqAFwP4RM/Puq2qhfqZp4rYmM4DKOtO0k2UrSGhLdnF+QZxEOFwBDHb4bIOadwWZ
 Rw5ev0taG3mnHuGBVbFJcyBwXzy/zLCdIINKPIzdJDQq1lodEkQFjuRhKs2RtrtwFMu+RN4IH
 r5I+Iwuh5QL3YqMHqjpXBCvuGl/LTI9C0FwmRYL8QvI5Y7F7FdUECyywywrtUrZkXJ9IxVnR4
 M8aNrGYeOXaADMdv2ylYXimDtRzNOEXW4E3IsrH+EYNW7j1oXVKuBVfunOS1dLF9GN++dDPPY
 56wAmut8fG73ZKNR0/1nING/HH/69uJ5A3oCm7qIjeINbvjNhDtNNsKmYufgU2SexJpjZIJnS
 KVQlD+v5tFJ0OBKdOtQC1/c9QojWxU+IcFfLZbjT6bMifWZWK2H6JcS0lSFA0RRJz+OVCZtE1
 ms7bGekkSuDYhC+kYWbch9Y26wPjjCS4k4PKWeqAX1mbl5QNHUNJt7cevUKcpEynY0Yb5uKWA
 5BXCdVsp7EgyHIjlxjcbXP7w0h5UPiFCNPmDjmjg13nW08qqn/EojRuqC06Pwkf5YT4ti//6r
 BgRtTZnSh6NVq9V93770fveSVV61XMprrqqz/nXglJOqJtK4qzaunZv7KjmXcrpKMHmeAs2+Z
 dXLaor7QQ4kZYSeUvypFY6eTtdBmdC8lA9L/BnfVKAplyUJ49KcUZvE2L866hCeV8Q3oqiOQa
 frM/RCUBRGJP35MCEzfB2OMFgzD/AXL7yH1n/+mfAPGd3BbI3VdusUwFaAQGot5IkDrNPBHfz
 Z7Pgs8Z6qlkcPscHCHYMnaJ+ZN4WQsNqlcZpycmpXJynVATMZPnz7afulxed8H7Cj6Ra9D6m9
 GZqnfkQzrCVsJ3rG7Lb8Xn3Cl1BOYMEWiM5tKyrkAeqejuSyyflnPbgXPf5jQ+tOWc8z/eWHa
 c1o1XC2e29A+OdRJUMLaRCB9FGQo8KUjUOa/C2L0qlMnmzuigqSwknCn9LbwnKplfycdYRHoc
 Jnz+rrBFsZlQPWPvo3eQIYmkgKdMkMNEP4oMm5PWurET8jHtM5UORuz4wNaHHILwUxoa7cAhP
 Sfv23vB8XHm4CW3LEfkZ4wiONHO1bLcaaIt9fqXKjXcedl8hID8HAomfbWIP2Rcoiy2zklgOp
 dL7r6zEShBTyOyOSRpxcCtmgSmpqeM5LJrozZ1YabNpMxw8HiZCIdB2Syr/Fy5SWR0TtwWo/2
 l7ZT2beB8RjyzOiDDetv6LEhWyrS2Izue51uX9pezguF45mGOaNxO9gTKxawAMsdVrHSh8fYz
 gPOuP0oTnOD9lA150YfUXOeBlfE71LTulHQwFCX8LdvN8tdlMyhKl964Xg6ObA5207QIbsAQm
 iXx3oyNFsNkauGeH4GnOBu9CNWaPJw5kFqn7ssDeApioriNcJC80dieS3622SxOUZL/U/61n8
 MduMx5U8snHoxnUK9XGAz7L2MFovF9gysYYAMhLe94p0wF4XrIwUSLtMF5EE9ueVQ7TfSHAHo
 xF0G9BTjXzhIPQlC+LZScCWvSuoa0tKBR3k2/xocZdEmWioQvwpzCot301OmxgOPSWxNFrJSD
 3N+5UUjfwYEDH4fMcQ3soB16MBZ0jtZSf1RBGlGrFfvayY74JSzly3BuHHy8sHnacKM1alGtw
 H6sTyDjmOWj98mDm90dJ8qyNJ8fb0P6UawNpdQhX270ObJvecRdu1baJTPe1myQGO3SUE+Rkj
 ZBNfrHWGyh5b9t94CXT2nlg0XhrbXczk1PL4qF15q10wlLiNMSbOWgKYj6f7Eldbp8JC54qpT
 UXkC1jubvoRPmL0QFaC5YLxI8Eyb/ANPY9t+sOs8JwMRcr87UF1hq9F3nGwdEGDUmGgMhsf+z
 5uF2Pggs5vRsuxTvQD40tuQWOxgMUqMe47zOo98zoSxP2LPrUFbtW1/and/n/u4ctz6Y9wGlS
 6ZjKAAiI2ucOL4dtGffuPlU9l/npUXEHw9FaiX/+rpYp1IvSFvMeaOqoqFxJp3OKIdxWF80rh
 chXgNOMGZcVTVCv9SEWcEsZyXj1I60wqm+rJ35ZBGd+wExn4hI0Xd2fDGy9GsdoTUSpFqBilf
 pqr6p1Epvq3OFQyxUo0OcTjc/u+SGfrGd4nZHK/WQe9luzTQ2MkrQJ9B/4fN9SRFa5+Bog+tt
 VY3guG69UqOgihA13DRxXR65zImpRmJt5nsPMKIpMuEO6p9ntg2VTZIe6/jeE/koeNAvgk6qR
 KlkMu9lzHCneqK3oQ06JEZpY2ewuoUHyJfIrtd6UukMaGjGmmuzE0EgcMe8KCyyTQ7xRBATsY
 s6Rzg1BNTPta4rOmriThnZfaCSoXyn5rAH0WzDO5fYdZAuG9OS3RK1+O6js30vJTnubx/25H3
 791e5bIdGm4bbBL73t2zTzJyGPFdIamUfFJru5OsN9nmCSRWt3bsJr3DaOuBDWzwThXnpGR7P
 kE4prpszKJyY/6s2Qxh1ODWZIa81DlNqkRTJwvmtMOE/Vblp/oB5GYyHD1hJaVXdbNwYWcDpu
 5ZS4FzJlOEwUlJ70ncpJeKEF1W3Xoa3ltlr9YEOBRM2oMjS5Lw+YmzCWLsLoPkQu52FHnnjoy
 aIrulw8U1BUACZWEU09xKjupMp/ZyyKHej72EauBV5BUTcp2ORNUkjghGZXGP778nOC7nzhOE
 d+jrKWMrYtVIYRwDoMaMh3Y9GBTI7XdixBlewtyHjkArHa6Ar2d6pFdKq7FNKP9p2w1MKGoB9
 7gyCnyMECWHS+nVAVdDSzM/qDwesphBgkTEyErAiAO7VB/aIfWcEYsFf3yYRQBr3j8bRMMaA1
 gwhO8wTbdxqpKQOF9HfgRMfvRn60RAcadqYLAHtI0esgyteNYwbIjcOks6JN1RfSt42559prw
 ISIK3/uBKfBzgXQID9E1VdaJzXQJuu7jdo3QWqZavnW1nl3BxAAY9KY2b/girKdIt/WW1Id/1
 6U5BqGYMTS3BHih//ymUttYdHepsdCqLuZIfBICTtBtEaWVzsVpcoqKq1YaAhoCJRSO9qRaG5
 KVggad7A7v9SvXHMdilJHeVTlJbSOgG4l+momr0jNbeCjjBZKn1qAIXHuprY1IqNuLxbkWPlR
 fqzc1kcEhY1ft8lT/WsiUXHTgI53SlBmOwcSBWQKTMVf5rmEyGX+kPfjFq7cZmMxNSi5DJxjj
 bU8LFsSaqH+eYseAoCBlcVkx+SVIaoLi+b3SmBMIGcCtoZtfEucFmo5df8sYB9rMlrtNgmdoc
 UjjjSxy9St0g6mx3ITGrxr1tWGRVBwFDC5InE95JhmNYvlfGalbz99GO8kqaXDHwJtoessHKm
 3hb32l2LdpoE67GSyoY1lBmoJu8Ey+uu1hGujCGzfM4Su5yG+r4WYPnerpAiXGXVybYKhDkdh
 samrC00bA4MMGhr35wZsCdL/31nyAWnu+el4j3n9S0QWVEc4vVn+h1GF/V7YsZvWuF9NZgPnD
 G5mnKvsL3SOCbMIFbck5PW61ojSwH4wc8aU9ZikLSusgK7cZnZK+tkY9cSeR6YQrBmQks6Rf4
 h/RxojR7doPoLydUIjWAPzPkEhqcdQ4a+c/T1ENy861pIhlpW96DuuToYyCe/w82uF8MQHSvp
 n9ZDyJZM2JlCm2CBj4mEYW4kiOh+5v+KkPW3S+cR5d6jt4Yv2Zjs8DBEv40VpoTh7I8vi07ad
 uoJheOuzNcELMk5gnepnNTN7Qah3n/VOLv/ChvKEEToxha/gN8vJdabNOz5Y7Z8Di1PQ/knBq
 UkXb3rd5eYbjaG1GAnMIMSnCvlnLjVVE8gZhX3j7JtbTsp3GP/GrpDKcFw5LBSr/oV9qHdy6e
 OsFEoPPaSU1F6OS/dm0JYx4dDM2433vDY6/kFws74ffGmarBBnyspmIq8AhztxvPjcDx4u+pE
 fJ2VvmRlzFu5+KS75W51dEFA62eKGfQbVrraBBL6NasJ900TqaGjkXLZjjPWSZ/3GFLrwrHGE
 NxtcxDuD41nxrfEcWbfgiSPqJP+pdujyGKtsOc+9nk0rf4cDkqc1aCS0K+gmnGo1MuT+5xvDd
 jKqzgDg6Wa55OMqIQKqo8ZSuOmBLAtAHEor16M5kKxO3DcW51R9jIvDjBfKSg4teAiQiiVlpT
 VlyualMponbhGtCZHBHWYGfgjFXdFKqwmkGEJbVKpUYYg/w/jbXgG8Nqmod6OhoESS7T+sdfR
 lwFdx4pXjKB8zVOWkfNbyKs0VHXQsHqGrYLOWwfDDcGhaPE7iGt7P7DLxybhm0XnJpUytJ3JF
 tyDRTIYmEzSuxl43pXElB+D41LV5rDlHx2LOFVH78MK2sK2PFN2NJTYTT3B6TWvWiK76cEvNs
 Hm+6chgRJwf9Ym9LUcLGKZrNRmKL5tS0jp15R9XjvfiMHgPstBgZ8tvAq1s/jP36BVzz7DB5I
 4F4j21vYP3xHSj62cxSq2I9Po+EWnoSt7SQ24MfTqg+VMcVsmdg==

On 11/17/25 11:04, Thomas Zimmermann wrote:
> Am 16.11.25 um 20:20 schrieb Neilay Kharwadkar:
>> Add a compile-in option for Terminus 10x18 bitmap console font
>> to improve readability on modern laptop displays.
>>
>> On modern 13-16 inch laptop displays with high pixel density,
>> common scaled resolutions like 1280x800 and 1440x900 are widely
>> used.
>>
>> At these resolutions, VGA 8x16 is too small and difficult to
>> read for extended periods, while Terminus 16x32 is too large,
>> providing only 25-28 rows. The existing 10x18 font has poor
>> readability.
>>
>> Terminus 10x18 provides improved readability with its clean,
>> fixed-width design while maintaining practical row counts
>> (44-50 rows).
>>
>> A comfortable and readable built-in font for early boot messages,
>> kernel panics or whenever userspace is unavailable.
>>
>> The font was converted from standard Terminus ter-i18b.psf using
>> psftools and formatted to match kernel font conventions.
>>
>> This patch is non-intrusive, no options are enabled by default
>> so most users won't notice a thing.
>=20
> What is the font's license and who owns the copyright?

Copyright seeems fine. According to [1] the font license is
SIL OFL 1.1, which is FSF approved. And we already have the
Terminus 16x32 font included in the linux kernel (CONFIG_FONT_TER16x32).

I've applied this patch to the fbdev git tree.
Thomas, let me know if you have additional concerns.

Thanks!
Helge

[1] https://terminus-font.sourceforge.net/



>> Signed-off-by: Neilay Kharwadkar <neilaykharwadkar@gmail.com>
>> ---
>> =C2=A0 include/linux/font.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 4 +-
>> =C2=A0 lib/fonts/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 12 +
>> =C2=A0 lib/fonts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 1 +
>> =C2=A0 lib/fonts/font_ter10x18.c | 5143 +++++++++++++++++++++++++++++++=
++++++
>> =C2=A0 lib/fonts/fonts.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 3 +
>> =C2=A0 5 files changed, 5162 insertions(+), 1 deletion(-)
>> =C2=A0 create mode 100644 lib/fonts/font_ter10x18.c
>>
>> diff --git a/include/linux/font.h b/include/linux/font.h
>> index 81caffd51bb4..fd8625cd76b2 100644
>> --- a/include/linux/font.h
>> +++ b/include/linux/font.h
>> @@ -35,6 +35,7 @@ struct font_desc {
>> =C2=A0 #define FONT6x10_IDX=C2=A0=C2=A0=C2=A0 10
>> =C2=A0 #define TER16x32_IDX=C2=A0=C2=A0=C2=A0 11
>> =C2=A0 #define FONT6x8_IDX=C2=A0=C2=A0=C2=A0 12
>> +#define TER10x18_IDX=C2=A0=C2=A0=C2=A0 13
>> =C2=A0 extern const struct font_desc=C2=A0=C2=A0=C2=A0 font_vga_8x8,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 font_vga_8x16,
>> @@ -48,7 +49,8 @@ extern const struct font_desc=C2=A0=C2=A0=C2=A0 font_=
vga_8x8,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 font_mini_4x6,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 font_6x10,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 font_ter_16x32,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fon=
t_6x8;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fon=
t_6x8,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fon=
t_ter_10x18;
>> =C2=A0 /* Find a font with a specific name */
>> diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
>> index ae59b5b4e225..7d03823e46dc 100644
>> --- a/lib/fonts/Kconfig
>> +++ b/lib/fonts/Kconfig
>> @@ -112,6 +112,17 @@ config FONT_SUN12x22
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 big letters (like the letter=
s used in the SPARC PROM). If the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 standard font is unreadable =
for you, say Y, otherwise say N.
>> +config FONT_TER10x18
>> +=C2=A0=C2=A0=C2=A0 bool "Terminus 10x18 font (not supported by all dri=
vers)"
>> +=C2=A0=C2=A0=C2=A0 depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
>> +=C2=A0=C2=A0=C2=A0 depends on !SPARC && FONTS || SPARC
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Terminus Font is a clean, fixed width b=
itmap font, designed
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for long (8 and more hours per day) wor=
k with computers.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is the high resolution version mad=
e for use with 13-16" laptops.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It fits between the normal 8x16 font an=
d Terminus 16x32.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If other fonts are unreadable for you, =
say Y, otherwise say N.
>> +
>> =C2=A0 config FONT_TER16x32
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Terminus 16x32 font (not supported=
 by all drivers)"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on FRAMEBUFFER_CONSOLE || DRM_PA=
NIC
>> @@ -140,6 +151,7 @@ config FONT_AUTOSELECT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on !FONT_SUN8x16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on !FONT_SUN12x22
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on !FONT_10x18
>> +=C2=A0=C2=A0=C2=A0 depends on !FONT_TER10x18
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on !FONT_TER16x32
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on !FONT_6x8
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select FONT_8x16
>> diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
>> index e16f68492174..30a85a4292fa 100644
>> --- a/lib/fonts/Makefile
>> +++ b/lib/fonts/Makefile
>> @@ -14,6 +14,7 @@ font-objs-$(CONFIG_FONT_PEARL_8x8) +=3D font_pearl_8x=
8.o
>> =C2=A0 font-objs-$(CONFIG_FONT_ACORN_8x8) +=3D font_acorn_8x8.o
>> =C2=A0 font-objs-$(CONFIG_FONT_MINI_4x6)=C2=A0 +=3D font_mini_4x6.o
>> =C2=A0 font-objs-$(CONFIG_FONT_6x10)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D=
 font_6x10.o
>> +font-objs-$(CONFIG_FONT_TER10x18)=C2=A0 +=3D font_ter10x18.o
>> =C2=A0 font-objs-$(CONFIG_FONT_TER16x32)=C2=A0 +=3D font_ter16x32.o
>> =C2=A0 font-objs-$(CONFIG_FONT_6x8)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +=3D font_6x8.o
>> diff --git a/lib/fonts/font_ter10x18.c b/lib/fonts/font_ter10x18.c
>> new file mode 100644
>> index 000000000000..80356e9d56c7
>> --- /dev/null
>> +++ b/lib/fonts/font_ter10x18.c
>> @@ -0,0 +1,5143 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/font.h>
>> +#include <linux/module.h>
>> +
>> +#define FONTDATAMAX 9216
>> +
>> +static const struct font_data fontdata_ter10x18 =3D {
>> +=C2=A0=C2=A0=C2=A0 { 0, 0, FONTDATAMAX, 0 }, {
>> +=C2=A0=C2=A0=C2=A0 /* 0 0x00 '^@' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 1 0x01 '^A' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x80, 0x40, /* #--------# */
>> +=C2=A0=C2=A0=C2=A0 0x80, 0x40, /* #--------# */
>> +=C2=A0=C2=A0=C2=A0 0xb3, 0x40, /* #-##--##-# */
>> +=C2=A0=C2=A0=C2=A0 0xb3, 0x40, /* #-##--##-# */
>> +=C2=A0=C2=A0=C2=A0 0x80, 0x40, /* #--------# */
>> +=C2=A0=C2=A0=C2=A0 0x80, 0x40, /* #--------# */
>> +=C2=A0=C2=A0=C2=A0 0xbf, 0x40, /* #-######-# */
>> +=C2=A0=C2=A0=C2=A0 0x9e, 0x40, /* #--####--# */
>> +=C2=A0=C2=A0=C2=A0 0x80, 0x40, /* #--------# */
>> +=C2=A0=C2=A0=C2=A0 0x80, 0x40, /* #--------# */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 2 0x02 '^B' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0xc0, /* ##--##--## */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0xc0, /* ##--##--## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xc0, 0xc0, /* ##------## */
>> +=C2=A0=C2=A0=C2=A0 0xe1, 0xc0, /* ###----### */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 3 0x03 '^C' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x73, 0x80, /* -###--###- */
>> +=C2=A0=C2=A0=C2=A0 0xf3, 0xc0, /* ####--#### */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 4 0x04 '^D' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 5 0x05 '^E' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 6 0x06 '^F' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 7 0x07 '^G' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 8 0x08 '^H' */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xf3, 0xc0, /* ####--#### */
>> +=C2=A0=C2=A0=C2=A0 0xe1, 0xc0, /* ###----### */
>> +=C2=A0=C2=A0=C2=A0 0xe1, 0xc0, /* ###----### */
>> +=C2=A0=C2=A0=C2=A0 0xf3, 0xc0, /* ####--#### */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 9 0x09 '^I' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x21, 0x00, /* --#----#-- */
>> +=C2=A0=C2=A0=C2=A0 0x21, 0x00, /* --#----#-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 10 0x0a '^J' */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xe1, 0xc0, /* ###----### */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0xc0, /* ##--##--## */
>> +=C2=A0=C2=A0=C2=A0 0xde, 0xc0, /* ##-####-## */
>> +=C2=A0=C2=A0=C2=A0 0xde, 0xc0, /* ##-####-## */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0xc0, /* ##--##--## */
>> +=C2=A0=C2=A0=C2=A0 0xe1, 0xc0, /* ###----### */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 11 0x0b '^K' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0x80, /* ----#####- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x80, /* ------###- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x80, /* -----##-#- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x80, /* ----##--#- */
>> +=C2=A0=C2=A0=C2=A0 0x3e, 0x00, /* --#####--- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x3e, 0x00, /* --#####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 12 0x0c '^L' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 13 0x0d '^M' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x31, 0x80, /* --##---##- */
>> +=C2=A0=C2=A0=C2=A0 0x31, 0x80, /* --##---##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0xf0, 0x00, /* ####------ */
>> +=C2=A0=C2=A0=C2=A0 0xe0, 0x00, /* ###------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 14 0x0e '^N' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x80, /* -##---###- */
>> +=C2=A0=C2=A0=C2=A0 0xe3, 0x00, /* ###---##-- */
>> +=C2=A0=C2=A0=C2=A0 0xc0, 0x00, /* ##-------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 15 0x0f '^O' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0xc0, /* ##--##--## */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0xf3, 0xc0, /* ####--#### */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0xc0, /* ##--##--## */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 16 0x10 '^P' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xc0, 0x00, /* ##-------- */
>> +=C2=A0=C2=A0=C2=A0 0xf0, 0x00, /* ####------ */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x00, /* ########-- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x00, /* ########-- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xf0, 0x00, /* ####------ */
>> +=C2=A0=C2=A0=C2=A0 0xc0, 0x00, /* ##-------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 17 0x11 '^Q' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0xc0, /* --------## */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0xc0, /* ------#### */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0xc0, /* --######## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0xc0, /* --######## */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0xc0, /* ------#### */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0xc0, /* --------## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 18 0x12 '^R' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 19 0x13 '^S' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 20 0x14 '^T' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x3d, 0x80, /* --####-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 21 0x15 '^U' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1b, 0x00, /* ---##-##-- */
>> +=C2=A0=C2=A0=C2=A0 0x0e, 0x00, /* ----###--- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 22 0x16 '^V' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 23 0x17 '^W' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 24 0x18 '^X' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 25 0x19 '^Y' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 26 0x1a '^Z' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x04, 0x00, /* -----#---- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x04, 0x00, /* -----#---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 27 0x1b '^[' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x10, 0x00, /* ---#------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x10, 0x00, /* ---#------ */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 28 0x1c '^\' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 29 0x1d '^]' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x12, 0x00, /* ---#--#--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x12, 0x00, /* ---#--#--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 30 0x1e '^^' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 31 0x1f '^_' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 32 0x20 ' ' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 33 0x21 '!' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 34 0x22 '"' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 35 0x23 '#' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 36 0x24 '$' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 37 0x25 '%' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x73, 0x00, /* -###--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x53, 0x00, /* -#-#--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x76, 0x00, /* -###-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0x00, /* --##-###-- */
>> +=C2=A0=C2=A0=C2=A0 0x65, 0x00, /* -##--#-#-- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x00, /* -##--###-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 38 0x26 '&' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3c, 0x00, /* --####---- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0x3c, 0x00, /* --####---- */
>> +=C2=A0=C2=A0=C2=A0 0x39, 0x80, /* --###--##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0xc7, 0x00, /* ##---###-- */
>> +=C2=A0=C2=A0=C2=A0 0xc3, 0x00, /* ##----##-- */
>> +=C2=A0=C2=A0=C2=A0 0xc3, 0x00, /* ##----##-- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x80, /* -##--####- */
>> +=C2=A0=C2=A0=C2=A0 0x3d, 0x80, /* --####-##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 39 0x27 ''' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 40 0x28 '(' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 41 0x29 ')' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 42 0x2a '*' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 43 0x2b '+' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 44 0x2c ',' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 45 0x2d '-' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 46 0x2e '.' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 47 0x2f '/' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 48 0x30 '0' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x80, /* -##---###- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x80, /* -##--####- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x79, 0x80, /* -####--##- */
>> +=C2=A0=C2=A0=C2=A0 0x71, 0x80, /* -###---##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 49 0x31 '1' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x3c, 0x00, /* --####---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 50 0x32 '2' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 51 0x33 '3' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x1f, 0x00, /* ---#####-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 52 0x34 '4' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x80, /* ------###- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x80, /* -----####- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x19, 0x80, /* ---##--##- */
>> +=C2=A0=C2=A0=C2=A0 0x31, 0x80, /* --##---##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 53 0x35 '5' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 54 0x36 '6' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1f, 0x00, /* ---#####-- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 55 0x37 '7' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 56 0x38 '8' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 57 0x39 '9' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x3e, 0x00, /* --#####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 58 0x3a ':' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 59 0x3b ';' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 60 0x3c '<' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 61 0x3d '=3D' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 62 0x3e '>' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 63 0x3f '?' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 64 0x40 '@' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xcf, 0x80, /* ##--#####- */
>> +=C2=A0=C2=A0=C2=A0 0xd9, 0x80, /* ##-##--##- */
>> +=C2=A0=C2=A0=C2=A0 0xd9, 0x80, /* ##-##--##- */
>> +=C2=A0=C2=A0=C2=A0 0xd9, 0x80, /* ##-##--##- */
>> +=C2=A0=C2=A0=C2=A0 0xd9, 0x80, /* ##-##--##- */
>> +=C2=A0=C2=A0=C2=A0 0xcf, 0x80, /* ##--#####- */
>> +=C2=A0=C2=A0=C2=A0 0xc0, 0x00, /* ##-------- */
>> +=C2=A0=C2=A0=C2=A0 0xc0, 0x00, /* ##-------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 65 0x41 'A' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 66 0x42 'B' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 67 0x43 'C' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 68 0x44 'D' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7e, 0x00, /* -######--- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x7e, 0x00, /* -######--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 69 0x45 'E' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7e, 0x00, /* -######--- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 70 0x46 'F' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7e, 0x00, /* -######--- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 71 0x47 'G' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x80, /* -##--####- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 72 0x48 'H' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 73 0x49 'I' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 74 0x4a 'J' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x80, /* -----####- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x3e, 0x00, /* --#####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 75 0x4b 'K' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x78, 0x00, /* -####----- */
>> +=C2=A0=C2=A0=C2=A0 0x78, 0x00, /* -####----- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 76 0x4c 'L' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 77 0x4d 'M' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x80, 0x80, /* #-------#- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xe3, 0x80, /* ###---###- */
>> +=C2=A0=C2=A0=C2=A0 0xf7, 0x80, /* ####-####- */
>> +=C2=A0=C2=A0=C2=A0 0xdd, 0x80, /* ##-###-##- */
>> +=C2=A0=C2=A0=C2=A0 0xc9, 0x80, /* ##--#--##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 78 0x4e 'N' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x71, 0x80, /* -###---##- */
>> +=C2=A0=C2=A0=C2=A0 0x79, 0x80, /* -####--##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x80, /* -##--####- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x80, /* -##---###- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 79 0x4f 'O' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 80 0x50 'P' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 81 0x51 'Q' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x80, /* -##--####- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 82 0x52 'R' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x78, 0x00, /* -####----- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 83 0x53 'S' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 84 0x54 'T' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 85 0x55 'U' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 86 0x56 'V' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 87 0x57 'W' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc9, 0x80, /* ##--#--##- */
>> +=C2=A0=C2=A0=C2=A0 0xdd, 0x80, /* ##-###-##- */
>> +=C2=A0=C2=A0=C2=A0 0xf7, 0x80, /* ####-####- */
>> +=C2=A0=C2=A0=C2=A0 0xe3, 0x80, /* ###---###- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0x80, 0x80, /* #-------#- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 88 0x58 'X' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 89 0x59 'Y' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 90 0x5a 'Z' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 91 0x5b '[' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 92 0x5c '\' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 93 0x5d ']' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 94 0x5e '^' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 95 0x5f '_' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 96 0x60 '`' */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 97 0x61 'a' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 98 0x62 'b' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 99 0x63 'c' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 100 0x64 'd' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 101 0x65 'e' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 102 0x66 'f' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x80, /* -----####- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 103 0x67 'g' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 104 0x68 'h' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 105 0x69 'i' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 106 0x6a 'j' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x00, /* -----###-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 107 0x6b 'k' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x78, 0x00, /* -####----- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 108 0x6c 'l' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 109 0x6d 'm' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 110 0x6e 'n' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 111 0x6f 'o' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 112 0x70 'p' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 113 0x71 'q' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 114 0x72 'r' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x6f, 0x80, /* -##-#####- */
>> +=C2=A0=C2=A0=C2=A0 0x78, 0x00, /* -####----- */
>> +=C2=A0=C2=A0=C2=A0 0x70, 0x00, /* -###------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 115 0x73 's' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 116 0x74 't' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x7e, 0x00, /* -######--- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0x00, /* ----####-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 117 0x75 'u' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 118 0x76 'v' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 119 0x77 'w' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 120 0x78 'x' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 121 0x79 'y' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 122 0x7a 'z' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 123 0x7b '{' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x00, /* -----###-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x38, 0x00, /* --###----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x00, /* -----###-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 124 0x7c '|' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 125 0x7d '}' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x38, 0x00, /* --###----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x00, /* -----###-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x38, 0x00, /* --###----- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 126 0x7e '~' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x39, 0x80, /* --###--##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x00, /* -##--###-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 127 0x7f '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x08, 0x00, /* ----#----- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0x80, /* #########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 128 0x80 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 129 0x81 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 130 0x82 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 131 0x83 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 132 0x84 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 133 0x85 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 134 0x86 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 135 0x87 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 136 0x88 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 137 0x89 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 138 0x8a '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 139 0x8b '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 140 0x8c '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 141 0x8d '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 142 0x8e '' */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 143 0x8f '' */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 144 0x90 '' */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7e, 0x00, /* -######--- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 145 0x91 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7b, 0x80, /* -####-###- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0xc0, /* ----##--## */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0xc0, /* ----##--## */
>> +=C2=A0=C2=A0=C2=A0 0x7c, 0xc0, /* -#####--## */
>> +=C2=A0=C2=A0=C2=A0 0xcf, 0xc0, /* ##--###### */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0x00, /* ##--##---- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0x00, /* ##--##---- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0xc0, /* ##--##--## */
>> +=C2=A0=C2=A0=C2=A0 0x77, 0x80, /* -###-####- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 146 0x92 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0xc0, /* -######### */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc7, 0xc0, /* ##---##### */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 147 0x93 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 148 0x94 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 149 0x95 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 150 0x96 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 151 0x97 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 152 0x98 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 153 0x99 '' */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 154 0x9a '' */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 155 0x9b '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 156 0x9c '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x7e, 0x00, /* -######--- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x31, 0x80, /* --##---##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 157 0x9d '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 158 0x9e '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0x00, /* ##--##---- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0x00, /* ##--##---- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0x00, /* ##--##---- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0x00, /* ##--##---- */
>> +=C2=A0=C2=A0=C2=A0 0xfb, 0x00, /* #####-##-- */
>> +=C2=A0=C2=A0=C2=A0 0xc3, 0x00, /* ##----##-- */
>> +=C2=A0=C2=A0=C2=A0 0xc7, 0x80, /* ##---####- */
>> +=C2=A0=C2=A0=C2=A0 0xc3, 0x00, /* ##----##-- */
>> +=C2=A0=C2=A0=C2=A0 0xc3, 0x00, /* ##----##-- */
>> +=C2=A0=C2=A0=C2=A0 0xc3, 0x00, /* ##----##-- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 159 0x9f '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x00, /* -----###-- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x38, 0x00, /* --###----- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 160 0xa0 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 161 0xa1 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 162 0xa2 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 163 0xa3 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x80, /* --#######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 164 0xa4 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3b, 0x80, /* --###-###- */
>> +=C2=A0=C2=A0=C2=A0 0x6e, 0x00, /* -##-###--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 165 0xa5 '' */
>> +=C2=A0=C2=A0=C2=A0 0x3b, 0x80, /* --###-###- */
>> +=C2=A0=C2=A0=C2=A0 0x6e, 0x00, /* -##-###--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x71, 0x80, /* -###---##- */
>> +=C2=A0=C2=A0=C2=A0 0x79, 0x80, /* -####--##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x80, /* -##--####- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x80, /* -##---###- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 166 0xa6 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3e, 0x00, /* --#####--- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 167 0xa7 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3e, 0x00, /* --#####--- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x3e, 0x00, /* --#####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 168 0xa8 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 169 0xa9 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 170 0xaa '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 171 0xab '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x70, 0x00, /* -###------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x80, /* --##----#- */
>> +=C2=A0=C2=A0=C2=A0 0x31, 0x80, /* --##---##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0x00, /* --##-###-- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0xc1, 0x80, /* ##-----##- */
>> +=C2=A0=C2=A0=C2=A0 0x83, 0x00, /* #-----##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0x80, /* ----#####- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 172 0xac '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x70, 0x00, /* -###------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x80, /* --##----#- */
>> +=C2=A0=C2=A0=C2=A0 0x31, 0x80, /* --##---##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x19, 0x80, /* ---##--##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x80, /* --##--###- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x80, /* -##--####- */
>> +=C2=A0=C2=A0=C2=A0 0xcd, 0x80, /* ##--##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x8f, 0x80, /* #---#####- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 173 0xad '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 174 0xae '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0xc0, /* ----##--## */
>> +=C2=A0=C2=A0=C2=A0 0x19, 0x80, /* ---##--##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0x00, /* ##--##---- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x19, 0x80, /* ---##--##- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0xc0, /* ----##--## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 175 0xaf '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0x00, /* ##--##---- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x19, 0x80, /* ---##--##- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0xc0, /* ----##--## */
>> +=C2=A0=C2=A0=C2=A0 0x19, 0x80, /* ---##--##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x66, 0x00, /* -##--##--- */
>> +=C2=A0=C2=A0=C2=A0 0xcc, 0x00, /* ##--##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 176 0xb0 '' */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 177 0xb1 '' */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x55, 0x40, /* -#-#-#-#-# */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x55, 0x40, /* -#-#-#-#-# */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x55, 0x40, /* -#-#-#-#-# */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x55, 0x40, /* -#-#-#-#-# */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x55, 0x40, /* -#-#-#-#-# */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x55, 0x40, /* -#-#-#-#-# */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x55, 0x40, /* -#-#-#-#-# */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x55, 0x40, /* -#-#-#-#-# */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0x55, 0x40, /* -#-#-#-#-# */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 178 0xb2 '' */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xaa, 0x80, /* #-#-#-#-#- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 179 0xb3 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 180 0xb4 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 181 0xb5 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 182 0xb6 '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf6, 0x00, /* ####-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf6, 0x00, /* ####-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 183 0xb7 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xfe, 0x00, /* #######--- */
>> +=C2=A0=C2=A0=C2=A0 0xfe, 0x00, /* #######--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 184 0xb8 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 185 0xb9 '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf6, 0x00, /* ####-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf6, 0x00, /* ####-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf6, 0x00, /* ####-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf6, 0x00, /* ####-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 186 0xba '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 187 0xbb '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xfe, 0x00, /* #######--- */
>> +=C2=A0=C2=A0=C2=A0 0xfe, 0x00, /* #######--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf6, 0x00, /* ####-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf6, 0x00, /* ####-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 188 0xbc '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf6, 0x00, /* ####-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf6, 0x00, /* ####-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0xfe, 0x00, /* #######--- */
>> +=C2=A0=C2=A0=C2=A0 0xfe, 0x00, /* #######--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 189 0xbd '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xfe, 0x00, /* #######--- */
>> +=C2=A0=C2=A0=C2=A0 0xfe, 0x00, /* #######--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 190 0xbe '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 191 0xbf '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 192 0xc0 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 193 0xc1 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 194 0xc2 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 195 0xc3 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 196 0xc4 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 197 0xc5 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 198 0xc6 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 199 0xc7 '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0xc0, /* --##-##### */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0xc0, /* --##-##### */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 200 0xc8 '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0xc0, /* --##-##### */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0xc0, /* --##-##### */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0xc0, /* --######## */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0xc0, /* --######## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 201 0xc9 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0xc0, /* --######## */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0xc0, /* --######## */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0xc0, /* --##-##### */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0xc0, /* --##-##### */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 202 0xca '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf7, 0xc0, /* ####-##### */
>> +=C2=A0=C2=A0=C2=A0 0xf7, 0xc0, /* ####-##### */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 203 0xcb '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xf7, 0xc0, /* ####-##### */
>> +=C2=A0=C2=A0=C2=A0 0xf7, 0xc0, /* ####-##### */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 204 0xcc '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0xc0, /* --##-##### */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0xc0, /* --##-##### */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0xc0, /* --##-##### */
>> +=C2=A0=C2=A0=C2=A0 0x37, 0xc0, /* --##-##### */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 205 0xcd '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 206 0xce '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xf7, 0xc0, /* ####-##### */
>> +=C2=A0=C2=A0=C2=A0 0xf7, 0xc0, /* ####-##### */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xf7, 0xc0, /* ####-##### */
>> +=C2=A0=C2=A0=C2=A0 0xf7, 0xc0, /* ####-##### */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 207 0xcf '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 208 0xd0 '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 209 0xd1 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 210 0xd2 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 211 0xd3 '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0xc0, /* --######## */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0xc0, /* --######## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 212 0xd4 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 213 0xd5 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 214 0xd6 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0xc0, /* --######## */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0xc0, /* --######## */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 215 0xd7 '' */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +=C2=A0=C2=A0=C2=A0 0x36, 0x00, /* --##-##--- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 216 0xd8 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 217 0xd9 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0xfc, 0x00, /* ######---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 218 0xda '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0xc0, /* ----###### */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 219 0xdb '' */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 220 0xdc '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 221 0xdd '' */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +=C2=A0=C2=A0=C2=A0 0xf8, 0x00, /* #####----- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 222 0xde '' */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0xc0, /* -----##### */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 223 0xdf '' */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0xff, 0xc0, /* ########## */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 224 0xe0 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7d, 0x80, /* -#####-##- */
>> +=C2=A0=C2=A0=C2=A0 0xc7, 0x00, /* ##---###-- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc6, 0x00, /* ##---##--- */
>> +=C2=A0=C2=A0=C2=A0 0xc7, 0x00, /* ##---###-- */
>> +=C2=A0=C2=A0=C2=A0 0x7d, 0x80, /* -#####-##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 225 0xe1 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3e, 0x00, /* --#####--- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x62, 0x00, /* -##---#--- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x00, /* -#######-- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 226 0xe2 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 227 0xe3 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 228 0xe4 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 229 0xe5 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1f, 0xc0, /* ---####### */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 230 0xe6 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x80, /* -##---###- */
>> +=C2=A0=C2=A0=C2=A0 0x7d, 0x80, /* -#####-##- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 231 0xe7 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x00, /* -----###-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 232 0xe8 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 233 0xe9 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 234 0xea '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x73, 0x80, /* -###--###- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 235 0xeb '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 236 0xec '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 237 0xed '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x01, 0x80, /* -------##- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x80, /* -##--####- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x79, 0x80, /* -####--##- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 238 0xee '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1f, 0x80, /* ---######- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x60, 0x00, /* -##------- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x1f, 0x80, /* ---######- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 239 0xef '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x61, 0x80, /* -##----##- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 240 0xf0 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 241 0xf1 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 242 0xf2 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 243 0xf3 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x30, 0x00, /* --##------ */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 244 0xf4 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x00, /* -----###-- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0d, 0x80, /* ----##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 245 0xf5 '' */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x6c, 0x00, /* -##-##---- */
>> +=C2=A0=C2=A0=C2=A0 0x38, 0x00, /* --###----- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 246 0xf6 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x7f, 0x80, /* -########- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 247 0xf7 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x39, 0x80, /* --###--##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x00, /* -##--###-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x39, 0x80, /* --###--##- */
>> +=C2=A0=C2=A0=C2=A0 0x6d, 0x80, /* -##-##-##- */
>> +=C2=A0=C2=A0=C2=A0 0x67, 0x00, /* -##--###-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 248 0xf8 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 249 0xf9 '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x1c, 0x00, /* ---###---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 250 0xfa '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 251 0xfb '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x80, /* ------###- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x80, /* ------###- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x03, 0x00, /* ------##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x63, 0x00, /* -##---##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x1b, 0x00, /* ---##-##-- */
>> +=C2=A0=C2=A0=C2=A0 0x0f, 0x00, /* ----####-- */
>> +=C2=A0=C2=A0=C2=A0 0x07, 0x00, /* -----###-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 252 0xfc '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3e, 0x00, /* --#####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 253 0xfd '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x1e, 0x00, /* ---####--- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x33, 0x00, /* --##--##-- */
>> +=C2=A0=C2=A0=C2=A0 0x06, 0x00, /* -----##--- */
>> +=C2=A0=C2=A0=C2=A0 0x0c, 0x00, /* ----##---- */
>> +=C2=A0=C2=A0=C2=A0 0x18, 0x00, /* ---##----- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 254 0xfe '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x3f, 0x00, /* --######-- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* 255 0xff '' */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +=C2=A0=C2=A0=C2=A0 0x00, 0x00, /* ---------- */
>> +} };
>> +
>> +
>> +const struct font_desc font_ter_10x18 =3D {
>> +=C2=A0=C2=A0=C2=A0 .idx=C2=A0=C2=A0=C2=A0 =3D TER10x18_IDX,
>> +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =3D "TER10x18",
>> +=C2=A0=C2=A0=C2=A0 .width=C2=A0=C2=A0=C2=A0 =3D 10,
>> +=C2=A0=C2=A0=C2=A0 .height =3D 18,
>> +=C2=A0=C2=A0=C2=A0 .charcount =3D 256,
>> +=C2=A0=C2=A0=C2=A0 .data=C2=A0=C2=A0=C2=A0 =3D fontdata_ter10x18.data,
>> +#ifdef __sparc__
>> +=C2=A0=C2=A0=C2=A0 .pref=C2=A0=C2=A0=C2=A0 =3D 5,
>> +#else
>> +=C2=A0=C2=A0=C2=A0 .pref=C2=A0=C2=A0=C2=A0 =3D -1,
>> +#endif
>> +};
>> diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
>> index 47e34950b665..a7f118b30171 100644
>> --- a/lib/fonts/fonts.c
>> +++ b/lib/fonts/fonts.c
>> @@ -54,6 +54,9 @@ static const struct font_desc *fonts[] =3D {
>> =C2=A0 #ifdef CONFIG_FONT_6x10
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &font_6x10,
>> =C2=A0 #endif
>> +#ifdef CONFIG_FONT_TER10x18
>> +=C2=A0=C2=A0=C2=A0 &font_ter_10x18,
>> +#endif
>> =C2=A0 #ifdef CONFIG_FONT_TER16x32
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &font_ter_16x32,
>> =C2=A0 #endif
>=20

