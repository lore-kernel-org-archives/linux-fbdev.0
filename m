From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 31 Oct 2014 09:00:30 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <54534FAE.1060401@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <54534523.8080801@ti.com>
In-Reply-To: <54534523.8080801@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Tomi,

On 10/31/2014 09:15 AM, Tomi Valkeinen wrote:
> Hi Hans,
> 
> On 22/10/14 19:45, Hans de Goede wrote:
> 
>> -We will add a clocks property to the simplefb devicetree bindings, so
>>  that u-boot setup framebuffers passed to the kernel (for early console
>>  support) can properly list the clocks used, and simplefb can claim them to
>>  avoid them getting turned off, thereby breaking the early console
> 
> Perhaps this has been discussed earlier, but I started to wonder if
> managing clocks is enough.
> 
> What about regulators (to power the LCD), gpios (to keep the LCD
> enabled) and pinctrl (for video signals)? I guess any those could be
> reset by the kernel if no driver uses them.

Yes this has been discussed before, AFAIK gpio / pinctrls should not be
spontaneously reset by the kernels. Regulators will be a problem, but there
we can pretty much follow whatever solution we end up with for clocks, since
they work very much alike (e.g. we could add a supply property to the
simplefb node).

Note I've no intention to add regulator support atm, we can do that when the
need arises, so that we can actually test the code.

Regards,

Hans
