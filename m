From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 28 Oct 2014 11:30:37 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <544F7E5D.60104@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <544F737A.7000109@ti.com>
 <CAL_JsqJ2JRg7k21CEVe4-At7enD+y3TN_7wfqhY0OHZm-_j17w@mail.gmail.com>
In-Reply-To: <CAL_JsqJ2JRg7k21CEVe4-At7enD+y3TN_7wfqhY0OHZm-_j17w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/28/2014 12:11 PM, Rob Herring wrote:
> On Tue, Oct 28, 2014 at 6:44 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On 22/10/14 19:45, Hans de Goede wrote:
>>
>>> Since we seem to have broad agreement on how to move forward with this, I
>>> would like to ask you to please merge this patch-set for 3.19.
>>>
>>> I know 3.19 is still somewhat ar away, but I would like to submit the u-boot
>>> side of this to upstream ASAP, so can you please let me know if you plan to
>>> take this patch-set for 3.19 soon ?
>>
>> This series looks fine to me, except patch 3 is missing a description,
>> and patch 4 makes the desc a continuation of the subject. Each patch
>> should have a description (independent from subject).
>>
>> No need to resend, I can cook up something for those, or I can edit the
>> descs if you provide the text.
>>
>> So if there are no strong objections, I'll queue this for 3.19.
> 
> Yes, I object to the binding still as it has not changed from what was
> previously posted.

It would be helpful if you could explain why you object. Last time you
said: " You are mixing in a hardware description that is simply inaccurate."

I then explained that this is not hardware description, but runtime state
information, as it tells the kernel which clocks were chosen to drive the
display (out of typically a list of possible options, depending on which
output is used, etc.). Just like which memory address the bootloader has
chosen to scan out the video image from.

Then you got quiet, so sorry, but this time your objection really is too
late. You cannot simply go quiet halfway through a discussion and then pop
up again when a new version is posted to say "I object" yet another time,
you've had your chance to make your arguments last time, and chose to stay
quiet after I explained in detail that this is not hardware description but
state information, so now it is simply too late.

These bindings have been discussed at Plumbers with various interested people
present, and the conclusion was that this really is the best way to handle this,
so this patch is:

    Signed-off-by: Hans de Goede <hdegoede@redhat.com>
    Reviewed-by: Mike Turquette <mturquette@linaro.org>
    Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

And David Herrman who is working on simpledrm, which will be merged soon, which
will also use the simplefb bindings also agrees. So we have the simplefb maintainer,
simpledrm maintainer, and the clk subsystem maintainer + 2 other maintainers all
agreeing on a way forward, the time for bikeshedding now really really really is
over.

Tomi, can you please let us know how you plan to proceed with this ?

Regards,

Hans
