From: Liu Ying <liu.y.victor@gmail.com>
Date: Tue, 14 Dec 2010 06:47:08 +0000
Subject: Re: [PATCH 9/9] ARM i.MX51 babbage: Add framebuffer support
Message-Id: <AANLkTimPpo5nJ2Bg_wZohgTuB1ypfqGJxvQSu5_2fKz2@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-10-git-send-email-s.hauer@pengutronix.de>
	<AANLkTi=vT8pX1QQ6DjzQatceO-tQb3Zu90CRAVi2DcpZ@mail.gmail.com>
	<20101213114332.GF6017@pengutronix.de>
In-Reply-To: <20101213114332.GF6017@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

2010/12/13 Sascha Hauer <s.hauer@pengutronix.de>:
> On Sun, Dec 12, 2010 at 09:37:38AM +0800, Liu Ying wrote:
>> Hello, Sascha,
>>
>> I have following 3 comments to this patch:
>> 1) I think DISP1_DATx pins need not be set specially, as they keep the
>> default register values.
>
> We do not want to depend on default register values in the Linux Kernel.
[LY] Ok. Please add disp1 related pins configuration, including
DISP1_HSYNC, DISP1_VSYNC and DISP1_CLK.
       It will be fine to add disp2 related pins configuration also.
>
>> 2) Please define 'MX51_PAD_DI_GP4__IPU_DI2_PIN15' in
>> arch/arm/plat-mxc/include/mach/iomux-mx51.h, and rename the pin to be
>> 'MX51_PAD_DI_GP4__DI2_PIN15', as we name it according to the MX51
>> iomux reference manual.
>
> I'm not sure. Normally it's good practice to code the unit into the
> name. Otherwise we end up with names like MX51_PAD_xyz__TX which could
> be the tx pin of just about any unit.
>
>
>> 3) It is better to exchange the following two lines or just remove the
>> first line:
>> + =A0 =A0 =A0 gpio_set_value(GPIO_DVI_RESET, 0);
>> + =A0 =A0 =A0 gpio_direction_output(GPIO_DVI_RESET, 0);
>
> ok.
>
> Sascha
>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 =A0=
 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5121-=
206917-5555 |
>
