From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Possible bug: nasty interaction between
 framebuffer and DRI/DRM
Date: Fri, 31 May 2002 22:10:53 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0205312209030.13028-100000@vervain.sonytel.be>
References: <200205311939.13659.chrish@gmx.co.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.sonytel.be ([193.74.243.200])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Dsjq-0004xA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 May 2002 13:11:07 -0700
In-Reply-To: <200205311939.13659.chrish@gmx.co.uk>
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
To: Chris Howells <chrish@gmx.co.uk>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 31 May 2002, Chris Howells wrote:
> On Friday 31 May 2002 1:08 pm, Geert Uytterhoeven wrote:
> 
> > Do you use `option UseFBDev' in your XF86Config?
> 
> No I'm not. Should I be?

Yes. Without that option, the X server will change the graphics chip's
registers behind the back of aty128fb.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
