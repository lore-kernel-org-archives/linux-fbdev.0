From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Date: Tue, 12 Jan 2016 13:10:29 +0000
Subject: Re: [RESEND PATCH 1/2] devicetree: mxsfb: add reset-active property
Message-Id: <yw1x7fjfuenu.fsf@unicorn.mansr.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1452594141-26073-1-git-send-email-mans@mansr.com>
	<5694F51C.7040107@ti.com>
In-Reply-To: <5694F51C.7040107@ti.com> (Tomi Valkeinen's message of "Tue, 12
	Jan 2016 14:44:12 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On 12/01/16 12:22, Mans Rullgard wrote:
>> Some boards connect the LCD_RESET pin to a reset input on the
>> display panel.  On these boards, this pin must be set to the
>> proper level for the display to function.
>>=20
>> This adds an optional "reset-active" property to the "display"
>> subnode such that devicetrees can specify the desired polarity
>> of the LCD_RESET pin.
>>=20
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>>  Documentation/devicetree/bindings/display/mxsfb.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Docum=
entation/devicetree/bindings/display/mxsfb.txt
>> index 96ec5179c8a0..cb7212a6bdf2 100644
>> --- a/Documentation/devicetree/bindings/display/mxsfb.txt
>> +++ b/Documentation/devicetree/bindings/display/mxsfb.txt
>> @@ -13,6 +13,11 @@ Required properties:
>>  - bits-per-pixel : <16> for RGB565, <32> for RGB888/666.
>>  - bus-width : number of data lines.  Could be <8>, <16>, <18> or <24>.
>> =20
>> +Optional properties:
>> +- reset-active : <0>: reset pin is active low
>> +                 <1>: reset pin is active high
>> +                 omitted: reset pin not used
>> +
>>  Required sub-node:
>>  - display-timings : Refer to binding doc display-timing.txt for details.
>
> So maybe this is fine for the mxsfb if it doesn't support any kind of
> panel drivers, and there's no plan to extend it. Otherwise the LCD_RESET
> pin could perhaps be exposed as a GPIO for the panel drivers.
>
> But even so, I think the definition of "reset" is a bit vague.
>
> I know panels for which "reset" is a pulse, you assert it for a short
> period. Other panels take reset more like a on/off switch. If I'm not
> mistaken, this one is the latter kind.
>
> I don't see any sleeps related to reset in the code. If reset is
> asserted when the display is blanked, is it guaranteed that the reset
> stays asserted long enough until the display is enabled again?

In the datasheet for the panel I'm dealing with, there's some vague
mention of 10 us (I missed it last time I looked), and my patch indeed
fails to ensure this is met.  Other panels will obviously have different
requirements.  To handle all cases properly, I suppose a configurable
delay after changing the reset pin should be added.

I could also take the lazy way out, pinmux this signal high and leave it
at that.

--=20
M=E5ns Rullg=E5rd
