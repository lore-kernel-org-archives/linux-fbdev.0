Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1896DC4332F
	for <linux-fbdev@archiver.kernel.org>; Mon,  6 Nov 2023 13:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjKFNsy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 6 Nov 2023 08:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjKFNsx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 6 Nov 2023 08:48:53 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD72BBF
        for <linux-fbdev@vger.kernel.org>; Mon,  6 Nov 2023 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699278528; x=1699883328; i=deller@gmx.de;
        bh=PA1YJ+qVRx9pUSfF3oggHQ458Ts7xa2r6hIMyr3h/sw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=SNdbs8vcX5i3oaCdixx/ga03A0m9LHxihZpemtMVByAgO2gtIHJGC3OrwAaRfCQV
         +BgDooz5pSX+URwuFiODJ+h+qEFc/XJN+yThjeZnXoVFxarxCd5f3Dnq2/aP5BO+l
         NE/2f92GwYbih6ijhj2u4ygbh2woTsE9i5wIAGDvqaD4VIGhUkQ7oKaQm+RPYQadH
         L7h5T7nttMg9oBFWdE3RjtmGNwRlOL/VtQxMsxxFOvbsc2sBg72gxldeLrqcIUNB8
         xJU/WAi7FnFT7Yi7mPeanSuFW9IpD2i6zU551UYODMvK37yVDJg+1ADfxAvkmQQkx
         UTYOf8zkXJ3FzzgW6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.209]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv2xU-1rHOGO2ANM-00r2CJ; Mon, 06
 Nov 2023 14:48:48 +0100
Message-ID: <462101f7-2c11-4fad-8875-615041f9a8ce@gmx.de>
Date:   Mon, 6 Nov 2023 14:48:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PSA: migrating linux-fbdev to new vger infrastructure
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org
References: <20231106-nippy-woodlouse-of-luxury-a46ed7@nitro>
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
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
In-Reply-To: <20231106-nippy-woodlouse-of-luxury-a46ed7@nitro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h6d1QKVYF+nT3zzxpjprsiILVuttKMV5/uOx3Wu6l5glWmuxbk2
 IIy1As/eiPxd3fhWize3THgYvAb5cuiMKVpNhGLUuNHVl1SeYNPWPokXSf+/pVLV1IE8/MH
 MdAOv2ktggdzjzTOid60rg3TIfa7oTd0p0LV9z2OPCWi8vdh3DwbBi8j69Cs0+KcTQ6DnoY
 4XXCBZ/7ng/A5Ds0IeawA==
UI-OutboundReport: notjunk:1;M01:P0:mt99Ca3zZmI=;DM/pz40tp5lVRbsfj3juSyW2LdI
 DyVwblUR2aeVqYrQcwVtiUqSdU51NH+YgBZTOTbHfT+gZzc3uxpC2WutxuJL3xXixR5W/7seo
 ttFyPDClPnficXtUdF3LtelRpTaSvITuepgoqhkK0oXmfsnCIYYI7RAlncdpR8GYfUVx8fNHf
 1i5pMjIizMfjK1eucIgI5n4sDxlFiZ+6Y+r8shfKz2L1KTCNksJatculcuvGgEKOhTFw7Z6W4
 SmihISnmQyJXxCvsmgO3szxIOMYcBQv8c1IY5AUq7FtXtYsqeLXwfsY88n5Dc45DIP4J2RxY3
 2BcxR92CnyESxLJ8dFq+Z4DWTNO+Ejksp4haCLXChYb82FTB5oJsteXXbSgaIVxH9qseq7CcW
 BPc7WCljd/R1G/HRydT14kO6/NEBZWa9KmHZUPSvRPz6NM+j5/pvmWbQP45NXAQ4InQrydaJg
 k7Vu/F1XrJBGHDmf7FdQotmtpiLQ8+EabiF9PF+XLM7rQuDRxBMq8Swjxe23+ebwGr8TFrFar
 p0fy3Uo4mZ7BWKwDRR0O54vSHEyEBhorzPMkDyk5hCd8e/mJhflCIIBszpXVrpHKbHzKaMbCQ
 xIGrq8zn8sw8cljey5NeTfvJsQrNKmvHY3nbucxlXJZj8f2JjL/cAlmbCJ6NCWv09HS2Qpuin
 M+J5dLBpYe6eFwUUj7F/335573w6Q1py+rBQYhPOreeNya7T5JXcDinknyNkdeBLTuxkqgefQ
 z04jR8M0DqBsrkoq9F1sxxLbQumODilJrXjUX4qJei/of6FFGSDg3mfimht4qfJnPljQVHIkd
 7tv2YNrY1IJZrozZZO62ghihuzr+hyCUwfTTkjK6KPCbbR74VhSwR9TS2E8hf2YOYBf+4QdDq
 eV/YKan87i5iadbDlduqpCLzC+Ftx2UExFW6eFggqyZ5uEC8h3U/Sm8L0mcdn3zbSfHMPzf0S
 JKRfd/1ugU4LJyjo3MQG0Hzp4wU=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 11/6/23 14:12, Konstantin Ryabitsev wrote:
> I plan to migrate the linux-fbdev@vger.kernel.org list to the new
> infrastructure this week. We're still doing it list-by-list to make sure=
 that
> we don't run into scaling issues with the new infra.
>
> The migration will be performed live and should not require any downtime=
.
> There will be no changes to how anyone interacts with the list after
> migration is completed, so no action is required on anyone's part.
>
> Please let me know if you have any concerns.

Thanks for the heads-up, and no concerns from my side.

Helge

