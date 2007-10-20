From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: intelfb not working on a 945GM
Date: Sat, 20 Oct 2007 11:32:56 -0700
Message-ID: <200710201132.56787.jbarnes@virtuousgeek.org>
References: <47174F1A.4050307@spiro.fisica.unipd.it>
	<200710191409.28522.jbarnes@virtuousgeek.org>
	<471A2466.1020907@spiro.fisica.unipd.it>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IjJ8Z-0001oE-AT for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Oct 2007 11:33:27 -0700
Received: from outbound-mail-52.bluehost.com ([69.89.20.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IjJ8Y-0004KA-0F
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Oct 2007 11:33:27 -0700
In-Reply-To: <471A2466.1020907@spiro.fisica.unipd.it>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

On Saturday, October 20, 2007 8:53 am Paride Legovini wrote:
> I have no embedded requirements, I just don't always need X, and I
> like the framebuffer console in general. Thank you for the
> modesetting-101 hint, maybe I'll give it a try (I didn't ever know of
> its existence).

Yeah, we're trying to provide a more complete (i.e. 3d accel and other 
advanced features available) alternative to fb for people who don't 
want X (or want other features).  The fb layer is nice and simple, so 
for a lot of applications and devices it's a perfect fit.  If you want 
to use all the features of your card though, you're stuck with X and 
all its baggage.  The modesetting-101 tree is one big step away from 
that; it allows you to run a full 3d stack w/o X and w/o any of the 
conflicts that occur when you use DRM with the fb layer.

> Oh, sorry for writing to you directly and not to the list, I'm too
> used to lists where the Reply-To: header is set to the list's
> address.

No problem, it's conventional to reply to both the list and the 
individual anyway...

Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
