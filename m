From: James Simmons <jsimmons@infradead.org>
Subject: Re: atyfb: 2.5.54
Date: Tue, 7 Jan 2003 22:09:39 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301072205400.17129-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0301072257220.21057-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W1vO-0006dn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 14:10:18 -0800
In-Reply-To: <Pine.GSO.4.21.0301072257220.21057-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nico Schottelius <schottelius@wdt.de>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> Atyfb is known not to work on some Rage Mobility P/M (incl. the one in my Vaio
> :-(

A have a few patchs for atyfb that I haven't got around to applying just 
yet. One is Popov non BIOS patch for some cards. I have another patch for 
a new DAC for older MACH 64 cards. The big issue I like to see solved is 
to us ethe hardware cursor. Right now I have it disabled, its using 
soft_cursor. I haven't had the time to look at teh specs for how the data 
is layed out for the cursor image. We have in atyfb.h

struct aty_cursor {
	u8 bits[8][64];
	u8 mask[8][64];
	u8 *ram;
}

This is really weird. I like to translate to the new api.





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
