From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH]: rivafb DDC2/I2C
Date: 13 Jan 2004 09:09:15 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073956162.14430.17.camel@localhost.localdomain>
References: <1110.203.177.116.240.1073919544.squirrel@webmail.po.com> 
	<20040112173853.GA2176@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgD4j-0006xX-PI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jan 2004 17:10:33 -0800
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AgD4j-0006CL-EC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jan 2004 17:10:33 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id 1A003BDF295
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Jan 2004 01:03:52 +0000 (UTC)
In-Reply-To: <20040112173853.GA2176@dreamland.darkstar.lan>
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
To: kronos@kronoz.cjb.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-01-13 at 01:38, Kronos wrote:
>
>                         *mode = vesa_modes[i];
> -                       return 1;
> +                       mode->flag |= MODE_IS_STANDARD;
> +                       break;
> +               } else {
> +                       calc_mode_timings(xres, yres, refresh, mode);
> +                       mode->flag = MODE_IS_STANDARD | MODE_IS_CALCULATED;
> +                       break;
>                 }
>         }
> 
> This won't work. It will exit after the first iteration in any case. You
> reintroduced the same bug you spotted some time ago ;)

Thanks :-).  Fixed.

> Also, I see that you introduced fb_sqrt, we already have int_sqrt (see
> lib/int_sqrt.c). If the only issue was the return value you can change
> fb_sqrt to:
> 
> static inline u32 fb_sqrt(int x) {
>         return (u32)int_sqrt(x);
> }
> 

No issue.  Fixed.

>  
> > 2. modedb.c
> > - removed __init for fb_find_mode().
> 
> You have to change the prototype in fb.h. fb_find_mode was implemented
> in a different way if MODULE was defined.

Ok.

> 
> And if we are keeping modedb (~2.7KB) after initialization we should
> merge it with vesa_modes (we still have MODE_IS_VESA flag) and remove 
> duplicates.
> 

Possibly.  Will be on my TODO.

Tony






-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
