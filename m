From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 04 Jun 2013 04:23:42 +0000
Subject: Re: [PATCH] PM: Add pm_sleep_ops_ptr() macro
Message-Id: <000601ce60db$4bd94e80$e38beb80$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <002801ce6022$a2928930$e7b79b90$@samsung.com>
 <1867006.c6mxKpbPvX@vostro.rjw.lan> <3772829.L58vmUyOpk@vostro.rjw.lan>
In-Reply-To: <3772829.L58vmUyOpk@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>
Cc: 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, 'Lars-Peter Clausen' <lars@metafoo.de>, 'Michael Hennerich' <michael.hennerich@analog.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

On Tuesday, June 04, 2013 4:55 AM, Rafael J. Wysocki wrote:
> On Monday, June 03, 2013 01:11:07 PM Rafael J. Wysocki wrote:
> > On Monday, June 03, 2013 03:21:51 PM Jingoo Han wrote:
> > > Add pm_sleep_ops_ptr() macro that allows the .pm entry in the driver structures
> > > to be assigned without having an #define xxx NULL for the case that PM_SLEEP is
> > > not enabled.
> > >
> > > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > > Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > Cc: Michael Hennerich <michael.hennerich@analog.com>
> >
> > Do you want me to replace the previous patch with this?
> 
> Quite frankly, I prefer the previous version, which was more general.
> 
> That is, what if someone wants to use that macro for runtime PM too?
> 
> Honestly, I think we'll be better off without any of them, so I'm dropping
> the previous patch too for now.

OK, I see.

I agree with your opinion.
Also, as I mentioned, I want other's better ideas.


Best regards,
Jingoo Han

> 
> Thanks,
> Rafael
> 
> 
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

