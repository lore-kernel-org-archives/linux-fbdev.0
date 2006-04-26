From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.16-rc3 + Xorg 6.9.0  - works for me...
Date: Wed, 26 Apr 2006 21:09:07 +0100
Message-ID: <20060426200907.GE9738@flint.arm.linux.org.uk>
References: <43F4AF97.8080909@xandros.com> <443E3A4B.8000101@netwinder.org> <443E4435.1060904@xandros.com> <443F8EB1.30803@netwinder.org> <444FBE2A.90106@xandros.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYqKK-0005uW-Hj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Apr 2006 13:09:32 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FYqKK-0007Ns-Em
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Apr 2006 13:09:32 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FYqKI-0007pM-SI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Apr 2006 13:09:32 -0700
Content-Disposition: inline
In-Reply-To: <444FBE2A.90106@xandros.com>
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
To: Woody Suwalski <woodys@xandros.com>
Cc: Martin Michlmayr <tbm@cyrius.com>, Ralph Siemsen <ralphs@netwinder.org>, linux-fbdev-devel@lists.sourceforge.net, debian-arm@lists.debian.org

On Wed, Apr 26, 2006 at 02:38:34PM -0400, Woody Suwalski wrote:
> >>>
> I just upgraded my Netwinder from 2.4.27 to 2.6.15 and the framebuffer
> no longer works.  Console works but when I start X.org I first get a
> corrupted screen and a little bit later the whole machine hangs.
> There's no panic or any information on the serial console.
> <<<
> 
> This problem appears only on Cyber2010 chips (Netwinders with Cyber2000 
> work OK)
> 
> The crash issue on 2010 can be solved by disabling burst mode on the 
> Cyberpro 2010 (graphic register 0x30, EXT_BUS_CTL_PCIBURST_WRITE=0). It 
> is enabled in the kernel driver by default now.

Exactly the same code exists in the 2.4.21-rmk kernel (just diff'd the
two drivers), so I don't understand why hasn't the problem been reported
against 2.4 kernels.

> Martin, Russell,
> Can you verify if the current 2.6.1x kernel + X 6.9 works OK on SHARK 
> machine??? I do not have any of them here to test...

I don't have Shark hardware either.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
