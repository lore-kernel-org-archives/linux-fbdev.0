From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Wed, 27 Aug 2014 12:56:44 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAKON4OyLVa8dxxaON4x7DUSck6w_zBhB+grbd-xOUugpeYSZ6A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com>
 <CAKON4Owj=b7r_iuOOrr_5R++oSbxqF0G0i4puFz7aTaUF+weuw@mail.gmail.com>
 <53FDD40A.3040106@redhat.com>
In-Reply-To: <53FDD40A.3040106@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 27, 2014 at 8:50 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 08/27/2014 02:44 PM, jonsmirl@gmail.com wrote:
>
> <snip>
>
>>> 1) Serving as *the* fb until a kms driver is present
>>
>> Why can't we whip together a real device specific fbdev driver and
>> quit trying to run without a device specific driver in place? History
>> has shown that to be bad idea except during early boot when there
>> isn't a choice.
>
> Writing a kms driver and getting it upstream is not a simple task, and
> starting with a too limited implementation is dangerous as we need to get
> the devicetree binding first from the get go.

I didn't say write a kms driver, I said write a fbdev driver.  Look in
drivers/video/fbdev. fbdev drivers are used on many embedded systems.
Its what we used for years before kms came along.

>
> IOW this is not really a realistic answer to problem 1.
>
> <snip>
>
>>> 2) Allowing for output of early kernel boot messages.
>>
>> For this to work the kernel needs to know two things - address of the
>> framebuffer and the x/y layout. Then just nuke this display when the
>> kernel finishes the boot process.
>
> Please read my earlier mails on how completely flawed it is to write
> "when the kernel finishes the boot process". The problem is that there
> is no way to really determine when this happens.

Let me rephrase that, when the existing code in the clk system and
regulator systems decide to do their clean up the display will get
nuked.


>
> Regards,
>
> Hans
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Jon Smirl
jonsmirl@gmail.com
