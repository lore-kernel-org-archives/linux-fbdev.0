From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Cursor problems still in test9
Date: Fri, 31 Oct 2003 08:46:46 +1300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1067543205.4041.17.camel@laptop-linux>
References: <20031028094907.GA1319@elf.ucw.cz>
 <Pine.LNX.4.44.0310300436440.28721-100000@phoenix.infradead.org>
 <20031030090934.GC295@elf.ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFIwa-0000Ef-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 11:58:56 -0800
Received: from smtp1.clear.net.nz ([203.97.33.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AFIwZ-0001wi-Ta
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 11:58:56 -0800
Received: from 218-101-109-48.dialup.clear.net.nz
 (218-101-109-48.dialup.clear.net.nz [218.101.109.48])
 by smtp1.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0HNL00AR5661F2@smtp1.clear.net.nz> for
 linux-fbdev-devel@lists.sourceforge.net; Fri, 31 Oct 2003 08:58:55 +1300 (NZDT)
In-reply-to: <20031030090934.GC295@elf.ucw.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Pavel Machek <pavel@suse.cz>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

You can also see the cursor not getting erased if you try my software
suspend port with the nice display turned on. It works fine on 2.4, but
under 2.6 you get underlines all over the place, even though it tries to
hide the cursor.

Regards,

Nigel

On Thu, 2003-10-30 at 22:09, Pavel Machek wrote:
> Well, we certainly do not want to see artifacts leaved behind cursor,
> which is what 2.6 currently does. (Type something in bash, backspace
> over it).
> 
> Making it behave like it does now with 2.6, but with cursor properly
> deleted after after backspace, it would be okay.
> 
> [It should behave the same way on 2.4 vgacon and fbcon... with
> possible difference that "bright background" might cause characters to
> blink on vgacon. That depends on vga card setting and is not really
> important.]


-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
