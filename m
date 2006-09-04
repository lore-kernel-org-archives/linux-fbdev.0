From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 8/9] atyfb: Improve
	atyfb_atari_probe()
Date: Mon, 4 Sep 2006 11:20:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0609041119520.6741@pademelon.sonytel.be>
References: <20060903220646.894202994@proteus.korsu.shacknet.nu>
	<20060903220704.533694946@proteus.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GKAdP-0005ip-3n for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 Sep 2006 02:20:51 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GKAdP-0000fp-DM
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 Sep 2006 02:20:52 -0700
In-Reply-To: <20060903220704.533694946@proteus.korsu.shacknet.nu>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: alex.kern@gmx.de, Ville Syrjala <syrjala@sci.fi>

On Mon, 4 Sep 2006 syrjala@sci.fi wrote:
> Improve atyfb_atari_probe():
> * Call correct_chipset() so that more par members, par->features in
>   particular, get initialized.

Thanks! This call was indeed missing for the Atari case.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
