From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 15 Aug 2016 13:25:42 +0000
Subject: Re: backlight-tosa: Delete owner assignment
Message-Id: <916b664f-7818-18ca-445b-27413259ebef@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <efe9964f-c907-305c-b75e-32a4139d1edd@users.sourceforge.net>
 <CAOMGZ=EWsO_pRg+s+hnPmwRePcrijFK3v+SRKTizfbqyY83iqQ@mail.gmail.com>
In-Reply-To: <CAOMGZ=EWsO_pRg+s+hnPmwRePcrijFK3v+SRKTizfbqyY83iqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

>> The field "owner" is set by core. Thus delete an extra initialisation.
> 
> Just a small nit on the patch title: "delete owner assignment" is
> virtually useless as a title because it has no meaning without the
> broader context and only describes the literal change. It's like
> naming a patch "add a line" or "change the code";
> it serves no purpose.

I have got an other impression.

Do you want that I add any more background information to the
commit message?


> How about "backlight-tosa: delete _unnecessary_ assignment"?

Will the underlined key word trigger any related software
development concerns?

Would another look be needed on how the usage of the mentioned data
structure element was reduced over time?

Regards,
Markus
