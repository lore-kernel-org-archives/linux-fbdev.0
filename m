From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 21 Oct 2015 08:09:11 +0000
Subject: Re: [PATCH RFC v2 2/2] simplefb: Claim and enable regulators
Message-Id: <56274827.3000708@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1445407141-16459-1-git-send-email-wens@csie.org>
 <1445407141-16459-3-git-send-email-wens@csie.org>
 <562744A9.1070705@redhat.com>
 <CAGb2v643sDnNv5DPYocu-50UB3q-itpwGdw8hZ3YN=V+nEBkMg@mail.gmail.com>
In-Reply-To: <CAGb2v643sDnNv5DPYocu-50UB3q-itpwGdw8hZ3YN=V+nEBkMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 21-10-15 10:04, Chen-Yu Tsai wrote:
> Hi,
>
> On Wed, Oct 21, 2015 at 3:54 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 21-10-15 07:59, Chen-Yu Tsai wrote:
>>>
>>> This claims and enables regulators listed in the simple framebuffer dt
>>> node. This is needed so that regulators powering the display pipeline
>>> and external hardware, described in the device node and known by the
>>> kernel code, will remain properly enabled.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>    drivers/video/fbdev/simplefb.c | 122
>>> ++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 121 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/video/fbdev/simplefb.c
>>> b/drivers/video/fbdev/simplefb.c
>>> index 52c5c7e63b52..c4ee10d83a70 100644
>>> --- a/drivers/video/fbdev/simplefb.c
>>> +++ b/drivers/video/fbdev/simplefb.c
>>> @@ -28,7 +28,10 @@
>>>    #include <linux/platform_device.h>
>>>    #include <linux/clk.h>
>>>    #include <linux/clk-provider.h>
>>> +#include <linux/of.h>
>>>    #include <linux/of_platform.h>
>>> +#include <linux/parser.h>
>>> +#include <linux/regulator/consumer.h>
>>>
>>>    static struct fb_fix_screeninfo simplefb_fix = {
>>>          .id             = "simple",
>>> @@ -174,6 +177,10 @@ struct simplefb_par {
>>>          int clk_count;
>>>          struct clk **clks;
>>>    #endif
>>> +#if defined CONFIG_OF && defined CONFIG_REGULATOR
>>> +       u32 regulator_count;
>>> +       struct regulator **regulators;
>>> +#endif
>>>    };
>>>
>>>    #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
>>> @@ -269,6 +276,112 @@ static int simplefb_clocks_init(struct simplefb_par
>>> *par,
>>>    static void simplefb_clocks_destroy(struct simplefb_par *par) { }
>>>    #endif
>>>
>>> +#if defined CONFIG_OF && defined CONFIG_REGULATOR
>>> +
>>> +#define SUPPLY_SUFFIX "-supply"
>>> +
>>> +/*
>>> + * Regulator handling code.
>>> + *
>>> + * Here we handle the num-supplies and vin*-supply properties of our
>>> + * "simple-framebuffer" dt node. This is necessary so that we can make
>>> sure
>>> + * that any regulators needed by the display hardware that the bootloader
>>> + * set up for us (and for which it provided a simplefb dt node), stay up,
>>> + * for the life of the simplefb driver.
>>> + *
>>> + * When the driver unloads, we cleanly disable, and then release the
>>> + * regulators.
>>> + *
>>> + * We only complain about errors here, no action is taken as the most
>>> likely
>>> + * error can only happen due to a mismatch between the bootloader which
>>> set
>>> + * up simplefb, and the regulator definitions in the device tree. Chances
>>> are
>>> + * that there are no adverse effects, and if there are, a clean teardown
>>> of
>>> + * the fb probe will not help us much either. So just complain and carry
>>> on,
>>> + * and hope that the user actually gets a working fb at the end of
>>> things.
>>> + */
>>> +static int simplefb_regulators_init(struct simplefb_par *par,
>>> +       struct platform_device *pdev)
>>> +{
>>> +       struct device_node *np = pdev->dev.of_node;
>>> +       struct property *prop;
>>> +       struct regulator *regulator;
>>> +       const char *p;
>>> +       int count = 0, i = 0, ret;
>>> +
>>> +       if (dev_get_platdata(&pdev->dev) || !np)
>>> +               return 0;
>>> +
>>> +       /* Count the number of regulator supplies */
>>> +       for_each_property_of_node(np, prop) {
>>> +               p = strstr(prop->name, SUPPLY_SUFFIX);
>>> +               if (p && p != prop->name)
>>> +                       count++;
>>> +       }
>>> +
>>> +       if (!count)
>>> +               return 0;
>>> +
>>> +       par->regulators = devm_kcalloc(&pdev->dev, count,
>>> +                                      sizeof(struct regulator *),
>>> GFP_KERNEL);
>>> +       if (!par->regulators)
>>> +               return -ENOMEM;
>>> +
>>> +       /* Get all the regulators */
>>> +       for_each_property_of_node(np, prop) {
>>> +               char name[32]; /* 32 is max size of property name */
>>> +
>>> +               p = strstr(prop->name, SUPPLY_SUFFIX);
>>> +               if (p && p != prop->name)
>>> +                       continue;
>>> +
>>> +               strlcpy(name, prop->name,
>>> +                       strlen(prop->name) - sizeof(SUPPLY_SUFFIX) + 1);
>>> +               regulator = devm_regulator_get_optional(&pdev->dev, name);
>>> +               if (IS_ERR(regulator)) {
>>> +                       if (PTR_ERR(regulator) = -EPROBE_DEFER)
>>> +                               return -EPROBE_DEFER;
>>> +                       dev_err(&pdev->dev, "regulator %s not found:
>>> %ld\n",
>>> +                               name, PTR_ERR(regulator));
>>> +                       continue;
>>> +               }
>>> +               par->regulators[i++] = regulator;
>>
>>
>> So you only fill slots when the regulator_get has succeeded
>>
>>> +       }
>>> +       par->regulator_count = i;
>>
>>
>> and regulator_count now is the amount of successfully gotten regulators
>> (which may be different from count).
>>
>>> +
>>> +       /* Enable all the regulators */
>>> +       for (i = 0; i < par->regulator_count; i++) {
>>> +               if (par->regulators[i]) {
>>
>>
>> That means that this "if" is not necessary, it will always be true.
>
> Right. This is leftover code from the first version. I'll remove it.
>
>>> +                       ret = regulator_enable(par->regulators[i]);
>>> +                       if (ret) {
>>> +                               dev_err(&pdev->dev,
>>> +                                       "failed to enable regulator %d:
>>> %d\n",
>>> +                                       i, ret);
>>> +                               devm_regulator_put(par->regulators[i]);
>>> +                               par->regulators[i] = NULL;
>
> Note here.
>
>>> +                       }
>>> +               }
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static void simplefb_regulators_destroy(struct simplefb_par *par)
>>> +{
>>> +       int i;
>>> +
>>> +       if (!par->regulators)
>>> +               return;
>>> +
>>> +       for (i = 0; i < par->regulator_count; i++)
>>> +               if (par->regulators[i])
>>
>>
>> And idem for this if.
>
> This is still needed, since if we fail to enable any regulator, we just
> ignore it, call regulator_put() on it, and forget about it (set the entry
> to NULL). See the noted place above.

Ah right, ok lets keep that in then :)

Regards,

Hans
