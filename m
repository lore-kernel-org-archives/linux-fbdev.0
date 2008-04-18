From: Andres Salomon <dilinger@queued.net>
Subject: Re: [PATCH] fb: Remove use of lock_kernel /
 unlock_kernel in fbmem
Date: Fri, 18 Apr 2008 13:41:12 -0400
Message-ID: <20080418134112.2a9c5929@ephemeral>
References: <200804131150.07601.thiagogalesi@gmail.com>
	<20080415221707.82da3d42.akpm@linux-foundation.org>
	<200804162000.59587.thiagogalesi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JmuYG-0004Qg-SD for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Apr 2008 10:39:08 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JmuY5-0006j4-Bz
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Apr 2008 10:38:58 -0700
In-Reply-To: <200804162000.59587.thiagogalesi@gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, 16 Apr 2008 20:00:59 -0300
Thiago Galesi <thiagogalesi@gmail.com> wrote:

> 
> This patch removes lock_kernel(), unlock_kernel() usage in fbmem.c and replaces it with a mutex
> 
> Signed-off-by: Thiago Galesi <thiagogalesi@gmail.com>
> 
[...]
> @@ -1413,6 +1435,8 @@ register_framebuffer(struct fb_info *fb_
>  
>  	event.info = fb_info;
>  	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
> +
> +	mutex_init(&fb_info->hwlock);
>  	return 0;
>  }
> 

Just a minor nit; in general, I'd think you would want to completely
initialize the structure (including calling mutex_init) before
registering the structure with the rest of the system (in this case,
with registered_fb and *_call_notifier_chain).  Initializing after
registration is just asking for a race conditions.


 
-- 
Need a kernel or Debian developer?  Contact me, I'm looking for contracts.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
