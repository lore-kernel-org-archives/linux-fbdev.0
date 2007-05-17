From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 10/10] [HEADS UP] fbdev: Move
 arch-specific bits to their respective subdirectories
Date: Thu, 17 May 2007 13:30:03 -0700 (PDT)
Message-ID: <20070517.133003.63739733.davem@davemloft.net>
References: <464B78BC.4080900@gmail.com> <20070517094930.GA27627@infradead.org>
	<1179399082.4586.10.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hombr-0003ZD-JR for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 May 2007 13:30:03 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hombp-00073g-Qo
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 May 2007 13:30:02 -0700
In-Reply-To: <1179399082.4586.10.camel@daplas>
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
To: adaplas@gmail.com
Cc: hch@infradead.org, akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: "Antonino A. Daplas" <adaplas@gmail.com>
Date: Thu, 17 May 2007 18:51:22 +0800

> On Thu, 2007-05-17 at 10:49 +0100, Christoph Hellwig wrote:
> > On Thu, May 17, 2007 at 05:33:48AM +0800, Antonino A. Daplas wrote:
> > > -#if defined(__sparc__) && !defined(__sparc_v9__)
> > > -	/* Should never get here, all fb drivers should have their own
> > > -	   mmap routines */
> > > -	return -EINVAL;
> > > -#else
> > > -	/* !sparc32... */
> > > +	if (fb_mmap_required())
> > > +		return -EINVAL;
> > > +
> > 
> > I don't like this bit.
> 
> Me too, actually. I did it this way because I don't want to deviate from
> the old code too much. Since all sparc32 drivers are either linked to
> sbuslib.c or has their own fb_mmap method, the above test is redundant. 
> I'll leave the decision to remove the above test to David Miller.

Feel free to remove it.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
