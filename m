From: James Simmons <jsimmons@infradead.org>
Subject: Re: Changing modes with fbset
Date: Fri, 9 Jan 2004 00:03:16 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401090002300.17957-100000@phoenix.infradead.org>
References: <20040106002822.GB442@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Aek7a-0007uN-Gn
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Jan 2004 16:03:26 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aek7Z-00032s-VW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Jan 2004 16:03:26 -0800
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Otto Solares <solca@guug.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, 5 Jan 2004, Otto Solares wrote:

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

The patches are getting pushed. With sysfs the info is there :-)



> 
> -solca
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
