From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fb: Remove use of lock_kernel /
 unlock_kernel in fbmem
Date: Tue, 15 Apr 2008 22:17:07 -0700
Message-ID: <20080415221707.82da3d42.akpm@linux-foundation.org>
References: <200804131150.07601.thiagogalesi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jm01E-0000pQ-PA for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 22:17:16 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jm01D-0006XR-Di
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 22:17:16 -0700
In-Reply-To: <200804131150.07601.thiagogalesi@gmail.com>
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
To: Thiago Galesi <thiagogalesi@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, 13 Apr 2008 11:50:07 -0300 Thiago Galesi <thiagogalesi@gmail.com> wrote:

> This patch removes lock_kernel(), unlock_kernel() usage in fbmem.c and replaces it with a mutex

It isn't that simple, alas.

vfs_ioctl() runs lock_kernel() prior to calling fb_ioctl(), so the
lock_kernel()s in fb_compat_ioctl() are actually providing exclusion against
fb_ioctl().  Your patch would break that.

A suitable fix might be to do

__fb_ioctl(...)
{
	<copy fb_ioctl() into here>
}

fb_ioctl(...)
{
	mutex_lock(&info->hwlock);
	__fb_ioctl(...);
	mutex_unlock(&info->hwlock);
}

and then change fb_compat_ioctl() to call __fb_ioctl().  All the other
callers of fb_ioctl() would need to be reviewed - see if they need to take
the mutex then call __fb_ioctl(), or they might be OK as they are, calling
fb_ioctl().

Then we can switch fb_fops over to

	.ioctl	= NULL,
	.unlocked_ioctl = fb_ioctl,



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
