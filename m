From: Sylwester Nawrocki <spnlinux@gmail.com>
Date: Mon, 03 Jan 2011 22:00:29 +0000
Subject: Re: [PATCH 3/5] S5PC110: add machine specific MIPI-DSI setup code.
Message-Id: <4D2246FD.1000607@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293535583-24789-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1293535583-24789-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On 01/03/2011 02:48 AM, daeinki wrote:
> Kukjin Kim 쓴 글:
>> InKi Dae wrote:
>>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>>> ---
>>> arch/arm/mach-s5pv210/Kconfig | 6 +++
>>> arch/arm/mach-s5pv210/Makefile | 1 +
>>> arch/arm/mach-s5pv210/setup-mipi.c | 76
>>> ++++++++++++++++++++++++++++++++++++
>>> 3 files changed, 83 insertions(+), 0 deletions(-)
>>> create mode 100644 arch/arm/mach-s5pv210/setup-mipi.c
>>>
>>> diff --git a/arch/arm/mach-s5pv210/Kconfig
>>> b/arch/arm/mach-s5pv210/Kconfig
>>> index 862f239..76da541 100644
>>> --- a/arch/arm/mach-s5pv210/Kconfig
>>> +++ b/arch/arm/mach-s5pv210/Kconfig
>>> @@ -53,6 +53,11 @@ config S5PV210_SETUP_SDHCI_GPIO
>>> help
>>> Common setup code for SDHCI gpio.
>>>
>>> +config S5P_SETUP_MIPI_DSI
>>
>> If this is for S5PV210, please use S5PV210_xxx as prefix. Or this is
>> for S5P
>> SoCS, move into plat-s5p.
>>
>> And as I know, this is _not_ only for MIPI DSI master...so need to
>> re-name.
>>
> Ok, moved to plat-s5p.
>
>>> + bool
>>> + help
>>> + Common setup code for MIPI-DSI
>>> +
>>> menu "S5PC110 Machines"
>>>
>>> config MACH_AQUILA
>>> @@ -92,6 +97,7 @@ config MACH_GONI
>>> select S5PV210_SETUP_I2C2
>>> select S5PV210_SETUP_KEYPAD
>>> select S5PV210_SETUP_SDHCI
>>> + select S5P_SETUP_MIPI_DSI
>>
>> Is this really only for machine?
>>
>>> help
>>> Machine support for Samsung GONI board
>>> S5PC110(MCP) is one of package option of S5PV210
>>> diff --git a/arch/arm/mach-s5pv210/Makefile
>> b/arch/arm/mach-s5pv210/Makefile
>>> index ff1a0db..638747c 100644
>>> --- a/arch/arm/mach-s5pv210/Makefile
>>> +++ b/arch/arm/mach-s5pv210/Makefile
>>> @@ -37,3 +37,4 @@ obj-$(CONFIG_S5PV210_SETUP_IDE) +>> setup-ide.o
>>> obj-$(CONFIG_S5PV210_SETUP_KEYPAD) += setup-keypad.o
>>> obj-$(CONFIG_S5PV210_SETUP_SDHCI) += setup-sdhci.o
>>> obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
>>> +obj-$(CONFIG_S5P_SETUP_MIPI_DSI) += setup-mipi.o
>>> \ No newline at end of file
>>> diff --git a/arch/arm/mach-s5pv210/setup-mipi.c b/arch/arm/mach-
>>> s5pv210/setup-mipi.c
>>> new file mode 100644
>>> index 0000000..2cc8cd1
>>> --- /dev/null
>>> +++ b/arch/arm/mach-s5pv210/setup-mipi.c
>>> @@ -0,0 +1,76 @@
>>> +/* linux/arch/arm/plat-s5p/setup-mipi.c
>>> + *
>>> + * Samsung MIPI-DSI DPHY driver.
>>> + *
>>> + * Author: InKi Dae <inki.dae@samsung.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License as
>>> + * published by the Free Software Foundation; either version 2 of
>>> + * the License, or (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program; if not, write to the Free Software
>>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>>> + * MA 02111-1307 USA
>>> + */
>>> +#include <linux/kernel.h>
>>> +#include <linux/string.h>
>>> +#include <linux/io.h>
>>> +#include <linux/err.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/clk.h>
>>> +
>>> +#include <mach/map.h>
>>> +#include <mach/regs-clock.h>
>>> +
>>> +#include <plat/mipi-dsi.h>
>>
>> Hmm...I didn't find this header in your previous patch.
>>
> previous patch??
>
>>> +#include <plat/regs-dsim.h>
>>
>> Same.
>>
>>> +
>>> +static int s5p_mipi_enable_d_phy(struct dsim_device *dsim, unsigned int
>>> enable)
>>
>> Why need struct dsim_device in argument?
>> As I said, this is for MIPI DSI and MIPI CSI...right?
>>
>>> +{
>>> + unsigned int reg;
>>> +
>>> + reg = readl(S5P_MIPI_CONTROL) & ~(1 << 0);
>>
>> Please use __raw_readl here, because no need memory barrier between
>> operations.
>>
>>> + reg |= (enable << 0);
>>> + writel(reg, S5P_MIPI_CONTROL);
>>
>> Same.
>>
>>> +
>>> + return 0;
>>
>> Always, return 0?
>>
>> If enabled by MIPI DSI and MIPI CSI, how each IP can know other IP's MIPI
>> enalbling?
>>
> ok, naming issue sould be considered more.
> hm, how about using "DSIM"? I think S5P_MIPI_DSI or MIPI_DSI is too long.

I think that Kukjin's question is not about naming but about the logic 
behind your interface. If I understand correctly bit 0 in
"S5P_MIPI_CONTROL" register is a common enable bit for both the camera
and display MIPI PHYs. Only the PHY reset bits are separate for both
PHYs. We need to create callbacks for both (DSIM, CSIS) drivers here.
And S5P_MIPI_CONTROL register access must be protected from possible 
races when CSIS and DSIM drivers are trying to use it at the same time.
Actually I did some work towards camera interface support, in regards of 
the PHY control, possibly I can post some RFC patches tomorrow.

I have also tried to exploit the shared I/O region support as described 
here: http://lwn.net/Articles/338837 . However it seems not really 
applicable to our case or would need an extension. And it would add
a relatively large overhead for controlling just a single shared memory 
mapped register..

Regards,
Sylwester
