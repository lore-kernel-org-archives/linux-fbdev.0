From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Wed, 13 Aug 2014 17:26:22 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <CAKON4OxoPDCAvOK8UEeMaJDuzFfQHwb0pVbFgoqSkn=_W5pAYw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-4-git-send-email-libv@skynet.be>
 <CACxGe6vaPUa4QvYWBA-QY7MTmJYoeqnPt9Zh5jpky6S9UYbrvQ@mail.gmail.com>
 <CANq1E4ReOB87RX8VhnW1Ln=SK3Tw5V962ujcsfuz-2E9Uc61yQ@mail.gmail.com>
 <53EB95D4.6010500@wwwdotorg.org>
In-Reply-To: <53EB95D4.6010500@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 12:44 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/13/2014 02:49 AM, David Herrmann wrote:
>>
>> Hi
>>
>> On Wed, Aug 13, 2014 at 10:40 AM, Grant Likely
>> <grant.likely@secretlab.ca> wrote:
>>>
>>> On Wed, Aug 13, 2014 at 8:17 AM, Luc Verhaegen <libv@skynet.be> wrote:
>>>>
>>>> The next commit will handle clocks correctly, so that these do not get
>>>> automatically disabled on certain SoC simplefb implementations. As a
>>>> result, the removal of this simplefb driver, and the release of the
>>>> clocks, is rather final, and only a full display driver can work after
>>>> this. So, it makes sense to also flag the dt node as disabled, even
>>>> though it has no real value today.
>>>>
>>>> Signed-off-by: Luc Verhaegen <libv@skynet.be>
>>>
>>>
>>> Please, no.
>>>
>>> Drivers should not be modifying the device tree without and
>>> exceptionally good reason for doing so. Drivers are to treat the DT as
>>> immutable.
>>>
>>> * the exception is an overlay driver which add new devices to the
>>> kernel. Definitely not the case here.
>>
>>
>> Why? I think we have exactly that case:
>>   * DT describes the real hw properly and those parts are immutable
>>   * Additionally, bootloaders create firmware-framebuffers and
>>     create simple-framebuffer devices for them. Those are
>>     valid as long as no driver reconfigured the real hw.
>>   * Once a real hw-driver loads, it might destroy the existing
>>     framebuffers, thus, it should also destroy the platform device.
>>   * If the real hw-driver is unloaded, it might re-create the FB
>>     and thus create a new (or enable the old) platform device.
>
>
> My intention was always that a bootloader's addition of a simplefb node to
> the DT would be user-configurable or driven by the original DT content. As
> such, there shouldn't ever be both a DT node describing the "real" HW and
> simplefb. In other words, if the DT already has the "real" DT node, the
> bootloader should automatically (or under user command) not add the simpefb
> node.

DT is just the wrong mechanism to signal this, use an ATAG or kernel
command line parameter.

real hardware has compatible = "real-hardware-name, simplefb"

simplefb is built into kernel. It will attach to the device because of
the compatible string. Then it can look at the command line and see if
the bootloader also supported simplefb and already set things up.

Then some mechanism will have to be designed to arrange a handoff
between simplefb and the chip specific KMS driver. But that's a Linux
problem, not a DT one.

>
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Jon Smirl
jonsmirl@gmail.com
