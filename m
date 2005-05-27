From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Sat, 28 May 2005 01:31:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0505280126280.22226@poirot.grange>
References: <Pine.LNX.4.60.0503220030230.12537@poirot.grange>
 <XFMail.20050322094106.jim.hague@acm.org> <20050525165305.213eea85.akpm@osdl.org>
 <Pine.LNX.4.60.0505270035250.13774@poirot.grange>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DboJD-0007SR-UA
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 27 May 2005 16:32:07 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DboJB-0000RO-U4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 27 May 2005 16:32:07 -0700
In-Reply-To: <Pine.LNX.4.60.0505270035250.13774@poirot.grange>
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

On Fri, 27 May 2005, Guennadi Liakhovetski wrote:

> On Wed, 25 May 2005, Andrew Morton wrote:
> 
> > Guys, did all these things get fixed up in 2.6.12-rc5?
> 
> At least I don't see the fix we discussed with Jim included. I'll 
> test-boot tomorrow. Anyway, I seem to be the only one affected, and 
> switching CONFIG_FB_PM2_FIFO_DISCONNECT fixes the problem, so, maybe we 
> could just mark this option "dangerous".
> 
> Will (try to) add tomorrow.

Confirmed - with CONFIG_FB_PM2_FIFO_DISCONNECT fb is still orange, without 
- no problem.

Thanks
Guennadi
---
Guennadi Liakhovetski



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
