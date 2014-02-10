From: David Herrmann <dh.herrmann@gmail.com>
Date: Mon, 10 Feb 2014 11:32:28 +0000
Subject: Re: [PATCH] fbdev: suppress warning when assigning vga-save/restore base
Message-Id: <CANq1E4TnyXW-YoRG0kp9YX14AKJ=oYRKQoBuujhyUSTFtK9FAA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375637141-2878-1-git-send-email-dh.herrmann@gmail.com>
	<52F8B6B3.5080602@ti.com>
In-Reply-To: <52F8B6B3.5080602@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ondrej Zajicek <santiago@crfreenet.org>, David Miller <davem@davemloft.net>

Hi Tomi

On Mon, Feb 10, 2014 at 12:23 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi David,
>
> On 04/08/13 20:25, David Herrmann wrote:
>> If drivers use "struct resource" objects to retrieve the vga-base, they
>> must correctly cast the integer to pointer. With x86+PAE we have 32bit
>> pointers but 64bit resource_size_t. Hence, cast it to "unsigned long"
>> before casting to "void*" to suppress warnings due to size differences.
>>
>> As IO addresses are always low addresses, we can safely drop the higher
>> part of the address. This is what these drivers did before, anyway.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> Reported-by: H. Peter Anvin <hpa@zytor.com>
>> ---
>> Hi
>>
>> hpa reported build-warnings on i386+PAE:
>> /home/hpa/kernel/distwork/drivers/video/arkfb.c:1019:23: warning: cast to
>>     pointer from integer of different size [-Wint-to-pointer-cast]
>>     par->state.vgabase = (void __iomem *) vga_res.start;
>>                          ^
>> /home/hpa/kernel/distwork/drivers/video/s3fb.c: In function 's3_pci_probe':
>> /home/hpa/kernel/distwork/drivers/video/s3fb.c:1186:23: warning: cast to pointer
>>     from integer of different size [-Wint-to-pointer-cast]
>>     par->state.vgabase = (void __iomem *) vga_res.start;
>>                          ^
>>
>> This is due to resource_size_t being 64bit but "void*" 32bit. This patch tries
>> to suppress these warnings but I am not really comfortable fixing this. I have
>> no idea whether my assumption (IO address are 32bit) is right. Please verify.
>>
>>  @David: The following 3 commits of yours presumably introduced the warnings. I
>> would be glad if you could review this:
>
> What was the conclusion on this patch? Should I apply for 3.14 fixes?

No, please drop it. If I understand David correctly, we should just
revert the patches in question. But someone who actually understands
what it is doing should propose that (which is not me..).

Thanks
David
