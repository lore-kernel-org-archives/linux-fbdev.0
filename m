From: Kay Sievers <kay.sievers@vrfy.org>
Date: Fri, 27 Jan 2012 16:32:23 +0000
Subject: Re: udlfb: remove sysfs framebuffer device with USB .disconnect()
Message-Id: <CAPXgP10eUncJTOY7Sc82fP3hfbxnFG8BhNWyN26BY+CFha8MGQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327090686.1555.2.camel@mop>
In-Reply-To: <1327090686.1555.2.camel@mop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Jan 21, 2012 at 15:32, Kay Sievers <kay.sievers@vrfy.org> wrote:
> On Sat, 2012-01-21 at 14:13 +0000, Florian Tobias Schandinat wrote:
>> On 01/21/2012 01:57 PM, Kay Sievers wrote:
>
>> > That's true. If one calls the current _unregister() *before* calling
>> > _unlink(), the _unlink() is a NOP. But that's intentional.
>>
>> I don't think you got me right. My complaint was that after your patch
>> do_unregister_framebuffer itself calls unlink_framebuffer _after_ it set
>> registered_fb[i] = NULL;
>> So for any framebuffer that does not call unlink_framebuffer directly the line
>> device_destroy(fb_class, MKDEV(FB_MAJOR, i));
>> will no longer be executed. Do you agree?
>
> Yes, I absolutely agree. :)

Hey Florian,

any updates?

We like to get that into the Fedora kernel, as we promised
out-of-the-box multi-seat hotplug support, but the framebuffer events
are broken at the moment.

It would be nice if it would show up in -next somehow, and gets
testing, so I don't need to convince anybody at the Fedora kernel
side, that this will land upstream ...

Thanks,
Kay
