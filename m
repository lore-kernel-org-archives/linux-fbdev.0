From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 1/2]Freescale i.MX framebuffer driver
Date: Fri, 18 Mar 2005 03:44:58 +0800
Message-ID: <200503180344.58891.adaplas@hotpop.com>
References: <20050317173624.GA29286@metis.extern.pengutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC0vX-0007l7-3U
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 11:45:03 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DC0vU-0007Nf-Ai
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 11:45:03 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A863CFD3C15
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Mar 2005 19:44:48 +0000 (UTC)
In-Reply-To: <20050317173624.GA29286@metis.extern.pengutronix.de>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Sascha Hauer <s.hauer@pengutronix.de>

On Friday 18 March 2005 01:36, Sascha Hauer wrote:
> Hello all,
>
> This Patch adds support for the framebuffer on the freescale i.MX SOC
> architecture. The driver has been tested on the mx1ads board, the pimx1
> board and another custom board with different displays.

Preliminary comments:

1. Can you use framebuffer_alloc()?  Meaning you have to change this:

struct imxfb_info {
       struct fb_info          fb;
	...
}

Then put all driver private data in info->par.

2. Comment on putting the blank function in the workqueue:  The console
expects that after calling fbcon_blank/fb_blank, that the hardware is really
in that state.  For example, after calling unblank(), the console expects
that it is entirely safe to write to the device because it will do so.

If it is indeed safe to access the  device on all blank states, then yes, a
workqueue should be fine.

3. Also add a Signed-off-by line and submit the patch inline.

Tony





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
