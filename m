From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Tue, 11 Mar 2003 23:23:02 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E6E61C6.2000503@winischhofer.net>
References: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org>	<1047407816.1013.182.camel@localhost.localdomain> 	<3E6E4D9A.7060003@winischhofer.net> <1047419056.1100.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ss9C-0001Bc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 14:22:59 -0800
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
>>>2. do not refresh unless var changed - fasted but can result in
>>>corruption/crash if registers were changed behind the back of fbdev
>>
>>I think one can rely on tidyness of applications changing the registers. 
>>Like X does.
> 
>  
> Unfortunately, this is what we are trying to prevent.  X assumes that
> the console is in text mode, so only registers that affect text mode are
> restored.  Frequently, cursor registers and bitmaps, as an example, are
> not refreshed.  There's probably more, ie accel engine, etc.

That surprises me. The X drivers I looked at (quite a bunch) restore all 
registers (that need to be restored, that is)

>>>3. selective refresh - do not refresh if switching between "trusted"
>>>consoles, refresh if switching from "untrusted" consoles.
>>
> 
> I actually prefer #3, and I already have working code for this.  We can
> also make this driver switchable (ie, drivers that are not affected by X
> can disable this, and only drivers that are affected such as the riva,
> aty, radeon, etc can turn this on).

What exactly is a "trusted" console?

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
