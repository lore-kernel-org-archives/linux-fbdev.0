From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 13 Dec 2010 11:23:45 +0000
Subject: Re: [PATCH 3/9] Add a mfd IPUv3 driver
Message-Id: <20101213112345.GD6017@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-4-git-send-email-s.hauer@pengutronix.de>
	<AANLkTine90yN=e-J_zr03GmGCXekEWTPKv0pB5-EhA1v@mail.gmail.com>
In-Reply-To: <AANLkTine90yN=e-J_zr03GmGCXekEWTPKv0pB5-EhA1v@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Liu Ying,

Thanks for looking at the patches.

On Sun, Dec 12, 2010 at 01:21:57PM +0800, Liu Ying wrote:
> Hello, Sascha,
> 
> IPU is not embedded in i,MX50 SoC, but in i.MX51/53 SoCs, please
> modify the commit message.
> 
> I have the following comments for the files editted respectively:
> 1) ipu-common.c
>     - ipu_idmac_get()/ipu_idmac_put() need a mechanism to protect IPU
> IDMAC resources, namely, get rid of potential race condition issue. As
> only framebuffer support is added in your patches, there should be no
> race condition issue now. After IC channels are supported(maybe as DMA
> engine), perhaps, there will be such kind of issue.

ok.

>     - ipu_idmac_select_buffer() need to add spinlock to protect
> IPU_CHA_BUFx_RDY registers.

ok.

>     - It looks that ipu_uninit_channel() only clears
> IPU_CHA_DB_MODE_SEL register, so why not put it in
> ipu_idmac_disable_channel()?

ok.

>     - It looks that ipu_add_client_devices() and your framebuffer
> patch assume /dev/fb0 uses DP_BG, /dev/fb1 uses DP_FG and /dev/fb2
> uses DC.
>       But fb1_platform_data->ipu_channel_bg is
> MX51_IPU_CHANNEL_MEM_DC_SYNC, this may make confusion for driver
> readers and it is not easy for code maintenance.

Do you have a better suggestion? fb2 becomes fb1 when overlay support
is not used.

>     - It also looks that ipu_add_client_devices() and your framebuffer
> driver assume DP_BG/DP_FG are bound with DI0 and DC is bound with DI1.
>       It is ok for babbage board to support this kind of
> configuration, but it may bring some limitation. For example, TVE(TV
> encoder) module embedded in MX51 SoC can only connected with DI1 and
> users may like to use TV as the primary device(support HW overlay),
> and FSL Android BSP does support to use DI1 with LCD as the primary
> device on babbage board.

SO we need to put the display number into the platform data, right?

> 
> 2) ipu-cpmem.c
>     - In order to improve performance, maybe writing
> ipu_ch_param_addr(ch) directly will be fine, but not using memset()
> and memcpy() in ipu_ch_param_init().

I don't see this function in any performance critical path.

> 
> 3) ipu-dc.c
>     - Looks '#include <asm/atomic.h>' and '#include
> <linux/spinlock.h>' are unnecessary.
>     - Need to call 'ipu_module_disable(IPU_CONF_DC_EN);' somewhere.

ok.

> 
> 4) ipu-di.c
>     - Looks '#include <asm/atomic.h>' and '#include <linux/delay.h>'
> are unnecessary.

ok.

> 
> 5) ipu-dmfc.c
>     - Looks '#include <linux/delay.h>' are unnecessary.

ok.

> 
> 6) ipu-dp.c
>     - Looks '#include <asm/atomic.h>' and '#include <linux/delay.h>'
> are unnecessary.

ok.

> 
> 7) ipu-prv.h
>     - Looks '#include <linux/interrupt.h>' is unnecessary.
>     - Please rename 'MX51_IPU_CHANNEL_xxxx' to be 'IPU_CHANNEL_xxxx',
> IPUv3 channel names do not depend on SoC name.

I was proven wrong each time I believed this.

> 
> 8) include/linux/mfd/imx-ipu-v3.h
>    - Looks '#include <linux/slab.h>' and '#include
> <linux/interrupt.h>' are unnecessary.

ok.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
