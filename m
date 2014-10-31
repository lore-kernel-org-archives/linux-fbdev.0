From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Fri, 31 Oct 2014 09:37:49 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <CABxcv=kdRTXKE8S-M_qRo_qz_Ap-e+qz393NQseNe=rkXZrxiw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <54534523.8080801@ti.com> <54534FAE.1060401@redhat.com>
In-Reply-To: <54534FAE.1060401@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello Hans,

On Fri, Oct 31, 2014 at 10:00 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Tomi,
>
> On 10/31/2014 09:15 AM, Tomi Valkeinen wrote:
>> Hi Hans,
>>
>> On 22/10/14 19:45, Hans de Goede wrote:
>>
>>> -We will add a clocks property to the simplefb devicetree bindings, so
>>>  that u-boot setup framebuffers passed to the kernel (for early console
>>>  support) can properly list the clocks used, and simplefb can claim them to
>>>  avoid them getting turned off, thereby breaking the early console
>>
>> Perhaps this has been discussed earlier, but I started to wonder if
>> managing clocks is enough.
>>

Managing clocks is definitely not enough. For example, adding some
regulators to the Snow Chromebook DTS broke simplefb [0]. This has
been mentioned on at least one of the many simplefb threads.

>> What about regulators (to power the LCD), gpios (to keep the LCD
>> enabled) and pinctrl (for video signals)? I guess any those could be
>> reset by the kernel if no driver uses them.
>
> Yes this has been discussed before, AFAIK gpio / pinctrls should not be
> spontaneously reset by the kernels. Regulators will be a problem, but there
> we can pretty much follow whatever solution we end up with for clocks, since
> they work very much alike (e.g. we could add a supply property to the
> simplefb node).
>

I think someone already said this but with regulators is not that easy
since you don't have an equivalent of the "clocks" property.

You need a "<name>-supply" property for each regulator that is an
input supply. Some boards may need different regulators for their
display (e.g: one to power the LCD and another to power the backlight)
so adding a single supply property will not be enough.

> Note I've no intention to add regulator support atm, we can do that when the
> need arises, so that we can actually test the code.
>

AFAIU that's exactly what Thierry was complaining about. There seems
to be only a focus on solving the clocks issue since that is needed
for sunxi but ignoring how the problem for other resources should be
solved.

The assumptions made by simplefb are quite fragile and only adding
support for managing clocks is just a partial solution that will give
a false sense of robustness since it could break later due to other
resources.

Best regards,
Javier

[0]: http://www.spinics.net/lists/arm-kernel/msg360119.html
