From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 20:41:07 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020705204107.H27920@flint.arm.linux.org.uk>
References: <Pine.BSF.4.44.0207051222060.63178-100000@shell.unixbox.com> <Pine.LNX.4.44.0207051228510.30731-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QYx9-0000Lb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 12:41:16 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207051228510.30731-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Fri, Jul 05, 2002 at 12:32:57PM -0700
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
Cc: Ani Joshi <ajoshi@shell.unixbox.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Jul 05, 2002 at 12:32:57PM -0700, James Simmons wrote:
> It is and has started to got into the mainline kernel. The thing was I was
> bending over backwards to not break peoples drivers.

If it's something small, then driver people don't mind having their
drivers fixed.

However, if its something large, just break them and let the driver people
fix up the pieces (assuming you've got adequate documentation either in
code or elsewhere for people to see both the reasons for the breakage,
the direction you're heading in, and an example driver to follow.)
Chances are that they'll know their driver better than anyone else.  If
it stays broken through the next stable series, then start considering
dropping the driver.

That's how it works in the other subsystems.

(FYI, you'll probably find that most people who didn't use the fbgen layer
decided not to use it because of the fix <-> par <-> var mess it forced
into the driver design.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
