From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Changing modes with fbset
Date: Tue, 06 Jan 2004 11:35:49 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073349349.780.181.camel@gaston>
References: <3FDBB97F.4070207@undead.cc>
	 <Pine.LNX.4.44.0401060005511.7347-100000@phoenix.infradead.org>
	 <20040106002822.GB442@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdfDX-0007Fu-Gx
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:37:07 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AdfDW-0008Bm-2w
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:37:06 -0800
In-Reply-To: <20040106002822.GB442@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-01-06 at 11:28, Otto Solares wrote:
> On Tue, Jan 06, 2004 at 12:06:04AM +0000, James Simmons wrote:
> > 
> > Applied. Thanks for finding that.
> 
> Hi James! now that you are back again, i would like to suggest
> a modification to fbdev core, i am having problems guessing
> which card is attached to a fb device.  I need this info to
> solve the 'more than 1 card' situation.  This could be easily
> fixed if the fbdev api provides the busid of the card, like
> "pci:0000:01:0.0".  That would solve a lot of things in the
> HAL detection routines.  Maybe that could be exported via
> sysfs but i have been waiting for sysfs for a while and don't
> see it coming to a reality.  Maybe an ioctl is enough.

Right, we need that and some way to know which heads are "coupled" for
dual head drivers. One of the reasons I haven't done dual head support
in radeonfb yet is that to get it working properly with X, I need to
update X too, and add a way for X to know which /dev/fb's are actually
"together" as 2 heads of the same card.

Then, we probably want some way to also enable mirroring instead of
dual head...

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
