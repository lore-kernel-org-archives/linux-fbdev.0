From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 06 Nov 2014 15:05:13 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <545B8E29.90807@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <54534523.8080801@ti.com> <545B8338.8060908@ti.com>
In-Reply-To: <545B8338.8060908@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/06/2014 03:18 PM, Tomi Valkeinen wrote:
> On 31/10/14 10:15, Tomi Valkeinen wrote:
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
>> What about regulators (to power the LCD), gpios (to keep the LCD
>> enabled) and pinctrl (for video signals)? I guess any those could be
>> reset by the kernel if no driver uses them.
> 
> Hans, ping. Have these been already discussed?

Yes, and I already responded to your original mail on this on Oct. 31th,
for some reason my mail client drops you from the CC, when I do a reply-to-all
to one of your mails (I've added you manually this time).

My replies did go to simple-fb@vger.kernel.org .I'll forward my 2 mails on this
to you.

Regards,

Hans
