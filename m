From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH][RIVAFB]: Updates to rivafb driver
Date: Thu, 17 Jun 2004 06:29:27 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406170629.27427.adaplas@hotpop.com>
References: <200406160406.07060.adaplas@hotpop.com> <Pine.LNX.4.56.0406161743100.14901@pentafluge.infradead.org> <20040616132318.1435b0c7.akpm@osdl.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Baiu7-0007Dl-Li
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 15:29:11 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Baiu7-00026t-Af
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 15:29:11 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 34A8A5EC3C5
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Jun 2004 21:51:05 +0000 (UTC)
In-Reply-To: <20040616132318.1435b0c7.akpm@osdl.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org
Cc: adaplas@pol.net, eger@havoc.gtf.org, linux-fbdev-devel@lists.sourceforge.net

On Thursday 17 June 2004 04:23, Andrew Morton wrote:
> jsimmons@pentafluge.infradead.org wrote:
> > Nice. I will apply.
>
> And then what will happen?
>
> Patches seem to disappear into the linux-fbdev tree never to be seen again.
> What can we do about this?
>

Andrew,

Can you also apply it (and the rivafb update patch) to your tree?  Especially the 
best-fit mode patch in -mm2 branch which fixes the broken stty functionality. 

I'll also submit corresponding changes to James' fbdev tree (once he releases
a diff against one of the 2.6.x branch -- I don't have BK).  

Tony




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
