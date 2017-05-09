From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 09 May 2017 19:19:47 +0000
Subject: Re: [PATCH v3] backlight: report error on failure
Message-Id: <e29c51a9-76e1-ab7c-8d24-952096e52ef2@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1494093610-5561-1-git-send-email-sudipm.mukherjee@gmail.com>
 <a0e76ff0-0f31-c3fd-79a3-3455861989e7@linaro.org>
 <20170509145657.GA5186@sudip-tp>
In-Reply-To: <20170509145657.GA5186@sudip-tp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>

On 09/05/17 15:56, Sudip Mukherjee wrote:
> On Mon, May 08, 2017 at 04:45:17PM +0100, Daniel Thompson wrote:
>> On 06/05/17 19:00, Sudip Mukherjee wrote:
>>> It is possible to update the backlight power and the brightness using
>>> the sysfs and on writing it either returns the count or if the callback
>>> function does not exist then returns the error code 'ENXIO'.
>>>
>>> We have a situation where the userspace client is writing to the sysfs
>>> to update the power and since the callback function exists the client
>>> receives the return value as count and considers the operation to be
>>> successful. That is correct as the write to the sysfs was successful.
>>> But there is no way to know if the actual operation was done or not.
>>>
>>> backlight_update_status() returns the error code if it fails. Pass that
>>> to the userspace client who is trying to update the power so that the
>>> client knows that the operation failed.
>>>
>>> This is not a change of ABI as the userspace expects an error of ENXIO,
>>> after this patch the range of errors that are returned to the userspace
>>> will increase.
>>
>> This comment is wrong, no code path through
>> backlight_device_set_brightness() can possibly return ENXIO.
> 
> I am seeing backlight_device_set_brightness() can return ENXIO
> if bd->ops is NULL. ofcourse I have not tried to test by passing NULL as
> backlight_ops in backlight_device_register().
> 
>>
>> My review comment to v1 was:
>>> Strictly speaking this is an ABI change. Its probably a harmless one
>>> making it ok to change but I'm interested what testing or code review
>>> you've done to be sure the userspace doesn't do odd things if the
>>> kernel starts to pass through errors.
>>
>> I find myself somewhat surprised to find the above review comment addressed
>> by adding text to the patch header denying that there is a change of ABI...
> 
> Yes, sorry about this. I got confused between API and ABI. :(
> 
> So, this is an ABI change (not API change, as I misunderstood) as now
> the userspace might get some more error codes as return which it was not
> expecting.
> How will you want me to test and review it? I can make a list of the
> other drivers which are registering the backlight and review what they
> are doing if there is an error in the backlight or brightness. And then
> we can have a statistics how many of the drivers will be returning extra
> error codes. I have been seeing few drivers and i noticed all of them
> are just returning 0 at the end.

I really did just wonder what you had already done!

Since yesterday I've done a quick code review of Weston, KDE and 
gnome-settings-daemon and saw no particular grounds to worry. Mostly the 
userspace sets sysfs from layers of IPC mechanisms so there's loads of 
ways it can report failure... I doubt one more will hurt ;-)

Let's just get this comment removed and that's probably enough!


Daniel.
