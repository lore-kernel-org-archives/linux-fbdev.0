From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: 2.5.34 -- vga16fb.c:177: In functio
Date: Tue, 10 Sep 2002 12:36:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1625D57726D@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oiOE-0007l8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Sep 2002 03:37:02 -0700
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
To: Jani Monoses <jani@iv.ro>
Cc: linux-fbdev-devel@lists.sourceforge.net, miles.lane@attbi.com

On 10 Sep 02 at 11:35, Jani Monoses wrote:

> very few drivers are converted to work with the new core James Simmons is working on.
> So most fb drivers won't compile.

I offered my updated vga16fb driver (which can do 8bpp and real text
except 4bpp, so you can watch fbtv at 320x200) when breakage to 2.5.33 
arrived, but nobody was interested (and I'm not going to port it to 
cfbaccel). If you are interested, you can pick patch from 
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/vga-2.5.34.gz.
It works on Matrox cards, and it is everything I can tell about it.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
