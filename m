From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: Re: Re: [PATCH] - video/tdfxfb.c warning fix.
Date: Mon, 3 May 2004 13:09:19 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040503160919.GC1219@lorien.prodam>
References: <20040430180451.GA3119@lorien.prodam> <20040430213513.7bafde36.akpm@osdl.org> <Pine.GSO.4.58.0405012045070.25805@waterleaf.sonytel.be> <20040501120852.139b4ac1.akpm@osdl.org> <Pine.GSO.4.58.0405012115260.25805@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKg1N-0007K2-Bm
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 May 2004 09:10:21 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKg0r-0002ek-7z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 May 2004 09:09:49 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0405012115260.25805@waterleaf.sonytel.be>
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, lcapitulino@prefeitura.sp.gov.br, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Em Sat, May 01, 2004 at 09:16:29PM +0200, Geert Uytterhoeven escreveu:

| On Sat, 1 May 2004, Andrew Morton wrote:
| > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
| > >  > You've taken a bunch of previously-working 3d acceleration functions and
| > >  > made them configurable, dependent upon CONFIG_EXPERIMENTAL.
| > >  >
| > >  > What on earth for?  Will this not gratuitously break people's
| > >  > previously-working 3d setups?
| > >
| > >  No, tdfxfb_cursor() was not used before, causing a compiler warning.
| > >  tdfxfb_cursor() may work, but we don't know, so we didn't dare to enable it by
| > >  default. Now the user (he who has the hardware) can enable it, and tell us
| > >  whether it works or not.
| >
| > OK, thanks.  As you can see, it really helps if people explain this sort of
| > thing in their initial patch (sigh).
| >
| > Does the same argument apply to this patch?
| 
| Yes. All these patches should enable the currently unused acceleration routines
| if the corresponding config option is set, and kill the compiler warnings if
| its not set.

 Humm, my fault. I thought my comments was enough, will try to make
better in next time.

PS: Andrew, I always need to think about "be very clear" vs "Andrew's time
to read e-mails". It is not a easy task. :-)

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
