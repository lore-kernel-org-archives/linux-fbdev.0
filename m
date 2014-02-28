From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Fri, 28 Feb 2014 13:56:48 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <531095A0.5040307@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com> <531087C0.1090501@gmail.com> <1393595264.3802.39.camel@paszta.hi.pengutronix.de>
In-Reply-To: <1393595264.3802.39.camel-+qGW7pzALmz7o/J7KWpOmN53zsg1cpMQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 02/28/14 14:47, Philipp Zabel wrote:
> Am Freitag, den 28.02.2014, 13:57 +0100 schrieb Sebastian Hesselbarth:
>> On 02/28/14 13:20, Tomi Valkeinen wrote:
>>> This series is a re-send of
>>> http://article.gmane.org/gmane.linux.drivers.devicetree/61739
>>>
>> ...
>>> Shortly about the display components in the series, in the order of probable
>>> public interest:
>>>
>>> * Analog TV, DVI and HDMI Connectors represent a respective connector on the
>>>     board. They don't do much, but they do mark the end of the video pipeline (from
>>>     the board's pov), and they should also in the future offer ways to handle
>>>     things like the +5V pin on DVI and HDMI connector and HPD pin.
>>>
>>> * MIPI DPI panel and MIPI DSI CM panels represent bindings for simple panels
>>>     using the respective video bus.
>>>
>>> * Sony acx565akm is an SPI controlled panel using flatlink video bus.
>>>
>>> * TFP410 is a DPI to DVI encoder.
>>>
>>> * TPD12S015 is a HDMI companion chip, used on OMAP boards.
>>
>> Tomi,
>>
>> Out of curiosity, will there be DT nodes for pull-up resistors soon,
>> too? ;)
>>
>> Honestly, TPD12S015 is a level shifter, there is nothing in it that
>> would justify a DT node nor a driver.
>>
>> Above you already note, that connector nodes should offer HPD in the
>> future, but I guess the binding should represent that now already.
>> I will be a DT stub anyway, the corresponding video sink driver will
>> have to look it up.
>>
>> Looking through the bindings for DVI and HDMI, I guess HPD gpio is
>> better kept in those nodes. From the relevant (DT) properties DVI and
>> HDMI connectors are in no way different.
>
> I like the idea of adding actual connector nodes to the board device
> trees. A TV encoder driver for example could this way detect from the
> device tree whether it is connected to a VGA, Composite, or S-Video
> connector (or maybe to both Composite and S-Video connectors at the same
> time).

I agree that different connectors help providing a better
user-experienced view of board layout. But I doubt that besides the
differentiation (HDMI, DVI, VGA, SVideo, ...) and the endpoint there
should be anything more in that node.

Sebastian

