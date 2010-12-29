From: Kyungmin Park <kyungmin.park@samsung.com>
Date: Wed, 29 Dec 2010 01:45:44 +0000
Subject: Re: [PATCH 1/5] S5PC110: add MIPI-DSI system register definitions.
Message-Id: <AANLkTi=o=7heymK2Aj4GfiTNvAW8nmq+=SeqqF5PcRM=@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293535562-24715-1-git-send-email-inki.dae@samsung.com>
	<003301cba6f4$3f6b2a90$be417fb0$%kim@samsung.com>
In-Reply-To: <003301cba6f4$3f6b2a90$be417fb0$%kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 29, 2010 at 10:03 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Inki Dae wrote:
>>
> One more comment.
>
> Please work on S5P SoCs based on maintainer's latest for-next.
> You can find the reason in below.
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
> Already added by Sylwester's patch.
>
>> =A0#define S5P_INFORM0 =A0 =A0 =A0 =A0 =A0S5P_CLKREG(0xF000)
>> =A0#define S5P_INFORM1 =A0 =A0 =A0 =A0 =A0S5P_CLKREG(0xF004)
>> @@ -196,7 +197,10 @@
>> =A0#define S5P_OTHERS_USB_SIG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
>>
>> =A0/* MIPI */
>> -#define S5P_MIPI_DPHY_EN =A0 =A0 =A0 =A0 =A0 =A0 (3)
>
> Oops, already removed because not used anywhere at that time.
>
>> +#define S5P_MIPI_DPHY_EN =A0 =A0 =A0 =A0 =A0 =A0 (3 << 0)
>> +
>> +/* S5P_MIPI_PHY_CON0 */
>> +#define S5P_MIPI_M_RESETN =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
>>
>> =A0/* S5P_DAC_CONTROL */
>> =A0#define S5P_DAC_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1)
>> --
>
> Please re-work your all patches.

Before re-work, give technical comments instead of patch submit.
You mean others are looks good except these one?

Thank you,
Kyungmin Park
