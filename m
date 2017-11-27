From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 18:12:50 +0000
Subject: Re: omapfb/dss: Delete an error message for a failed memory allocation in three functions
Message-Id: <5e90409f-fcb0-cdb6-9bc3-26ad30a1f7c9@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <502de06b-ca86-d0ff-bd50-d260fbe46fe5@users.sourceforge.net>
 <20171127174454.GA18851@lenoch>
In-Reply-To: <20171127174454.GA18851@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>

>> Can a default allocation failure report provide the information
>> which you might expect so far?
> 
> You should be able to answer that question yourself.

I can not answer this detail completely myself because my knowledge
is incomplete about your concrete expectations for the exception handling
which can lead to different views for the need of additional error messages.


> And if you are unable to do so, just do not sent changes pointed
> by any code analysis tools.

They can point aspects out for further software development considerations,
can't they?


> As a side note, if you look at whole call chain, you'll find quite some
> room for optimizations - look how dev and pdev are used. That also applies
> to other patches.

Would you prefer to improve the source code in other ways?

Regards,
Markus
