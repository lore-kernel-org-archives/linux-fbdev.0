From: James Simmons <jsimmons@infradead.org>
Subject: Re: My Matrox G200 died with 2.5.51
Date: Fri, 20 Dec 2002 18:58:40 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212201857410.6471-100000@phoenix.infradead.org>
References: <3DFDA124.10707@users.sf.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DFDA124.10707@users.sf.net>
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
To: nomero <nomero@users.sourceforge.net>
Cc: linux-fbdev-devel@lists.sourceforge.net


> I compiled the new 2.5.51 kernel and enabled the new framebuffer with 
> the VESA generic driver.
> My system is a Slackware 8.0. My graphic card was a Matrox G200 and the 
> resolution of fb console was 1024 X 768, 16M of colors (0x318).
> When I rebooted with my new kernel, i noted that fb didn't work well 
> (when i switched from a tty to another, some parts of the first tty were 
> "pasted" to the second).
> When I rebooted, my Matrox G200 died definetly.  I've made something 
> wrong or it's an fb's bug?
> If it is a bug, I hope to have been helpful.
> see you,

Your card died :-( Sounds like your hardware bit the dust. The VESA code 
isn't able to kill any cards as it depends on the BIOS to do the right 
thing.




-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
