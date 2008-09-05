From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] efifb/imacfb consolidation +
	hardware support
Date: Thu, 4 Sep 2008 17:10:06 -0700
Message-ID: <20080904171006.3698819b.akpm@linux-foundation.org>
References: <48C001EC.3040205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KbOu1-0005BM-FC for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 17:10:17 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KbOu0-0005Ph-45
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 17:10:17 -0700
In-Reply-To: <48C001EC.3040205@redhat.com>
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
To: Peter Jones <pjones@redhat.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> User-Agent: Thunderbird 2.0.0.14 (X11/20080501)

uh-oh.

On Thu, 04 Sep 2008 11:42:36 -0400
Peter Jones <pjones@redhat.com> wrote:

> Hi.  Below is a patch that removes imacfb entirely, merging its DMI
> table into the (otherwise very similar) efifb driver.  This also adds
> hardware support for many of the newer Intel Apple hardware.  This has
> been fairly well tested; we've been shipping it in Fedora for some time.
> 

The patch was space-stuffed.  I fixed that.  Please see
Documentation/email-clients.txt to fix it.

Please send a Signed-off-by: for this change.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
