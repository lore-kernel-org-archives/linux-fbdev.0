From: Grant Likely <grant.likely@linaro.org>
Date: Thu, 13 Nov 2014 12:36:01 +0000
Subject: Re: [PATCH v2 1/4] dt-bindings: simplefb: Specify node location and handoff related properties
Message-Id: <CACxGe6tra-G3-FV0FJcfXNEVgJNdsR+NvzALM34_XymP93icGg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415868610-13297-1-git-send-email-hdegoede@redhat.com>
 <CACxGe6uX7V-TcZfM0vP4SvjxKx3T_RGByX8wFqTdFo4LEzP2Yg@mail.gmail.com>
 <5464A0A2.1080503@redhat.com>
In-Reply-To: <5464A0A2.1080503@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 13, 2014 at 12:14 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 11/13/2014 12:02 PM, Grant Likely wrote:
>> On Thu, Nov 13, 2014 at 8:50 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> Since simplefb nodes do not relate directly to hw typically they have been
>>> placed in the root of the devicetree. As the represent runtime information
>>> having them as sub-nodes of /chosen is more logical, specify this.
>>>
>>> Also specify when to set the chosen stdout-path property to a simplefb node.
>>>
>>> For reliable handover to a hardware specific driver, that driver needs to
>>> know which simplefb to unregister when taking over, specify how the hw driver
>>> can find the matching simplefb node.
>>>
>>> Last add some advice on how to fill and use simplefb nodes from a firmware
>>> pov.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> --
>>> Changes in v2:
>>> -Add stdout-path to the example code
>>> ---
>>>  .../bindings/video/simple-framebuffer.txt          | 38 +++++++++++++++++++++-
>>>  1 file changed, 37 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
>>> index 8f35718..8b7ecf6 100644
>>> --- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
>>> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
>>> @@ -4,6 +4,26 @@ A simple frame-buffer describes a frame-buffer setup by firmware or
>>>  the bootloader, with the assumption that the display hardware has already
>>>  been set up to scan out from the memory pointed to by the reg property.
>>>
>>> +Since simplefb nodes represent runtime information they must be sub-nodes of
>>> +the chosen node (*). The primary display node must be named framebuffer0,
>>> +additional nodes must be called framebuffer1, etc.
>>
>> Thinking more about our conversation yesterday, the preferred name
>> should still be framebuffer@<address>. There is no reason to break
>> with established convention, and as mentioned in my reply on patch #2,
>> using the name is not the preferred way to identify a device node. So,
>> my recommendation is to prefer the name "framebuffer@<addr>", but if
>> it is inconvenient because the address isn't known, then
>> "framebuffer#" is acceptable.
>
> Since we want to use pre-filled simplefb nodes already present in the devicetree,
> and u-boot is the one chosing the framebuffer address we don't know the
> address to put in the dts file beforehand, so framebuffer# it is.

fdt_set_name() is available to U-Boot to rename a node. :-)

Prepopulating with /chosen/framebuffer#, and then renaming to
/chosen/framebuffer@<addr> is perfectly reasonable.

g.
