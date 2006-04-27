From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.16-rc3 + Xorg 6.9.0  - works for me...
Date: Thu, 27 Apr 2006 12:53:53 +0100
Message-ID: <20060427115353.GA30095@flint.arm.linux.org.uk>
References: <43F4AF97.8080909@xandros.com> <443E3A4B.8000101@netwinder.org> <443E4435.1060904@xandros.com> <443F8EB1.30803@netwinder.org> <444FBE2A.90106@xandros.com> <20060426200907.GE9738@flint.arm.linux.org.uk> <444FD4C9.1040209@xandros.com> <20060427114817.GA7196@deprecation.cyrius.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZ54Z-0000O7-8D
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 04:54:15 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FZ54Y-0005qg-0m
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 04:54:15 -0700
Content-Disposition: inline
In-Reply-To: <20060427114817.GA7196@deprecation.cyrius.com>
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
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Woody Suwalski <woodys@xandros.com>, Ralph Siemsen <ralphs@netwinder.org>, linux-fbdev-devel@lists.sourceforge.net, debian-arm@lists.debian.org

On Thu, Apr 27, 2006 at 01:48:17PM +0200, Martin Michlmayr wrote:
> * Woody Suwalski <woodys@xandros.com> [2006-04-26 16:15]:
> > >>Can you verify if the current 2.6.1x kernel + X 6.9 works OK on SHARK 
> > >>machine??? I do not have any of them here to test...
> > >
> > >I don't have Shark hardware either.
> > >
> > Well, maybe Martin or Wookey can find one...
> 
> I have no Shark, but I can confirm that 2.4 works on my Netwinder
> while 2.6 doesn't.

And under 2.6, does clearing this burst bit solve your problem?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
