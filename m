From: Sebastian Frias <sf84@laposte.net>
Date: Tue, 29 Dec 2015 14:06:38 +0000
Subject: Re: [RFC PATCH] fbdev: add support for Sigma Designs' smp8xxxfb.ko
Message-Id: <5682936E.2040904@laposte.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <56828767.4050302@laposte.net> <CAH6sp9NrvapSMnPq5aagUFG2upf6-H9QJL1bkhMSscDL21Q-EQ@mail.gmail.com>
In-Reply-To: <CAH6sp9NrvapSMnPq5aagUFG2upf6-H9QJL1bkhMSscDL21Q-EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Klaver <fransklaver@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>

On 12/29/2015 02:49 PM, Frans Klaver wrote:
> On Tue, Dec 29, 2015 at 2:15 PM, Sebastian Frias <sf84@laposte.net> wrote:
>> Hi,
>>
>> We are wondering what is the recommended way of adding support for a
>> framebuffer driver on the Linux kernel.
>> Below you can find a patch with a proposed solution.
>
> That's not really a solution to add a driver to the kernel. You'd have
> to include some actual driver code as well.

We are not attempting to upstream the driver yet, that's why its code is 
not included.

The patch is an attempt to allow the user to enable Framebuffer support 
by providing an option for the user and then setting FB_CFB_FILLRECT, 
FB_CFB_COPYAREA and FB_CFB_IMAGEBLIT to yes.

It does the job, but we feel (and you have sort of confirmed it) that it 
may not be a good idea to do it that way.

>
>
>> Our frambuffer driver source code is provided separately, but right now it
>> requires "cfb_fillrect", "cfb_copyarea" and "cfb_imageblit" to be provided
>> by the kernel.
>>
>> Our current kernel fork (based on 3.4) hardcodes FB_CFB_FILLRECT,
>> FB_CFB_COPYAREA and FB_CFB_IMAGEBLIT to yes.
>> Since we are in the process of migrating to 4.x and upstreaming changes
>> along the way, we would like to know if the patch below is the way to go
>> with it or if you have suggestions to improve it.
>
> Is the below patch really a patch you intend to upstream, or are you
> just wondering about what your Kconfig entry should look like when you
> upstream your driver?

Right now we don't know if the driver will be upstreamed.
Let me rephrase my question:

- how would you recommend enabling FB_CFB_FILLRECT, FB_CFB_COPYAREA and 
FB_CFB_IMAGEBLIT for a driver that is not included in the kernel's tree?

If that is not possible, I guess we will have to keep a forked tree 
until the driver is upstreamed, but we would like to avoid that, hence 
the question.

>
>
>> Subject: [RFC PATCH] fbdev: add support for Sigma Designs' smp8xxxfb.ko
>>
>> Signed-off-by: Sebastian Frias <sf84@laposte.net>
>> ---
>>   drivers/video/fbdev/Kconfig |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
>> index e6d16d6..46c4ab2 100644
>> --- a/drivers/video/fbdev/Kconfig
>> +++ b/drivers/video/fbdev/Kconfig
>> @@ -615,6 +615,16 @@ config FB_BF537_LQ035
>>            To compile this driver as a module, choose M here: the
>>            module will be called bf537-lq035.
>>
>> +config FB_TANGO
>> +       bool "Sigma Designs FrameBuffer support"
>> +       depends on FB && ARCH_TANGO
>> +       select FB_CFB_FILLRECT
>> +       select FB_CFB_COPYAREA
>> +       select FB_CFB_IMAGEBLIT
>> +       help
>> +         You need to enable this if you intend to use Sigma
>> +         Designs' smp8xxxfb.ko driver.
>> +
>>   config FB_BFIN_7393
>>          tristate "Blackfin ADV7393 Video encoder"
>>          depends on FB && BLACKFIN
>
> Frans
>
