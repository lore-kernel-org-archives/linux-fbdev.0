From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 2/4] fbdev: add connector entries for uvesafb
Date: Sun, 24 Jun 2007 00:05:07 +0400
Message-ID: <20070623200507.GA29496@2ka.mipt.ru>
References: <20070623105146.GC12623@spock.one.pl> <20070623110627.c911373c.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754274AbXFWUF5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070623110627.c911373c.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, Jun 23, 2007 at 11:06:27AM -0700, Andrew Morton (akpm@linux-foundation.org) wrote:
> On Sat, 23 Jun 2007 12:51:46 +0200 Michal Januszewski <spock@gentoo.org> wrote:
> 
> > Add connector's idx and val constants for v86d and uvesafb.
> > 
> > Also change the maximum message size to 4k to allow transfers of VBE
> > data blocks from userspace.
> > 
> > Signed-off-by: Michal Januszewski <spock@gentoo.org>
> > ---
> > include/linux/connector.h |    7 ++++---
> >  1 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/connector.h b/include/linux/connector.h
> > index 10eb56b..46b2aba 100644
> > --- a/include/linux/connector.h
> > +++ b/include/linux/connector.h
> > @@ -36,14 +36,15 @@
> >  #define CN_VAL_CIFS                     0x1
> >  #define CN_W1_IDX			0x3	/* w1 communication */
> >  #define CN_W1_VAL			0x1
> > +#define CN_IDX_V86D			0x4
> > +#define CN_VAL_V86D_UVESAFB		0x1
> >  
> > -
> > -#define CN_NETLINK_USERS		4
> > +#define CN_NETLINK_USERS		5
> >  
> >  /*
> >   * Maximum connector's message size.
> >   */
> > -#define CONNECTOR_MAX_MSG_SIZE 	1024
> > +#define CONNECTOR_MAX_MSG_SIZE 	4096
> >  
> >  /*
> >   * idx and val are unique identifiers which 
> > 
> > 
> 
> Evgeniy, could you please review this?
> 
> The need to add these enumerations for unrelated subsystems to connector.h
> may get a bit ugly as time passes, but I guess it's OK for now.

Hi.

I have no problem with the patch, although it could be possible to split
patch to two - add id and increase the size, but it is too minor nit.

Ack.

-- 
	Evgeniy Polyakov
