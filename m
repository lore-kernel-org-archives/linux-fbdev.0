From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [FBDEV]: Video mode change
	notify (fbset)
Date: Wed, 23 Jun 2004 11:00:32 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088006431.1854.151.camel@gaston>
References: <200406220639.20791.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdAJD-0004vl-OL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:09:11 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdAJB-0004gr-Rd
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:09:09 -0700
In-Reply-To: <200406220639.20791.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2004-06-21 at 17:39, Antonino A. Daplas wrote:
> Hi,
> 
> This patch allows fbset to change the video mode and the console
> window size via the notifier call chain.  It will only notify fbcon of
> mode changes from user space.  Changes coming from
> upstream will be ignored.
> 
> The code will only update the current console.

Excellent. I still want, at one point, to restore the per-vt var structure
in fbcon btw. 

Andrew, that should probably go in. The lack of fbset functionality is
a big regression of fbdev's in 2.6 compared to 2.4

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
