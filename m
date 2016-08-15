From: Vegard Nossum <vegard.nossum@gmail.com>
Date: Mon, 15 Aug 2016 11:39:06 +0000
Subject: Re: [PATCH] backlight-tosa: Delete owner assignment
Message-Id: <CAOMGZ=EWsO_pRg+s+hnPmwRePcrijFK3v+SRKTizfbqyY83iqQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <efe9964f-c907-305c-b75e-32a4139d1edd@users.sourceforge.net>
In-Reply-To: <efe9964f-c907-305c-b75e-32a4139d1edd@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, Kernel Janitors List <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>

On 15 August 2016 at 13:12, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 15 Aug 2016 13:03:29 +0200
>
> The field "owner" is set by core. Thus delete an extra initialisation.

Hi,

Just a small nit on the patch title: "delete owner assignment" is
virtually useless as a title because it has no meaning without the
broader context and only describes the literal change. It's like
naming a patch "add a line" or "change the code"; it serves no
purpose.

How about "backlight-tosa: delete _unnecessary_ assignment"? This
immediately communicates the reason for/intent of the patch (there is
unnecessary code, thus we can simplify it).

(Sorry about singling out this patch and the apparent bikeshedding,
this comment obviously applies to a lot of patches by a lot of
authors!)

Thanks,


Vegard
