From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: RFC: s3c2410fb direction of changes.
Date: Tue, 09 Jan 2007 08:08:17 +0100
Message-ID: <45a33f611aa47@wp.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
Content-Type: text/plain; charset="iso-8859-1"
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net

Hello,

There is a clash between sent patches 4067/1 and 4083/1.=20

The patch 4083 comes into a direction of complete removal of the
fb registers from the s3c2410fb structure.

The patch 4067 comes in the opposite direction as #4083/1. It
depends whether you want complete removal of the s3c2410fb
registers settings and do everything by settings separate fields
(e.g. display type instead of 2-bits of in the lcdcon1).

IMO, the best way is the same as the PXA display is set:
registers calculated from other values (e.g. from resolution,
bpp, etc) should be removed from the s3c2410fb definition and
calculated by the framebuffer code. The enum type values (e.g.
the display type) should be set with "or" operator into registers
where they belong to. Look at the pxafb_mach_info structure.

Which direction is bettter?

Regards,
Krzysztof

----------------------------------------------------
LUC BESSON przedstawia
Najwi=EAksz=B1 europejsk=B1 animacj=EA ostatnich lat!!
ARTUR I MINIMKI - ju=BF w kinach!!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fminimki.html=
&sid=3D984



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
