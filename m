From: Yang Yingliang <yangyingliang@huawei.com>
Date: Thu, 30 Jul 2020 13:24:04 +0000
Subject: Re: [PATCH] vgacon: Fix an out-of-bounds in vgacon_scrollback_update()
Message-Id: <c3714d73-d5fe-c77a-e554-bb1ff4fd6980@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200713105730.550334-1-yangyingliang@huawei.com>
 <220220f1-48f7-46f6-952f-ab41fa57d6a1@kernel.org>
In-Reply-To: <220220f1-48f7-46f6-952f-ab41fa57d6a1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jirislaby@kernel.org>, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>


On 2020/7/30 19:04, Jiri Slaby wrote:
> On 13. 07. 20, 12:57, Yang Yingliang wrote:
>> I got a slab-out-of-bounds report when I doing fuzz test.
>>
>> [  334.989515] =================================
>> [  334.989577] BUG: KASAN: slab-out-of-bounds in vgacon_scroll+0x57a/0x8ed
>> [  334.989588] Write of size 1766 at addr ffff8883de69ff3e by task test/2658
>> [  334.989593]
>> [  334.989608] CPU: 3 PID: 2658 Comm: test Not tainted 5.7.0-rc5-00005-g152036d1379f #789
>> [  334.989617] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>> [  334.989624] Call Trace:
>> [  334.989646]  dump_stack+0xe4/0x14e
>> [  334.989676]  print_address_description.constprop.5+0x3f/0x60
>> [  334.989699]  ? vgacon_scroll+0x57a/0x8ed
>> [  334.989710]  __kasan_report.cold.8+0x92/0xaf
>> [  334.989735]  ? vgacon_scroll+0x57a/0x8ed
>> [  334.989761]  kasan_report+0x37/0x50
>> [  334.989789]  check_memory_region+0x1c1/0x1e0
>> [  334.989806]  memcpy+0x38/0x60
>> [  334.989824]  vgacon_scroll+0x57a/0x8ed
>> [  334.989876]  con_scroll+0x4ef/0x5e0
> ...
>> Because vgacon_scrollback_cur->tail plus memcpy size is greater than
>> vgacon_scrollback_cur->size. Fix this by checking the memcpy size.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/video/console/vgacon.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
>> index 998b0de1812f..b51ffb9a208d 100644
>> --- a/drivers/video/console/vgacon.c
>> +++ b/drivers/video/console/vgacon.c
>> @@ -243,6 +243,7 @@ static void vgacon_scrollback_startup(void)
>>   static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
>>   {
>>   	void *p;
>> +	int size;
>>   
>>   	if (!vgacon_scrollback_cur->data || !vgacon_scrollback_cur->size ||
>>   	    c->vc_num != fg_console)
>> @@ -251,13 +252,17 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
>>   	p = (void *) (c->vc_origin + t * c->vc_size_row);
>>   
>>   	while (count--) {
>> +		size = vgacon_scrollback_cur->size - vgacon_scrollback_cur->tail;
>> +		if (size > c->vc_size_row)
>> +			size = c->vc_size_row;
>> +
>>   		scr_memcpyw(vgacon_scrollback_cur->data +
>>   			    vgacon_scrollback_cur->tail,
>> -			    p, c->vc_size_row);
>> +			    p, size);
> Are you sure the consumer can handle split lines? As vgacon_scrolldelta
> (soff in particular) looks to me like it doesn't.
>
> Have you tested you patch? I mean with soft scrollback on the vga console?

I only test the patch with the reproduce program.


Thanks,

Yang

>
>>   		vgacon_scrollback_cur->cnt++;
>> -		p += c->vc_size_row;
>> -		vgacon_scrollback_cur->tail += c->vc_size_row;
>> +		p += size;
>> +		vgacon_scrollback_cur->tail += size;
>>   
>>   		if (vgacon_scrollback_cur->tail >= vgacon_scrollback_cur->size)
>>   			vgacon_scrollback_cur->tail = 0;
>>
> thanks,
