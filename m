From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb and 16bit color problem
Date: Mon, 24 Jun 2002 07:41:46 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020624054147.21846@192.168.4.1>
References: <20020625104117.A31689@bokeoa.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from n147.ols.wavesec.net ([209.151.19.147] helo=zion.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17MtiJ-0007cZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Jun 2002 10:02:47 -0700
In-Reply-To: <20020625104117.A31689@bokeoa.com>
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
To: Bryan Stillwell <bryan@bokeoa.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

>I thought that piece of code looked weird because it's setting green
>equal to rinfo->palette[regno<<1].green, but doesn't seem to ever use
>green during the rest of the function...

It should about 2 lines below ... at least in my tree.

>BTW, don't you mean 64 palette entries for green (being that it's 6
>bits)? 

Yah, sorry, typing too fast ;)

>Anyways, I took some time this weekend to look over the code
>some more, and I really doubt my problems originates in that function.
>As I understand it, the palette (colormap?) will only be used when
>displaying colors in text mode.

Hrm... there HW colormap is used in all modes in recent drivers, thus
you can actually set a gamma table. The driver should set it to a
linear ramp by default though that may be broken.

>My problem seems to affect many more colors (practically all 65536 of
>them), but I've yet to track it down.  I put in a request on ATI's
>website to get access to the specs (hoping that'll help me), but I
>haven't heard anything back from them yet.

Ben.



-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
