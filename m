From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] pxafb: move parallel LCD timing
 setup into dedicate function
Date: Tue, 8 Apr 2008 01:21:36 -0700
Message-ID: <20080408012136.30b71560.akpm@linux-foundation.org>
References: <f17812d70804072105r57413cc4gba7f66abb4724809@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jj95r-0005aR-3o for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 01:22:15 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jj95o-0003A8-Pc
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 01:22:15 -0700
In-Reply-To: <f17812d70804072105r57413cc4gba7f66abb4724809@mail.gmail.com>
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
To: eric miao <eric.y.miao@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Mack <daniel@caiaq.de>, lkml <linux-kernel@vger.kernel.org>

On Tue, 8 Apr 2008 12:05:16 +0800 "eric miao" <eric.y.miao@gmail.com> wrote:

> @@ -636,61 +671,31 @@ static int pxafb_activate_var(struct
> fb_var_screeninfo *var,
>  		printk(KERN_ERR "%s: invalid lower_margin %d\n",
>  			fbi->fb.fix.id, var->lower_margin);
>  #endif
> +	/* Update shadow copy atomically */
> +	local_irq_save(flags);

So this code will only ever work on uniprocessor machines?

Is this a safe and reasonable assumption?

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
