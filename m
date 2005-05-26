From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Fri, 27 May 2005 00:38:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0505270035250.13774@poirot.grange>
References: <Pine.LNX.4.60.0503220030230.12537@poirot.grange>
 <XFMail.20050322094106.jim.hague@acm.org> <20050525165305.213eea85.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbR0P-0005U5-If
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 26 May 2005 15:39:09 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DbR0N-0003o0-3I
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 26 May 2005 15:39:09 -0700
In-Reply-To: <20050525165305.213eea85.akpm@osdl.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Jim Hague <jim.hague@acm.org>, linux-fbdev-devel@lists.sourceforge.net

On Wed, 25 May 2005, Andrew Morton wrote:

> Jim Hague <jim.hague@acm.org> wrote:
> >
> > On 21-Mar-2005 Guennadi Liakhovetski wrote:
> > > On Mon, 21 Mar 2005, Andrew Morton wrote:
> > >> Guennadi, could you please confirm that
> > >> 
> > >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.
> > >> 12-rc1-mm1/broken-out/pm2fb-x-and-vt-switching-crash-fix.patch
> > >> 
> > >> fixes this one?
> > > 
> > > As discussed with Jim on linux-fbdev-devel this patch fixes the vt / X 
> > > switching problem. We still don't know why starting with 2.4.11 I have to 
> > > switch CONFIG_FB_PM2_FIFO_DISCONNECT off to restore colours / images.
> > > [...]
> > > I traced this breakage down to the patch to 
> > > pm2fb.c after 2.6.10-rc2. Jim wanted to try to reproduce this problem with 
> > > my fb-geometry / colour settings, but I haven't heard from him since then, 
> > 
> > FIrst off, so we're all clear, the problem with vt/X switching was definitely a
> > pm2fb bug exposed by chages in fbcon, and is definitely fixed by the above
> > patch. Please apply.
> > 
> > As to Guennadi's problem with colours and images, I've been trying to
> > reproduce locally without success, hence silence. My pm2fb-on-Sparc
> > correspondent hasn't seen this either, and I've had no other reports.
> > 
> > I have one possible clue, which I'll pursue with Guennadi off-list.
> 
> Guys, did all these things get fixed up in 2.6.12-rc5?

At least I don't see the fix we discussed with Jim included. I'll 
test-boot tomorrow. Anyway, I seem to be the only one affected, and 
switching CONFIG_FB_PM2_FIFO_DISCONNECT fixes the problem, so, maybe we 
could just mark this option "dangerous".

Will (try to) add tomorrow.

Thanks
Guennadi
---
Guennadi Liakhovetski



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
