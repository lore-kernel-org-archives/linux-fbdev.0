From: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Wed, 25 May 2005 16:53:05 -0700
Message-ID: <20050525165305.213eea85.akpm@osdl.org>
References: <Pine.LNX.4.60.0503220030230.12537@poirot.grange>
	<XFMail.20050322094106.jim.hague@acm.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Db5fk-00061A-B3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 16:52:24 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Db5fi-0005Qx-ON
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 16:52:24 -0700
In-Reply-To: <XFMail.20050322094106.jim.hague@acm.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jim Hague <jim.hague@acm.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, g.liakhovetski@gmx.de

Jim Hague <jim.hague@acm.org> wrote:
>
> On 21-Mar-2005 Guennadi Liakhovetski wrote:
> > On Mon, 21 Mar 2005, Andrew Morton wrote:
> >> Guennadi, could you please confirm that
> >> 
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.
> >> 12-rc1-mm1/broken-out/pm2fb-x-and-vt-switching-crash-fix.patch
> >> 
> >> fixes this one?
> > 
> > As discussed with Jim on linux-fbdev-devel this patch fixes the vt / X 
> > switching problem. We still don't know why starting with 2.4.11 I have to 
> > switch CONFIG_FB_PM2_FIFO_DISCONNECT off to restore colours / images.
> > [...]
> > I traced this breakage down to the patch to 
> > pm2fb.c after 2.6.10-rc2. Jim wanted to try to reproduce this problem with 
> > my fb-geometry / colour settings, but I haven't heard from him since then, 
> 
> FIrst off, so we're all clear, the problem with vt/X switching was definitely a
> pm2fb bug exposed by chages in fbcon, and is definitely fixed by the above
> patch. Please apply.
> 
> As to Guennadi's problem with colours and images, I've been trying to
> reproduce locally without success, hence silence. My pm2fb-on-Sparc
> correspondent hasn't seen this either, and I've had no other reports.
> 
> I have one possible clue, which I'll pursue with Guennadi off-list.

Guys, did all these things get fixed up in 2.6.12-rc5?

Thanks.


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
