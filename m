From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH] sisfb accel capabilities
Date: Sun, 6 Jun 2004 13:08:44 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406061308181.4558@waterleaf.sonytel.be>
References: <20040603024412.GE20951@havoc.gtf.org> <40BEF4ED.7090909@winischhofer.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWvWK-0002UU-RV
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Jun 2004 04:08:56 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BWvWK-0002dI-Aa
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Jun 2004 04:08:56 -0700
In-Reply-To: <40BEF4ED.7090909@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: David Eger <eger@havoc.gtf.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 3 Jun 2004, Thomas Winischhofer wrote:
> > Also, using fbset to turn acceleration on and off ought to work, though
> > i still think this is better done via sysfs... just don't have time to
> > learn that ATM...
>
> This depends on that STUPID_ACCELF_TEXT_SHIT, right? Nice name... ;)
> Note that not only fbset needs this, but DirectFB as well.

And XFree86, in fbdev-friendly mode.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
