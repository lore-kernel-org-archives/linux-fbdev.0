From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: rivafb problems with 2.5.24 + latest fbdev.diff patch
Date: Thu, 27 Jun 2002 13:24:07 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206271312270.19152-100000@www.transvirtual.com>
References: <3D12DB67.4010007@megapathdsl.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17NfoM-0005Hb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Jun 2002 13:24:14 -0700
In-Reply-To: <3D12DB67.4010007@megapathdsl.net>
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
Cc: Fbdev <linux-fbdev-devel@lists.sourceforge.net>


> 1)  When I boot, when the rivafb is activated, I don't see Tux.
> Instead, where Tux should be, there are about four or five text
> rows that are completely white.  The scrolling boot information
> does appear below the white rectangle.

Normal for now. No tux until I write the code. The white is due to a bug
in the upper framebuffer console system. I plan to fix that in the near
future. First I have port everything over.

> 2)  After booting, running the command "fbset -a 1600x1200-76"
> causes the machine to lock up.  This same command worked fine
> with 2.5.22.

I noticed. The mode did change for me but it locked up. Nothing was
recorded either. Since you are using serial console can you define
RIVAFBDEBUG in fbdev.c and send me your output.

> 3)  After starting up XFree86, when I switch to one of the
> VTs, all characters are reversed!  The lines are not reversed,
> but each character is displayed flipped on its vertical axis.

My fault. I set the new RIVA driver to MSB mode for dealing with images.
The X server uses the opposite. I did that to reduce the amount of code in
the kernel driver. Unfortunely X is broken so I have to add back the extra
code again.

> 4)  Lastly, I have not yet figured out how to get rivafb
> in the 2.5 series to boot directly into 1600x1200x16 @ 76Hz.
[snip]..

> I was then informed that I should use "video=riva:1600x1200@75-16",
> since there is no 76Hz entry in linux/drivers/video/modedb.c.

I attempted that one as well. It didn't work for me either.



-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
