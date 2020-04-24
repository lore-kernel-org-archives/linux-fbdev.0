From: Markus Elfring <Markus.Elfring@web.de>
Date: Fri, 24 Apr 2020 07:46:36 +0000
Subject: Re: console: Complete exception handling in newport_probe()
Message-Id: <f1d27f1b-d822-3457-7ca9-c4c5a8b98365@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
 <20200423142909.GB1562@nuc8i5> <f054f00c-b813-e0c2-fe2e-30ccdec1ff46@web.de>
 <20200423170245.GA3417@nuc8i5>
In-Reply-To: <20200423170245.GA3417@nuc8i5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dejin Zheng <zhengdejin5@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Cc: =?UTF-8?Q?Thomas_Bogend=c3=b6rfer?= <tsbogend@alpha.franken.de>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

> Sorry, I do not know how to use the SmPL script.

I would like to try again to make you more familiar with applications
of the Coccinelle software.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/coccinelle.rst?id=b4f633221f0aeac102e463a4be46a643b2e3b819#n9

Another small example according to a script for the semantic patch language:
@display@
expression e, x;
statement is, es;
type t;
@@
*e = (t) ioremap(...)
 ... when != if( \( !e \| e == NULL \| unlikely( \( !e \| e == NULL \) ) \| WARN_ON( \( !e \| e == NULL \) ) \) ) is else es
     when != iounmap(e)
 return x;



>> Would you like to let any more source code analysis tools help you
>> to find remaining update candidates?
>>
> yes, but I think the source code analysis tools only can found the simple
> repetitive issue.

The shown analysis approach can point 127 source files out from
the software “Linux next-20200423”. These files contain function implementations
which might need further development considerations.


> and need spend some time learning to use it.

You came along a few files where you noticed questionable source code.
Would you become interested to find similar places for another check?


elfring@Sonne:~/Projekte/Linux/next-patched> XX=$(date) && spatch --no-loops --timeout 12 -j 4 --chunksize 1 -dir ~/Projekte/Linux/next-patched ~/Projekte/Coccinelle/janitor/show_questionable_ioremap_usage3.cocci > ~/Projekte/Bau/Linux/scripts/Coccinelle/ioremap/20200423/show_questionable_ioremap_usage3.diff 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/ioremap/20200423/show_questionable_ioremap_usage3-errors.txt; YY=$(date) && echo "$XX | $YY"
Fr 24. Apr 09:08:44 CEST 2020 | Fr 24. Apr 09:10:37 CEST 2020

Would you like to extend your learning experiences accordingly?


> now, I think the best for me may be that read and check the source code.

How do you think about to reduce efforts for manual code inspection?

Regards,
Markus
