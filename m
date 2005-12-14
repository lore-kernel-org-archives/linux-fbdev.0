From: Luc Verhaegen <libv@skynet.be>
Subject: Re: Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and updated CyblaFB
Date: Wed, 14 Dec 2005 16:18:24 +0100
Message-ID: <20051214151824.GA9248@skynet.be>
References: <439EF4CB.8030007@t-online.de> <20051213142054.4fd59226.akpm@osdl.org> <43A01969.6050109@t-online.de> <Pine.LNX.4.62.0512141604281.498@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmYPD-00060W-6Y
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 07:18:59 -0800
Received: from outmx014.isp.belgacom.be ([195.238.4.69])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EmYPB-0005yu-Jr
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 07:18:59 -0800
Received: from outmx014.isp.belgacom.be (localhost [127.0.0.1])
        by outmx014.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id jBEFIfjL030874
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 Dec 2005 16:18:42 +0100
        (envelope-from <libv@skynet.be>)
Received: from death (224-141.246.81.adsl.skynet.be [81.246.141.224])
        by outmx014.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id jBEFIOBb030661
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 Dec 2005 16:18:24 +0100
        (envelope-from <libv@skynet.be>)
Received: from death by death with local (Exim 3.36 #1 (Debian))
	id 1EmYOe-0002PP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 Dec 2005 16:18:24 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512141604281.498@pademelon.sonytel.be>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, Dec 14, 2005 at 04:05:07PM +0100, Geert Uytterhoeven wrote:
> On Wed, 14 Dec 2005, Knut Petersen wrote:
> > Andrew Morton wrote:
> > > Masking pointers to 32 bits.  Is this driver supposed to be run on 64-bit
> > > machines?
> > >  
> > Never can it be run on anything else but 32 bit machines because this graphics
> > core is
> > integrated in the VIA VT8601A northbridge. So the cpu is either a VIA C3,
> > a VIA Eden, a Pentium III or a Celeron. It is planned to add support for
> > closely related
> > graphics cores, but also those can be run with nothing but 32 bit cpus,
> > starting from the
> > first pentium. Even if this driver would be compiled into a 64 bit kernel, the
> > imageblit function never would be executed as the init code never will find
> > the
> > cyberblade/i1 graphics core in such a system.
> 
> Until VIA adds 64-bit support to it's C3 line...
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
They still don't have the C7 out. And they've become pretty silent ever 
since their big but empty press release about 64-bit in oktober of 2004.

If 64bit every really happens for VIA, then it won't be tied to the 
PLE133 or a trident descendant.

I'd be more worried about this getting ported to the XGI V3, but afaik 
XGI is not as nice a player as it originally made out to be.
 
Luc Verhaegen.
http://www.livejournal.com/users/libv/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
