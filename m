From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: scroll modes
Date: Wed, 30 Nov 2005 13:48:59 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be>
References: <438D9E60.7040007@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhROV-0006K0-Rb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 04:49:07 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhROV-00052H-Dc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 04:49:08 -0800
In-Reply-To: <438D9E60.7040007@t-online.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

On Wed, 30 Nov 2005, Knut Petersen wrote:
> Is there a patch for "true ywrap" scrolling?

Is there a need for a patch (except for a patch to cyblafb)?

> There is no need for moving data around in video memory or to redraw the
> screen
> as the cyberblade hardware handles wrapping at the end of the video memory
> perfectly
> fine.

Ywrap has been working fine with amifb since ages (unless someone broke it very
recently).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
