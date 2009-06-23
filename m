From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 3/3] atyfb: Coding style cleanup
Date: Tue, 23 Jun 2009 20:30:22 +0300
Message-ID: <20090623173022.GD9980@sci.fi>
References: <1245533384-28371-1-git-send-email-syrjala@sci.fi>
	<1245533384-28371-3-git-send-email-syrjala@sci.fi>
	<BD79186B4FD85F4B8E60E381CAEE1909019BDCF8@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1MJ9pM-0000j6-Rn
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Jun 2009 17:30:36 +0000
Received: from smtp5.welho.com ([213.243.153.39])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJ9pF-00033Z-Ru for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Jun 2009 17:30:31 +0000
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909019BDCF8@mi8nycmail19.Mi8.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

On Tue, Jun 23, 2009 at 12:52:58PM -0400, H Hartley Sweeten wrote:
> On Saturday, June 20, 2009 2:30 PM, Ville Syrjala wrote:
> > Fix a bunch of coding style problems in atyfb_base.c.
> > =

> > Signed-off-by: Ville Syrjala <syrjala@sci.fi>
> > ---
> > There are still some problems left, at least over 80 char lines, but
> > fixing those in a decent manner would require some code restructuring
> > to reduce the overly deep nesting. I decided to leave those bits mostly
> > untouched for now.
> > =

> >  drivers/video/aty/atyfb_base.c |  829 ++++++++++++++++++++++----------=
--------
> >  1 files changed, 458 insertions(+), 371 deletions(-)
> > =

> > diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_b=
ase.c
> > index 63d3739..913b4a4 100644
> > --- a/drivers/video/aty/atyfb_base.c
> > +++ b/drivers/video/aty/atyfb_base.c
> > @@ -132,7 +132,7 @@
> >  #endif
> >  =

> >  #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
> > -#define PRINTKE(fmt, args...)	 printk(KERN_ERR "atyfb: " fmt, ## args)
> > +#define PRINTKE(fmt, args...)	printk(KERN_ERR "atyfb: " fmt, ## args)
> =

> Why not: =

> =

> #define pr_fmt(fmt)	"atyfb: " fmt
> =

> Then just use pr_info() and pr_err()?  Also, pr_devel() could be used ins=
tead
> of the private DPRINTK() definition.

Ideally it should use dev_info(), dev_err() and dev_dbg() but at the
moment I have no motivation to start cleaning up the printk mess in
this driver.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
