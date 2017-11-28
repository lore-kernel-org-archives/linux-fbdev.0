From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 28 Nov 2017 12:13:51 +0000
Subject: Re: omapfb/dss: Delete an error message for a failed memory allocation in three functions
Message-Id: <bdf052ef-4f32-af1e-4b1b-6fb75e5e0af9@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1511809633.32426.70.camel@perches.com>
 <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
 <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
 <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
 <alpine.DEB.2.20.1711281026410.3443@hadrien>
 <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
 <20171128102327.GA30267@lenoch>
 <796a5c89-7c72-776d-e769-e52f5e5bf43f@users.sourceforge.net>
 <20171128114130.GA1615@lenoch>
In-Reply-To: <20171128114130.GA1615@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Julia Lawall <julia.lawall@lip6.fr>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joe Perches <joe@perches.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>

>> I am not going to “verify” your update suggestion by my evolving approaches
>> around the semantic patch language (Coccinelle software) at the moment.
> 
> As you are sending patches as Markus Elfring

I am contributing also some update suggestions.


> I would expect you take Coccinelle's suggestion into account

The proposed change is based on a semantic patch script which I developed
with the support of other well-known Linux contributors.


> and actually try to understand code before sending patch.

I concentrated my understanding on the concrete transformation pattern
in this use case.


> That suggestion may lead to actual bug in code which your patch just leaves
> unnoticed as it is not apparent from the patch itself

There can be other change possibilities left over as usual.


> (no, not talking about this very patch it all started with)

Thanks for your distinction.


> That said, I'm considering Markus Elfring being a human.

Thanks for this view.


> If you do not like reactions to your patches

I am looking for constructive responses. - Disagreements can trigger
special communication challenges.


> or are interested only in improving tool that generates them,

How do you think about to look at any more background information?

https://github.com/coccinelle/coccinelle/issues
https://systeme.lip6.fr/pipermail/cocci/


> it would be better to just setup a "tip bot for Markus
> Elfring" and let it send patches automatically.

There is already an other automatic source code analysis system active.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/scripts/coccinelle


> The way you are sending patches makes impression (at least to me),
> that you spent some time on fixing issue Coccinelle found

Yes. - This view is appropriate.


> and not just shut the warning up.

Additional improvement possibilities can be taken into account
after corresponding software development discussions, can't they?

Regards,
Markus
