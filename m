From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2 v2] Add DIU platform code for
	MPC8610HPCD
Date: Tue, 25 Mar 2008 12:18:04 -0700
Message-ID: <20080325121804.a273944e.akpm@linux-foundation.org>
References: <12059526271941-git-send-email-yorksun@freescale.com>
	<12059526274026-git-send-email-yorksun@freescale.com>
	<12059526271964-git-send-email-yorksun@freescale.com>
	<20080320153304.cdc1817d.akpm@linux-foundation.org>
	<20080325124322.GH12798@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JeEfA-0005Gy-F7 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Mar 2008 12:18:25 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JeEf9-0004fd-69
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Mar 2008 12:18:24 -0700
In-Reply-To: <20080325124322.GH12798@shadowen.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andy Whitcroft <apw@shadowen.org>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, yorksun@freescale.com, galak@kernel.crashing.org, linux-kernel@vger.kernel.org

On Tue, 25 Mar 2008 12:43:22 +0000
Andy Whitcroft <apw@shadowen.org> wrote:

> > > ...
> > >
> > > +unsigned int mpc8610hpcd_get_pixel_format
> > > +	(unsigned int bits_per_pixel, int monitor_port)
> 
> This seems like it might be detectable, does this seem like something we
> should try an report?

I guess so.  It's quite unusual.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
