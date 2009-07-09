From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 0/4] [ARM] S3C-fb update
Date: Thu, 09 Jul 2009 17:08:50 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC076E71C7EA@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: "adaplas@gmail.com" <adaplas@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Pawel Osciak <p.osciak@samsung.com>

This is a resend as my previous attempt seems to have failed.
Please accept my apologies if you are receiving this patch set for
the second time.


This patch series adds support for VSYNC wait ioctl
(FBIO_WAITFORVSYNC) and display panning for the S3C framebuffer.

It also contains minor fixes for the driver.

The series contains:

[PATCH 1/4] [ARM] s3c-fb: Fix an off-by-one error at window release
[PATCH 2/4] [ARM] s3c-fb: Include fixes
[PATCH 3/4] [ARM] s3c-fb: Add support for display panning
[PATCH 4/4] [ARM] s3c-fb: Add wait for vsync support


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
