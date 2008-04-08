From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 3/4] pxafb: move parallel LCD timing
	setup into dedicate function
Date: Tue, 8 Apr 2008 18:01:46 +0800
Message-ID: <f17812d70804080301j5670244dr21346e75c4744eab@mail.gmail.com>
References: <f17812d70804072105r57413cc4gba7f66abb4724809@mail.gmail.com>
	<20080408012136.30b71560.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JjAeC-00081S-G9 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 03:01:48 -0700
Received: from wa-out-1112.google.com ([209.85.146.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JjAeB-0000Xf-72
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 03:01:48 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1894881waf.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 08 Apr 2008 03:01:46 -0700 (PDT)
In-Reply-To: <20080408012136.30b71560.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Mack <daniel@caiaq.de>, lkml <linux-kernel@vger.kernel.org>

On Tue, Apr 8, 2008 at 4:21 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 8 Apr 2008 12:05:16 +0800 "eric miao" <eric.y.miao@gmail.com> wrote:
>
>  > @@ -636,61 +671,31 @@ static int pxafb_activate_var(struct
>  > fb_var_screeninfo *var,
>  >               printk(KERN_ERR "%s: invalid lower_margin %d\n",
>  >                       fbi->fb.fix.id, var->lower_margin);
>  >  #endif
>  > +     /* Update shadow copy atomically */
>  > +     local_irq_save(flags);
>
>  So this code will only ever work on uniprocessor machines?
>
>  Is this a safe and reasonable assumption?
>

Y, this is a reasonable assumption for PXA2xx/3xx, though as noted in
the comment, it's too heavy for an local_irq_{save,restore} here, but
a fix to this would involve more investigation, so I'd rather have this
fixed later.

-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
