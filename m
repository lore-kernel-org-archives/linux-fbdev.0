From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.6.11-rc5
Date: Sun, 27 Feb 2005 09:07:37 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0502270906420.3143@numbat.sonytel.be>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
 <20050224145049.GA21313@suse.de>  <20050226004137.GA25539@suse.de>
 <1109380389.15026.112.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5JSx-0004pM-2H
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Feb 2005 00:07:51 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D5JSv-0005ak-BW
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Feb 2005 00:07:50 -0800
In-Reply-To: <1109380389.15026.112.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, Linus Torvalds <torvalds@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 26 Feb 2005, Benjamin Herrenschmidt wrote:
> On Sat, 2005-02-26 at 01:41 +0100, Olaf Hering wrote:
> > modedb can not be __init because fb_find_mode() may get db == NULL.
> > fb_find_mode() is called from modules.
> 
> Ahhh, good catch ! I though that was fixed long ago, looks like I was
> wrong.

Yep, I was surprised by this bug as well...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
