From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH] - video/tdfxfb.c warning fix.
Date: Sat, 1 May 2004 21:17:02 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405012116490.25805@waterleaf.sonytel.be>
References: <20040430180451.GA3119@lorien.prodam> <20040430213513.7bafde36.akpm@osdl.org>
 <Pine.GSO.4.58.0405012045070.25805@waterleaf.sonytel.be>
 <20040501120852.139b4ac1.akpm@osdl.org> <20040501120936.62c6db39.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJzz0-0005f8-5V
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 12:17:06 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BJzyz-0002By-LW
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 01 May 2004 12:17:05 -0700
In-Reply-To: <20040501120936.62c6db39.akpm@osdl.org>
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
Cc: lcapitulino@prefeitura.sp.gov.br, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 1 May 2004, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> >  Does the same argument apply to this patch?
>
> And to this one?
>
>
> From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
>
> Make HGA acceleration functions selectable in kernel config, fix these
> warnings:

Yep.

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
