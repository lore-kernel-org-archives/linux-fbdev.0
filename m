From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 25 Sep 2015 17:58:00 +0000
Subject: Re: [PATCH] fbdev: put module after running driver callback
Message-Id: <CANq1E4RZsPCqUu2M6jR24bvJqJys9paR=ttauh_VcN1GL7kLig@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441987843-4313-1-git-send-email-dh.herrmann@gmail.com>
 <5603DD55.8080801@ti.com>
In-Reply-To: <5603DD55.8080801@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

Hi

On Thu, Sep 24, 2015 at 1:24 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 11/09/15 19:10, David Herrmann wrote:
>> Currently, for each open() on an fbdev device, we pin the underlying
>> fbdev device and driver module. On close(), we release both. This
>> guarantees that the fbdev object stays around until the last FD is
>> released (even though it might be unregistered already).
>>
>> However, currently we call module_put() *before* calling put_fb_info().
>> This has the side-effect that the driver module might be unloaded before
>> put_fb_info() calls into fbinfo->fbops->fb_destroy().
>>
>> Fix this by keeping the module pinned until after we release our fbdev
>> reference. Note that register_framebuffer() and unregister_framebuffer()
>> are special as we require the driver to unregister device before
>> unloading. Hence, they don't need to pin the module. However, all open
>> handlers *have to*.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>>  drivers/video/fbdev/core/fbmem.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
>> index 0705d88..4e78731 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -1482,13 +1482,16 @@ __acquires(&info->lock)
>>  __releases(&info->lock)
>>  {
>>       struct fb_info * const info = file->private_data;
>> +     struct module *owner;
>>
>>       mutex_lock(&info->lock);
>>       if (info->fbops->fb_release)
>>               info->fbops->fb_release(info,1);
>> -     module_put(info->fbops->owner);
>> +     owner = info->fbops->owner;
>>       mutex_unlock(&info->lock);
>> +
>>       put_fb_info(info);
>> +     module_put(owner);
>>       return 0;
>>  }
>
> Looking at fb_open(), in error case it calls module_put() followed by
> put_fb_info(). Is that broken also?

Indeed, same issue here. I will send v2 which fixes both.

> Have you hit this bug, or did you just find it by looking at the code?
> In other words, is this for 4.3 fixes, or 4.4. I guess the user needs to
> unload the module just at the right time to trigger this bug.

Theoretical issue. It's almost impossible to trigger, as module
unloading takes ages compared to the time required to release the
fbinfo.

Thanks
David
