From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 14 Nov 2014 10:30:09 +0000
Subject: Re: [PATCH 4/7] ARM: dts: sun6i: Add simplefb node
Message-Id: <5465D9B1.8010707@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
 <1415871109-28332-4-git-send-email-hdegoede@redhat.com>
 <20141113164606.GM20972@lukather> <5464EFF9.9010203@redhat.com>
 <20141114102417.GY20972@lukather>
In-Reply-To: <20141114102417.GY20972@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/14/2014 11:24 AM, Maxime Ripard wrote:
> On Thu, Nov 13, 2014 at 06:52:57PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11/13/2014 05:46 PM, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Thu, Nov 13, 2014 at 10:31:46AM +0100, Hans de Goede wrote:
>>>> Add a simplefb template node for u-boot to further fill and activate.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>>>> index 543f895..438952e 100644
>>>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>>>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>>>> @@ -62,6 +62,16 @@
>>>>  		ethernet0 = &gmac;
>>>>  	};
>>>>  
>>>> +	chosen {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <1>;
>>>> +		ranges;
>>>> +
>>>> +		framebuffer0 {
>>>> +			compatible = "simple-framebuffer";
>>>> +			status = "disabled";
>>>
>>> Aren't we suppose to have clocks in there too?
>>
>> I deliberately left them out as they are not needed on sun6i, once the blocks
>> are setup ahb access is not necessary, but it seems that the ahb_gate bits
>> in sun4i / sun5i / sun7i double as a reset. Toggling them on / off / on breaks
>> the mode, while toggling module clocks on / off / on only causes a glitch.
>>
>> Since the sun6i has a separate reset controller, the clock gates seem to really
>> only control ahb access which is not necessary once the mode has been set up.
> 
> Ok. That can always be changed in the future if we ever find we need
> them anyway.
> 
> I'll merge these four patches as soon as the bindings doc is
> acked-by/merged by Grant or any other DT maintainer.

Note these patches are using framebuffer0 rather then framebuffer0-hdmi as node
name, which may cause issues if we later want to add lcd support. So I've a v2
coming which changes the name to framebuffer0-hdmi, please merge that instead.

Regards,

Hans
