From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Thu, 08 Oct 2015 06:49:58 +0000
Subject: Re: [PATCH v2] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <CA+gwMccn6DjE6khY6RMdgvz9xw4Gs2kLj26SJhxoj1B2te8Yjw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443954683-13126-1-git-send-email-robert.jarzmik@free.fr>
	<CAL_JsqLy-pK4VpBkj1-wVg85XvPemssM-=Ckx=yDjiXKXbtwtA@mail.gmail.com>
	<87y4ffaj3m.fsf@belgarion.home>
In-Reply-To: <87y4ffaj3m.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Oct 6, 2015 at 9:32 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:
>>> +       "marvell,pxa2xx-lcdc",
>>
>> No differences in h/w for any of the chips?
> All pxa25x, pxa27x and pxa3xx are compatible.
> AFAIK, pxa3xx has an IP with additional registers. But :
>  - these (this) register(s) is not necessary for the display controller to work
>    (it's more a control to shift red/green/blue values, and energy management)
>  - all the registers in pxa2{5,7}x are the same in pxa3xx

So the pxa3xx is pxa2xx compatible. The pxa3xx device tree should
contain compatible = "marvell,pxa3xx-lcdc", "marvell,pxa2xx-lcdc";

That way we can just ignore the pxa3xx compatible value until the need
arises to do something different with the additional registers, and if
that happens we already have it in the device trees.

>> If lcd-type is smart-panel, then this node would not make sense.
> Ah I see, so this could be optional maybe ?
>
> Actually when I'll move the panel definition to bindings/display/panel, is this
> what I should do :
>  - create a file marvell,pxa2xx-panel
>  - input all these properties into this file
>
> And then, when a board maintainer will create a devicetree description, he will
> write something like :
>       compatible = "toshiba,ltm0305a776";
>       compatible = "marvell,pxa2xx-panel";
>       lcd-type = "color-tft";
>       ...
>
> If that's the case, I wonder how to "enforce" that a panel used with
> marvell,pxa2xx-lcdc (through the of_graph 'port' node) be compatible with
> marvell,pxa2xx-panel ?

I think we should move to use drm simple-panel as soon as possible,
but until this information can be derived from the compatible string,
it should maybe stay contained to the lcdc node. At least I don't
think adding a marvell panel compatible is a solution. Maybe this
could be generalized and added as an optional property to the
simple-panel bindings.

regards
Philipp
