From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: fbdev upstream (was: Changing modes with fbset)
Date: Wed, 24 Dec 2003 19:20:49 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1072254049.739.61.camel@gaston>
References: <3FD6C52C.7090906@undead.cc>  <3FDBB97F.4070207@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ4Gh-0002Ws-1M
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 00:21:23 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AZ4Gg-0003kr-Eg
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 00:21:22 -0800
In-Reply-To: <3FDBB97F.4070207@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-12-14 at 12:14, John Zielinski wrote:
> Found it.  It's a bug in fbcon.c where the rows and cols were mixed up 
> so fbcon_resize tries to set the mode again with xres and yres 
> reversed.  Didn't happen during boot as fbcon_state_manager is 
> registered after the console is taken over.

Good catch. I merged that in my tree (I use a different version of
the client notification mecanism though, I don't like much the
version that James pushed).

Since James vanished, I intend to take the most obvious bug fixes
and driver updates from his tree into mine, test them, and then
submit them one by one to Andrew Morton for 2.6.x inclusion.

I do not intend, at least in a first step, to take the sysfs
stuffs as the structure lifetime changes are fairly invasive and
happened to break a bunch of things. Once all the rest is merged
up, we can look into it again in more detail, isolated from the
other bunch of changes.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
