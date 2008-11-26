From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [Linux-fbdev-devel] [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Wed, 26 Nov 2008 05:25:57 -0500
Message-ID: <45a44e480811260225k5dc2bedal41ccac33626f3b4c@mail.gmail.com>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
	 <492D125D.5010607@teltonika.lt>
	 <45a44e480811260118v440716bbqa8d37c8b696c148a@mail.gmail.com>
	 <Pine.LNX.4.64.0811261106180.2632@anakin>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753220AbYKZK0S@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0811261106180.2632@anakin>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, David Brownell <dbrownell@users.sourceforge.net>, linux-fbdev-devel@lists.sourceforge.net, Haavard Skinnemoen <hskinnemoen@atmel.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>, Ben Gardner <bgardner@wabtec.com>, Eric Miao <eric.miao@marvell.com>, Philipp Zabel <philipp.zabel@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.arm.linux.org.uk, Russell King <rmk@arm.linux.org.uk>

On Wed, Nov 26, 2008 at 5:08 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, 26 Nov 2008, Jaya Kumar wrote:
>> On Wed, Nov 26, 2008 at 4:09 AM, Paulius Zaleckas
>> <paulius.zaleckas@teltonika.lt> wrote:
>> > Jaya Kumar wrote:
>> >>   * @to_irq: optional hook supporting non-static gpio_to_irq() mappings;
>> >>   *   implementation may not sleep
>> >>   * @dbg_show: optional routine to show contents in debugfs; default code
>> >> @@ -84,6 +86,9 @@ struct gpio_chip {
>> >>                                               unsigned offset, int value);
>> >>       void                    (*set)(struct gpio_chip *chip,
>> >>                                               unsigned offset, int value);
>> >> +     void                    (*set_bus)(struct gpio_chip *chip,
>> >> +                                             unsigned offset, int values,
>> >
>> > I think values should be unsigned
>> >
>>
>> Okay, can do but it is unusual no? since set uses int value, i figured
>> set_bus should be similar right?
>
> ->set() sets one pin, right? So it's either 0 or 1.
>
> ->set_bus() sets multiple pins. With `int', it will fail for bit 31, as that's
> the sign bit.

I'm not sure I understood this. I imagine the usage will be like

int values = 0x8000_0000;
set_bus(..., start_pin, values);

write_32(register, values); // will still work to set bit 31
(values >> 31) == 1;

>
> Perhaps you even want u32, to make it clear what's the maximum number of pins
> you can set in one shot?

Yes, I agree, I will change to use u32 as it is then explicit.

Thanks,
jaya
