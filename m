From: Heiko Stuebner <heiko@sntech.de>
Date: Tue, 21 Aug 2018 12:48:19 +0000
Subject: Re: [PATCH v3] backlight: pwm_bl: switch to using "atomic" PWM API
Message-Id: <1691066.Iypvixkm4y@phil>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180814165059.13219-1-enric.balletbo@collabora.com>
In-Reply-To: <20180814165059.13219-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel@collabora.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>, cl@rock-chips.com

Am Dienstag, 14. August 2018, 18:50:59 CEST schrieb Enric Balletbo i Serra:
> The "atomic" API allows us to configure PWM period and duty_cycle and
> enable it in one call.
> 
> The patch also moves the pwm_init_state just before any use of the
> pwm_state struct, this fixes a potential bug where pwm_get_state
> can be called before pwm_init_state.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

On a Rockchip rk3399-scarlet tablet
Tested-by: Heiko Stuebner <heiko@sntech.de>

This patch also _fixes_ the kernel bug below.

Scarlet is not yet submitted upstream, but when I remove
the brightness-levels and default-brightness-level properties
in my wip devicetree files to rely on the newly introduced
automatic level calculation, I end up with the following:

[  136.723586] Internal error: ptrace BRK handler: f20003e8 [#1] PREEMPT SMP
[  136.735920] Modules linked in: drm_panel_orientation_quirks pwm_bl(+) ip_tables x_tables ipv6 smsc95xx smsc75xx ax88179_178a asix usbnet phy_rockchip_pcie i2c_hid
[  136.752227] CPU: 5 PID: 1547 Comm: systemd-udevd Tainted: G        W         4.18.0-12611-g04bcfe5fee2d-dirty #1033
[  136.763916] Hardware name: Google Scarlet (DT)
[  136.763923] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  136.763943] pc : pwm_backlight_probe+0x610/0x850 [pwm_bl]
[  136.763958] lr : pwm_backlight_probe+0x108/0x850 [pwm_bl]
[  136.786349] sp : ffff00000a33b930
[  136.794421] x29: ffff00000a33b930 x28: ffff00000a33bdf0 
[  136.800373] x27: 0000000000000100 x26: ffff000000ada110 
[  136.806327] x25: 0000000000000000 x24: ffff000000ad9348 
[  136.806343] x23: ffff8000f1a3e400 x22: ffff000008e29000 
[  136.818239] x21: ffff8000f1a3e410 x20: ffff8000f097a798 
[  136.824189] x19: ffff00000a33b9a0 x18: 0000000000000000 
[  136.830137] x17: 0000000000000000 x16: 0000000000000000 
[  136.836156] x15: 0000000000000400 x14: 0000000000000400 
[  136.842104] x13: 0000000000000000 x12: 0000000000000001 
[  136.848052] x11: 0000000000000003 x10: 0101010101010101 
[  136.855639] x9 : fffffffffffffffd x8 : 7f7f7f7f7f7f7f7f 
[  136.861588] x7 : 0000000000000000 x6 : 0000000000000005 
[  136.867727] x5 : ffff8000f150c900 x4 : ffff8000f1a3e610 
[  136.876571] x3 : ffff8000f097a880 x2 : 0000000000000000 
[  136.882519] x1 : ffff800016393500 x0 : 0000000000000000 
[  136.888481] Process systemd-udevd (pid: 1547, stack limit = 0x0000000095c9ae43)
[  136.888484] Call trace:
[  136.888498]  pwm_backlight_probe+0x610/0x850 [pwm_bl]
[  136.888523]  platform_drv_probe+0x50/0xa0
[  136.909550]  really_probe+0x1c8/0x2a0
[  136.914515]  driver_probe_device+0x58/0x108
[  136.919196]  __driver_attach+0xdc/0xe0
[  136.930103]  driver_attach+0x20/0x28
[  136.934286]  bus_add_driver+0x1b8/0x228
[  136.938580]  driver_register+0x60/0x110
[  136.942890]  __platform_driver_register+0x40/0x48
[  136.948172]  pwm_backlight_driver_init+0x1c/0x1000 [pwm_bl]
[  136.948187]  do_one_initcall+0x5c/0x180
[  136.958709]  do_init_module+0x58/0x1b0
[  136.962905]  load_module+0x1bfc/0x2200
[  136.967104]  __se_sys_finit_module+0xc0/0xd8
[  136.971967]  __arm64_sys_finit_module+0x14/0x20
[  136.977038]  el0_svc_common+0x60/0xe8
[  136.981136]  el0_svc_handler+0x24/0x88
[  136.985333]  el0_svc+0x8/0xc
[  136.988558] Code: 95eb49f6 17ffff25 9101c3b3 17fffe8d (d4207d00) 
[  136.995379] ---[ end trace 0f7902d334b84f12 ]---
