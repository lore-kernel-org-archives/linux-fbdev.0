From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 1/3] [FBDEV]: Core fbcon fixes
Date: Tue, 22 Jun 2004 21:20:59 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406222120.59948.adaplas@hotpop.com>
References: <200406220638.34214.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BclAl-0007uY-Gy
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 06:18:47 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BclAl-00012B-7g
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 06:18:47 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 40AAF5F7307
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 22 Jun 2004 12:39:02 +0000 (UTC)
In-Reply-To: <200406220638.34214.adaplas@hotpop.com>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 22 June 2004 06:39, Antonino A. Daplas wrote:
> This patch fixes the following bugs/regressions for fbcon:
>

Andrew, James

I found a few problems with all 3 patches.  

All of them are usable, by the way, I just want to clean up the code
for a few obvious mistakes that should not really affect anything
except for producing minor glitches in a few corner cases.

I'll resend today or tomorrow.

Thanks.

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
