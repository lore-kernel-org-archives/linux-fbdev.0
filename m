From: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Subject: Re: [PATCH 4/4] cirrusfb: fix error paths in
	cirrusfb_xxx_register()
Date: Wed, 25 Feb 2009 09:48:40 +0100
Message-ID: <10f740e80902250048j31a9a2c5n5c39066ba156c10d@mail.gmail.com>
References: <20090224223702.86f7e129.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1LcFRj-0006Nu-IC
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Feb 2009 08:48:51 +0000
Received: from mail-bw0-f157.google.com ([209.85.218.157])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LcFRa-0004kj-MM for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Feb 2009 08:48:51 +0000
Received: by bwz1 with SMTP id 1so6406609bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Feb 2009 00:48:40 -0800 (PST)
In-Reply-To: <20090224223702.86f7e129.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, linux-m68k@lists.linux-m68k.org

Hi Krzysztof,

On Tue, Feb 24, 2009 at 22:37, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> It is not an end to cirrusfb patches unfortunately.
> I have just got a GD5446 (Picasso4) and it locks up
> my computer when the cirrusfb module is loaded.
> Time to fix this model as well...

Cool! Which Amiga model do you have?

The Picasso4 is also not yet supported in Zorro II mode. There are some docs
available (it's just about using the right offsets), but as I don't
have the hardware,
I never did it myself. Christian Steigies is probably most interested...

Gr{oetje,eeting}s,


     Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
