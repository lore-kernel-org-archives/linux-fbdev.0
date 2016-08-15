From: Vegard Nossum <vegard.nossum@gmail.com>
Date: Mon, 15 Aug 2016 13:37:49 +0000
Subject: Re: backlight-tosa: Delete owner assignment
Message-Id: <CAOMGZ=F8BJA0w7oOpKCHRDTFM-=Hm6GQdW-GcdCasWP4i_B--g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <efe9964f-c907-305c-b75e-32a4139d1edd@users.sourceforge.net>
 <CAOMGZ=EWsO_pRg+s+hnPmwRePcrijFK3v+SRKTizfbqyY83iqQ@mail.gmail.com> <916b664f-7818-18ca-445b-27413259ebef@users.sourceforge.net>
In-Reply-To: <916b664f-7818-18ca-445b-27413259ebef@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, Kernel Janitors List <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>

On 15 August 2016 at 15:25, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> The field "owner" is set by core. Thus delete an extra initialisation.
>>
>> Just a small nit on the patch title: "delete owner assignment" is
>> virtually useless as a title because it has no meaning without the
>> broader context and only describes the literal change. It's like
>> naming a patch "add a line" or "change the code";
>> it serves no purpose.
>
> I have got an other impression.
>
> Do you want that I add any more background information to the
> commit message?

No, the rest of the commit message is fine. I was only concerned about
the patch title (the first line) since that's what appears frequently
in patch lists (cgit, shortlogs, email/archives), etc.

>> How about "backlight-tosa: delete _unnecessary_ assignment"?
>
> Will the underlined key word trigger any related software
> development concerns?

No, the emphasis was just for the email, I wouldn't put that in the
actual commit log.

> Would another look be needed on how the usage of the mentioned data
> structure element was reduced over time?

No, it's fine, it's really just about the patch title :-) Thanks,


Vegard
