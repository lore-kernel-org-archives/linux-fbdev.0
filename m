From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Compiling Rage xlinit.c
Date: Wed, 19 May 2004 09:36:50 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40AB7102.5080803@bitworks.com>
References: <Pine.LNX.4.44.0405172122310.796-100000@phoenix.infradead.org>
Reply-To: RSmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQSC3-0002kn-GZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 07:37:15 -0700
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BQSC3-0000uz-4K
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 07:37:15 -0700
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 19 May 2004 09:36:39 -0500
In-Reply-To: <Pine.LNX.4.44.0405172122310.796-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: jsimmons@infradead.org
Cc: stevel@mvista.com, fb-devel <linux-fbdev-devel@lists.sourceforge.net>, source@mvista.com

James Simmons wrote:

> Sorry about the delayed response. I recieved that patch along time ago. 
> It was ported to 2.6.X and I placed it into the BK repo for fbdev.
> Xui from tyan sent me a patch to get it going. Since you have the specs to 
> boot from scratch I really like to work with you on this. The code for the 
> mach64 is old. I have newer code in my BK repos. If you need a patch I can 
> send it to you.

Cool.  Hook me up.  Does the stuff in your BK contain all the M1 mods 
from recient 2.4?  I've tried your fbdiff patch but it wouldn't apply to 
2.6.6 so I just used what was stock in 2.6.6.

I don't think the newer Mach64 code will make any difference right now 
though.  If I run xlinit (with my mods) on a chip with only POR I don't 
get a sync yet.

So I'm  still missing something.  I've got some questions pending with 
ATI dev support and thier supposed to be trying to get me some info 
(other than the bios source) on bringing up the chip from scratch.




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
