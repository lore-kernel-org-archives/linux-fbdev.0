From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 08:27:07 +0000
Subject: Re: [linux-sunxi] [PATCH 2/4] simplefb: Add support for enumerating simplefb dt nodes in /chosen
Message-Id: <54646B5B.1070604@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-2-git-send-email-hdegoede@redhat.com>
 <CAGRGNgW_Q6oghpe5Mw-8aYPVVj1YZ6R3iaqOQzCE9dSD1nYSyA@mail.gmail.com>
In-Reply-To: <CAGRGNgW_Q6oghpe5Mw-8aYPVVj1YZ6R3iaqOQzCE9dSD1nYSyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/13/2014 12:39 AM, Julian Calaby wrote:
> Hi Hans,
> 
> On Thu, Nov 13, 2014 at 9:08 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Update simplefb to support the new preferred location for simplefb dt nodes
>> under /chosen.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/video/fbdev/simplefb.c | 33 ++++++++++++++++++++++++++++++++-
>>  1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
>> index cd96edd..be7d288 100644
>> --- a/drivers/video/fbdev/simplefb.c
>> +++ b/drivers/video/fbdev/simplefb.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/platform_data/simplefb.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/clk-provider.h>
>> +#include <linux/of_platform.h>
>>
>>  static struct fb_fix_screeninfo simplefb_fix = {
>>         .id             = "simple",
>> @@ -385,7 +386,37 @@ static struct platform_driver simplefb_driver = {
>>         .probe = simplefb_probe,
>>         .remove = simplefb_remove,
>>  };
>> -module_platform_driver(simplefb_driver);
>> +
>> +static int __init simplefb_init(void)
>> +{
>> +       int i, ret;
>> +       char name[16];
>> +       struct device_node *np;
>> +
>> +       ret = platform_driver_register(&simplefb_driver);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i = 0; ; i++) {
>> +               snprintf(name, sizeof(name), "framebuffer%d", i);
> 
> This smells like an infinite loop: we can be pretty sure that no
> hardware will ever exist with more than 9999 (I think?) framebuffers,
> however if that ever happens this'll loop until it runs out of RAM.
> Maybe add a suitably high limit to the for loop?

The loop will stop as soon as there are no more framebuffer# nodes in chosen,
so the loop is only infinite if there are infinite nodes in the devicetree,
which would make the devicetree infinitely large, so this will never happen.

Regards,

Hans
