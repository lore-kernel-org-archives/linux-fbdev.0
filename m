From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] Add w100 framebuffer driver
Date: Tue, 4 Jan 2005 10:31:46 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0501041029390.27452@waterleaf.sonytel.be>
References: <200501031947.33925.rpurdie@rpsys.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cll2p-0004KK-8b
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Jan 2005 01:32:03 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cll2j-00064i-U9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Jan 2005 01:32:03 -0800
In-Reply-To: <200501031947.33925.rpurdie@rpsys.net>
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
To: Richard Purdie <rpurdie@rpsys.net>
Cc: "adaplas@hotpop.com" <adaplas@hotpop.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 3 Jan 2005, Richard Purdie wrote:
> Add a framebuffer driver for the ATI w100 as found on several Sharp PDAs
> 
> Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

> +static int w100fb_pan_display(struct fb_var_screeninfo *var, struct fb_info 
> *info)
> +{
> +	return 0;
> +}

If your driver doesn't support panning, just don't fill in .fb_pan_display

> +static void w100_vsync()
                          ^
			  void

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
