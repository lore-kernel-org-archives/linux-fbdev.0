From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 21 Jan 2012 14:13:07 +0000
Subject: Re: udlfb: remove sysfs framebuffer device with USB .disconnect()
Message-Id: <4F1AC7F3.3040909@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327090686.1555.2.camel@mop>
In-Reply-To: <1327090686.1555.2.camel@mop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 01/21/2012 01:57 PM, Kay Sievers wrote:
> On Sat, Jan 21, 2012 at 14:44, Florian Tobias Schandinat
> <FlorianSchandinat@gmx.de> wrote:
>> On 01/20/2012 08:18 PM, Kay Sievers wrote:
> 
>>> +++ b/drivers/video/fbmem.c
>>> @@ -1672,7 +1672,7 @@ static int do_unregister_framebuffer(str
>>>       registered_fb[i] = NULL;
>>
>> Here registered_fb[fb_info->node] is set to NULL...
> 
>>> +int unlink_framebuffer(struct fb_info *fb_info)
>>> +{
>>> +     int i;
>>> +
>>> +     i = fb_info->node;
>>> +     if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
>>> +             return -EINVAL;
>>
>> ...and here you check whether it is still valid (did you copy the check from the
>> do_unregister_framebuffer?). So the code below would be never executed, when
>> called in this context.
> 
> That's true. If one calls the current _unregister() *before* calling
> _unlink(), the _unlink() is a NOP. But that's intentional.

I don't think you got me right. My complaint was that after your patch
do_unregister_framebuffer itself calls unlink_framebuffer _after_ it set
registered_fb[i] = NULL;
So for any framebuffer that does not call unlink_framebuffer directly the line
device_destroy(fb_class, MKDEV(FB_MAJOR, i));
will no longer be executed. Do you agree?


Best regards,

Florian Tobias Schandinat

> 
> The _unlink() is only needed for stuff needs to be called when we are
> required to 'orphan' the device before cleaning up. Normal,
> non-hotpluggable devices do not need this, they can continue what they
> do today.
> 
> The _unlink() call *can* be called before _unregister() if needed for
> disconnecting it from the driver core parent and remove its userspace
> visibility. If _unlink() is called before _unregister(), it passes the
> check, the later _unregister() will also pass the check but get rid of
> the entire device.
> 
> Kay
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

