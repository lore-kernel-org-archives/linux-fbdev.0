From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fb: convert lock/unlock_kernel()
	into local fb mutex
Date: Tue, 5 Aug 2008 02:00:29 -0700
Message-ID: <20080805020029.dfd783de.akpm@linux-foundation.org>
References: <20080805073755.bb8d5c8c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQIPm-0004Ti-Nl for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 02:01:10 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQIPk-0006Vb-CC
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 02:01:10 -0700
In-Reply-To: <20080805073755.bb8d5c8c.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 5 Aug 2008 07:37:55 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Change lock_kernel()/unlock_kernel() to local fb mutex.
> Each frame buffer instance has its own mutex.
> 
> The one line try_to_load() function is unrolled to
> request_module() in two places for readability.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> 
> The only caveat is that I had to put request_module()
> call outside this new mutex while it was inside the 
> lock_kernel() (inside fb_open()). 

Why did you have to do that?

The request_module() in fb_ioctl() is inside the lock...

> If the request_module() should be called only inside this mutex
> please drop the patch.

No, request_module() doesn't need lock_kernel().

The only possible problem I can see is the sole remaining lock_kernel()
in drivers/video/console/vgacon.c.  The fbcon.c code used to be
serialised against vgacon_do_font_op() via lock_kernel, but with this
change vgacon_do_font_op() can now run concurrently with all the code
which you've put inside fb_info.mutex_lock.  Probably not a problem, but
please check that sometime.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
