From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 13 Aug 2014 09:32:10 +0000
Subject: Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <CANq1E4QwYX+XY0PUdGenqB6cUDPSTbQEKzv_6VxT=NpvuEmFFA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-4-git-send-email-libv@skynet.be>
 <CACxGe6vaPUa4QvYWBA-QY7MTmJYoeqnPt9Zh5jpky6S9UYbrvQ@mail.gmail.com>
 <CANq1E4ReOB87RX8VhnW1Ln=SK3Tw5V962ujcsfuz-2E9Uc61yQ@mail.gmail.com>
 <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
In-Reply-To: <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi

On Wed, Aug 13, 2014 at 11:23 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Wed, Aug 13, 2014 at 9:49 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> On Wed, Aug 13, 2014 at 10:40 AM, Grant Likely
>> <grant.likely@secretlab.ca> wrote:
>>> * the exception is an overlay driver which add new devices to the
>>> kernel. Definitely not the case here.
>>
>> Why?
>
> The majority of the DT code is based on the assumption of a static
> tree. Pantelis has been working on being able to modify it at runtime
> with overlays, but he has had to go through a lot of rework because it
> is not a trivial task. When you get into modifying the DT, you need to
> have a lot more understanding of the side effects to changing the
> tree. The DT structure also has a lifecycle that can go beyond the
> current lifecycle of the kernel. The kexec tool will extract the
> current tree from the kernel, make the appropriate modifications, and
> use that to boot the next kernel. Allowing any driver to modify the
> tree has side effects beyond just the current kernel.

Ok, fair enough. So we leave the DT untouched. That still allows
calling device_add() / device_del() on platform-devices, right?

> In this specific case, it will interact badly with the work Pantelis
> is doing to make platform devices work with overlays. Modifying the
> status property will cause the associated struct device to get removed
> in the middle of probing a driver for that device! That will most
> likely cause an oops.
>
> Besides, Luc straight out *said*: "...even though it has no real value
> today". In what circumstance is that justification for modifying the
> tree?

Sorry, I wasn't clear enough: I'm not arguing in favor of this patch.
I just want to figure out what to do once we implement
hardware-handover for graphics devices on non-x86 (which this series
is kinda preparing for). This patch just reminded me, that we could do
this on a DT level, instead of driver-core level. But I'm fine with
avoiding that, if you warn about complications.

Thanks
David
