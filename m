From: Joe Perches <joe@perches.com>
Date: Tue, 28 Nov 2017 08:04:04 +0000
Subject: Re: omapfb/dss: Delete an error message for a failed memory allocation in three functions
Message-Id: <1511856244.19952.14.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
         <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
         <1511809633.32426.70.camel@perches.com>
         <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
         <1511833514.32426.86.camel@perches.com>
         <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
In-Reply-To: <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "Andrew F. Davis" <afd@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Tue, 2017-11-28 at 08:41 +0100, SF Markus Elfring wrote:
> > > It seems that I got no responses so far for clarification requests
> > > according to the documentation in a direction I hoped for.
> > 
> > That's because you are pretty unresponsive to direction.
> 
> From which places did you get this impression?

How many times have I told you to include the reason for
your patches in
your proposed commit message?  Too often.

For instance, specific to this patch:

Many people do not know that a generic kmalloc does a
dump_stack() on OOM.  That information should be part
of the commit message.

Also removing the printk code reduces overall code size.
The actual size reduction should be described in the
commit message too.

