From: Hans Verkuil <hansverk@cisco.com>
Date: Fri, 12 Aug 2016 15:53:17 +0000
Subject: Re: [PATCH RFC 5/5] drm/i2c: add tda998x/tda9950 CEC driver
Message-Id: <7722d4a0-03f6-3858-0771-e6598d838b65@cisco.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEx-0004ry-Jg@rmk-PC.armlinux.org.uk>
 <a9bc07ee-ae77-1791-ccf8-cb654cd4c302@cisco.com>
 <f656e9b9-edb1-f6d7-bf64-7d608f2f3890@cisco.com>
 <20160812152939.GG1041@n2100.armlinux.org.uk>
In-Reply-To: <20160812152939.GG1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On 08/12/2016 05:29 PM, Russell King - ARM Linux wrote:
> On Fri, Aug 12, 2016 at 05:16:41PM +0200, Hans Verkuil wrote:
>> On 08/12/2016 04:38 PM, Hans Verkuil wrote:
>>> On 08/12/2016 04:15 PM, Russell King wrote:
>>>> Add a CEC driver for the TDA9950, which is a stand-alone I2C CEC device.
>>>> The TDA9950 contains a command processor which handles retransmissions
>>>> and the low level bus protocol.  The driver just has to read and write
>>>> the messages, and handle error conditions.
>>>>
>>>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>>>> ---
>>>> drivers/gpu/drm/i2c/Kconfig           |   5 +
>>>> drivers/gpu/drm/i2c/Makefile          |   1 +
>>>> drivers/gpu/drm/i2c/tda9950.c         | 514 ++++++++++++++++++++++++++++++++++
>>>> include/linux/platform_data/tda9950.h |  15 +
>>>> 4 files changed, 535 insertions(+)
>>>> create mode 100644 drivers/gpu/drm/i2c/tda9950.c
>>>> create mode 100644 include/linux/platform_data/tda9950.h
>>>>
>>>
>>> <snip>
>>>
>>>> +static int tda9950_cec_adap_log_addr(struct cec_adapter *adap, u8 addr)
>>>> +{
>>>> +    struct tda9950_priv *priv = adap->priv;
>>>> +    u16 addresses;
>>>> +    u8 buf[2];
>>>> +
>>>> +    if (addr = CEC_LOG_ADDR_INVALID)
>>>> +        addresses = priv->addresses = BIT(15);
>>>
>>> I saw this in patch 4/5 as well: why set bit 15? I would expect that this
>>> is just set to 0. And priv->addresses doesn't seem to be used anywhere.
>>
>> Yeah, you are right, priv->addresses is used. I've been reviewing too many
>> patches today.
>>
>> The whole BIT(15) part remains weird. If log_addr is called with
>> LOG_ADDR_INVALID as argument, then the intention is that no more
>> messages are to be received (unless the hardware is in snooping mode).
>> So there is no need to receive broadcast messages either.
>
> What about hardware where you can't stop it receiving broadcast
> addresses?  Should drivers manually check for this in their
> interrupt handler?
>
>> That said, I now realize that if userspace wants to configure the CEC
>> device as 'Unregistered', then adap_log_addr is never called, which
>> would be required if the hardware has to enable support to receive
>> broadcast messages.
>
> I don't see how that could possibly work.  The CEC specification
> requires that we receive broadcast addressed messages so that (eg)
> the current source can be tracked.  Being present on the bus, and
> participating as an active source requires the reception of
> broadcast messages so that you know when you stop being an active
> source.
>
> Nothing (afaics) enables broadcast address reception in the kernel
> side, nor using cec-ctl in userspace.

There are three possible 'states' of a CEC adapter w.r.t. logical addresses:

1) There is no physical address or no logical addresses have been set
by the application (CEC_ADAP_S_LOG_ADDRS): in that case the device
will not participate on the bus, it doesn't care about receiving messages
let alone replying to them. The only exception is if the device can
snoop messages, that is allowed even if CEC_ADAP_S_LOG_ADDRS is never
called. That is ideal to have a 'neutral' observer of the bus that just
listens but never participates. Not all hardware supports snooping, though.

2) CEC_ADAP_S_LOG_ADDRS is called and the device becomes an 'Unregistered'
device (i.e. it gets logical address 15). In that case it should receive
broadcast messages and be able to transmit messages.

3) CEC_ADAP_S_LOG_ADDRS is called and the device claims one or more logical
addresses in the range 0-14. Then it can receive broadcast and directed
messages, and of course transmit messages.

 From the point of view of the hardware state 1 is selected if adap_log_addr
is called with LOG_ADDR_INVALID. Some hardware might still receive broadcast
messages (because they can't turn that off) and those should be filtered out
by the CEC framework. But I think that doesn't happen, which would be a bug.
I'll verify that tomorrow.

State 2 is a problem for hardware that has to enable support to receive
broadcast messages since adap_log_addr is never called with
LOG_ADDR_UNREGISTERED as argument. I missed that, since the hardware I tested
with always accepts broadcast messages. I'll look into this tomorrow as well.
It should be easy to fix.

State 3 works OK.

So for the dw-hdmi cec driver that means that for state 1 you set 'addresses'
to 0, for state 2 you set it to BIT(15) and for state 3 you always
OR with BIT(15). At least, as I understand your hardware.

BTW, if either the tda or dw-hdmi supports snooping mode, then I strongly
recommend supporting that. It's great for debugging.

Regards,

	Hans

>
>>>> +    else
>>>> +        addresses = priv->addresses |= BIT(addr);
>>>> +
>>>> +    /* TDA9950 doesn't want address 15 set */
>>>> +    addr &= 0x7fff;
>>
>> Shouldn't this be 'addresses' instead of 'addr'? 'addr' makes no sense here.
>>
>> And if so, then I still don't understand setting BIT(15), since that bit is
>> removed by the &=.
>
> You're right in this case, but for dw-hdmi, bit 15 must be set for
> broadcast messages to be received.
>

