From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 28 Nov 2017 09:11:48 +0000
Subject: Re: omapfb/dss: Delete an error message for a failed memory allocation in three functions
Message-Id: <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
 <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
 <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
In-Reply-To: <1511856244.19952.14.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Joe Perches <joe@perches.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>

> How many times have I told you to include the reason for
> your patches in your proposed commit message?

It might be useful to look again.


> Too often.

I answered this feedback to some degree.


> Many people do not know that a generic kmalloc does a
> dump_stack() on OOM.

This is another interesting information, isn't it?

It is expected that the function “devm_kzalloc” has got a similar property.


> That information should be part of the commit message.

How do you think about to provide it also in any reference documentation
in a clearer way?

I would be more confident then to copy it into my messages.
Do you want that I take your current answer as an official note
for my work (instead of waiting for adjustments of other areas)?


> Also removing the printk code reduces overall code size.

Such an effect can be nice if the involved contributors can agree on
the deletion of questionable error messages at all.


> The actual size reduction should be described in the
> commit message too.

For which hardware and software combinations would you like to see
facts there?

Regards,
Markus
