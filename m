From: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: PATCH: 2.6.7-rc3 drivers/video/fbmem.c: user/kernel pointer bugs
Date: Thu, 10 Jun 2004 02:24:41 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040610012441.GY12308@parcelfarce.linux.theplanet.co.uk>
References: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYEJB-0007tK-Hb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Jun 2004 18:24:45 -0700
Received: from parcelfarce.linux.theplanet.co.uk
	([195.92.249.252] helo=www.linux.org.uk ident=93)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BYEJB-0006YX-4S
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Jun 2004 18:24:45 -0700
Content-Disposition: inline
In-Reply-To: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
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
Content-Transfer-Encoding: 7bit
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel <linux-kernel@vger.kernel.org>

On Wed, Jun 09, 2004 at 03:46:39PM -0700, Robert T. Johnson wrote:
> Since sprite is a user pointer, reading sprite->mask or sprite->image.data 
> requires unsafe dereferences.  Let me know if you have any questions or if 
> I've made a mistake.

Nice catch.  IMO drivers/video/* is too damn scary to get in there and look
for now - as long as there are less nasty areas to deal with ;-)

BTW, had con_font_op() shown up in your checks?  It _does_ avoid dereferencing
userland pointers in a very similar scenario, but proving that is not something
I'd wish on any code.  Short version of the story:
	* console_font_op ->data can be a userland pointer.  It is obtained
from ioctls on many paths; all end up passing the (kernel) pointer to
structure to con_font_op().
	* a lot of code in drivers uses struct console_font_op.  And
dereferences ->data.
	* con_font_op() checks op->op and if it is KD_FONT_OP_[SG]ET, op->data
gets moved to kernel.  In any case, op is passed to the same method -
->con_font_op().  In some cases - with kernel pointer in ->data, in some -
with userland one.
	* ->con_font_op() in drivers does not dereference op->data unless
op->op is one of those two.

Oh, and to make life even funnier, struct console_font_op is also misused to
store current font.

I wonder what did cqual say about that one - it sure as hell should raise a lot
of red flags and the last item (none of the drivers dereference ->data unless
->op is one of KD_FONT_OP_{S,G}ET) is going to be hell on anything short of
full AI.  sparse does *not* figure out that it's safe and raises hell over
->data not being declared as userland pointer while getting copy_..._user()
on it.

	FWIW, I think we should reduxe mixing of ioctl and kernel structures.
console_font_op is a particulary obnoxious example, but lots of the stuff
in drivers/video is not much better.


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
