From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/13 v2] viafb: viafb.modes,
	viafb.txt
Date: Fri, 8 Aug 2008 13:32:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808081331130.420@anakin>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078B698D@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRQCu-0004U5-Bv for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 04:32:32 -0700
Received: from edna.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KRQCs-0001sU-Vg
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 04:32:32 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078B698D@exchtp03.taipei.via.com.tw>
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
To: JosephChan@via.com.tw
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, 8 Aug 2008, JosephChan@via.com.tw wrote:
> +    4. VX800 2D accelerator hasn't been supported in this driver yet. When
> +       using driver on VX800, one should add parameter "viafb_accel=0" to
> +       disable 2D accelerator.

Can't the driver detect this automatically, and disable the 2D
accelerator when running on a VX800?

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
