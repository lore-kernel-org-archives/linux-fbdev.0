From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Wed, 31 Jan 2018 11:51:21 +0000
Subject: Re: [PATCH 1/5] backlight: lp8788: document sysfs attributes
Message-Id: <878tceckli.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1516978005.git.aishpant@gmail.com>
 <6523e26889d3dd65e90ea27c0d302a95aeb9da8b.1516978005.git.aishpant@gmail.com>
 <20180131110727.rmmwyqzwozwhda6z@oak.lan>
In-Reply-To: <20180131110727.rmmwyqzwozwhda6z@oak.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>, Aishwarya Pant <aishpant@gmail.com>
Cc: Milo Kim <milo.kim@ti.com>, linux-fbdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Julia Lawall <julia.lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>

On Wed, 31 Jan 2018, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> On Fri, Jan 26, 2018 at 08:20:08PM +0530, Aishwarya Pant wrote:
>> Add documentation for sysfs interfaces of lp8788 backlight driver by
>> looking through the code and the git commit history.
>> 
>> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
>> ---
>>  Documentation/ABI/testing/sysfs-class-backlight-lp8788 | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp8788
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lp8788 b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
>> new file mode 100644
>> index 000000000000..c0e565c8d63d
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
>> @@ -0,0 +1,10 @@
>> +sysfs interface for Texas Instruments lp8788 mfd backlight driver
>> +-----------------------------------------------------------------
>> +
>> +What:		/sys/class/backlight/<backlight>/bl_ctl_mode
>> +Date:		Feb, 2013
>> +KernelVersion:	v3.10
>> +Contact:	Milo Kim <milo.kim@ti.com>
>> +Description:
>> +		(RO) Displays whether the brightness is controlled by the PWM
>> +		input("PWM based") or the I2C register("Register based").
>
> I rather dislike drivers with this type of "bonus" sysfs controls. I'm
> struggling to come up with any reason why the userspace would want to
> read this control (and I think bl_ctl_mode gets the fewest hits after
> searching with google hits of any search I've tried) . It looks to me 
> like this is debug information that should never have gone into sysfs 
> at all.

Agreed. I think the same holds for the other extra sysfs attributes. At
worst, having these prevents the backlight class from adding the names
later on, which is just backwards.

BR,
Jani.


>
> So I think this is either something that should go directly into
> ABI/obsolete (with a fairly short expiry time) or perhaps simply
> remove the property entirely.
>
>
> Daniel.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Technology Center
