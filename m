From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and
 updated CyblaFB
Date: Wed, 14 Dec 2005 16:05:07 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0512141604281.498@pademelon.sonytel.be>
References: <439EF4CB.8030007@t-online.de> <20051213142054.4fd59226.akpm@osdl.org>
 <43A01969.6050109@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmYC0-0004nu-B8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 07:05:20 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EmYBx-0005jb-MW
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 07:05:20 -0800
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id jBEF57YL002312
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 Dec 2005 16:05:07 +0100 (MET)
In-Reply-To: <43A01969.6050109@t-online.de>
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

On Wed, 14 Dec 2005, Knut Petersen wrote:
> Andrew Morton wrote:
> > Masking pointers to 32 bits.  Is this driver supposed to be run on 64-bit
> > machines?
> >  
> Never can it be run on anything else but 32 bit machines because this graphics
> core is
> integrated in the VIA VT8601A northbridge. So the cpu is either a VIA C3,
> a VIA Eden, a Pentium III or a Celeron. It is planned to add support for
> closely related
> graphics cores, but also those can be run with nothing but 32 bit cpus,
> starting from the
> first pentium. Even if this driver would be compiled into a 64 bit kernel, the
> imageblit function never would be executed as the init code never will find
> the
> cyberblade/i1 graphics core in such a system.

Until VIA adds 64-bit support to it's C3 line...

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
