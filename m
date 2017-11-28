From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 28 Nov 2017 10:50:14 +0000
Subject: Re: omapfb/dss: Delete an error message for a failed memory allocation in three functions
Message-Id: <796a5c89-7c72-776d-e769-e52f5e5bf43f@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
 <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
 <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
 <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
 <alpine.DEB.2.20.1711281026410.3443@hadrien>
 <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
 <20171128102327.GA30267@lenoch>
In-Reply-To: <20171128102327.GA30267@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Julia Lawall <julia.lawall@lip6.fr>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joe Perches <joe@perches.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>

>> How will this aspect evolve further?
> 
> I do not follow.

Interesting …


> This is OMAP framebuffer driver, so in this case, there is zero variation.

How much are you interested to compare differences in build results
also for this software module because of varying parameters?

Which parameters were applied for your size comparisons so far?


> Could you, please, review following patch

I assume that other OMAP developers are in a better position to decide
about the deletion of extra memory allocations (instead of keeping
questionable error messages).


> and verify is it satisfies your automated static code analysis test?

I am not going to “verify” your update suggestion by my evolving approaches
around the semantic patch language (Coccinelle software) at the moment.

But I thank you for this contribution.
How will further feedback evolve for such an idea?

Regards,
Markus
