From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] tdfxfb: mtrr support
Date: Mon, 30 Jul 2007 13:58:45 +0200
Message-ID: <20070730135845.59d9a6cc.krzysztof.h1@wp.pl>
References: <20070729230653.d5dd086b.krzysztof.h1@wp.pl>
	<1185750991.9324.14.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IFTqE-0001hK-VC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jul 2007 04:55:15 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IFTqD-0007Ge-E5
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jul 2007 04:55:14 -0700
In-Reply-To: <1185750991.9324.14.camel@daplas>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, 30 Jul 2007 07:16:31 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:
> Since akpm already commented against using #ifdef's within functions,
> might as well modify the patch to something like this:
> 
> #ifdef CONFIG_MTRR
> static inline void tdfxfb_mtrr_add(struct fb_info *info)
> {
> 	struct tdfxfb_par *par = info->par;
> 
> 	par->mtrr_handle =  mtrr_add(info->fix.smem_start,
> 				 info->fix.smem_len, 
> 				 MTRR_TYPE_WRCOMB, 1);
> }
> #else
> #define tdfxfb_mtrr_add(...) do {} while (0)
> #endif

It doesn't really solve all mtrr #ifdefs problems.

The ultimate solution is to move mtrr.h to include/asm-generic or include/linux
directory.
It has redefined all functions as dummies in case CONFIG_MTRR is not
defined.

Regards,
Krzysztof

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
