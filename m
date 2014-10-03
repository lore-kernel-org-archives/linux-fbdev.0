From: Rob Herring <robherring2@gmail.com>
Date: Fri, 03 Oct 2014 16:19:52 +0000
Subject: Re: [PATCH v3] dt-bindings: Add a clocks property to the simple-framebuffer binding
Message-Id: <CAL_Jsq+_uFAQ-LjRtmqTW8CQvAwUVkYNu6STVEgeqsHA684rtw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412345120-24588-1-git-send-email-hdegoede@redhat.com>
 <CAL_JsqKU2n8p=YfJua3k-mR40bG_4SiZY8_-SL-MXtuWN5NeHg@mail.gmail.com>
 <CAMuHMdVgaXoGXyJdD8PRufZQYLTSY=_ZWRRo=OtRo3mrg3uEug@mail.gmail.com>
In-Reply-To: <CAMuHMdVgaXoGXyJdD8PRufZQYLTSY=_ZWRRo=OtRo3mrg3uEug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 3, 2014 at 11:04 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Rob,
>
> On Fri, Oct 3, 2014 at 5:57 PM, Rob Herring <robherring2@gmail.com> wrote:
>> On Fri, Oct 3, 2014 at 9:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> A simple-framebuffer node represents a framebuffer setup by the firmware /
>>> bootloader. Such a framebuffer may have a number of clocks in use, add a
>>> property to communicate this to the OS.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>>
>>> --
>>> Changes in v2:
>>> -Added Reviewed-by: Mike Turquette <mturquette@linaro.org>
>>> Changes in v3:
>>> -Updated description to make clear simplefb deals with more then just memory
>>
>> NAK. "Fixing" the description is not what I meant and does not address
>> my concerns. Currently, simplefb is configuration data. It is
>> auxiliary data about how a chunk of memory is used. Using it or not
>> has no side effects on the hardware setup, but you are changing that
>> aspect. You are mixing in a hardware description that is simply
>> inaccurate.
>>
>> The kernel has made the decision to turn off "unused" clocks. If its
>> determination of what is unused is wrong, then it is not a problem to
>> fix in DT.
>
> The kernel has made that decision because the driver hadn't told the
> kernel that those clocks had to be enabled.
> The only way for the driver to know which clocks to enable is by adding
> them to the description in DT.

Lack of a proper and complete driver is still a kernel problem. Now,
if you want to accurately describe the display h/w in DT and you
happen to use the simplefb driver, I don't really care. It just needs
to be a separate binding.

A driver is not the only solution here. The SOC or clock controller
code could keep the clock on based on either the fact that the clock
is already on or it is just hardcoded. This is not a problem unique to
displays.

Rob
