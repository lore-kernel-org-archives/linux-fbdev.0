From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Tue, 11 Mar 2003 23:27:37 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E6E62D9.40603@winischhofer.net>
References: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org>	<1047407816.1013.182.camel@localhost.localdomain> 	<3E6E4D9A.7060003@winischhofer.net> <1047419056.1100.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ssD5-0002CC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 14:27:00 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
> Unfortunately, this is what we are trying to prevent.  X assumes that
> the console is in text mode, so only registers that affect text mode are
> restored.  Frequently, cursor registers and bitmaps, as an example, are
> not refreshed.  There's probably more, ie accel engine, etc.

Argh.. of course, cursor and accelerator registers are usually not 
restored, you're right at this. But the drivers usually leave the engine 
in the same state as when started. (A "restore" of accelerator engine 
registers is mostly impossible, because a complete restore would cause 
the last command to be executed again)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
