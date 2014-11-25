From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 25 Nov 2014 13:21:19 +0000
Subject: Re: [PATCH v3 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <5474824F.8080000@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
 <1416309051-26784-3-git-send-email-hdegoede@redhat.com>
 <547476DA.2030004@ti.com> <54747B72.1050406@redhat.com>
 <54747DCF.9010502@ti.com>
In-Reply-To: <54747DCF.9010502@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/25/2014 02:02 PM, Tomi Valkeinen wrote:
> On 25/11/14 14:52, Hans de Goede wrote:
>
>>>> +Required properties:
>>>> +- compatible: "allwinner,simple-framebuffer"
>>>> +- allwinner,pipeline, one of:
>>>
>>> Sorry my ignorance, but what's sunxi and what's allwinner? Both names
>>> are mixed here.
>>
>> sunxi is the sun#i SoCs from Allwinner, Allwinner is the manufacturer
>> and the
>> SoC "code" names used everywhere in the kernel for their SoCs are sun4i,
>> sun5i,
>> sun6i, etc. Most people refer to these SoCs as sunxi. This is also what the
>> linux-sunxi mailinglist in the Cc is about.
>>
>> The official devicetree vendor prefix for Allwinner is allwinner, hence the
>> allwinner in the compatible name, see e.g. also
>>
>> Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
>>
>> Which also uses sunxi / sun4i everywhere except in the compatible vendor
>> prefix.
>
> Alright, thanks for explanation.
>
> Shouldn't the compatible then be "allwinner,sunxi-simple-framebuffer",
> to differentiate from some other SoC Allwinner has or might create in
> the future? That is, presuming you're confident enough that a single
> compatible string covers all the current and forthcoming sunxi SoCs.

This was discussed in an earlier thread, we (Ian Campbell, Grant and me)
decided to settle on allwinner,simple-framebuffer to make it clear that
these are allwinner extensions to the standard simple-framebuffer bindings,
and that the node otherwise is simple-framebuffer compatible.

We were afraid that e.g. sun4i-simple-framebuffer would signal that it
is not a normal simple-framebuffer node, so we decided to go with just
the allwinner, prefix to indicate that it uses allwinner specific
extensions.

Regards,

Hans
