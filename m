From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 12 Mar 2003 06:33:21 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047421959.1100.103.camel@localhost.localdomain>
References: <20030311220539.20321.qmail@web14912.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ssMH-0004DZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 14:36:29 -0800
In-Reply-To: <20030311220539.20321.qmail@web14912.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 06:05, Jon Smirl wrote:
> If your in messing with the early boot sequence, why
> don't you make the kernel initialize all of the video
> cards in the system instead of only the primary one.

Because I don't know how to :)?  It basically just involves a far call
no, if we know where the VBIOS code actually starts?  

Note that this will still be arch-specific.  Separate non-primary card
initialization code for each arch is still necessary.

> 
> Alsom is it really better to continue messing with
> these real mode X86 BIOS calls, or would it just be
> better to try and extract the info from the card
> vendors on how to do reset or get the DDC info? If we

Initialization can only be done in real mode.  Once the kernel is in
protected mode, BIOS code cannot be run again (without extreme
difficulty), so resetting is out of the question.

Unfortunately, we don't have info from manufacturers, so we rely on some
standards, such as VESA, to do it transparently for us.  Still VESA code
is mostly 16-bit.

> had the info about the cards we could just ignore the
> VBIOS and write this code into the protected mode FB
> drivers where it belongs. This problem just keeps
> recurring over and over on the non-X86 platforms; it's
> stupid having to carry around an X86 emulator just to
> run the VBIOS code.

Again, most BIOS code cannot run in protected mode, so we need to
emulate a real-mode environment for them.  It's doubtful that Linus
would want that in his kernel.  Our only chance to do this is during
early boot, or in user space.

> 
> I have a user space program that can reset secondary
> cards using their VBIOS and emulating X86 real mode.
> It can probably be easily modified to get the DDC info
> and then IOCTL it into the fb driver. I'll post it if
> you want.
> 

Yes, let me see what I can do.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
