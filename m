From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: Re: [FBDEV UPDATE] Newer patch.
Date: Fri, 31 Oct 2003 00:07:30 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031030230730.GA942@casa.fluido.as>
References: <20031023234552.GB554@phunnypharm.org> <Pine.LNX.4.44.0310301833140.4560-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFLt9-0004mX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 15:07:35 -0800
Received: from a205017.upc-a.chello.nl
	([62.163.205.17] helo=mail.fluido.as ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AFLt9-0000T4-06
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 15:07:35 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310301833140.4560-100000@phoenix.infradead.org>
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Ben Collins <bcollins@debian.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

	Subject: [Linux-fbdev-devel] Re: [FBDEV UPDATE] Newer patch.
	Date: gio, ott 30, 2003 at 06:38:46 +0000

Quoting James Simmons (jsimmons@infradead.org):

> I have fixed the problems you have reported. I have a newer patch. Note 
> this is updated with the LCD support. I like to see if the patch works on 
> sparc. I has updates from the latest 2.4.X kernels. Please give it a try.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> Let me know the results.

Thanks for integrating Ben's radeon stuff. But I have bad news.

I got a fresh 2.6.0test9 and patched it with your patch. First,
radeonfb_setup was missing from radeon_base.c, while it was declared
in fbmem.c. I applied the patch that was contributed to the list by
Javier Villavicencio a few days ago. Thus, I had a good compile. I
have video=radeonfb:1280x1024-32@75 set in my lilo.conf file. 

At reboot, my LCD screen complained about bad frequencies: 50.9 kHz
horizontal, and 43.7 Hz vertical. Normal frequencies with the above
settings are 80kHz and 75Hz. Passing 1280x1024-32@60 instead of
1280x1024-32@75 did not change the generated frequencies, so it seems
that interpretation of the mode line is not OK.

I plugged in an old CRT monitor, and I could see a normal screen. But
when starting X (set up with Option "UseFBDev" "true"), the LCD
monitor became happy of the frequency that it received but was frozen
with a garbled screen. And the keyboard was dead. I logged in remotely
and found out that the X executable was hanging and could not be
killed. Reboot was needed.

I can run at 1280x1024-32@75 with 2.6.0test7 with the original patches
from Ben (actually, using the whole kernel tree that he suggested I
should use, gotten via rsync). And X works OK in FB mode with his
kernel. With proper OpenGL acceleration.

All this with a radeon 9200 card. More info upon request...

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
