From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fb: convert lock/unlock_kernel()
	into local fb mutex
Date: Tue, 5 Aug 2008 09:04:43 -0700
Message-ID: <20080805090443.b423f9cf.akpm@linux-foundation.org>
References: <20080805100731.AC1E297A81B@f43.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQP2J-0004v6-Gh for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:05:26 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQP2I-0005ji-6z
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:05:23 -0700
In-Reply-To: <20080805100731.AC1E297A81B@f43.poczta.interia.pl>
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
To: krzysztof.h1@poczta.fm
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On 05 Aug 2008 12:07:30 +0200 krzysztof.h1@poczta.fm wrote:

> 
> Should I cc some other list or person next time?

Nope, linux-fbdev-devel is appropriate, and I'm processing all of the
fbdev patches.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
