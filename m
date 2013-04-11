From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 11 Apr 2013 16:06:49 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <5166DF99.2000308@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <20130408171637.98b5ad1f867bcbda883af68b@linux-foundation.org>
 <2569832.XQDrhUGNaI@avalon>
In-Reply-To: <2569832.XQDrhUGNaI@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 04/11/2013 03:56 AM, Laurent Pinchart wrote:
> On Monday 08 April 2013 17:16:37 Andrew Morton wrote:
>> On Wed,  3 Apr 2013 20:39:43 -0600 Stephen Warren wrote:
>>> A simple frame-buffer describes a raw memory region that may be rendered
>>> to, with the assumption that the display hardware has already been set
>>> up to scan out from that buffer.
>>>
>>> This is useful in cases where a bootloader exists and has set up the
>>> display hardware, but a Linux driver doesn't yet exist for the display
>>> hardware.
>>>
>>> ...
>>>
>>> +config FB_SIMPLE
>>> +	bool "Simple framebuffer support"
>>> +	depends on (FB = y) && OF
>>
>> It's sad that this simple little thing requires Open Firmware.  Could
>> it be generalised in some way so that the small amount of setup info
>> could be provided by other means (eg, module_param) or does the
>> dependency go deeper than that?
> 
> I second that request. I like the idea of a simple framebuffer driver if it 
> helps deprecating fbdev in the long term, but I don't want it to offer an 
> excuse not to implement a DRM/KMS driver. In particular adding DT bindings 
> would force us to keep supporting the ABI for a (too) long time.

The platforms I intend to use this with only support device tree. Adding
support for platform data right now would just be dead code. If somebody
wants to use this driver with a board file based system rather than a DT
based system, it would be trivial do modify the driver to add a platform
data structure at that time.

Adding support for a platform data structure won't remove the need for
DT support in the driver; any platform that uses DT will always
configure this driver through the DT binding irrespective of whether
some other platform could configure it using platform_data.

I don't believe the DT bindings imply that they must be implemented by
an FB driver rather than a KMS driver. It's just that it's much simpler
to do so at present. If the whole FB subsystem goes away at some time,
it should be possible to implement a simplest-possible KMS driver that
supports the same DT binding. I didn't do it this way because supporting
a pre-allocated FB in DRM/KMS apparently means implementing a custom
memory allocator for this in the driver, which would be a lot of code
overhead when right now the driver can just use the FB subsystem and
simply return the address directly. The simplest possible FB driver
appears much simpler (less code size, less maintenance) than the
simplest possible KMS driver.

My inclination is that for many platforms, the bootloader support for
graphics output will appear first (before the kernel's), and this driver
will allow for the kernel to have a graphical console, allowing a more
complete/useful system to be available earlier. In many cases, that
window may be small; a DRM/KMS driver may appear soon after the basic
CPU/board/... support, and then people can switch to using it if they want.

That said, I also don't really see a problem not implementing a DRM/KMS
driver for a platform; a dumb frame-buffer works perfectly well for my
needs. Nobody would be forced to continue using it once a better
alternative existed.
