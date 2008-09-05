From: Peter Jones <pjones@redhat.com>
Subject: Re: [PATCH] efifb/imacfb consolidation +
	hardware support
Date: Fri, 05 Sep 2008 10:05:42 -0400
Message-ID: <48C13CB6.4010506@redhat.com>
References: <48C001EC.3040205@redhat.com>
	<20080904171006.3698819b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KbbxE-0000l1-Oi for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 07:06:28 -0700
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KbbxD-0008Ix-9K
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 07:06:28 -0700
In-Reply-To: <20080904171006.3698819b.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
> 
> uh-oh.
> 
> On Thu, 04 Sep 2008 11:42:36 -0400
> Peter Jones <pjones@redhat.com> wrote:
> 
>> Hi.  Below is a patch that removes imacfb entirely, merging its DMI
>> table into the (otherwise very similar) efifb driver.  This also adds
>> hardware support for many of the newer Intel Apple hardware.  This has
>> been fairly well tested; we've been shipping it in Fedora for some time.
>>
> 
> The patch was space-stuffed.  I fixed that.  Please see
> Documentation/email-clients.txt to fix it.

Thanks for the pointer.

> Please send a Signed-off-by: for this change.

I'll assume that in this response is fine:

Signed-off-by: Peter Jones <pjones@redhat.com>


-- 
         Peter

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
