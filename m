From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Question] sumbit VIAFB driver
Date: Tue, 6 May 2008 11:44:50 -0700
Message-ID: <20080506114450.8be56880.akpm@linux-foundation.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F363D2@exchtp03.taipei.via.com.tw>
	<Pine.LNX.4.64.0805052035180.3160@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtSAa-0001dC-Gu for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 May 2008 11:45:44 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JtSAT-0005YN-Qa
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 May 2008 11:45:39 -0700
In-Reply-To: <Pine.LNX.4.64.0805052035180.3160@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: JosephChan@via.com.tw, linux-fbdev-devel@lists.sourceforge.net

On Mon, 5 May 2008 20:37:22 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> 	Hi Joseph,
> 
> On Mon, 5 May 2008, JosephChan@via.com.tw wrote:
> > We would like to sumbit VIA's framebuffer device driver into kernel and
> > I've done the patch file.
> > But the patch seems too large to send (2 files exceed 2700 lines, other
> > 3 more files exceed 1000 lines), it's appreciated to guide me to
> > separate those signle file into multiple parts?
> 
> For review, you can split the patch in multiple parts (one for each big
> change) and send them separately.
> 
> For submission (after integrating the review comments!), you can send it as
> one big patch to Andrew Morton, I think. Andrew?
> 

Sure.  Just copy me on the split-up patches and remind me to join them all
together for upstream merging.


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
