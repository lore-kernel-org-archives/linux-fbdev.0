From: Stephen Warren <swarren@wwwdotorg.org>
Date: Fri, 25 Oct 2013 15:29:27 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <526A8E57.6050508@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <3278905.VOXO7bPE7e@avalon> <526999DA.7080409@wwwdotorg.org> <1580941.z2CDo8WmRF@avalon>
In-Reply-To: <1580941.z2CDo8WmRF@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/25/2013 12:33 PM, Laurent Pinchart wrote:
> On Thursday 24 October 2013 23:06:18 Stephen Warren wrote:
>> On 10/24/2013 12:20 PM, Laurent Pinchart wrote:
...
>>> The case I'm mostly concerned about would be two different compatibility
>>> strings to select whether the device should be handled by a KMS or V4L
>>> driver. I don't think that's a good idea.
>>
>> I wouldn't think of the two compatible values as selecting different
>> specific Linux drivers, but rather they simply describe the HW in
>> different levels of detail. The fact that if we know a certain level of
>> detail about the HW means that Linux can and does create a KMS driver
>> rather than a V4L2 driver seems like a detail that's completely hidden
>> inside the OS.
> 
> I expect the same level of details to be needed on both the KMS and V4L sides. 
> Taking the example of the ADV7511 HDMI transmitter, the only change in the DT 
> bindings between KMS and V4L would be the compatible string. "adi,adv7511-v4l" 
> and "adi,adv7511-kms" is an option that I don't really like. Renaming -v4l and 
> -kms to different names wouldn't fundamentally change the problem.

Yes, two compatible values such as "adi,adv7511-v4l" and
"adi,adv7511-kms" sounds like a bad idea.

Rather, shouldn't we have just "adi,adv7511", and the driver for that
should register itself in a way that allows either/both the top-level
DRM or top-level V4L drivers to find it, and make use of its services.
There are plenty of drivers in the kernel already that export services
through two different subsystems, e.g. a GPIO HW module that registers
as both a struct gpio_chip and a struct irq_chip, or both a struct
gpio_chip and a pinctrl device.
