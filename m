From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Wed, 26 Nov 2008 04:18:27 -0500
Message-ID: <45a44e480811260118v440716bbqa8d37c8b696c148a@mail.gmail.com>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
	 <492D125D.5010607@teltonika.lt>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753405AbYKZJSs@vger.kernel.org>
In-Reply-To: <492D125D.5010607@teltonika.lt>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Cc: David Brownell <dbrownell@users.sourceforge.net>, David Brownell <david-b@pacbell.net>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, Nov 26, 2008 at 4:09 AM, Paulius Zaleckas
<paulius.zaleckas@teltonika.lt> wrote:
> Jaya Kumar wrote:
>>   * @to_irq: optional hook supporting non-static gpio_to_irq() mappings;
>>   *   implementation may not sleep
>>   * @dbg_show: optional routine to show contents in debugfs; default code
>> @@ -84,6 +86,9 @@ struct gpio_chip {
>>                                               unsigned offset, int value);
>>       void                    (*set)(struct gpio_chip *chip,
>>                                               unsigned offset, int value);
>> +     void                    (*set_bus)(struct gpio_chip *chip,
>> +                                             unsigned offset, int values,
>
> I think values should be unsigned
>

Okay, can do but it is unusual no? since set uses int value, i figured
set_bus should be similar right?

Thanks,
jaya
