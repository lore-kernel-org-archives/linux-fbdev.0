From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 11 Nov 2014 21:54:30 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock =?iso-8859-1?Q?handling=0D?= code
Message-Id: <20141111215430.3FA41C41610@trevor.secretlab.ca>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <54534523.8080801@ti.com> <545B8338.8060908@ti.com>
 <545B8E29.90807@redhat.com>
In-Reply-To: <545B8E29.90807@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 06 Nov 2014 16:05:13 +0100
, Hans de Goede <hdegoede@redhat.com>
 wrote:
> Hi,
> 
> On 11/06/2014 03:18 PM, Tomi Valkeinen wrote:
> > On 31/10/14 10:15, Tomi Valkeinen wrote:
> >> Hi Hans,
> >>
> >> On 22/10/14 19:45, Hans de Goede wrote:
> >>
> >>> -We will add a clocks property to the simplefb devicetree bindings, so
> >>>  that u-boot setup framebuffers passed to the kernel (for early console
> >>>  support) can properly list the clocks used, and simplefb can claim them to
> >>>  avoid them getting turned off, thereby breaking the early console
> >>
> >> Perhaps this has been discussed earlier, but I started to wonder if
> >> managing clocks is enough.
> >>
> >> What about regulators (to power the LCD), gpios (to keep the LCD
> >> enabled) and pinctrl (for video signals)? I guess any those could be
> >> reset by the kernel if no driver uses them.

I'm okay with extending the binding for each of these dependencies
/providing/ it can be argued that the way simplefb uses it is merely to
inhibit the kernel from making any changes to the resource, and then
releasing the resource when it is done. Each resource type will need to
be taken on a case-by-case basis since each has it's own behaviour. I'll
want to see that the simplefb driver doesn't need to do anything special
per device, and that the resource binding is well established and
generic.

g.

