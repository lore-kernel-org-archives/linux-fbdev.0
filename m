From: "Rodolfo Giometti" <giometti@enneenne.com>
Subject: [RFC] driving a LCD panel via I2C
Date: Mon, 24 Sep 2007 10:58:08 +0200 (CEST)
Message-ID: <41784.213.84.50.107.1190624288.squirrel@webmail.enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IZjqT-0004hB-Dh for Linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 02:03:13 -0700
Received: from 81-174-11-161.static.ngi.it
	([81.174.11.161] helo=mail.enneenne.com ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IZjqR-0007hO-PZ
	for Linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 02:03:13 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel@lists.sourceforge.net, i2c@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

Hello,

I have an LCD panel on a custom PXA27x based board and it must be turned
on/off by some special commands via a GPIO throught a I2C chip.

I'd like some suggestion about I can easily manage this situation.

Maybe can I add a special I2C function to get i2c_client pointer and then
using it to send on/off commands to the LCD?

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
