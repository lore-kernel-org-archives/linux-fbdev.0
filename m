From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: (no subject)
Date: Fri, 28 May 2004 15:42:16 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405281542.16461.adaplas@hotpop.com>
References: <PMEKJGJGKKPHMBEGKNMIEEBKCCAA.xuhaoz@neonetech.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTc0b-0002Rf-2z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 May 2004 00:42:29 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTc0a-0002K4-IH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 May 2004 00:42:28 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 657B751603B
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 May 2004 07:10:01 +0000 (UTC)
In-Reply-To: <PMEKJGJGKKPHMBEGKNMIEEBKCCAA.xuhaoz@neonetech.com>
Content-Disposition: inline
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
To: xuhaoz <xuhaoz@neonetech.com>, linux-fbdev-devel@lists.sourceforge.net

On Wednesday 26 May 2004 17:00, xuhaoz wrote:
> hi all
> 	how can i config the framebuffer to be an available console?,i want the
> boot message to display onto the board lcd screen .i use uclinux2.4, arm7no
> mmu
>

1. If you are developing your own driver, you will need the following hooks.  
(You may not need all of them if you don't plan on changing video modes after 
initialization. Or at least provide a stub).

static struct fb_ops xxxfb_ops = {
	owner:		THIS_MODULE,
	fb_get_fix:		xxxfb_get_fix,
	fb_get_var:	xxxfb_get_var,
	fb_set_var:	xxxfb_set_var,
	fb_get_cmap:	xxxfb_get_cmap,
	fb_set_cmap:	xxxfb_set_cmap,
	fb_pan_display:	xxxfb_pan_display,
};

Then in your init, something like this:

info->fb_ops = &xxxfb_ops;

2. Add this to fbmem.c, (in static struct fb_drivers[]):

#ifdef CONFIG_FB_PVR2
	{ "xxx", xxxfb_init, xxxfb_setup },
#endif

xxxfb_setup can be NULL.

3.  If you can use one of the generic drawing functions, (see any of the 
fbcon_cfb*.c files). If not, you have to create those too.
  
Tony





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
