From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 19 May 2014 13:50:52 +0000
Subject: Re: [PATCH] backlight: gpio-backlight: Fix warning when the GPIO is on a I2C chip
Message-Id: <20140519135052.GK4978@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140509012454.GL2198@atomide.com>
In-Reply-To: <20140509012454.GL2198@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

> If the GPIO for the backlight is on an I2C chip, we currently
> get nasty warnings like this during the boot:
>=20
> WARNING: CPU: 0 PID: 6 at drivers/gpio/gpiolib.c:2364 gpiod_set_raw_value=
+0x40/0x4c()
> Modules linked in:
> CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 3.15.0-rc4-12393-gcde9f4e #4=
00
> Workqueue: deferwq deferred_probe_work_func
> [<c0014cbc>] (unwind_backtrace) from [<c001191c>] (show_stack+0x10/0x14)
> [<c001191c>] (show_stack) from [<c0566ae0>] (dump_stack+0x80/0x9c)
> [<c0566ae0>] (dump_stack) from [<c003f61c>] (warn_slowpath_common+0x68/0x=
8c)
> [<c003f61c>] (warn_slowpath_common) from [<c003f65c>] (warn_slowpath_null=
+0x1c/0x24)
> [<c003f65c>] (warn_slowpath_null) from [<c02f7e10>] (gpiod_set_raw_value+=
0x40/0x4c)
> [<c02f7e10>] (gpiod_set_raw_value) from [<c0308fbc>] (gpio_backlight_upda=
te_status+0x4c/0x74)
> [<c0308fbc>] (gpio_backlight_update_status) from [<c030914c>] (gpio_backl=
ight_probe+0x168/0x254)
> [<c030914c>] (gpio_backlight_probe) from [<c0378fa8>] (platform_drv_probe=
+0x18/0x48)
> [<c0378fa8>] (platform_drv_probe) from [<c0377c40>] (driver_probe_device+=
0x10c/0x238)
> [<c0377c40>] (driver_probe_device) from [<c0376330>] (bus_for_each_drv+0x=
44/0x8c)
> [<c0376330>] (bus_for_each_drv) from [<c0377afc>] (device_attach+0x74/0x8=
c)
> [<c0377afc>] (device_attach) from [<c03771c4>] (bus_probe_device+0x88/0xb=
0)
> [<c03771c4>] (bus_probe_device) from [<c03775c8>] (deferred_probe_work_fu=
nc+0x64/0x94)
> [<c03775c8>] (deferred_probe_work_func) from [<c00572e8>] (process_one_wo=
rk+0x1b4/0x4bc)
> [<c00572e8>] (process_one_work) from [<c00579d0>] (worker_thread+0x11c/0x=
398)
> [<c00579d0>] (worker_thread) from [<c005dfd8>] (kthread+0xc8/0xe4)
> [<c005dfd8>] (kthread) from [<c000e768>] (ret_from_fork+0x14/0x2c)
>=20
> Fix this by using gpio_set_value_cansleep() as suggested in
> drivers/gpio/gpiolib.c:2364. This is what the other backlight drivers
> are also doing.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
