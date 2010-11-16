From: Daniel Drake <dsd@laptop.org>
Date: Tue, 16 Nov 2010 09:33:52 +0000
Subject: Re: [PATCH] lxfb: Program panel v/h sync output polarity correctly
Message-Id: <AANLkTi=vvHEOVn=x6pTx3DGZDKm566UDjfXOqta=Dyj_@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101114141231.414F29D401B@zog.reactivated.net>
In-Reply-To: <20101114141231.414F29D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On 16 November 2010 08:26, Michael Grzeschik <mgr@pengutronix.de> wrote:
> I rechecked the Datasheet and it seems you are right with that.
> But i don't like the logical mess in the statements. So here is what i
> would prefer.
>
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(info->var.sync & FB_SYNC_HOR_HIGH_ACT))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D FP_PT2_HSP;
>
> Instead i would like to see something like this:
>
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp &=3D ~(FP_PT2_HSP);

You'd have to add an else condition to actually set the bit (in the
active low case) though.
I'd be happy to do that, but my opinion is that my original version is clea=
ner.
Apples vs oranges. Paul, which approach do you prefer?

Thanks,
Daniel
