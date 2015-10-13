From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 13 Oct 2015 07:08:46 +0000
Subject: Re: [PATCH RFC 1/2] dt-bindings: simplefb: Support a list of regulator supply properties
Message-Id: <561CADFE.2010609@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444669458-5588-1-git-send-email-wens@csie.org>
 <1444669458-5588-2-git-send-email-wens@csie.org>
 <20151012171018.GB3659@leverpostej>
 <CAGb2v651=uaHEQK4wpEQywgr311NSbqEvYkpsC5zSHPSFq-HHg@mail.gmail.com>
In-Reply-To: <CAGb2v651=uaHEQK4wpEQywgr311NSbqEvYkpsC5zSHPSFq-HHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 13-10-15 04:22, Chen-Yu Tsai wrote:
> On Tue, Oct 13, 2015 at 1:10 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Tue, Oct 13, 2015 at 01:04:17AM +0800, Chen-Yu Tsai wrote:
>>> The physical display tied to the framebuffer may have regulators
>>> providing power to it, such as power for LCDs or interface conversion
>>> chips.
>>>
>>> The number of regulators in use may vary, but the regulator supply
>>> binding can not be a list. Work around this by adding a "num-supplies"
>>> property to communicate the number of supplies, and a list of 0 ~ N
>>> "vinN-supply" properties for the actual regulator supply.
>>
>> This is getting more complicated by the minute...
>
> Yeah...
>
> I considered "backlight" and "panel" properties, but that seems to need
> more effort to parse. Regulators seemed easier.
>
>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>   .../devicetree/bindings/video/simple-framebuffer.txt       | 14 ++++++++++----
>>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
>>> index 4474ef6e0b95..0cc43e1be8b5 100644
>>> --- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
>>> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
>>> @@ -47,10 +47,14 @@ Required properties:
>>>     - a8b8g8r8 (32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r).
>>>
>>>   Optional properties:
>>> -- clocks : List of clocks used by the framebuffer. Clocks listed here
>>> -           are expected to already be configured correctly. The OS must
>>> -           ensure these clocks are not modified or disabled while the
>>> -           simple framebuffer remains active.
>>> +- clocks : List of clocks used by the framebuffer.
>>> +- num-supplies : The number of regulators used by the framebuffer.
>>> +- vinN-supply : The N-th (from 0) regulator used by the framebuffer.
>>
>> I don't see why you need num-supplies. Why not just try probing
>> vin${N}-supply until such a property isn't present in the DT?

+1 for this.

> That's doable. Though I'd add a hard limit on it. Does 16 seem reasonable?

I would not add a hard limit to the binding, you can use a fixed array in
the code to make the code simpler. I would say 8 should be sufficient, since
the limit will only be in the code we can always bump it when we need to.

Regards,

Hans
