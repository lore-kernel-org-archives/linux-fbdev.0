From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this one works ;-)
Date: Thu, 29 Apr 2004 14:13:16 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040429201316.GA26704@guug.org>
References: <1083199850.20089.110.camel@gaston> <Pine.LNX.4.44.0404291848170.1327-100000@phoenix.infradead.org> <20040429181142.GB26608@guug.org> <20040429194813.GA8799@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJHuQ-0003Xf-HT
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 13:13:26 -0700
Received: from guug.galileo.edu ([168.234.203.30] helo=guug.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BJHuP-0006Oe-Uz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 13:13:26 -0700
Content-Disposition: inline
In-Reply-To: <20040429194813.GA8799@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Apr 29, 2004 at 09:48:13PM +0200, Kronos wrote:
> Il Thu, Apr 29, 2004 at 12:11:42PM -0600, Otto Solares ha scritto: 
> > On Thu, Apr 29, 2004 at 07:01:00PM +0100, James Simmons wrote:
> > > 
> > > > > No we don't. We have the default modedb. I already tested a patch using 
> > > > > modedb. It works like a charm :-) I can stty all I want!!!! 
> > > > 
> > > > On your monitor... then most TFT owners will curse you :)
> > > 
> > > As we move from ioctls to sysfs we will also move from using 
> > > fb_var_screeninfo as the userland interface to using mode strings.
> > > That means when someone creates a string  like
> > > 
> > > 834x721@81 
> > > 
> > > then for non TFT monitors it should fail. For TFT monitors it will work.
> > > If someoone using stty ask for exotic mode then if the monitor is TFT then 
> > > it should work. Else it should fail. 
> > 
> > James: I have seen sysfs support for fbdev in the -mm series
> > from Kronoz I think, this sysfs interface that will obsolete
> > var_screeninfo and fix_screeninfo is 2.6 material?
> 
> Well, my patch uses class_simple to expose the framebuffer device so
> that udev can create /dev/fbN. Drivers can't touch the class_device
> (yet), for example radeonfb attaches edid info to the pci device, not to
> the framebuffer device. After the exams I will cook up a patch that
> should improve that.

Excellent news!

> > or we have to wait until 2.7 starts?
> 
> I think that for fully dynamic fb_info we should wait 2.7, the rest can
> go in 2.6. Resolution change via sysfs shouln't have a big impact on
> fbdev core.

I just would suggest as userspace fbdev consumer that is a pain to
do development using two different interfaces, if sysfs interface
will obsolete the ioctl one, it must have all the mechanics that
are present in the ioctl one so no mix of interfaces would be
required.

-otto



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
