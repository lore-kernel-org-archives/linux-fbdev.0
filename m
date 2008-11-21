From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: fb_setcmap vs fb_setcolreg (was: Re: [PATCH]
 sh: sh7760fb: Fix color pallette setting)
Date: Fri, 21 Nov 2008 09:45:40 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0811210939380.12975@anakin>
References: <49264861.6030205@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1L3ReF-00016Y-8p
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Nov 2008 08:45:55 +0000
Received: from wilson.telenet-ops.be ([195.130.132.42])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L3ReC-00087a-Jv for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Nov 2008 08:45:55 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by wilson.telenet-ops.be (Postfix) with SMTP id 1515534014
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 21 Nov 2008 09:45:44 +0100 (CET)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by wilson.telenet-ops.be (Postfix) with ESMTP id D557334039
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 21 Nov 2008 09:45:43 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id mAL8jgAp029602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 21 Nov 2008 09:45:43 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id mAL8jgRI029591
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 21 Nov 2008 09:45:42 +0100
In-Reply-To: <49264861.6030205@renesas.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 21 Nov 2008, Nobuhiro Iwamatsu wrote:
> The setting of the color palette was wrong, fixed it.
> And removed fb_setcmap, and added fb_setcolreg function.

BTW, several drivers (radeonfb, omapfb, uvesafb, viafb) implement both
.fb_setcmap and .fb_setcolreg, which is a bit silly, as drivers/video/fbcmap.c
won't ever call .fb_setcolreg if .fb_setcmap is present.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
