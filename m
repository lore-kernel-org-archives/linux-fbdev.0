From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1 2.6.15-rc4-git1] Fixing switch to KD_TEXT, enhanced
 version
Date: Sat, 10 Dec 2005 22:32:15 +0800
Message-ID: <439AE6EF.6070006@gmail.com>
References: <439A81AE.5030509@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1El5mE-0000EA-JN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 06:32:42 -0800
Received: from wproxy.gmail.com ([64.233.184.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1El5mE-0000Ya-7s
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 06:32:42 -0800
Received: by wproxy.gmail.com with SMTP id 68so1531616wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 10 Dec 2005 06:32:38 -0800 (PST)
In-Reply-To: <439A81AE.5030509@t-online.de>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Every framebuffer driver relies on the assumption that the
> set_par() function of the driver is called before drawing
> functions and other functions dependent on the hardware
> state are executed.
> 
> Whenever you switch from X to a framebuffer console for the
> very first time, there is a chance that a broken X system has
> _not_ set the mode to KD_GRAPHICS, thus the vt and framebuffer
> code executes a screen redraw and several other functions
> before a set_par() is executed. This is believed to be not a
> bug of linux but a bug of X/xdm. At least some X releases
> used by SuSE and Debian show this behaviour.
> 
> There was a 2nd case, but that has been fixed by Antonino
> Daplas on 10-dec-2005.
> 
> This patch allows drivers to set a flag to inform fbcon_switch()
> that they prefer a set_par() call on every console switch,
> working around the problems caused by the broken X releases.
> 
> The flag will be used by the next release of cyblafb and might
> help other drivers that assume a hardware state different to
> the one used by X.
> 
> As the default behaviour does not change, this patch should
> be acceptable to everybody.
> 
> Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

Acked-by: Antonino Daplas <adaplas@pol.net>

> +#define FBINFO_MISC_ALLWAYS_SETPAR   0x40000
                       ^^^^^^^
Please post a follow up patch to fix the spelling.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
