From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: why not put LOGO_W and LOGO_H in linux_logo.h
 ?
Date: Thu, 22 Aug 2002 21:36:38 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0208222136220.9137-100000@vervain.sonytel.be>
References: <Pine.LNX.4.33.0208221226300.9077-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hxlf-0001l0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Aug 2002 12:37:19 -0700
In-Reply-To: <Pine.LNX.4.33.0208221226300.9077-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Stephane Wirtel <stephane.wirtel@belgacom.net>, Linux Frame Buffer Devel Mailing List <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 22 Aug 2002, James Simmons wrote:
> > > Good question. Is there any reason why this is?
> > it's more easy to change the logo if it is in linux_logo.h
> >
> > i modified fblogo, to make a linux_logo.h with LOGO_W and LOGO_H.
> 
> Geert how do you feel about thsi change?

For me that's OK.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
