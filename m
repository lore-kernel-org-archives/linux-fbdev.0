From: nihil <nihil0@freestart.hu>
Subject: Matrox G450 fbdev, v4l  and TV-OUT question
Date: Wed, 18 Feb 2004 23:32:44 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077143563.1716.16.camel@gaia>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtaJ5-0000Am-K9
	for Linux-fbdev-devel@lists.sourceforge.net; Wed, 18 Feb 2004 14:36:39 -0800
Received: from 206.126-182-adsl-pool.axelero.hu ([81.182.126.206] helo=pulsus.mine.nu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtaEB-0006GT-29
	for Linux-fbdev-devel@lists.sourceforge.net; Wed, 18 Feb 2004 14:31:35 -0800
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
To: Linux-fbdev-devel@lists.sourceforge.net

Hi!

I found out, that up to the kernel version 2.6.2 the setting of the
bright and contrast for the Matrox G450 TV-OUT doesn't work. However
it worked in 2.4.xx and also in 2.6.1.

I can get the values with:
~> v4lctl -c /dev/fb0 list
attribute  | type   | current | default | comment
-----------+--------+---------+---------+------------------------
norm       | choice | (null)  | (null)  |
input      | choice | (null)  | (null)  |
bright     | int    |     127 |     127 | range is 0 => 780
contrast   | int    |     127 |     127 | range is 0 => 1023
color      | int    |     165 |     165 | range is 0 => 255
hue        | int    |       0 |       0 | range is 0 => 255
test outpu | bool   | off     | off     |

But if I try to set a value, I get only an error message:
~> v4lctl -c /dev/fb0 bright 600
ioctl: VIDIOC_S_CTRL(id=9963776;value=600): Inappropriate ioctl for device

It is also the same for the contrast:
~> v4lctl -c /dev/fb0 contrast 800
ioctl: VIDIOC_S_CTRL(id=9963777;value=800): Inappropriate ioctl for device

What could be the problem? What is changed in the kernel from 2.6.1 to 2.6.2, 
that causes this problem? If this doesn't work anymore, how can I change the 
bright/contrast for the TV-OUT on the Matrox G450 card?

Thank you in advance!
nihil





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
