From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: atmel_lcdfb: max pixclock check
Date: Tue, 12 May 2009 14:30:03 +0200
Message-ID: <4A096BCB.3030403@atmel.com>
References: <49F1C0E4.9050906@emlix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757427AbZELMa3@vger.kernel.org>
In-Reply-To: <49F1C0E4.9050906@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: =?ISO-8859-15?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Ben Nizette <bn@niasdigital.com>, Linux Kernel list <linux-kernel@vger.kernel.org>

Daniel Gl=F6ckner :
> Hi,
> in the current Atmel LCD framebuffer driver there is the following ch=
eck in the
> fb_check_var callback:
>=20
> if ((PICOS2KHZ(var->pixclock) * var->bits_per_pixel / 8) > clk_value_=
khz) {
> 	dev_err(dev, "%lu KHz pixel clock is too fast\n",
> 		PICOS2KHZ(var->pixclock));
> 	return -EINVAL;
> }
>=20
> I can't find any constraint like this in the data sheets and applicat=
ion note.
> What I can find is a minimum for clk_value_khz/PICOS2KHZ(var->pixcloc=
k)
> depending on the display type, scan mode, and interface width.

Indeed, I have just acked a patch from Ben Nizette removing this constr=
ain.
http://lkml.org/lkml/2009/5/12/189

> Is the quoted if-statement correct or should it be changed to a minim=
um clock
> divider check?

We can imagine such a check depending on display type. Patches welcome =
;-)

> And while we're at it, is it correct to return -EINVAL here instead o=
f changing
> var->pixclock to the closest supported value?

I do not know... Maybe someone on linux-fb-devel can answer ?

Bye,
--=20
Nicolas Ferre
