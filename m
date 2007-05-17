From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 10/10] [HEADS UP] fbdev: Move
	arch-specific bits to	their respective subdirectories
Date: Thu, 17 May 2007 18:51:22 +0800
Message-ID: <1179399082.4586.10.camel@daplas>
References: <464B78BC.4080900@gmail.com> <20070517094930.GA27627@infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hoda0-0007DU-PE for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 May 2007 03:51:32 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hoda0-0008LV-FH
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 May 2007 03:51:32 -0700
Received: by py-out-1112.google.com with SMTP id a29so800537pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 17 May 2007 03:51:31 -0700 (PDT)
In-Reply-To: <20070517094930.GA27627@infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, 2007-05-17 at 10:49 +0100, Christoph Hellwig wrote:
> On Thu, May 17, 2007 at 05:33:48AM +0800, Antonino A. Daplas wrote:
> > -#if defined(__sparc__) && !defined(__sparc_v9__)
> > -	/* Should never get here, all fb drivers should have their own
> > -	   mmap routines */
> > -	return -EINVAL;
> > -#else
> > -	/* !sparc32... */
> > +	if (fb_mmap_required())
> > +		return -EINVAL;
> > +
> 
> I don't like this bit.

Me too, actually. I did it this way because I don't want to deviate from
the old code too much. Since all sparc32 drivers are either linked to
sbuslib.c or has their own fb_mmap method, the above test is redundant. 
I'll leave the decision to remove the above test to David Miller.

>   It's just that all sparc frame buffers happen
> to have a mmap method but there's nothing fundamentally arch specific
> here.  You should be able to plug a pci video card into any linux
> supported machine provided the fb driver does the full setup (which
> only very few do in practice, but..)
> 
> So I'd just require drivers to have a fb_mmap method and make fb_mmap
> the default one.

This one is a tad bit more complicated, so I'll leave the present setup
for now. Once the arch-specific parts are properly separated, maybe I'll
take that step.
  
>   The page protection cleanup is still nice of course,
> but it might make sense to give it a more generic name as it's not
> really fb specific.

Any suggestion for a name? io_pgprotect() perhaps?

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
