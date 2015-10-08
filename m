From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Thu, 08 Oct 2015 19:15:00 +0000
Subject: Re: [PATCH v2] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <87lhbd9npn.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443954683-13126-1-git-send-email-robert.jarzmik@free.fr>
	<CAL_JsqLy-pK4VpBkj1-wVg85XvPemssM-=Ckx=yDjiXKXbtwtA@mail.gmail.com>
	<87y4ffaj3m.fsf@belgarion.home>
	<CAL_JsqLatWZa1mYL1v83ryJntyLtHDfSfr0gXkvPXJrpCE=qcg@mail.gmail.com>
In-Reply-To: <CAL_JsqLatWZa1mYL1v83ryJntyLtHDfSfr0gXkvPXJrpCE=qcg@mail.gmail.com>
	(Rob Herring's message of "Thu, 8 Oct 2015 08:30:36 -0500")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, Philipp Zabel <philipp.zabel@gmail.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Rob Herring <robh@kernel.org> writes:

>> The pxafb driver acts today on the subset of registers which are the same across
>> all pxaXXX variants. This is what made me think only one compatible property was
>> required.
>>
>> If I'm wrong, I could add "marvell,pxa3xx-lcdc", is that what you think I should
>> do ?
>
> I would prefer specific compatibles (e.g. marvell,pxa270-lcdc) in
> addition to a generic one. You never know when a specific chip will
> have some quirk even though "the IP is the same".
Okay.

>> And then, when a board maintainer will create a devicetree description, he will
>> write something like :
>>       compatible = "toshiba,ltm0305a776";
>>       compatible = "marvell,pxa2xx-panel";
>
> Drop this compatible.
>
>>       lcd-type = "color-tft";
>>       ...
>>
>> If that's the case, I wonder how to "enforce" that a panel used with
>> marvell,pxa2xx-lcdc (through the of_graph 'port' node) be compatible with
>> marvell,pxa2xx-panel ?
>
> I'm not sure what you mean. Putting the panel into the dts ensures
> that. The FB driver may check for toshiba,ltm0305a776 or a list of
> panels. However, a DRM driver would probably not check that.
>
> Rob
What I mean is that the LDLC controller _must_ be programmmed with the correct
panel type, ie. one register of the LDLC should be set according to this type.

The type is a hardware property of the panel, and yet it is absolutely mandatory
to have it set in the panel.

What I mean is : what is the good way to enforce that this property is set
somewhere in the devicetree description ? Philipp adviced for it to be transfered
to the ldlc description (ie. marvell,pxa2xx-ldlc), while I was thinking of
having it in a panel description.

Cheers.

-- 
Robert
