From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Sat, 03 Jul 2010 01:44:37 +0000
Subject: Re: [PATCH 2/2] S5PV210: Add MIPI-DSI Driver.
Message-Id: <AANLkTinQ2jC1w6B9q-pirShQ9GJODDwmS6e80KWYRpMm@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4C29AF72.6090200@samsung.com> <4C29C766.7010901@samsung.com>
	<4C2DA889.5010809@samsung.com>
In-Reply-To: <4C2DA889.5010809@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi InKi,

2010/7/2 InKi Dae <inki.dae@samsung.com>:
> this patch addes MIPI-DSI Driver.
>
> to use this driver, some structures below should be added to machine
> specific file.

A quick question. I'm having difficulty understanding the larger
picture here. There's the MIPI-DSI host controller driver (which I
think is what this patch is) which is specific to this platform. Then
there's the MIPI-DSI LCD panels which are supposed to be fully
platform independent, right? and would thus ideally have a platform
independent MIPI-DSI client driver?

Would I be correct in saying this patch below does not provide such an
abstraction and so structures that would be necessary for such a
display driver (eg: struct mipi_lcd_driver ) appear to be declared in
the samsung platform specific files. In other words, if we wanted to
support a particular MIPI-DSI LCD panel, it would require a client
driver that is tied intimately to this platform?

Could you point us to an example mipi-dsi client driver that is using
the patch you provided? ie: something that is calling
s5p_dsim_register_lcd_driver. That would help us understand the
abstraction that is being made here.

Thanks,
jaya
