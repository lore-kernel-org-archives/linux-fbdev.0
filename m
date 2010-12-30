From: InKi Dae <daeinki@gmail.com>
Date: Thu, 30 Dec 2010 01:23:15 +0000
Subject: Re: [PATCH 1/5] S5PC110: add MIPI-DSI system register definitions.
Message-Id: <AANLkTinL3tq7ZGmddBTv2Z=1Sxb+yt6nS7NS1Cu16tVc@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293535562-24715-1-git-send-email-inki.dae@samsung.com>
	<003201cba6f2$6b532a60$41f97f20$%kim@samsung.com>
In-Reply-To: <003201cba6f2$6b532a60$41f97f20$%kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello, Mr. Kukjin.

I am on vacation until this sunday.
Could you please give me your reviews?

If you give me your comments about my patch series then I will re-work
them on Monday.
by doing so, we could save the time.

thank you.

2010/12/29 Kukjin Kim <kgene.kim@samsung.com>:
> Inki Dae wrote:
>>
> Please keep myself in Cc on this. I already noticed that to you before.
> I think you should check whether mail loop is suitable or not...
>
> And would be better if you could add #0 patch to understand your patches.
>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> ---
>> =A0arch/arm/mach-s5pv210/include/mach/regs-clock.h | =A0 =A06 +++++-
>> =A01 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> b/arch/arm/mach-
>> s5pv210/include/mach/regs-clock.h
>> index ebaabe0..09680d9 100644
>> --- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
>> +++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
>> @@ -146,6 +146,7 @@
>> =A0#define S5P_OM_STAT =A0 =A0 =A0 =A0 =A0S5P_CLKREG(0xE100)
>> =A0#define S5P_USB_PHY_CONTROL =A0S5P_CLKREG(0xE80C)
>> =A0#define S5P_DAC_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0S5P_CLKREG(0xE810)
>> +#define S5P_MIPI_DPHY_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0S5P_CLKREG=
(0xE814)
>>
>> =A0#define S5P_INFORM0 =A0 =A0 =A0 =A0 =A0S5P_CLKREG(0xF000)
>> =A0#define S5P_INFORM1 =A0 =A0 =A0 =A0 =A0S5P_CLKREG(0xF004)
>> @@ -196,7 +197,10 @@
>> =A0#define S5P_OTHERS_USB_SIG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
>>
>> =A0/* MIPI */
>> -#define S5P_MIPI_DPHY_EN =A0 =A0 =A0 =A0 =A0 =A0 (3)
>> +#define S5P_MIPI_DPHY_EN =A0 =A0 =A0 =A0 =A0 =A0 (3 << 0)
>> +
>> +/* S5P_MIPI_PHY_CON0 */
>> +#define S5P_MIPI_M_RESETN =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
>>
>> =A0/* S5P_DAC_CONTROL */
>> =A0#define S5P_DAC_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1)
>> --
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
