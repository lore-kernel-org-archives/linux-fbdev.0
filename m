From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH]: rivafb DDC2/I2C
Date: Tue, 13 Jan 2004 09:50:12 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073947811.763.175.camel@gaston>
References: <1110.203.177.116.240.1073919544.squirrel@webmail.po.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgAyW-0004u9-3p
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jan 2004 14:56:00 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AgAyV-0001JX-KM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jan 2004 14:55:59 -0800
In-Reply-To: <1110.203.177.116.240.1073919544.squirrel@webmail.po.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Tue, 2004-01-13 at 01:59, Antonino A. Daplas wrote:
> Hi,
> 
> Attached is a patch against linux-2.6.1 + fbdev.diff. (It's another big
> patch so it's zipped).
>

Sounds nice (according to your description at least :)

I won't have time to try it on my side much during this week
(linuxconf.au), nor to adapt radeonfb to the changes at least
until I'm back.

James: Are you still around ? Got my previous set of patches ?

I think it's time to start feeding Andrew (though I'd rather
add the FB_ACTIVATE_FIND first, but that can always get in later
if we really want it).

Note that I reproduced cases of console resize via stty blowing
up in accel_clear_margins on an x86, I think that's unrelated to
the changes I did though, but I haven't figured out what's going
on exactly yet. It blows up after the resize, apparently in a
call to fbcon_switch()...

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
