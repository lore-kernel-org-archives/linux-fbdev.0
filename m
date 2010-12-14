From: Liu Ying <liu.y.victor@gmail.com>
Date: Tue, 14 Dec 2010 13:13:28 +0000
Subject: Re: [PATCH 3/9] Add a mfd IPUv3 driver
Message-Id: <AANLkTi=3v+Fb77aYAarGDBLRZBMSz-GkngV2umN+hKbU@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-4-git-send-email-s.hauer@pengutronix.de>
	<AANLkTine90yN=e-J_zr03GmGCXekEWTPKv0pB5-EhA1v@mail.gmail.com>
	<20101213112345.GD6017@pengutronix.de>
	<AANLkTimuchaGAEuGX24GSnAu5-FVtG_kE_KDozGKo9e-@mail.gmail.com>
	<20101214084024.GS6017@pengutronix.de>
In-Reply-To: <20101214084024.GS6017@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

2010/12/14 Sascha Hauer <s.hauer@pengutronix.de>:
> On Tue, Dec 14, 2010 at 12:05:07PM +0800, Liu Ying wrote:
>> Hello, Sascha,
>>
>> Please find my feedback with [LY] embedded.
>>
>> Best Regards,
>> Liu Ying
>>
>> 2010/12/13 Sascha Hauer <s.hauer@pengutronix.de>:
>> > Hi Liu Ying,
>> >
>> > Thanks for looking at the patches.
>> [LY] You are welcome.
>> >
>> > On Sun, Dec 12, 2010 at 01:21:57PM +0800, Liu Ying wrote:
>> >> Hello, Sascha,
>> >>
>> >> IPU is not embedded in i,MX50 SoC, but in i.MX51/53 SoCs, please
>> >> modify the commit message.
>> >>
>> >> I have the following comments for the files editted respectively:
>> >> 1) ipu-common.c
>> >> =A0 =A0 - ipu_idmac_get()/ipu_idmac_put() need a mechanism to protect=
 IPU
>> >> IDMAC resources, namely, get rid of potential race condition issue. As
>> >> only framebuffer support is added in your patches, there should be no
>> >> race condition issue now. After IC channels are supported(maybe as DMA
>> >> engine), perhaps, there will be such kind of issue.
>> >
>> > ok.
>> >
>> >> =A0 =A0 - ipu_idmac_select_buffer() need to add spinlock to protect
>> >> IPU_CHA_BUFx_RDY registers.
>> >
>> > ok.
>> >
>> >> =A0 =A0 - It looks that ipu_uninit_channel() only clears
>> >> IPU_CHA_DB_MODE_SEL register, so why not put it in
>> >> ipu_idmac_disable_channel()?
>> >
>> > ok.
>> >
>> >> =A0 =A0 - It looks that ipu_add_client_devices() and your framebuffer
>> >> patch assume /dev/fb0 uses DP_BG, /dev/fb1 uses DP_FG and /dev/fb2
>> >> uses DC.
>> >> =A0 =A0 =A0 But fb1_platform_data->ipu_channel_bg is
>> >> MX51_IPU_CHANNEL_MEM_DC_SYNC, this may make confusion for driver
>> >> readers and it is not easy for code maintenance.
>> >
>> > Do you have a better suggestion? fb2 becomes fb1 when overlay support
>> > is not used.
>> [LY] How about assigning DP-BG to /dev/fb0, DC to /dev/fb1 and DP_FG
>> to /dev/fb2?
>> >
>> >> =A0 =A0 - It also looks that ipu_add_client_devices() and your frameb=
uffer
>> >> driver assume DP_BG/DP_FG are bound with DI0 and DC is bound with DI1.
>> >> =A0 =A0 =A0 It is ok for babbage board to support this kind of
>> >> configuration, but it may bring some limitation. For example, TVE(TV
>> >> encoder) module embedded in MX51 SoC can only connected with DI1 and
>> >> users may like to use TV as the primary device(support HW overlay),
>> >> and FSL Android BSP does support to use DI1 with LCD as the primary
>> >> device on babbage board.
>> >
>> > SO we need to put the display number into the platform data, right?
>> [LY] Yes, I think so. As the primary display port could be DI0 or DI1
>> on boards like babbage board(two display ports are used), the primary
>> display number in platform data should be configurable(I'm not sure
>> whether this can be accepted by community), perhaps, configured by
>> kernel bootup command line.
>
> Ok, I'll find a solution for this.
>
>> >
>> >>
>> >> 2) ipu-cpmem.c
>> >> =A0 =A0 - In order to improve performance, maybe writing
>> >> ipu_ch_param_addr(ch) directly will be fine, but not using memset()
>> >> and memcpy() in ipu_ch_param_init().
>> >
>> > I don't see this function in any performance critical path.
>> [LY] Yes, currently, this function is not in performance critical
>> path, so it is ok for me now. However, after IC/IRT channels are
>> involved, the channels' idmac configuration might be changed from time
>> to time and frequently, as the channels could be used as dma engine.
>
> We are talking about 60 frames per second at maximum, right? So the
> channel would be reconfigured 60 times a second, that's still not
> performance critical, at least not if we are talking about a 100 byte or
> something memset.
>
You are right. Take processing VGA(640x480) frames for example, IC
channel's input bandwidth is 100MPixel/sec and output 50MPixel/sec,
the framerate can theoritically reach 162fps, then there will be about
162fps x 2 IDMACs x 2(memset/memcpy) x100Byte =3D 63KByte/sec memory
accessing overhead.
>> >
>> >>
>> >> 3) ipu-dc.c
>> >> =A0 =A0 - Looks '#include <asm/atomic.h>' and '#include
>> >> <linux/spinlock.h>' are unnecessary.
>> >> =A0 =A0 - Need to call 'ipu_module_disable(IPU_CONF_DC_EN);' somewher=
e.
>> >
>> > ok.
>> >
>> >>
>> >> 4) ipu-di.c
>> >> =A0 =A0 - Looks '#include <asm/atomic.h>' and '#include <linux/delay.=
h>'
>> >> are unnecessary.
>> >
>> > ok.
>> >
>> >>
>> >> 5) ipu-dmfc.c
>> >> =A0 =A0 - Looks '#include <linux/delay.h>' are unnecessary.
>> >
>> > ok.
>> >
>> >>
>> >> 6) ipu-dp.c
>> >> =A0 =A0 - Looks '#include <asm/atomic.h>' and '#include <linux/delay.=
h>'
>> >> are unnecessary.
>> >
>> > ok.
>> >
>> >>
>> >> 7) ipu-prv.h
>> >> =A0 =A0 - Looks '#include <linux/interrupt.h>' is unnecessary.
>> >> =A0 =A0 - Please rename 'MX51_IPU_CHANNEL_xxxx' to be 'IPU_CHANNEL_xx=
xx',
>> >> IPUv3 channel names do not depend on SoC name.
>> >
>> > I was proven wrong each time I believed this.
>> [LY] What if IPUv3 will be embedded in more SoCs? Could you please
>> tell the reason? Thanks.
>
> Then channel assignments will change, I'll promise.

i.MX53 SoC doesn't change IPUv3 channel assignments.
>
> Sascha
--=20
Liu Ying
