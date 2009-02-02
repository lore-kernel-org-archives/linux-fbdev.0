From: Fritz Code <codefritz@googlemail.com>
Subject: kernel-compiled-in-support of TFT 16bit and STN
	8bit LCD
Date: Mon, 2 Feb 2009 09:58:36 +0100
Message-ID: <3e9cdced0902020058l5234aaaat21a7b08cbcd3f37a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <codefritz@googlemail.com>) id 1LTudd-0002cj-GB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Feb 2009 08:58:41 +0000
Received: from mail-ew0-f10.google.com ([209.85.219.10])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LTudb-0006VU-OV for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Feb 2009 08:58:41 +0000
Received: by ewy3 with SMTP id 3so948837ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 02 Feb 2009 00:58:37 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

the framebuffer-driver is hard compiled in the linux kernel, so its
not realized as a module.

I want to build a linux kernel (I'm using 2.4.21, an update to a newer
version is at the moment not possible)
which supports at runtime a TFT 16bit and a STN 8bit LCD.
Im using a Samsung Framebuffer-Driver (s3c2410fb_core.c in
driver/video) since Im using an embedded system based on Samsung
S3C2410.

Well at the moment the selection of LCD support is done my defines in .config:

CONFIG_S3C2410_TFT / CONFIG_S3C2410_STN

depending on the LCD type one of the above defines must be set and as
a result of this the define LCD_TYPE gets set
to STN or TFT.

color-depth:
CONFIG_FBCON_CFB8 /CONFIG_FBCON_CFB16


The defines are used in the samsung framebuffer driver. Well my
question is now if it is a good idea to substitute this
"hardcoded" defines in the driver with dynamic if-requests to
distinguish during the runtime and build a kernel with support of both
LCD types?

Thanks

Regards,
--Codefritz

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
