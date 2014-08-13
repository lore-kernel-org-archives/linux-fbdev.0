From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 13 Aug 2014 09:23:14 +0000
Subject: Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-4-git-send-email-libv@skynet.be>
 <CACxGe6vaPUa4QvYWBA-QY7MTmJYoeqnPt9Zh5jpky6S9UYbrvQ@mail.gmail.com>
 <CANq1E4ReOB87RX8VhnW1Ln=SK3Tw5V962ujcsfuz-2E9Uc61yQ@mail.gmail.com>
In-Reply-To: <CANq1E4ReOB87RX8VhnW1Ln=SK3Tw5V962ujcsfuz-2E9Uc61yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 9:49 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Wed, Aug 13, 2014 at 10:40 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>> On Wed, Aug 13, 2014 at 8:17 AM, Luc Verhaegen <libv@skynet.be> wrote:
>>> The next commit will handle clocks correctly, so that these do not get
>>> automatically disabled on certain SoC simplefb implementations. As a
>>> result, the removal of this simplefb driver, and the release of the
>>> clocks, is rather final, and only a full display driver can work after
>>> this. So, it makes sense to also flag the dt node as disabled, even
>>> though it has no real value today.
>>>
>>> Signed-off-by: Luc Verhaegen <libv@skynet.be>
>>
>> Please, no.
>>
>> Drivers should not be modifying the device tree without and
>> exceptionally good reason for doing so. Drivers are to treat the DT as
>> immutable.
>>
>> * the exception is an overlay driver which add new devices to the
>> kernel. Definitely not the case here.
>
> Why?

The majority of the DT code is based on the assumption of a static
tree. Pantelis has been working on being able to modify it at runtime
with overlays, but he has had to go through a lot of rework because it
is not a trivial task. When you get into modifying the DT, you need to
have a lot more understanding of the side effects to changing the
tree. The DT structure also has a lifecycle that can go beyond the
current lifecycle of the kernel. The kexec tool will extract the
current tree from the kernel, make the appropriate modifications, and
use that to boot the next kernel. Allowing any driver to modify the
tree has side effects beyond just the current kernel.

In this specific case, it will interact badly with the work Pantelis
is doing to make platform devices work with overlays. Modifying the
status property will cause the associated struct device to get removed
in the middle of probing a driver for that device! That will most
likely cause an oops.

Besides, Luc straight out *said*: "...even though it has no real value
today". In what circumstance is that justification for modifying the
tree?

> I think we have exactly that case:
>  * DT describes the real hw properly and those parts are immutable
>  * Additionally, bootloaders create firmware-framebuffers and
>    create simple-framebuffer devices for them. Those are
>    valid as long as no driver reconfigured the real hw.
>  * Once a real hw-driver loads, it might destroy the existing
>    framebuffers, thus, it should also destroy the platform device.
>  * If the real hw-driver is unloaded, it might re-create the FB
>    and thus create a new (or enable the old) platform device.
>
> Or, in a nutshell: A "simple-framebuffer" device is basically a
> platform-device for framebuffers. Framebuffers can be created and
> destroyed during runtime. The reason we create platform-devices for
> them, is to allow dummy drivers to be probed. Real hw-drivers
> obviously bind to the parent bus device.
>
> Other ideas are obviously welcome, but so far all of the other ideas
> sounded like big hacks (like remove_conflicting_framebuffers() so
> far..).
>
> Thanks
> David
