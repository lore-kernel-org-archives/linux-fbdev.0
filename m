From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH] fbdev: Batch cmap changes at driver
 level
Date: Mon, 2 May 2005 20:33:52 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505022031230.25864@pentafluge.infradead.org>
References: <1113175165.9568.516.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSgfz-0004m5-5T
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 May 2005 12:33:55 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DSgfy-000866-Jv
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 May 2005 12:33:55 -0700
In-Reply-To: <1113175165.9568.516.camel@gaston>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>


> This patch adds to the fbdev interface a set_cmap callback that allow
> the driver to "batch" palette changes. This is useful for drivers like
> radeonfb which might require lenghtly workarounds on palette accesses,
> thus allowing to factor out those workarounds efficiently.

> +	/* set color registers in batch */
> +	int (*fb_setcmap)(struct fb_cmap *cmap, struct fb_info *info);
> +
>  	/* blank display */
>  	int (*fb_blank)(int blank, struct fb_info *info);

The old fb_setcolreg is a hang over from the old api. Every driver 
implemented the fb_setcolreg but not every one has a fb_setcmap. So I went 
with fb_setcolreg instead. I hope to see drivers move over to this 
function instead. The only question is how to avoid setting color register 
that don't need changes. That can be expensive.
 


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
