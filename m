From: Miles Lane <miles@megapathdsl.net>
Subject: Re: rivafb problems with 2.5.24 + latest fbdev.diff patch
Date: 27 Jun 2002 17:28:03 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1025224085.1632.2.camel@turbulence.megapathdsl.net>
References: <Pine.LNX.4.44.0206271312270.19152-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from front1.mail.megapathdsl.net ([66.80.60.31])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Njgj-0003gJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Jun 2002 17:32:37 -0700
In-Reply-To: <Pine.LNX.4.44.0206271312270.19152-100000@www.transvirtual.com>
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
To: James Simmons <jsimmons@transvirtual.com>
Cc: Fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2002-06-27 at 13:24, James Simmons wrote:

<snip>

> > 2)  After booting, running the command "fbset -a 1600x1200-76"
> > causes the machine to lock up.  This same command worked fine
> > with 2.5.22.
> 
> I noticed. The mode did change for me but it locked up. Nothing was
> recorded either. Since you are using serial console can you define
> RIVAFBDEBUG in fbdev.c and send me your output.

I tried this, but nothing got emitted on the serial console.
The system locked up, as before.

<snip>

> > 4)  Lastly, I have not yet figured out how to get rivafb
> > in the 2.5 series to boot directly into 1600x1200x16 @ 76Hz.
> [snip]..
> 
> > I was then informed that I should use "video=riva:1600x1200@75-16",
> > since there is no 76Hz entry in linux/drivers/video/modedb.c.
> 
> I attempted that one as well. It didn't work for me either.

Hmm. So you don't know what the correct method to do this is?
Or this is the correct way and it simply is not working.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
