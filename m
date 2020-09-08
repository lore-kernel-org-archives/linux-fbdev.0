From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:37:36 +0000
Subject: Re: [PATCH] video: fbdev: radeon: Fix memleak in radeonfb_pci_register
Message-Id: <c2434d86-64c9-2870-f8cc-df604adb17ef@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200825062900.11210-1-dinghao.liu@zju.edu.cn>
 <CGME20200825074817eucas1p29ac412697c8579d3f66c46d9e356b4e0@eucas1p2.samsung.com>
 <CA+7wUswtuOPqQ131F5LdH=7dH+sWZc+jmMHXpaYmTDUehvx5eQ@mail.gmail.com>
In-Reply-To: <CA+7wUswtuOPqQ131F5LdH=7dH+sWZc+jmMHXpaYmTDUehvx5eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Malaterre <malat@debian.org>, Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, kjlu@umn.edu, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>


On 8/25/20 9:47 AM, Mathieu Malaterre wrote:
> On Tue, Aug 25, 2020 at 9:27 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>>
>> When radeon_kick_out_firmware_fb() fails, info should be
>> freed just like the subsequent error paths.
>>
>> Fixes: 069ee21a82344 ("fbdev: Fix loading of module radeonfb on PowerMac")
>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>> ---
>>  drivers/video/fbdev/aty/radeon_base.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
>> index 3fe509cb9b87..13bd2bd5c043 100644
>> --- a/drivers/video/fbdev/aty/radeon_base.c
>> +++ b/drivers/video/fbdev/aty/radeon_base.c
>> @@ -2307,7 +2307,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
>>
>>         ret = radeon_kick_out_firmware_fb(pdev);
>>         if (ret)
>> -               return ret;
>> +               goto err_release_fb;
> 
> Good catch ! Thanks
> 
> Reviewed-by: Mathieu Malaterre <malat@debian.org>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>>         /* request the mem regions */
>>         ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
>> --
>> 2.17.1
