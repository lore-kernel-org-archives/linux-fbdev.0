From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: Tue, 1 Apr 2003 07:22:09 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030401152209.91116.qmail@web14913.mail.yahoo.com>
References: <1049203284.1050.14.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14913.mail.yahoo.com ([216.136.225.240])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190NaU-00058i-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 07:22:10 -0800
In-Reply-To: <1049203284.1050.14.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--- Antonino Daplas <adaplas@pol.net> wrote:
> 4. fb_validate_mode(struct fb_var_screeninfo *var,
> struct fb_info *info)
> 
> - validate mode timings in var
> 
> 5. fb_get_mode(int flags, int val, struct
> fb_var_screeninfo *var, struct
> fb_info *info)
> 
> - compute mode timings using GTF (refresh driven,
> hsync driven, pixclock
> driven, or maximized refresh) and place result in
> var
> 
> #4 and #5 are already in fbmon.c
>

Wouldn't it be better to make fb_get_mode only return
the list of valid modes based on the hardware and
monitor (if available) combination rather than letting
the app sort it out?

We could then make a new IOCTL fb_get_hwmode for
returning the card's capabilities if more detail is
desired.


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://platinum.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
