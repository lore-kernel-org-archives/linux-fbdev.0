From: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: Rivafb not working properly in kernel 2.5.15.
Date: Sun, 12 May 2002 10:34:27 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0205121032480.6581-100000@shell.unixbox.com>
References: <3CDD34E4.4040803@megapathdsl.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from shell.unixbox.com ([207.211.45.65])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 176x4Y-0007Fr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 May 2002 10:23:50 -0700
In-Reply-To: <3CDD34E4.4040803@megapathdsl.net>
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
To: Miles Lane <miles@megapathdsl.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


What video board and arch (i'm assuming i386)?


ani

On Sat, 11 May 2002, Miles Lane wrote:

> I am running development kernel 2.5.15 and am having some
> trouble getting rivafb to display in the correct mode.
>
> After booting with "video=riva:1600x1200-16", fbset says:
>
> mode "1600x1200-60"
>      # D: 162.022 MHz, H: 75.010 kHz, V: 60.008 Hz
>      geometry 1600 1200 1600 1200 16
>      timings 6172 304 64 46 1 192 3
>      hsync high
>      vsync high
>      accel true
>      rgba 5/11,6/5,5/0,0/0
> endmode
>
> But the Tux logo is all purple.  After running fbset -a "1600x1200-76",
> I seem to have the correct mode:
>
> mode "1600x1200-76"
>      # D: 197.981 MHz, H: 95.183 kHz, V: 76.146 Hz
>      geometry 1600 1200 1600 1200 8
>      timings 5051 304 40 42 3 136 5
>      accel true
>      rgba 8/0,8/0,8/0,0/0
> endmode
>
> What do I need to change about my append= line in order to get
> the corrent mode set at boot time or is this a bug in the
> rivafb code in 2.5.15?
>
>
> _______________________________________________________________
>
> Have big pipes? SourceForge.net is looking for download mirrors. We supply
> the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
