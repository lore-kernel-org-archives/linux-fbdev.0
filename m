From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Radeon: do not blank screen during suspend
Date: Sat, 18 Sep 2004 14:47:02 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1095482822.3574.24.camel@gaston>
References: <20040915112652.GA21386@elf.ucw.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8X8D-0001UO-5z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 21:47:29 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1C8X8C-0005yV-Cm
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 21:47:29 -0700
In-Reply-To: <20040915112652.GA21386@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: ajoshi@shell.unixbox.com, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>

On Wed, 2004-09-15 at 21:26, Pavel Machek wrote:
> Hi!
> 
> This stops ugly flashing from radeon during suspend/resume, please
> apply,

Shoud be fine.

BTW. What is the status with Patrick merge of pmdisk & swsusp ? Has it
been merged at all ? (No time to check at the moment). I still hope I'll
find some time to do real work on it (& cleanup the ppc support that I
had working experimentally at OLS) sooner or later...

Ben.
							Pavel
> 
> --- clean-mm/drivers/video/aty/radeon_pm.c	2004-08-24 09:03:18.000000000 +0200
> +++ linux-mm/drivers/video/aty/radeon_pm.c	2004-09-15 13:00:51.000000000 +0200
> @@ -871,7 +871,8 @@
>  	agp_enable(0);
>  #endif
>  
> -	fb_set_suspend(info, 1);
> +	if (system_state != SYSTEM_SNAPSHOT)
> +		fb_set_suspend(info, 1);
>  
>  	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
>  		/* Make sure engine is reset */
> @@ -880,12 +881,14 @@
>  		radeon_engine_idle();
>  	}
>  
> -	/* Blank display and LCD */
> -	radeonfb_blank(VESA_POWERDOWN, info);
> -
> -	/* Sleep */
> -	rinfo->asleep = 1;
> -	rinfo->lock_blank = 1;
> +	if (system_state != SYSTEM_SNAPSHOT) {
> +		/* Blank display and LCD */
> +		radeonfb_blank(VESA_POWERDOWN, info);
> +
> +		/* Sleep */
> +		rinfo->asleep = 1;
> +		rinfo->lock_blank = 1;
> +	}
>  
>  	/* Suspend the chip to D2 state when supported
>  	 */
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
