From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: Status of radeonfb in 2.5?
Date: Wed, 16 Oct 2002 16:55:11 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DADD22F.9030508@netscape.net>
References: <3DACA222.5030409@netscape.net> <20021016223613.17897@192.168.4.1>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from imo-d04.mx.aol.com ([205.188.157.36])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181vFj-0002Gw-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 13:58:51 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-fbdev-devel@lists.sourceforge.net

Benjamin Herrenschmidt wrote:
>>I was curious to know if the maintainer for the radeonfb 
>>driver was planning to update it wrt James' recent API 
>>changes.  Considiering it is the latest line available, I'd 
>>hope that its brokeness will not be permanent ;-).
> 
> 
> I've ported radeonfb 0.1.6 to 2.5.42 (available in the linuxppc-2.5
> bk tree) and will port it to James latest changes. Ani (the
> maintainer) will probably then just use that port.
> 
> Ben.
> 

Excellent!  Two other questions (not necessarily related):

A) Is it (or will it ever be) possible to run dual head 
using two different cards (like radeon & riva-tnt2)?  I know 
there is still much work to be done, but I was curious if 
this was even remotely possible.  Sorta hate to let a good 
video card go to waste if you know what I mean :-).

B) Does anyone have a painless, yet precise way of 
generating modelines for fb.modes if you are using 
XFree-4.2?  I only ask because the XFree modelines are all 
determined by i2c DDC probing, thus there are none in the 
XF86Config file.  The modeline output captured in the log 
XFree.0.log is not the same output which modeline2fb 
expects.  Anyhow, I've tried using some of the information 
in the log, but I always get funky results.  I may be 
looking in the wrong place, but the documentation for both 
the fbdev kernel drivers and the X drivers are sorely out of 
date, so please excuse me if this is a question that has 
previously been answered.  I just need some formulae to 
convert values between what shows up in XFree.0.log when i2c 
DDC probes for the modelines and what needs to go in 
fb.modes.  Thanks in advance!

Cheers,
Nicholas



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
