From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] fbdev updates.
Date: Thu, 4 Jul 2002 00:03:54 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020704000354.B4733@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207011041320.23794-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17PtAK-0006Fs-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 03 Jul 2002 16:04:05 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207011041320.23794-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Mon, Jul 01, 2002 at 10:48:41AM -0700
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Jul 01, 2002 at 10:48:41AM -0700, James Simmons wrote:
> Here are the latest updates to the framebuffer layer. Please test it outso
> I can push it as soon as possible to Linus.

The following comments are from a first review of sa1100fb.[ch] changes.

1. It would appear to break sa1100 inverse colourmap stuff.  There are LCD
   panels out there where it is a rather fundamental requirement to write
   the palette with "inverted" colourmap values.

2. I've no idea why you moved "lccr0" and "lccr3" in sa1100fb.h - this
   looks like noise to me.

3. I think you replaced "fbi" too many times:
	+/* Fake monspecs to fill in infonfo structure */

4. You're also merging in cpufreq changes from my tree in this patch;
   however I was going to send these to Linus along with the cpufreq
   submission so no problem.

5. I strongly disagree with your apparant decision to make the cpufreq
   part of the generic framebuffer core (by apparantly adding the notifier
   block to the core fb_info structure).  Firstly, you've broken sa1100fb.c
   by not including the relevant definition in fb_info (ok, so cpufreq
   stuff isn't in Linus' tree yet).  Secondly, it isn't something that all
   framebuffers require; its only required on SoC devices where the hardware
   designers have been stingy.  As such, we should NOT penalise the x86
   people by adding random useless garbage to structures that they're never
   going to use.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
