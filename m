From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 10:56:00 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404271054530.14434@waterleaf.sonytel.be>
References: <60004.64.139.3.221.1082827760.squirrel@www.foogod.com>
 <Pine.LNX.4.44.0404250138120.15965-100000@phoenix.infradead.org>
 <10078.171.72.5.226.1083003170.squirrel@www.foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIONw-0003dE-2K
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 01:56:12 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIONv-0006Ne-PV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 01:56:11 -0700
In-Reply-To: <10078.171.72.5.226.1083003170.squirrel@www.foogod.com>
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
To: Alex Stewart <alex@foogod.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 26 Apr 2004, Alex Stewart wrote:
> yres_virtual does need to be set larger than yres in order for ypanning to
> function, last I checked.  In order to set it to the correct value for the
> particular card, we set it to 30000 (very large), and then call check_var
> to have it scale it down to what the hardware can handle (this seems

Hmm, but the `rules' are to round _up_ a value if it doesn't fit, or return an
error.

Rounding down violates this rule.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
