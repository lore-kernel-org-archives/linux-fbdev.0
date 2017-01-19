From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 19 Jan 2017 08:24:00 +0000
Subject: Re: [PATCH v2 2/5] fbdev: ssd1307fb: Remove reset-active-low from the DT binding document
Message-Id: <c7148c49-ea1f-1ff5-d2da-0e55cf626d8a@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484303628.git.jsarha@ti.com>
 <b68e1b9b735543b9e1511cfeb8e5d9ceec6c7666.1484303628.git.jsarha@ti.com>
 <20170118222804.ifqkkffot5n55gsk@rob-hp-laptop>
In-Reply-To: <20170118222804.ifqkkffot5n55gsk@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org

On 01/19/17 00:28, Rob Herring wrote:
> On Fri, Jan 13, 2017 at 12:35:46PM +0200, Jyri Sarha wrote:
>> Remove reset-active-low from the devicetree binding document. The actual
>> implementation has never been there in the driver code and there is no
>> reason to add it because the gpiod API supports gpio flags, including
>> GPIO_ACTIVE_LOW, directly trough its own devicetree binding.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
>> index eb31ed4..4aee67f 100644
>> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
>> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
>> @@ -8,14 +8,14 @@ Required properties:
>>           0x3c or 0x3d
>>    - pwm: Should contain the pwm to use according to the OF device tree PWM
>>           specification [0]. Only required for the ssd1307.
>> -  - reset-gpios: Should contain the GPIO used to reset the OLED display
>> +  - reset-gpios: Should contain the GPIO used to reset the OLED display. See
>> +                 Documentation/devicetree/bindings/gpio/gpio.txt for details.
> You need to define the active state. Does the active state actually 
> vary? Sounds like the compatible is not specific enough unless some 
> boards have an inverter.
> 

No, I am not aware of the active state ever varying. For some reason
someone specified the reset-active-low, but probably in the end it was
not needed after all because the implementation was not added.

The only reason I can think of why the reset gpio would need active low
flag is very weird board design or broken gpio driver.

Best regards,
Jyri
