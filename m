From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Add three new IOCTLs to FB API
Date: Tue, 23 Sep 2003 18:36:10 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030923163610.GA5824@dreamland.darkstar.lan>
References: <Pine.GSO.4.21.0309220919230.4957-100000@vervain.sonytel.be> <3F6F8337.7050000@us.ibm.com>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1q9P-0001cf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 09:36:31 -0700
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1q9N-0000i3-Ct
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Sep 2003 09:36:29 -0700
Content-Disposition: inline
In-Reply-To: <3F6F8337.7050000@us.ibm.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Romanick <idr@us.ibm.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Il Mon, Sep 22, 2003 at 04:18:15PM -0700, Ian Romanick ha scritto: 
> >>2) Get 3D driver name. Return the name of the DRM driver that is 
> >>associated
> >>with this fb device. For example aty128fb would return r128, radeonfb 
> >>would
> >>return radeon. Empty string if there is none. There are eight DRM drivers 
> >>and
> >>15 fb ones.
> >
> >I think this should be done using sysfs, too. I.e. symbolic links between 
> >the
> >fbdev and drm drivers in /sys.
> 
> I'm not that familiar with how sysfs works.  How would this look? 
> There'd be a tree like:
> 
>     /sys/
>         card0/
Actually it will be /sys/graphics/fb0

>             dri.so (link to client-side driver)

Userspace  library? We  can  put  the   name  here,  not  a  symlink  to
the  library. sysfs  deals  only  with kobjects  (ie.  things that  live
somewhere in the  kernel). We can create link between  two kobjects (see
sysfs_create_link) but not between a kobject and something else.

>             DRM_device (link to DRM device that will load kernel module)

Do you mean device under /dev? Can't do that, see above. We can put
module name, so a user can do:
modprobe `cat /sys/graphics/fb0/drm_module`

>             PCI_INFO (file containing PCI device information)

Under /sys/graphics/fb0 there will be a "device" symlink. This will take
you to the device dir:
root@dreamland:/sys/bus/pci/devices/0000:01:00.0# ls
class  config  detach_state  device  irq  power/  resource subsystem_device  subsystem_vendor  vendor
root@dreamland:/sys/bus/pci/devices/0000:01:00.0# cat vendor device subsystem_vendor subsystem_device
0x1002
0x4e45
0x1681
0x0002

You can get everything from here without the need to add another
attribute.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Ci sono due cose che l'uomo non puo` nascondere:
essere ubriaco ed essere innamorato.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
