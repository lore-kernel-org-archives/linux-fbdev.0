From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: patch - bitblt 2D acceleration for
	s1d13xxxfb
Date: Mon, 8 Jun 2009 15:19:00 +0200
Message-ID: <20090608151900.7f11bd38.kristoffer.ericson@gmail.com>
References: <20090605193853.d235e679.kristoffer.ericson@gmail.com>
	<20090605135916.34dc2c71.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1MDefF-00057B-IE
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Jun 2009 13:13:25 +0000
Received: from mail-bw0-f222.google.com ([209.85.218.222])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDefE-0002DP-NF for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Jun 2009 13:13:25 +0000
Received: by bwz22 with SMTP id 22so2960469bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 08 Jun 2009 06:13:22 -0700 (PDT)
In-Reply-To: <20090605135916.34dc2c71.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Andrew,

Ive sent the updated patch to you and list earlier. Is it okey to merge? 
I feel confident that it doesnt break anything and it is tested
to both compile and work. 

If needed I could run it by Russell and push it that way.

Best wishes 
Kristoffer Ericson

On Fri, 5 Jun 2009 13:59:16 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 5 Jun 2009 19:38:53 +0200
> Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> 
> > Greetings,
> > 
> > Just wanted some feedback since this patch is quite large. Any comments are
> > appreciated. It patches, compiles and runs like a fox on fire.
> 
> we like firey foxes.
> 
> > This patch:
> > enables 2D rectfill and copyarea acceleration for 13506, need to look
> > at hardware sheets before I can say it works on other version but at minimal
> > 13806.
> > 
> > Also some cleans up the code.
> > 
> >
> > ...
> >
> > +/**
> > + * we make sure only one bitblt operation is running
> > + */
> > +static DEFINE_SPINLOCK(s1d13xxxfb_bitblt_lock);
> > +
> > +/**
> > + * list of card production ids
> >   */
> >  static const int s1d13xxxfb_prod_ids[] = {
> >  	S1D13505_PROD_ID,
> > @@ -59,7 +71,7 @@ static const int s1d13xxxfb_prod_ids[] = {
> >  	S1D13806_PROD_ID,
> >  };
> >  
> > -/*
> > +/**
> >   * List of card strings
> >   */
> >  static const char *s1d13xxxfb_prod_names[] = {
> > @@ -68,8 +80,8 @@ static const char *s1d13xxxfb_prod_names[] = {
> >  	"S1D13806",
> >  };
> >  
> > -/*
> > - * Here we define the default struct fb_fix_screeninfo
> > +/**
> > + * here we define the default struct fb_fix_screeninfo
> >   */
> 
> The /** token is reserved for introducing a kerneldoc-formatted
> comment, but none of the above three comments are kerneldoc comments.
> 
> > +/**
> > + *	bltbit_wait_bitset - waits for change in register value
> > + *	@info : framebuffer structure
> > + *	@bit  : value expected in register
> > + *	@timeout : ...
> > + *
> > + *	waits until value changes INTO bit
> > + */
> 
> That one is kerneldoc.
> 
> > +u8 bltbit_wait_bitset(struct fb_info *info, u8 bit, int timeout)
> 
> The patch adds lots of global functions.  Please make symbols static
> where possible.
> 
> > +{
> > +	while (!(s1d13xxxfb_readreg(info->par, S1DREG_BBLT_CTL0) & bit)) {
> > +		udelay(10);
> > +		if (!--timeout) {
> > +			dbg_blit("wait_bitset timeout\n");
> > +			break;
> > +		}
> > +	}
> > +
> > +	return timeout;
> > +}
> > +
> >
> > ...
> >
> 
> It otherwise looks OK to my inexpert eye.


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
