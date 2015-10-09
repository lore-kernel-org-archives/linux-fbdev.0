From: Rob Herring <robh@kernel.org>
Date: Fri, 09 Oct 2015 00:46:15 +0000
Subject: Re: [PATCH v2] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <CAL_JsqLeXtfkh=XYFXFCfDo8=eEiFQUS=aMOk=qz1itLDGQy=g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443954683-13126-1-git-send-email-robert.jarzmik@free.fr>
 <CAL_JsqLy-pK4VpBkj1-wVg85XvPemssM-=Ckx=yDjiXKXbtwtA@mail.gmail.com>
 <87y4ffaj3m.fsf@belgarion.home> <CAL_JsqLatWZa1mYL1v83ryJntyLtHDfSfr0gXkvPXJrpCE=qcg@mail.gmail.com>
 <87lhbd9npn.fsf@belgarion.home>
In-Reply-To: <87lhbd9npn.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Thu, Oct 8, 2015 at 2:15 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:

>>> And then, when a board maintainer will create a devicetree description, he will
>>> write something like :
>>>       compatible = "toshiba,ltm0305a776";
>>>       compatible = "marvell,pxa2xx-panel";
>>
>> Drop this compatible.
>>
>>>       lcd-type = "color-tft";
>>>       ...
>>>
>>> If that's the case, I wonder how to "enforce" that a panel used with
>>> marvell,pxa2xx-lcdc (through the of_graph 'port' node) be compatible with
>>> marvell,pxa2xx-panel ?
>>
>> I'm not sure what you mean. Putting the panel into the dts ensures
>> that. The FB driver may check for toshiba,ltm0305a776 or a list of
>> panels. However, a DRM driver would probably not check that.
>>
>> Rob
> What I mean is that the LDLC controller _must_ be programmmed with the correct
> panel type, ie. one register of the LDLC should be set according to this type.
>
> The type is a hardware property of the panel, and yet it is absolutely mandatory
> to have it set in the panel.
>
> What I mean is : what is the good way to enforce that this property is set
> somewhere in the devicetree description ? Philipp adviced for it to be transfered
> to the ldlc description (ie. marvell,pxa2xx-ldlc), while I was thinking of
> having it in a panel description.

Either of those options are fine. Neither should need
marvell,pxa2xx-panel though. I'd lean towards putting it in the panel,
but in that case it should be generic for panels which I think it is.
It should probably be optional with not present meaning color-tft
(since every other type is practically dead), but you could say
required on pxa2xx.

The only way to enforce it ATM, is panicking or something if the LCDC
finds it is not set. That's not any worse that checking for
marvell,pxa2xx-panel.

Rob
