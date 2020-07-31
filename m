From: Jiri Slaby <jirislaby@kernel.org>
Date: Fri, 31 Jul 2020 04:56:14 +0000
Subject: Re: [PATCH] vgacon: Fix an out-of-bounds in vgacon_scrollback_update()
Message-Id: <42bd14e3-ae2f-0c14-5d42-e3e7aeb11c78@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200713105730.550334-1-yangyingliang@huawei.com>
 <220220f1-48f7-46f6-952f-ab41fa57d6a1@kernel.org>
 <c3714d73-d5fe-c77a-e554-bb1ff4fd6980@huawei.com>
 <9aecd7ac-5060-6b8d-61f8-393431eb243f@kernel.org>
 <3df26fed-5ade-df26-6417-380401b9650b@huawei.com>
In-Reply-To: <3df26fed-5ade-df26-6417-380401b9650b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yang Yingliang <yangyingliang@huawei.com>, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>

Hi,

On 31. 07. 20, 5:23, Yang Yingliang wrote:
> void execute_one(void)
> {
> 		intptr_t res = 0;
> 	res = syz_open_dev(0xc, 4, 1);

open(/dev/tty1)

> 	if (res != -1)
> 		r[0] = res;
> *(uint16_t*)0x20000000 = 0xc;
> *(uint16_t*)0x20000002 = 0x373;
> *(uint16_t*)0x20000004 = 0x1442;
> 	syscall(__NR_ioctl, r[0], 0x5609ul, 0x20000000ul);

VT_RESIZE(12, 883)

> memcpy((void*)0x20003500, "\x7f\x45\x4c\x46\x00\x00\x00...
> 	syscall(__NR_write, r[0], 0x20003500ul, 0x381ul);

Write 381 bytes of some ELF to the tty.

OK, that's it. Thanks.

-- 
js
