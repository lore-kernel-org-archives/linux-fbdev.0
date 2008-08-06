From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: How to test virtual resolution
Date: Wed, 6 Aug 2008 21:17:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808062116260.17614@anakin>
References: <FE151544B54DB0428FFA9AE99C27A12102183DD0@az33exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQoWA-0001I2-2X for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 12:17:54 -0700
Received: from winston.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQoW8-0002xG-M7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 12:17:54 -0700
In-Reply-To: <FE151544B54DB0428FFA9AE99C27A12102183DD0@az33exm22.fsl.freescale.net>
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
To: sun york <yorksun@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 6 Aug 2008, sun york wrote:
> I was asked to add the support for virtual resolution for fsl_diu_fb. I
> don't know how to test it without X. It seems that fbcon can use the
> virtual resolution and pan around. Can someone shed some light on this?

You can try fbtest (CVS module FBdev/utlilities/fbtest on
http://sourceforge.net/projects/linux-fbdev).

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
