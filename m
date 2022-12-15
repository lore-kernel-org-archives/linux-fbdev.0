Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECF2C3DA6E
	for <linux-fbdev@archiver.kernel.org>; Thu, 15 Dec 2022 23:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLOXDX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 15 Dec 2022 18:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLOXDS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 15 Dec 2022 18:03:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D876301
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Dec 2022 15:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671145380; bh=olUoF4qY4Rtnhcsk5kjv/jtmE6j5K8YVkxI64K+8G34=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=rpX+vWZWuz+PpKGsNahxkiGlW6vmcmAGoEA3CNmKALLEgG+WnEewYy6MtnO/QhsxO
         Vu7EeLLMf/M8L/8iCC+DFdaEgxJdCXqLSkkk3GrXOy2rgpGkOSg8S8xOvcnJfs3eVb
         B43dorIXIfS5SzZc3/CG5DAIhRoeP7gEO4KeRRkR6EliDoDxBBsXdv9K7U5NDNISlw
         SLOVH5hO8LR4D4q9QZRJP83M8B492X6Ycb5S2E0tADS+sbPXeiU2713yLZxEaymM6C
         LXaNAbIzhQgcndXhb7u0tUj3BNYkSGY7q0VUxk4ebo2avYhfkX9p+pV+RCQMMuXu5F
         z9QYCWp4rZ/6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.161.210]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzf6-1pVpr743Uo-00QzGo; Fri, 16
 Dec 2022 00:03:00 +0100
Message-ID: <6ef71be5-def9-4578-3f73-c43c35d7e4a9@gmx.de>
Date:   Fri, 16 Dec 2022 00:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: matroxfb: cannot determine memory size
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-fbdev@vger.kernel.org
Cc:     "Z. Liu" <liuzx@knownsec.com>, it+linux-fbdev@molgen.mpg.de
References: <5da53ec5-3a9c-ec87-da20-69f140aaaa6b@molgen.mpg.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <5da53ec5-3a9c-ec87-da20-69f140aaaa6b@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T1NhRqp9NS1vxUFHVybV7519Q5tAHuS55MGYPDITeIod1GL2tR4
 wKFGukL0DAqpItK2wxu9/ic2hYB4qEtyIevyf9XIcxtdOGmUc/koXytKCuPtMJdd2z7NbmK
 D6KvMvlpqph9P29UjPJZ0BCgI7a/1KZm+u8ktc0GKiAjIkjYMYxt2nNSLaNaKrlRFP9lk2b
 vWXwZHT65kgfgu6u52vzA==
UI-OutboundReport: notjunk:1;M01:P0:JFIiJ9p0QOM=;HFo4G1EPDRONX5HqRtqlgd4aKaK
 qcwMqrKksdqbR4ub9anPyQ16W1NX64hnqxL4Yp5/KvhBxUDwdnhaD+tdtzZtTIkxEwKJ6KUDM
 7ZeCQMwllbvSNHh+1IKPscqzrVulMAODOkdM37XLgXyWUvleMODOnmIeLGxmynnej8Fn7D4HS
 VAp2Qtsom2b9v4QQIP+PoN3mjd8yDKM2Rq67ZUJcDvaOwz9p585cCphFDlUQIJ+Smupp91joD
 T2dJXLWDvPk3wASeF5oui+r6phDYGGvW1rH3nQIby8nsKJ4k6hTIIrmGCZp11X5rqA4e+3F17
 75bc7f/if1ZTtqEj1Sv8BuY+Q5f10gBm6RhZb5wRWOv4qR9XPu7Jovs4IVW5lSfEAmz7n1fPK
 VfotszElzBNqBAX8Qqa9cd9H9XPgrXCGCLJvkAy0SZW4GFPdpreVLFgW49EQ2v/LuycfRJsvC
 3suVT0IY9bBdhUNZTQTqvVQe5TRn2pY+/6VCHhBKzQ2qgtymXHJ/KTDLiXwe0oDTqVStopqZl
 NnrpcqtF6VXM0HZxzl17QC+VbHwxQnixOFyKlKyvD2r/q5MM+lrJh0K8ldlrIOWVpQ1XJVdx8
 x47gA19DpCJBezgHEDpJqPTOzRmYzyDstGBbLbRYCNuhrPRJ+gUxOaDT5BicS7x+QEnD84Eic
 n6RAZ7219LKfnIfEoyeHBaUkcBeRhRUGbSkleoncXQ5hpTb0f9mfn/FnuCaMtnd24ghffCNH8
 sM3RsrybteIVveTTN2MkylCuQdG4/N0SCSSWxInk1rK/98qIXSqywzAJJdcvTSxB7bRiUCsu/
 qlrZvhnI5VCrVGJyjlzd7UVz88lWMBtHATupnS/5Vs4MOYebNsFAzIKi0E/ICMtckUa90JGyr
 DcvYHsSJ8rVJ8cevkh9Hwbc7wD0K7bdGRsPEiQkdZedXrMTdNYtRDHR9sxZIzbR1Tj7Juyq92
 I7quUWpUYIRcAAz3cjPulnuR2J0=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/15/22 17:39, Paul Menzel wrote:
> Dear Linux folks,
>
>
> Between Linux 5.10.103 and 5.10.110/5.15.77, matrixfb fails to load.
>
> ## Working:
>
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 5.10.103=
.mx64.429 (root@theinternet.molgen.mpg.de) (gcc (GCC) 7.5.0, GNU ld (GNU B=
inutils) 2.37) #1 SMP Mon Mar 7 16:41:58 CET 2022
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.000000] Command line: BOOT_IMA=
GE=3D/boot/bzImage-5.10.103.mx64.429 root=3DLABEL=3Droot ro crashkernel=3D=
64G-:256M console=3DttyS0,115200n8 console=3Dtty0 init=3D/bin/systemd audi=
t=3D0 random.trust_cpu=3Don systemd.unified_cgroup_hierarchy
>  =C2=A0=C2=A0=C2=A0 [=E2=80=A6]
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.000000] DMI: Dell Inc. PowerEd=
ge R910/0KYD3D, BIOS 2.10.0 08/29/2013
>  =C2=A0=C2=A0=C2=A0 [=E2=80=A6]
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 48.045530] matroxfb: Matrox MGA-G200eW=
 (PCI) detected
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 48.054675] matroxfb: 640x480x8bpp (vir=
tual: 640x13107)
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 48.059966] matroxfb: framebuffer at 0x=
C5000000, mapped to 0x00000000ca7238fa, size 8388608
>
> ## Non-working:
>
> ### 5.10.110
>
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 5.10.110=
.mx64.433 (root@theinternet.molgen.mpg.de) (gcc (GCC) 7.5.0, GNU ld (GNU B=
inutils) 2.37) #1 SMP Thu Apr 14 15:28:53 CEST 2022
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.000000] Command line: root=3DL=
ABEL=3Droot ro crashkernel=3D64G-:256M console=3DttyS0,115200n8 console=3D=
tty0 init=3D/bin/systemd audit=3D0 random.trust_cpu=3Don systemd.unified_c=
group_hierarchy
>  =C2=A0=C2=A0=C2=A0 [=E2=80=A6]
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.000000] DMI: Dell Inc. PowerEd=
ge R910/0KYD3D, BIOS 2.10.0 08/29/2013
>  =C2=A0=C2=A0=C2=A0 [=E2=80=A6]
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 35.225987] matroxfb: Matrox MGA-G200eW=
 (PCI) detected
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 35.234088] matroxfb: cannot determine =
memory size
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 35.238931] matroxfb: probe of 0000:09:=
03.0 failed with error -1
>
> ### 5.15.77
>
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 5.15.77.=
mx64.440 (root@theinternet.molgen.mpg.de) (gcc (GCC) 10.4.0, GNU ld (GNU B=
inutils) 2.37) #1 SMP Tue Nov 8 15:42:33 CET 2022
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.000000] Command line: root=3DL=
ABEL=3Droot ro crashkernel=3D64G-:256M console=3DttyS0,115200n8 console=3D=
tty0 init=3D/bin/systemd audit=3D0 random.trust_cpu=3Don systemd.unified_c=
group_hierarchy
>
>  =C2=A0=C2=A0=C2=A0 [=E2=80=A6]
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.000000] DMI: Dell Inc. PowerEd=
ge R715/0G2DP3, BIOS 1.5.2 04/19/2011
>  =C2=A0=C2=A0=C2=A0 [=E2=80=A6]
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 9.436420] matroxfb: Matrox MGA-G=
200eW (PCI) detected
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 9.444502] matroxfb: cannot deter=
mine memory size
>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 9.449316] matroxfb: probe of 000=
0:0a:03.0 failed with error -1
>
> We see it on several systems:
>
>  =C2=A0=C2=A0=C2=A0 $ lspci -nn -s 0a:03.0 # Dell PowerEdge R715
>  =C2=A0=C2=A0=C2=A0 0a:03.0 VGA compatible controller [0300]: Matrox Ele=
ctronics Systems Ltd. MGA G200eW WPCM450 [102b:0532] (rev 0a)
>
>  =C2=A0=C2=A0=C2=A0 $ lspci -nn -s 09:03.0 # Dell PowerEdge R910
>  =C2=A0=C2=A0=C2=A0 09:03.0 VGA compatible controller [0300]: Matrox Ele=
ctronics Systems Ltd. MGA G200eW WPCM450 [102b:0532] (rev 0a)
>
> I found some old log from April 2022, where I booted 5.10.109, and the e=
rror is not there, pointing toward the regression to be introduced between=
 5.10.109 and 5.10.110.
>
> ```
> $ git log --oneline v5.10.109..v5.10.110 --grep fbdev
> b1c28577529c video: fbdev: sm712fb: Fix crash in smtcfb_write()
> 681a317034b2 video: fbdev: udlfb: replace snprintf in show functions wit=
h sysfs_emit
> a7c624abf694 video: fbdev: omapfb: panel-tpo-td043mtea1: Use sysfs_emit(=
) instead of snprintf()
> 543dae0a46b0 video: fbdev: omapfb: panel-dsi-cm: Use sysfs_emit() instea=
d of snprintf()
> da210b1b551c video: fbdev: omapfb: acx565akm: replace snprintf with sysf=
s_emit
> 8c7e2141fb89 video: fbdev: cirrusfb: check pixclock to avoid divide by z=
ero
> 1e33f197468f video: fbdev: w100fb: Reset global state
> 08dff4820127 video: fbdev: nvidiafb: Use strscpy() to prevent buffer ove=
rflow
> 066d9b48f949 video: fbdev: omapfb: Add missing of_node_put() in dvic_pro=
be_of
> bf4bad1114a3 video: fbdev: fbcvt.c: fix printing in fb_cvt_print_name()
> 6de6a64f23a6 video: fbdev: atmel_lcdfb: fix an error code in atmel_lcdfb=
_probe()
> 64ec3e678d76 video: fbdev: smscufx: Fix null-ptr-deref in ufx_usb_probe(=
)
> 0dff86aeb191 video: fbdev: controlfb: Fix COMPILE_TEST build
> ec1c20b02ae0 video: fbdev: controlfb: Fix set but not used warnings
> f8bf19f7f311 video: fbdev: matroxfb: set maxvram of vbG200eW to the same=
 as vbG200 to avoid black screen
> 2ca2a5552a83 video: fbdev: atari: Atari 2 bpp (STe) palette bugfix
> 72af8810922e video: fbdev: sm712fb: Fix crash in smtcfb_read()
> ```
>
> Is it worthwhile to test commit f8bf19f7f311 (video: fbdev: matroxfb: se=
t maxvram of vbG200eW to the same as vbG200 to avoid black screen)?

Yes, it is.
Please try and report back.
It seems to be the only relevant patch, and it fits with the name of your =
card.

Helge


>
> The master commit 62d89a7d49a was added to v5.18-rc1, and was also backp=
orted to the Linux 5.15 series in 5.15.33.
>
>
> Kind regards,
>
> Paul

