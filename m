From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: mark framebuffer as Orphan
Date: Thu, 15 Feb 2007 15:27:08 -0800
Message-ID: <20070215152708.2e4f8c8b.akpm@linux-foundation.org>
References: <20070215132549.c182f7bf.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161640AbXBOX1T@vger.kernel.org>
In-Reply-To: <20070215132549.c182f7bf.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Thu, 15 Feb 2007 13:25:49 -0800
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Are we ready to do this?
> I'd love for Tony to return, but he's been missing for awhile now.
> 
> So this give us the following major areas that are marked as Orphan:
> 
> Firmware loader
> Framebuffer
> Serial (8250/16x50)
> 
> and PCMCIA has a Team.  It doesn't seem to be hurting.  :)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  MAINTAINERS |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- linux-2.6.20-git9.orig/MAINTAINERS
> +++ linux-2.6.20-git9/MAINTAINERS
> @@ -1321,11 +1321,9 @@ W:	http://www.farsite.co.uk/
>  S:	Supported
>  
>  FRAMEBUFFER LAYER
> -P:	Antonino Daplas
> -M:	adaplas@pol.net
>  L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
>  W:	http://linux-fbdev.sourceforge.net/
> -S:	Maintained
> +S:	Orphan

No, James is keeping an eye on things, but he obviously doesn't have as
much time to work on it as Tony did.

My point was that for bugs such as the one Pavel identified we're no longer
able to palm it off on the maintainer and expect magic to happen.  Either we
all dig in and help out or things don't get fixed.
