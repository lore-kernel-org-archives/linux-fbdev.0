From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 28 Nov 2017 18:09:11 +0000
Subject: Re: omapfb/dss: Delete an error message for a failed memory allocation in three functions
Message-Id: <c0f850bc-0c4d-09d4-bdf4-049b3e00fc75@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
 <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
 <alpine.DEB.2.20.1711281026410.3443@hadrien>
 <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
 <20171128102327.GA30267@lenoch>
 <796a5c89-7c72-776d-e769-e52f5e5bf43f@users.sourceforge.net>
 <20171128114130.GA1615@lenoch>
 <bdf052ef-4f32-af1e-4b1b-6fb75e5e0af9@users.sourceforge.net>
 <20171128175016.GA3501@lenoch>
In-Reply-To: <20171128175016.GA3501@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Julia Lawall <julia.lawall@lip6.fr>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joe Perches <joe@perches.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>

>> Additional improvement possibilities can be taken into account
>> after corresponding software development discussions, can't they?
> 
> Sure, but that is in contrary to all you replies.

Where do you see a contradiction in this case?


> I guess you are familiar with Documentation/process/submitting-patches.rst chapter 8.

I hope so in principle.


> No matter that patch was generated or suggested by a tool, you sent
> it and normal review procedure follows.

This is generally fine.


> And here you ignored _all_ suggestions

I did not integrate a few of them for my commit message so far
because it seems that there are open issues for further clarification.

Do you want that I send a second approach for this software module
before your own evolving update suggestion?


> and concentrate solely on improving Coccinelle scripts.

I hope not.


> On kernel related lists suggestions to patch itself are discussed.

This is usual.


> Whenever you take them into account while developing Coccinelle
> is up to you (on the Cocci list).

This is also happening, isn't it?

Regards,
Markus
