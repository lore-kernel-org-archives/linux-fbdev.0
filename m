From: Jiri Slaby <jirislaby@kernel.org>
Date: Thu, 30 Jul 2020 13:38:06 +0000
Subject: Re: [PATCH] vgacon: Fix an out-of-bounds in vgacon_scrollback_update()
Message-Id: <9aecd7ac-5060-6b8d-61f8-393431eb243f@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200713105730.550334-1-yangyingliang@huawei.com>
 <220220f1-48f7-46f6-952f-ab41fa57d6a1@kernel.org>
 <c3714d73-d5fe-c77a-e554-bb1ff4fd6980@huawei.com>
In-Reply-To: <c3714d73-d5fe-c77a-e554-bb1ff4fd6980@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Yang Yingliang <yangyingliang@huawei.com>, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>

On 30. 07. 20, 15:24, Yang Yingliang wrote:
>=20
> On 2020/7/30 19:04, Jiri Slaby wrote:
>> On 13. 07. 20, 12:57, Yang Yingliang wrote:
>>> I got a slab-out-of-bounds report when I doing fuzz test.
>>>
>>> [=A0 334.989515]
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [=A0 334.989577] BUG: KASAN: slab-out-of-bounds in
>>> vgacon_scroll+0x57a/0x8ed
>>> [=A0 334.989588] Write of size 1766 at addr ffff8883de69ff3e by task
>>> test/2658
>>> [=A0 334.989593]
>>> [=A0 334.989608] CPU: 3 PID: 2658 Comm: test Not tainted
>>> 5.7.0-rc5-00005-g152036d1379f #789
>>> [=A0 334.989617] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>>> BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>>> [=A0 334.989624] Call Trace:
>>> [=A0 334.989646]=A0 dump_stack+0xe4/0x14e
>>> [=A0 334.989676]=A0 print_address_description.constprop.5+0x3f/0x60
>>> [=A0 334.989699]=A0 ? vgacon_scroll+0x57a/0x8ed
>>> [=A0 334.989710]=A0 __kasan_report.cold.8+0x92/0xaf
>>> [=A0 334.989735]=A0 ? vgacon_scroll+0x57a/0x8ed
>>> [=A0 334.989761]=A0 kasan_report+0x37/0x50
>>> [=A0 334.989789]=A0 check_memory_region+0x1c1/0x1e0
>>> [=A0 334.989806]=A0 memcpy+0x38/0x60
>>> [=A0 334.989824]=A0 vgacon_scroll+0x57a/0x8ed
>>> [=A0 334.989876]=A0 con_scroll+0x4ef/0x5e0
>> ...
>>> Because vgacon_scrollback_cur->tail plus memcpy size is greater than
>>> vgacon_scrollback_cur->size. Fix this by checking the memcpy size.
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>> =A0 drivers/video/console/vgacon.c | 11 ++++++++---
>>> =A0 1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/video/console/vgacon.c
>>> b/drivers/video/console/vgacon.c
>>> index 998b0de1812f..b51ffb9a208d 100644
>>> --- a/drivers/video/console/vgacon.c
>>> +++ b/drivers/video/console/vgacon.c
>>> @@ -243,6 +243,7 @@ static void vgacon_scrollback_startup(void)
>>> =A0 static void vgacon_scrollback_update(struct vc_data *c, int t, int
>>> count)
>>> =A0 {
>>> =A0=A0=A0=A0=A0 void *p;
>>> +=A0=A0=A0 int size;
>>> =A0 =A0=A0=A0=A0=A0 if (!vgacon_scrollback_cur->data ||
>>> !vgacon_scrollback_cur->size ||
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 c->vc_num !=3D fg_console)
>>> @@ -251,13 +252,17 @@ static void vgacon_scrollback_update(struct
>>> vc_data *c, int t, int count)
>>> =A0=A0=A0=A0=A0 p =3D (void *) (c->vc_origin + t * c->vc_size_row);
>>> =A0 =A0=A0=A0=A0=A0 while (count--) {
>>> +=A0=A0=A0=A0=A0=A0=A0 size =3D vgacon_scrollback_cur->size -
>>> vgacon_scrollback_cur->tail;
>>> +=A0=A0=A0=A0=A0=A0=A0 if (size > c->vc_size_row)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D c->vc_size_row;
>>> +
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 scr_memcpyw(vgacon_scrollback_cur->data +
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vgacon_scrollback_c=
ur->tail,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p, c->vc_size_row);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p, size);
>> Are you sure the consumer can handle split lines? As vgacon_scrolldelta
>> (soff in particular) looks to me like it doesn't.
>>
>> Have you tested you patch? I mean with soft scrollback on the vga
>> console?
>=20
> I only test the patch with the reproduce program.

Out of curiosity, what is it doing? Resize and then scroll by \n (line
feed)? Can you share it?

thanks,
--=20
js
