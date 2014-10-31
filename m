From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 31 Oct 2014 09:51:09 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <54535B8D.7040508@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>	<54534523.8080801@ti.com>	<54534FAE.1060401@redhat.com>
 <CABxcv=kdRTXKE8S-M_qRo_qz_Ap-e+qz393NQseNe=rkXZrxiw@mail.gmail.com>
In-Reply-To: <CABxcv=kdRTXKE8S-M_qRo_qz_Ap-e+qz393NQseNe=rkXZrxiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/31/2014 10:37 AM, Javier Martinez Canillas wrote:
> Hello Hans,
> 
> On Fri, Oct 31, 2014 at 10:00 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Tomi,
>>
>> On 10/31/2014 09:15 AM, Tomi Valkeinen wrote:
>>> Hi Hans,
>>>
>>> On 22/10/14 19:45, Hans de Goede wrote:
>>>
>>>> -We will add a clocks property to the simplefb devicetree bindings, so
>>>>  that u-boot setup framebuffers passed to the kernel (for early console
>>>>  support) can properly list the clocks used, and simplefb can claim them to
>>>>  avoid them getting turned off, thereby breaking the early console
>>>
>>> Perhaps this has been discussed earlier, but I started to wonder if
>>> managing clocks is enough.
>>>
> 
> Managing clocks is definitely not enough. For example, adding some
> regulators to the Snow Chromebook DTS broke simplefb [0]. This has
> been mentioned on at least one of the many simplefb threads.

Ok.

>>> What about regulators (to power the LCD), gpios (to keep the LCD
>>> enabled) and pinctrl (for video signals)? I guess any those could be
>>> reset by the kernel if no driver uses them.
>>
>> Yes this has been discussed before, AFAIK gpio / pinctrls should not be
>> spontaneously reset by the kernels. Regulators will be a problem, but there
>> we can pretty much follow whatever solution we end up with for clocks, since
>> they work very much alike (e.g. we could add a supply property to the
>> simplefb node).
>>
> 
> I think someone already said this but with regulators is not that easy
> since you don't have an equivalent of the "clocks" property.
> 
> You need a "<name>-supply" property for each regulator that is an
> input supply. Some boards may need different regulators for their
> display (e.g: one to power the LCD and another to power the backlight)
> so adding a single supply property will not be enough.

Right so we can simply insert simplefbvdd1-supply, simplefbvdd2-supply, etc.
regulator nodes into the simplefb node, and have the simplefb kernel code look
for supplies with a name of simplefb_vdd%d in a loop until it fails to find one.

Note that the foo-supply names are local to the simplefb node, these do not
need to be the same as the ones in the nodes describing the actual hardware
blocks. Not having an array is somewhat inconvenient, but easily worked around
and once worked around this really is just the same problem as with clocks.

>> Note I've no intention to add regulator support atm, we can do that when the
>> need arises, so that we can actually test the code.
>>
> 
> AFAIU that's exactly what Thierry was complaining about. There seems
> to be only a focus on solving the clocks issue since that is needed
> for sunxi but ignoring how the problem for other resources should be
> solved.

That is simply not true, I'm fully aware that we may eventually need other
resources, e.g. regulators. I just want to take this one step at a time,
I really believe that once we have this figured out for one resource, it
becomes a lot easier to also figure out for other resources.

> The assumptions made by simplefb are quite fragile and only adding
> support for managing clocks is just a partial solution that will give
> a false sense of robustness since it could break later due to other
> resources.

The key word here being resources. We need to figure out how to do
resource management for simplefb, once we have that figured out for one
resource, the others can follow the same "design-pattern". As the long
thread about the clocks support has shown, getting consensus on this
with only one resource in play already is hard enough, so baby steps
is the way to go.

Regards,

Hans
