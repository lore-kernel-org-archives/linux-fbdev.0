From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Radeon 9000 on a linux 2.4.18 kernel.
Date: Fri, 24 Jan 2003 10:34:10 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301241033510.7472-100000@vervain.sonytel.be>
References: <20030124093155.GA1998@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18c0Ea-00086b-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 01:34:48 -0800
In-Reply-To: <20030124093155.GA1998@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 24 Jan 2003, Sven Luther wrote:
> On Fri, Jan 24, 2003 at 10:23:19AM +0100, Geert Uytterhoeven wrote:
> > On Fri, 24 Jan 2003, Sven Luther wrote:
> > >   2) Does anyone know how to check the pci ids of such a card from OF ?
> > 
> > dev /<path_to_device> (use `dev' and `ls' to find out)
> > .properties
> 
> Ok, thanks, will try, it is much easier (i guess) than blindly typing
> stuff in the the display less linux, and moving the disk (and the pci
> scsi card) between boxes. I already broke a pin of the vga connector
> attached to my monitor by doing this and had to buy a new monitor.

Serial console is still not working?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
