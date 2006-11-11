From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fwd: [Suspend-devel] resume not working on
 acer ferrari 4005 with radeonfb enabled
Date: Fri, 10 Nov 2006 18:02:47 -0800
Message-ID: <20061110180247.39878272.akpm@osdl.org>
References: <200611110031.16173.rjw@sisk.pl>
	<1163209746.4982.203.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GiiCq-0003tQ-UD for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Nov 2006 18:02:53 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GiiCp-0003l3-FY
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Nov 2006 18:02:52 -0800
In-Reply-To: <1163209746.4982.203.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Solomon Peachy <pizza@shaftnet.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Christian@ogre.sisk.pl, Christian.Hoffmann@wallstreetsystems.com, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Hoffmann@albercik.sisk.pl

On Sat, 11 Nov 2006 12:49:06 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2006-11-11 at 00:31 +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > We've just got the appended report.  Could you please have a look at this?
> 
> There are many possible reasons for that. The most likely is that the
> BIOS isn't bringing the chip back on resume, causing radeonfb to
> crash when trying to access it.
> 

I assume from this:

> > Greetings,
> > Rafael
> > 
> > 
> > ----------  Forwarded Message  ----------
> > 
> > Subject: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
> > Date: Friday, 10 November 2006 20:44
> > From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
> > To: suspend-devel@lists.sourceforge.net
> > 
> > Hello,
> >  
> > when I have radeonfb enabled, my laptop (X700 ati mobility) doesnt resume
> > anymore. Screen stays black and nothing works anymore, no capslock light, no
    ^^^^^^^

that it's a regression, from some unknown-previous-kernel-version.

> > ctrl alt sysreq b etc. I tried all kind of things vbetool, passing
> > acpi_sleep=s3_bios,s3_mode to the kernel. Nothing seems to work.
> >  
> > You can see dmesg output and lspci -vv output here 
> >  http://christianhoffmann.de/temp/radeon.log
> >  http://christianhoffmann.de/temp/lspci.log
> >  
> > Thanks a lot for any input.
> >  
> > Chris
> >  
> > PS: I use kernel 2.18.1 + patch for radeonfb from
> > http://bugzilla.kernel.org/attachment.cgi?id=9408&action=view

That's http://www.shaftnet.org/~pizza/radeonfb-atom-2.6.18-v6a.diff.

What happens when that patch isn't applied?

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
