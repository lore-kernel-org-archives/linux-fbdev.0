From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH] - video/tdfxfb.c warning fix.
Date: Sat, 1 May 2004 20:47:10 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405012045070.25805@waterleaf.sonytel.be>
References: <20040430180451.GA3119@lorien.prodam> <20040430213513.7bafde36.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJzWA-0004VE-A1
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 11:47:18 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BJzW9-000516-PS
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 11:47:17 -0700
In-Reply-To: <20040430213513.7bafde36.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 30 Apr 2004, Andrew Morton wrote:
> "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br> wrote:
> >  This patch fixes this warning:
> >
> >   drivers/video/tdfxfb.c:1005: warning: `tdfxfb_cursor' defined but not
> >   used
> >
> >   and make the acceleration function selectable (like hgafb
> >  and tridentfb):
>
> You've taken a bunch of previously-working 3d acceleration functions and
> made them configurable, dependent upon CONFIG_EXPERIMENTAL.
>
> What on earth for?  Will this not gratuitously break people's
> previously-working 3d setups?

No, tdfxfb_cursor() was not used before, causing a compiler warning.
tdfxfb_cursor() may work, but we don't know, so we didn't dare to enable it by
default. Now the user (he who has the hardware) can enable it, and tell us
whether it works or not.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
