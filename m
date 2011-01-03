From: "Janorkar, Mayuresh" <mayur@ti.com>
Date: Mon, 03 Jan 2011 06:47:12 +0000
Subject: RE: New entry in modedb
Message-Id: <EAF47CD23C76F840A9E7FCE10091EFAB03232056D6@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <EAF47CD23C76F840A9E7FCE10091EFAB0322F86892@dbde02.ent.ti.com>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB0322F86892@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Thanks Paul.

I would send the required patch.

-Thanks,
Mayuresh

> -----Original Message-----
> From: Paul Mundt [mailto:lethal@linux-sh.org]
> Sent: Friday, December 24, 2010 9:12 AM
> To: Janorkar, Mayuresh
> Cc: linux-fbdev@vger.kernel.org
> Subject: Re: New entry in modedb
> 
> On Fri, Dec 17, 2010 at 09:09:43PM +0530, Janorkar, Mayuresh wrote:
> > We keep a database for modes in drivers/video/modedb.c
> > The file says:
> >
> > /*
> >  *  Standard video mode definitions (taken from XFree86)
> >  */
> >
> > I am using a panel whose entry is not available in this mode database.
> > Can I add a new entry for my panel?
> >
> If it's a standard definition that multiple users are likely to use in
> the future, sure. We have certainly added new modes in the past based on
> expected usage criteria, not limited to the legacy XFree86 definitions.
