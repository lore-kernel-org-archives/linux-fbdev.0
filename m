From: "Michael McLagan" <mmclagan@invlogic.com>
Subject: Bug in register_framebuffer ??
Date: Tue, 25 Nov 2003 16:20:42 -0500 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200311252120.hAPLKipU000562@utility.invlogic.com>
Reply-To: "Michael McLagan" <mmclagan@invlogic.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOkc8-0002ZO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Nov 2003 13:20:52 -0800
Received: from utility.invlogic.com ([198.182.196.8] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AOkc7-0004gK-W7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 25 Nov 2003 13:20:52 -0800
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
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: "nufan_wfk@yahoo.com" <nufan_wfk@yahoo.com>, "ivtv@kernel.dk" <ivtv@kernel.dk>

Hello,

   I'm looking into a problem with the ivtv (Hauppauge PVR) frame buffer
driver and I came across this piece of code in fbmem.c, line 782, v2.4.22:

>		for (j = 0; j < MAX_NR_CONSOLES; j++)
>			if (con2fb_map[j] == i) {
>				if (owner)
>					__MOD_INC_USE_COUNT(owner);
>				if (!fb_info->fbops->fb_open)
>					continue;
>				if (!fb_info->fbops->fb_open(fb_info,0))
>					continue;
>				if (owner)
>					__MOD_DEC_USE_COUNT(owner);
>			}
>		fb_ever_opened[i] = 1;

  I believe this is causing us a problem with the module usage count
being incremented despite there being no visible use on the system.  
Since the driver doesn't define fb_open, it looks like the above will
increment the use count without decrementing it.

Should it be coded:

		for (j = 0; j < MAX_NR_CONSOLES; j++)
			if ((con2fb_map[j] == i) && fb_info->fbops->fb_open) {
			    if (owner) {
				__MOD_INC_USE_COUNT(owner);
			        if (!fb_info->fbops->fb_open(fb_info,0))
				    __MOD_DEC_USE_COUNT(owner);
			    } else {
				fb_info->fbops->fb_open(fb_info,0);
			    }
			}
		fb_ever_opened[i] = 1;

Seems to me that does the same thing without artificially inflating
the module usage count.

If that makes sense, could someone either let me know or pass it on 
to Marcelo and Linus (assuming 2.6 uses the same piece of code)?

   Michael




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
