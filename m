From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 19:39:23 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020705193923.G27920@flint.arm.linux.org.uk>
References: <20020705185754.C27920@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207051123240.25589-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QXzO-0000ob-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 11:39:31 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207051123240.25589-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Fri, Jul 05, 2002 at 11:32:51AM -0700
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

On Fri, Jul 05, 2002 at 11:32:51AM -0700, James Simmons wrote:
> > James, you're OTT here.
> 
> I apologize I'm sorry. I did get upset. Its just this has been discussed
> time and time again. It gets annoying after awhile and it stopped me from
> completing the fbdev changes in the last development series. I don't want
> that again.

Rubbish.  You posted a fbdev interface change to linux-kernel when the
kernel was supposed to be stabilising.  I converted several of my drivers
to the new interface the best I could.  The drivers are coded in such a
way to make the final stages of your changes as trivial as possible.  I
did find a few bugs with the interface several months later, and had to
undo some of the changes.  However, all work on the new interface appeared
to have stopped.

_I_ didn't stop your fbdev changes.  You stopped them yourself when other
driver maintainers didn't comply with your ill-timed request.  That caused
me to have to back out some of the changes.

And that's the situation today.  If you want to carry on this slagging
match... but its not getting either of us anywhere.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
