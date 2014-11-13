From: Grant Likely <grant.likely@linaro.org>
Date: Thu, 13 Nov 2014 16:07:18 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v3 1/4] dt-bindings: simplefb: Specify node location and handoff relate
Message-Id: <CACxGe6tA90T+nj5aBbWWd4SJVofzKLY9AS2cXeqUJyAVMYECbw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
 <5464C026.7030300@ti.com> <5464C444.4050101@redhat.com>
 <5464D3C7.7060707@ti.com>
In-Reply-To: <5464D3C7.7060707@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 13, 2014 at 3:52 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 13/11/14 16:46, Hans de Goede wrote:
>> Hi,
>>
>> On 11/13/2014 03:28 PM, Tomi Valkeinen wrote:
>>> On 13/11/14 15:34, Hans de Goede wrote:
>>>
>>>> +chosen {
>>>> +   framebuffer0: framebuffer@5fc00000 {
>>>>             compatible = "simple-framebuffer";
>>>> -           reg = <0x1d385000 (1600 * 1200 * 2)>;
>>>> +           reg = <0x5fc00000 (4096 * 1024)>;
>>>
>>> Was there a reason for this change?
>>
>> I changed the node name to match the new bindings text which
>> specifies that the node name must be framebuffer@<address>,
>> while at it I've taken a real world address range.
>>
>> I assume you refer to the bit where the size of the reg property
>> is changed ? That indeed is not really necessary.
>
> Yes, I meant the size of the reg prop. As this is an example, I think it
> should be as clear as possible.
>
> I guess a valid use case here is to set the size to larger-than-needed,
> so that it gets preallocated and you don't need to worry about getting
> the memory later when the system has already been running for a longer
> time. But if that's the case in this example, I think it would be better
> to describe it explicitly.

Besides, we already have a mechanism for that called /reserved-memory.
Any memory used by a framebuffer needs to be described in the reserved
map anyway, and that region can be made larger than the firmware
configured framebuffer.

g.
