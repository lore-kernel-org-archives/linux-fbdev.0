From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [PATCH] 0/3 Add I2C/DDC support to radeonfb (resend)
Date: Sat, 23 Aug 2003 15:42:08 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030823134208.GA861@dreamland.darkstar.lan>
References: <20030822170905.GA5757@dreamland.darkstar.lan> <1061595832.1259.41.camel@thor.holligenstrasse29.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-1.tiscali.it ([195.130.225.147])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19qYeb-0003uE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 23 Aug 2003 06:42:05 -0700
Content-Disposition: inline
In-Reply-To: <1061595832.1259.41.camel@thor.holligenstrasse29.lan>
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
To: michel@daenzer.net
Cc: linux-fbdev-devel@lists.sourceforge.net

Il Sat, Aug 23, 2003 at 01:43:53AM +0200, Michel D?nzer ha scritto: 
> On Fri, 2003-08-22 at 19:09, Kronos wrote: 
> > 
> > i2c  bus  is registered  in  radeonfb_pci_register  and unregistered  in
> > radeonfb_pci_unregister. I'm a  bit concerned about XFree  that uses the
> > same bus...
> 
> If there was an interface to userspace, the X driver could use that?

EDID block will be exported to  userspace via sysfs (see patch 3/3) and,
yes, X can use that.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
The trouble with computers is that they do what you tell them,
not what you want.
D. Cohen


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
