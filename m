From: Bryan Stillwell <bryan@bokeoa.com>
Subject: radeonfb and 16bit color problem
Date: Thu, 20 Jun 2002 21:29:58 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020620212958.B20756@bokeoa.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from morpheus.bokeoa.com ([66.7.161.57])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17LF7e-0004Dr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Jun 2002 20:30:07 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

I'm using version 0.1.5 of the radeonfb driver that Ani Joshi posted on
this list earlier this month with kernel 2.4.19pre10, and I've run into
a problem with the colors not being right in 16bit color mode.  In 15bit
color mode, everything seems to look good...

Since running `fbset 800x600-75 -depth 16` seems to want to switch to
15bit color and not 16bit color, I had to use `fbset 800x600-75 -depth
16 -rgba 5,6,5,0` to get into 16bit color mode.  However, once I'm in
16bit color and try to view some jpegs using fbi, the colors are messed
up.

Based of of how the colors in the images are changing, I'm guessing
that the video card is only using the lower 5 bits of green instead of
all 6 bits (chopping off the most significant bit.)  This causes colors
that were only 50% green before to become 100% green (and 25% green
before to become 50%.)

Any ideas would be helpful.  I tried looking at the code myself, but I'm
still quite new to the framebuffer code.  However, this part looked kind
of strange to me:

   /* For 565, the green component is mixed one order below */
   if (rinfo->depth == 16) {
      OUTREG(PALETTE_INDEX, pindex>>1);
      OUTREG(PALETTE_DATA, (rinfo->palette[regno>>1].red << 16) |
             (green << 8) | (rinfo->palette[regno>>1].blue));
      green = rinfo->palette[regno<<1].green;
   }


BTW, I have a Radeon 8500 (QL).

Thanks,
Bryan


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
