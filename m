From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: atyfb and radeonfb
Date: Thu, 14 Nov 2002 12:09:58 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0211141209250.8876-100000@vervain.sonytel.be>
References: <1037142584.2774.230.camel@zion>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18CHtT-0001lX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Nov 2002 03:10:43 -0800
In-Reply-To: <1037142584.2774.230.camel@zion>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Steven Newbury <steven.newbury1@ntlworld.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 13 Nov 2002, Benjamin Herrenschmidt wrote:
> On Fri, 2002-11-08 at 16:28, Steven Newbury wrote:
> > Is atyfb in 2.4 known to work with recent Mach64 chips like Rage XL? 
> > When I install the driver it detects the chip but results in just a 
> > black screen.  I also noticed that it detects WRAM, whereas I am certain 
> > it should be SGRAM.  The XFree86 driver detects everything ok and just 
> > works.
> 
> Well, I don't know if Geert still have much time to maintain
> this driver, any help implementing the missing features would
> be nice ;)

Erhm, not really...

For RAGE XL support, you want to contact Steve Longerbeam <stevel@mvista.com>.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
