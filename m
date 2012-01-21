From: Kay Sievers <kay.sievers@vrfy.org>
Date: Sat, 21 Jan 2012 13:57:13 +0000
Subject: Re: udlfb: remove sysfs framebuffer device with USB .disconnect()
Message-Id: <CAPXgP12LJudv3bpOfxntqoDoGnLbKqN2xWfA5nuYU7wNfN1Ymw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327090686.1555.2.camel@mop>
In-Reply-To: <1327090686.1555.2.camel@mop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Sat, Jan 21, 2012 at 14:44, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> On 01/20/2012 08:18 PM, Kay Sievers wrote:

>> +++ b/drivers/video/fbmem.c
>> @@ -1672,7 +1672,7 @@ static int do_unregister_framebuffer(str
>>       registered_fb[i] = NULL;
>
> Here registered_fb[fb_info->node] is set to NULL...

>> +int unlink_framebuffer(struct fb_info *fb_info)
>> +{
>> +     int i;
>> +
>> +     i = fb_info->node;
>> +     if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
>> +             return -EINVAL;
>
> ...and here you check whether it is still valid (did you copy the check from the
> do_unregister_framebuffer?). So the code below would be never executed, when
> called in this context.

That's true. If one calls the current _unregister() *before* calling
_unlink(), the _unlink() is a NOP. But that's intentional.

The _unlink() is only needed for stuff needs to be called when we are
required to 'orphan' the device before cleaning up. Normal,
non-hotpluggable devices do not need this, they can continue what they
do today.

The _unlink() call *can* be called before _unregister() if needed for
disconnecting it from the driver core parent and remove its userspace
visibility. If _unlink() is called before _unregister(), it passes the
check, the later _unregister() will also pass the check but get rid of
the entire device.

Kay
