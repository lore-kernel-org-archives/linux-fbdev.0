From: "Jochen Roth" <jochen@panix.com>
Subject: inverting sync line drivers
Date: Mon, 9 Jun 2003 18:25:08 -0400 (EDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200306092225.h59MP8t18771@panix3.panix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail1.panix.com ([166.84.1.72])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19PV4g-0003HI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Jun 2003 15:25:10 -0700
Received: from panix3.panix.com (panix3.panix.com [166.84.1.3])
	by mail1.panix.com (Postfix) with ESMTP id EE5CA4874E
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Jun 2003 18:25:08 -0400 (EDT)
Received: (from jochen@localhost)
	by panix3.panix.com (8.11.6p2/8.8.8/PanixN1.1) id h59MP8t18771
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 9 Jun 2003 18:25:08 -0400 (EDT)
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
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

Before I dig out my oscilloscope I think I need a reality
check here...

I am working on a driver for a S3Trio family chip in an old
IBM thin client. It looks like the hsync and vsync signals
coming out of the Trio are run through a 74ACT04 hex inverter.

This is supported by the fact that the monitor syncs better
if I negate the interpretation of FB_SYNC_HOR_HIGH_ACT and
FB_SYNC_VERT_HIGH_ACT from what the other S3 drivers do.

(I looked at some old PCI adapters with the same chip and they
seem to run the sync signals straight from the video
controller to the vga connector.)

Has anybody seen something like this before?

Regards,
Jochen



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
