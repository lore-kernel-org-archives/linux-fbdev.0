From: Ian Romanick <idr@us.ibm.com>
Subject: Re: Add three new IOCTLs to FB API
Date: Mon, 22 Sep 2003 16:18:15 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F6F8337.7050000@us.ibm.com>
References: <Pine.GSO.4.21.0309220919230.4957-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1ZxD-0007N9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 16:18:51 -0700
Received: from e4.ny.us.ibm.com ([32.97.182.104])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1ZxC-0003LA-RC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 16:18:50 -0700
Received: from northrelay02.pok.ibm.com (northrelay02.pok.ibm.com [9.56.224.150])
	by e4.ny.us.ibm.com (8.12.10/8.12.2) with ESMTP id h8MNIHFX844046
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 19:18:17 -0400
Received: from us.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by northrelay02.pok.ibm.com (8.12.9/NCO/VER6.6) with ESMTP id h8MNIF7h223596
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 19:18:16 -0400
In-Reply-To: <Pine.GSO.4.21.0309220919230.4957-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:
> On Sun, 21 Sep 2003, Jon Smirl wrote:
> 
>>3) Get vendor and card PCI ID
> 
> In 2.6.0, you should be able to get them from sysfs, once fbdev does full
> sysfs.
> 
> Note that both are PCI-specific, for whatever that matters (no DRM for non-PCI
> chips anyway, right?).

Right.  Just PCI and AGP (which looks like PCI).  Presumably PCI Express 
will look the same.  I can't imagine ISA or VLB cards being supported. 
Ever.  At some point someone *may* support Sun's UPA or some other 
proprietary graphics interface, but I wouldn't lose too much sleep over 
it. :)

>>2) Get 3D driver name. Return the name of the DRM driver that is associated
>>with this fb device. For example aty128fb would return r128, radeonfb would
>>return radeon. Empty string if there is none. There are eight DRM drivers and
>>15 fb ones.
> 
> I think this should be done using sysfs, too. I.e. symbolic links between the
> fbdev and drm drivers in /sys.

I'm not that familiar with how sysfs works.  How would this look? 
There'd be a tree like:

     /sys/
         card0/
             dri.so (link to client-side driver)
             DRM_device (link to DRM device that will load kernel module)
             PCI_INFO (file containing PCI device information)

Or something roughly similar?  If so, I think this would be a 
*wonderful* way to handle it. :)




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
