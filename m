From: Paul Mackerras <paulus@samba.org>
Subject: Re: cfbimgblt.c
Date: Sat, 24 Aug 2002 22:33:29 +1000 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9338.0278362476$1030224455@news.gmane.org>
References: <1029972099.551.3.camel@daplas>
	<Pine.LNX.4.33.0208221123140.9077-200000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dp.samba.org ([66.70.73.150] helo=lists.samba.org)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17ia9y-00022s-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 24 Aug 2002 05:36:58 -0700
In-Reply-To: <Pine.LNX.4.33.0208221123140.9077-200000@maxwell.earthlink.net>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

James Simmons writes:

> Paul please test the code.

(The new cfbimgblt.c, that is.)

It mostly seems to be fine, except there are some problems with the
cursor.  I have only tested it with the standard 8x16 font so far
though.  I had to add a #include <video/fbcon.h> near the top to get
the definitions of fb_readl and fb_writel.

It seems to be not erasing the cursor image when it should.  So, if I
am logged in on the console and I type a few characters and then press
backspace a few times, it leaves those character positions entirely
white.  Also, when I press return it leaves the cursor image on that
line as well as drawing the cursor after the shell prompt on the next
line.

I just tried with the old cfbimgblt.c and it also does the same
thing.  So it's not the new cfbimgblt.c that is doing this, it's
something else in your fbcon changes (or just possibly mine :).  This
is with atyfb with my patches.
Paul.


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
