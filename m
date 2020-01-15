From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 15:31:10 +0000
Subject: Re: [PATCH] video: ssd1307fb: add the missed regulator_disable
Message-Id: <8c4c9d8d-f85f-1d46-4f8d-5423028a72c2@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191118114150.25724-1-hslester96@gmail.com>
 <CGME20191206140944epcas3p298db1ab394da9960226f9d4eeb9878ab@epcas3p2.samsung.com>
 <efd5bc3a-9c3b-2d66-7aa1-c06748294fc3@ysoft.com>
In-Reply-To: <efd5bc3a-9c3b-2d66-7aa1-c06748294fc3@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>, Chuhong Yuan <hslester96@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 12/6/19 3:09 PM, Michal Vokáč wrote:
> On 18. 11. 19 12:41, Chuhong Yuan wrote:
>> The driver forgets to disable the regulator in remove like what is done
>> in probe failure.
>> Add the missed call to fix it.
>>
>> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>> ---
>>   drivers/video/fbdev/ssd1307fb.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
>> index 78ca7ffc40c2..819fbee18dda 100644
>> --- a/drivers/video/fbdev/ssd1307fb.c
>> +++ b/drivers/video/fbdev/ssd1307fb.c
>> @@ -791,6 +791,8 @@ static int ssd1307fb_remove(struct i2c_client *client)
>>           pwm_disable(par->pwm);
>>           pwm_put(par->pwm);
>>       }
> 
> An empty line missing here?
> 
>> +    if (par->vbat_reg)
>> +        regulator_disable(par->vbat_reg);
>>       fb_deferred_io_cleanup(info);
>>       __free_pages(__va(info->fix.smem_start), get_order(info->fix.smem_len));
>>       framebuffer_release(info);
>>
> 
> I have tested this on imx6dl-yapp4-hydra board with SSD1305 and this fixes
> the following problem when unloading the driver:
> 
> root@imx6qdlsabresd:~# rmmod ssd1307fb
> [  191.792674] ------------[ cut here ]------------
> [  191.797453] WARNING: CPU: 0 PID: 858 at /mnt/ssd/users/vokac/development/sources/linux-fslc/drivers/regulator/core.c:2047 _regulator_put.part.6+0x178/0x180
> [  191.811464] Modules linked in: ssd1307fb(-)
> [  191.815688] CPU: 0 PID: 858 Comm: rmmod Not tainted 5.4.0-next-20191128-00005-g121a1da986f1-dirty #14
> [  191.824914] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  191.831445] Backtrace:
> [  191.833909] [<8010d878>] (dump_backtrace) from [<8010db8c>] (show_stack+0x20/0x24)
> [  191.841490]  r7:00000009 r6:60060013 r5:00000000 r4:812d96b0
> [  191.847164] [<8010db6c>] (show_stack) from [<80c1fa24>] (dump_stack+0x9c/0xb0)
> [  191.854395] [<80c1f988>] (dump_stack) from [<80126cec>] (__warn+0xec/0x104)
> [  191.861362]  r7:00000009 r6:80ff25c0 r5:00000000 r4:00000000
> [  191.867029] [<80126c00>] (__warn) from [<80126dbc>] (warn_slowpath_fmt+0xb8/0xc0)
> [  191.874519]  r9:00000009 r8:805a2e00 r7:000007ff r6:80ff25c0 r5:00000000 r4:81206788
> [  191.882274] [<80126d08>] (warn_slowpath_fmt) from [<805a2e00>] (_regulator_put.part.6+0x178/0x180)
> [  191.891239]  r9:ed261200 r8:ed261b00 r7:ed3d9e64 r6:ec413020 r5:81206788 r4:ecaaa400
> [  191.898991] [<805a2c88>] (_regulator_put.part.6) from [<805a2e40>] (regulator_put+0x38/0x48)
> [  191.907435]  r9:ed261200 r8:ed261b00 r7:ed3d9e64 r6:ec413020 r5:81206788 r4:ecaaa400
> [  191.915190] [<805a2e08>] (regulator_put) from [<805a9540>] (devm_regulator_release+0x1c/0x20)
> [  191.923716]  r5:81206788 r4:00000003
> [  191.927303] [<805a9524>] (devm_regulator_release) from [<8065b848>] (release_nodes+0x1c8/0x208)
> [  191.936007] [<8065b680>] (release_nodes) from [<8065b9e0>] (devres_release_all+0x40/0x60)
> [  191.944191]  r10:00000081 r9:ed3d8000 r8:80101204 r7:00000081 r6:7f00307c r5:ec412c80
> [  191.952023]  r4:ec413020
> [  191.954568] [<8065b9a0>] (devres_release_all) from [<80657244>] (device_release_driver_internal+0x108/0x1b0)
> [  191.964397]  r5:ec412c80 r4:ec413020
> [  191.967981] [<8065713c>] (device_release_driver_internal) from [<80657398>] (driver_detach+0x64/0xb0)
> [  191.977205]  r7:00000081 r6:00cfdebc r5:7f00307c r4:ec413020
> [  191.982872] [<80657334>] (driver_detach) from [<80655ce4>] (bus_remove_driver+0x5c/0xb0)
> [  191.990965]  r5:7f003140 r4:7f00307c
> [  191.994549] [<80655c88>] (bus_remove_driver) from [<80657d88>] (driver_unregister+0x38/0x5c)
> [  192.002989]  r5:7f003140 r4:7f00307c
> [  192.006579] [<80657d50>] (driver_unregister) from [<8078290c>] (i2c_del_driver+0x2c/0x30)
> [  192.014759]  r5:7f003140 r4:7f003060
> [  192.018356] [<807828e0>] (i2c_del_driver) from [<7f001754>] (ssd1307fb_driver_exit+0x14/0x8c0 [ssd1307fb])
> [  192.028013]  r5:7f003140 r4:81206788
> [  192.031604] [<7f001740>] (ssd1307fb_driver_exit [ssd1307fb]) from [<801c36b8>] (sys_delete_module+0x138/0x208)
> [  192.041615] [<801c3580>] (sys_delete_module) from [<80101000>] (ret_fast_syscall+0x0/0x54)
> [  192.049882] Exception stack(0xed3d9fa8 to 0xed3d9ff0)
> [  192.054941] 9fa0:                   00000002 7eb4ac28 00cfdebc 00000800 00000064 00000000
> [  192.063125] 9fc0: 00000002 7eb4ac28 00000000 00000081 7eb4af0e 00cfde80 7eb4ae0c 00000001
> [  192.071306] 9fe0: 76f0ec61 7eb4abe4 0001b403 76f0ec68
> [  192.076363]  r6:00000000 r5:7eb4ac28 r4:00000002
> [  192.081033] ---[ end trace af216f02771e12a7 ]---
> 
> 
> With this patch the problem disappears. Thanks.
> 
> Tested-by: Michal Vokáč <michal.vokac@ysoft.com>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
