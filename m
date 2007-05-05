From: Luc Verhaegen <libv@skynet.be>
Subject: Re: [PATCH 06/20] vt8623fb: New
	framebuffer	driver for VIA VT8623
Date: Sun, 6 May 2007 01:31:47 +0200
Message-ID: <20070505233147.GA19039@skynet.be>
References: <463C996A.9050005@gmail.com> <20070505181551.GB6016@sci.fi>
	<20070505200801.GA28014@localhost.localdomain>
	<20070505203450.GC6016@sci.fi> <20070505224855.GA18807@skynet.be>
	<1178406457.22828.7.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkTjM-00050Z-MZ for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 16:32:00 -0700
Received: from outmx009.isp.belgacom.be ([195.238.5.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HkTjL-000535-3P
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 16:32:00 -0700
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l45NVi2c004227
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 6 May 2007 01:31:44 +0200 (envelope-from <libv@skynet.be>)
Received: from death (2.175-64-87.adsl-dyn.isp.belgacom.be [87.64.175.2])
	by outmx009.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l45NVhDC004221
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 6 May 2007 01:31:44 +0200 (envelope-from <libv@skynet.be>)
Received: from death by death with local (Exim 3.36 #1 (Debian))
	id 1HkTj9-0004xV-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 06 May 2007 01:31:47 +0200
Content-Disposition: inline
In-Reply-To: <1178406457.22828.7.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Sun, May 06, 2007 at 07:07:37AM +0800, Antonino A. Daplas wrote:
> On Sun, 2007-05-06 at 00:48 +0200, Luc Verhaegen wrote:
> > 
> > You mean that tiny one which talks about GUEUEs and such?
> 
> I hope you're being ironic with the 'tiny' :-), because the patch that
> came from VIA was humongous.
> 

Well, my estimate for a full featured fb driver for this hardware would 
be around 10kloc/300kB source.

> > 
> > Who plans on cleaning that one up? Who is prepared to see VIA just 
> > plough on regardless after that, just like VIA did with the X driver?
> > 
> 
> Yep, just looking at that patch, it will be a difficult one to clean up.
> 
> Tony

It takes a special kind of idiot to take something like that on and 
keep it up too.

Luc Verhaegen.
http://unichrome.sf.net/

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
