From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Fri, 31 Oct 2014 10:19:36 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <CABxcv=mRZj4NhiU_yCY9ih00xObLGSQErh-6_P=0c6-UuiY42w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <54534523.8080801@ti.com> <54534FAE.1060401@redhat.com>
 <CABxcv=kdRTXKE8S-M_qRo_qz_Ap-e+qz393NQseNe=rkXZrxiw@mail.gmail.com>
 <54535B8D.7040508@redhat.com>
In-Reply-To: <54535B8D.7040508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello Hans,

Thanks for your answers.

On Fri, Oct 31, 2014 at 10:51 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> What about regulators (to power the LCD), gpios (to keep the LCD
>>>> enabled) and pinctrl (for video signals)? I guess any those could be
>>>> reset by the kernel if no driver uses them.
>>>
>>> Yes this has been discussed before, AFAIK gpio / pinctrls should not be
>>> spontaneously reset by the kernels. Regulators will be a problem, but there
>>> we can pretty much follow whatever solution we end up with for clocks, since
>>> they work very much alike (e.g. we could add a supply property to the
>>> simplefb node).
>>>
>>
>> I think someone already said this but with regulators is not that easy
>> since you don't have an equivalent of the "clocks" property.
>>
>> You need a "<name>-supply" property for each regulator that is an
>> input supply. Some boards may need different regulators for their
>> display (e.g: one to power the LCD and another to power the backlight)
>> so adding a single supply property will not be enough.
>
> Right so we can simply insert simplefbvdd1-supply, simplefbvdd2-supply, etc.
> regulator nodes into the simplefb node, and have the simplefb kernel code look
> for supplies with a name of simplefb_vdd%d in a loop until it fails to find one.
>
> Note that the foo-supply names are local to the simplefb node, these do not
> need to be the same as the ones in the nodes describing the actual hardware
> blocks. Not having an array is somewhat inconvenient, but easily worked around
> and once worked around this really is just the same problem as with clocks.
>

Yes, I guess the question is how many regulators the driver should
support but I expect most displays don't need more than a couple.

>>> Note I've no intention to add regulator support atm, we can do that when the
>>> need arises, so that we can actually test the code.
>>>
>>
>> AFAIU that's exactly what Thierry was complaining about. There seems
>> to be only a focus on solving the clocks issue since that is needed
>> for sunxi but ignoring how the problem for other resources should be
>> solved.
>
> That is simply not true, I'm fully aware that we may eventually need other
> resources, e.g. regulators. I just want to take this one step at a time,
> I really believe that once we have this figured out for one resource, it
> becomes a lot easier to also figure out for other resources.
>

Great, I'm glad to hear that you are willing to add support for
regulators (and other resources).

>> The assumptions made by simplefb are quite fragile and only adding
>> support for managing clocks is just a partial solution that will give
>> a false sense of robustness since it could break later due to other
>> resources.
>
> The key word here being resources. We need to figure out how to do
> resource management for simplefb, once we have that figured out for one
> resource, the others can follow the same "design-pattern". As the long
> thread about the clocks support has shown, getting consensus on this
> with only one resource in play already is hard enough, so baby steps
> is the way to go.
>

I'm certainly not against adding clock management if that will make
simplefb more robust. I was just worried that other resources could be
ignored. But I'm ok of doing baby steps if there is a long term plan.

As I mentioned in another thread, I believe Doug's suggestion is the
best approach. That is to have the simplefb node with all its
resources in the DTS but with status = "disabled". The bootloader
should only fill the information about the framebuffer memory region
(location and size, width, height, format, etc) and change the
simplefb node status to "okay".

If a FDT does not have a simplefb node then the bootloader can create
one (like is made for the /choosen node in most bootloaders).

That will better document which resources are really used when someone
reads the DTS and also avoid duplicating code in the bootloaders to
fill all the information about resources but is just my humble opinion
and I really don't want to bikesheed more on this.

Best regards,
Javier
