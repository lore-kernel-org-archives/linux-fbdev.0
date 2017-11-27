From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:48:26 +0000
Subject: Re: omapfb/dss: Delete an error message for a failed memory allocation in three functions
Message-Id: <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
In-Reply-To: <1511809633.32426.70.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Joe Perches <joe@perches.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>

> There is the generic stack dump on OOM so the module/line
> is already known.

Can such an implementation detail become better documented
than in C source code?


> The existence of these messages increases code size which
> also make the OOM condition slightly more likely.

Interesting view =E2=80=A6


> Markus' commit messages are always really poor descriptions
> of why these removals are somewhat useful and the commit
> could/should/might be applied.

I agree that they could be improved for this transformation
pattern if other information sources would become clearer
for corresponding references.
It seems that I got no responses so far for clarification requests
according to the documentation in a direction I hoped for.

Regards,
Markus
