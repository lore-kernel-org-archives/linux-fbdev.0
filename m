From: Jamey Hicks <jamey.hicks@hp.com>
Subject: Re: lcd/backlight module support
Date: Tue, 04 Nov 2003 14:33:21 -0500
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Message-ID: <1067974401.10922.1198.camel@vimes.crl.hpl.hp.com>
References: <1066862161.29582.298.camel@vimes.crl.hpl.hp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces@lists.arm.linux.org.uk>
In-Reply-To: <1066862161.29582.298.camel@vimes.crl.hpl.hp.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Content-Type: text/plain; charset="us-ascii"
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net


In response to feedback on the previous version, I have updated the
lcd/backlight module patch, adding sysfs attributes and lcd contrast
control.

ftp://ftp.handhelds.org/pub/linux/kernel/lcd-module-031104.patch

Russ Dill sent me a pointer to his backlight framework patch.  There
seem to be some good ideas there as well that I could use to make
further improvements on the lcd/backlight controls.

Also based on the feedback on the previous version, I submitted a patch
to Patrick Mochel to change "legacy" bus to "platform" bus, and this has
now been applied.

Jamey



-------------------------------------------------------------------
Subscription options: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ/Etiquette:       http://www.arm.linux.org.uk/armlinux/mailinglists.php
