From: Kronos <kronos@kronoz.cjb.net>
Subject: EDID for radeonfb
Date: Wed, 20 Aug 2003 00:33:50 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030819223350.GA838@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19pF6r-0002tv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 19 Aug 2003 15:37:49 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>

i2c-algo-bit.o: read 128 bytes.
needed 0 jiffies
read_EDID: i2c_transfer = 2
0x0 0xff 0xff 0xff 0xff 0xff 0xff
EDID v1 signature!
RADEON_GPIO_Y_1: hi
EDID checksum passed.
Dumping data:
0x0 0xff 0xff 0xff 0xff 0xff 0xff 0x0 0x41 0xc 0x18 0x8 0xa3 0x6 0x0 0x0
0x14 0xd 0x1 0x3 0x1f 0x22 0x1b 0x78 0xea 0xc 0x95 0xa2 0x56 0x4c 0x96 0x25
0x1a 0x50 0x54 0xbf 0xef 0x80 0x71 0x4a 0x71 0x4f 0x81 0x40 0x81 0x80 0x1 0x1 
0x1 0x1 0x1 0x1 0x1 0x1 0x30 0x2a 0x0 0x98 0x51 0x0 0x2a 0x40 0x30 0x70
0x13 0x0 0x52 0xe 0x11 0x0 0x0 0x1e 0x0 0x0 0x0 0xff 0x0 0x20 0x48 0x44
0x20 0x20 0x30 0x30 0x31 0x36 0x39 0x39 0xa 0x20 0x0 0x0 0x0 0xfc 0x0 0x50
0x68 0x69 0x6c 0x69 0x70 0x73 0x20 0x31 0x37 0x30 0x53 0x34 0x0 0x0 0x0 0xfd 
0x0 0x38 0x4c 0x1e 0x52 0xe 0x0 0xa 0x20 0x20 0x20 0x20 0x20 0x20 0x0 0x22

Ok, I've a working implementation of the I2C code for radeonfb :)
The bug was very stupid: 0x50 became 0x20 and I spent a couple of weeks
wondering why it didn't work...

I've tested the code on a R300 board but it should work on any radeon. I
need a couple of day to merge  it into radeonfb and to test. I'll send a
patch ASAP.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Runtime error 6D at f000:a12f : user incompetente


-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
