From: Otto Solares <solca@guug.org>
Subject: Re: Changing modes with fbset
Date: Thu, 8 Jan 2004 19:31:44 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040109013144.GC17821@guug.org>
References: <20040106002822.GB442@guug.org> <Pine.LNX.4.44.0401090002300.17957-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AelUb-0005Ua-Im
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Jan 2004 17:31:17 -0800
Received: from guug.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AelUb-0005P2-7X
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Jan 2004 17:31:17 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401090002300.17957-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Jan 09, 2004 at 12:03:16AM +0000, James Simmons wrote:
> On Mon, 5 Jan 2004, Otto Solares wrote:
> 
> > On Tue, Jan 06, 2004 at 12:06:04AM +0000, James Simmons wrote:
> > > 
> > > Applied. Thanks for finding that.
> > 
> > Hi James! now that you are back again, i would like to suggest
> > a modification to fbdev core, i am having problems guessing
> > which card is attached to a fb device.  I need this info to
> > solve the 'more than 1 card' situation.  This could be easily
> > fixed if the fbdev api provides the busid of the card, like
> > "pci:0000:01:0.0".  That would solve a lot of things in the
> > HAL detection routines.  Maybe that could be exported via
> > sysfs but i have been waiting for sysfs for a while and don't
> > see it coming to a reality.  Maybe an ioctl is enough.
> 
> The patches are getting pushed. With sysfs the info is there :-)

Great!

-solca



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
