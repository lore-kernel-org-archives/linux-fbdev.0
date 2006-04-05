From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Bug in vga16fb?
Date: Thu, 06 Apr 2006 00:48:48 +0200
Message-ID: <44344950.9090703@vc.cvut.cz>
References: <20060404204002.GB2251@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRGo2-0006S0-N3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Apr 2006 15:48:54 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FRGo1-0006vS-FY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Apr 2006 15:48:54 -0700
Received: from mailgw (localhost [127.0.0.1])
	by mailgw.cvut.cz (Postfix) with SMTP id 33CCB13B726
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  6 Apr 2006 00:48:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw.cvut.cz (Postfix) with ESMTP id 1A7F813B7F2
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  6 Apr 2006 00:48:49 +0200 (CEST)
Received: from mailgw.cvut.cz ([127.0.0.1])
	by localhost (mailgw [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 12993-01-33 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 6 Apr 2006 00:48:49 +0200 (CEST)
Received: from [127.0.0.1] (buk.vc.cvut.cz [147.32.240.88])
	by mailgw.cvut.cz (Postfix) with ESMTP id E73BA13B726
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  6 Apr 2006 00:48:48 +0200 (CEST)
In-Reply-To: <20060404204002.GB2251@localhost.localdomain>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Ondrej Zajicek wrote:
> Hello
> 
> I tried vga16fb driver in 320x200x4 nonstd mode (on i386 - little endian). In
> this mode framebuffer reports PACKED PIXELS type. Drawing through framebuffer
> is OK, but console is broken - it looks like that even and odd columns are
> exchanged.
> 
> Framebuffer structure of this mode is that even pixel is in high nibble and
> odd pixel is in low nibble.
> 
> It looks like vga16fb use cfbimgblt.c/slow_imageblit in this mode for
> image-blit and this function in CFB4 writes even pixel in low nibble and
> odd pixel in high nibble.
> 
> What is correct framebuffer structure for CFB4 mode?

Unfortunately there is no standard, as CFB4 itself is quite non-standard VGA 
mode.  Some videocards first output low nibble, followed by high, and some do 
otherwise.  I've experimented with this back in 2000, and I've found that Matrox 
Millennium does exactly opposite than some ATI Mach64 card I had in another box 
at that time.

So your only option is providing two CFB4 modes.  Unfortunately I have no idea 
how to autodetect what your hardware actually does without adding camera to the 
system...
							Petr Vandrovec



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
