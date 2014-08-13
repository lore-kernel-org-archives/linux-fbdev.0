From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 13 Aug 2014 16:44:04 +0000
Subject: Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <53EB95D4.6010500@wwwdotorg.org>
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

On 08/13/2014 02:49 AM, David Herrmann wrote:
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
> Why? I think we have exactly that case:
>   * DT describes the real hw properly and those parts are immutable
>   * Additionally, bootloaders create firmware-framebuffers and
>     create simple-framebuffer devices for them. Those are
>     valid as long as no driver reconfigured the real hw.
>   * Once a real hw-driver loads, it might destroy the existing
>     framebuffers, thus, it should also destroy the platform device.
>   * If the real hw-driver is unloaded, it might re-create the FB
>     and thus create a new (or enable the old) platform device.

My intention was always that a bootloader's addition of a simplefb node 
to the DT would be user-configurable or driven by the original DT 
content. As such, there shouldn't ever be both a DT node describing the 
"real" HW and simplefb. In other words, if the DT already has the "real" 
DT node, the bootloader should automatically (or under user command) not 
add the simpefb node.
