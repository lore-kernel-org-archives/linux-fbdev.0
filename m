From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 12:29:37 +0000
Subject: Re: [PATCH v2 1/4] dt-bindings: simplefb: Specify node location and handoff related properties
Message-Id: <5464A431.2050706@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415868610-13297-1-git-send-email-hdegoede@redhat.com>
 <CACxGe6uX7V-TcZfM0vP4SvjxKx3T_RGByX8wFqTdFo4LEzP2Yg@mail.gmail.com>
 <CACxGe6uPKcZ4XqdiPQtia-0D+BnqjDE3eW-oDCR+byUrVtNpSg@mail.gmail.com>
In-Reply-To: <CACxGe6uPKcZ4XqdiPQtia-0D+BnqjDE3eW-oDCR+byUrVtNpSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/13/2014 01:03 PM, Grant Likely wrote:
> On Thu, Nov 13, 2014 at 11:02 AM, Grant Likely <grant.likely@linaro.org> wrote:
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
>> "framebuffer#" is acceptable. Then use /aliases for actual enumeration
>> which has the advantage of also working for framebuffers that aren't
>> in /chosen.
> 
> Some more thoughts about aliases.
> 
> There is a natural tension between enumerate framebuffers or
> enumerating displays. There is precedence for displays to be named
> 'display...' and to use /aliases/display* to enumerate them. What do
> we do for framebuffers? Does it make sense to have a separate
> /aliases/framebuffer* enumeration, or would it be better to have a
> single 'display' namespace so that the same name is used right
> through?
> 
> Right now I'm leaning towards using /aliases/display* for everything,
> and making simplefb understand that /aliases/display# could either
> point directly to the framebuffer when there is not node for the
> hardware, or point to the display node. This would make it easy to
> have consistent names for display. For example, with the kexec
> scenario, if /aliases/display0 points at the display node then the
> alias won't need to be changed between first boot when firmware sets
> up a framebuffer, and kexec boot after the kernel has torn down the
> original framebuffer. If /aliases/display0 points to the framebuffer
> node directly, then the linkage from /aliases/display0 to the HW
> display node will be lost when the framebuffer gets torn down.
> 
> Doing it this way does make two assumptions though. It assumes that
> each display will have its own node somewhere so that no two
> framebuffers will point to the same node. Second, it assumes that we
> have a mechanism to handoff a display name (/dev/fb*)? from simplefb
> to another device. I don't know enough about the fbdev subsystem to
> know whether or not this will be a problem. Or if there are any
> namespace conflicts between fbdev and drm.
> 
> Implementation would be simple to do. If the simple framebuffer node
> has a 'display' property, then it will call of_alias_get_id() on the
> target of that phandle. Otherwise it will call of_alias_get_id() on
> itself.
> 
> Thoughts?

Re-using display# aliases, and specifying that if the simplefb node has
a display property, that then the id of the node the display property
points to should be used, and otherwise the id of the simplefb node itself
sounds like a good idea.

I'll go work on a v3 and put this in (and update the example for this
as well).

Regards,

Hans
