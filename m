From: Richard Smith <rsmith@bitworks.com>
Subject: Rage Mobility M1 devid  4c52
Date: Thu, 15 Jan 2004 01:44:16 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <400644D0.1060500@bitworks.com>
Reply-To: rsmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ah2Be-0001m2-Dg
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 23:45:06 -0800
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ah2Be-0003My-2C
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 23:45:06 -0800
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Jan 2004 01:42:32 -0600
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

I'm trying to run the atyfb on a board that has a ATI Rage Mobility M1 
on it.  Grepping the driver source yeilds some refererences to a 
Mobility M1 as though its supported but my device id of 0x4c52 does not 
show up in the table of known devices and the driver fails to detect my 
chip.

If I copy the PCI Rage Mobililty like and change the device ID to 0x4c52 
then I get atyfb messages but some of the info is wrong.  For example it 
says I have 4M of wram but an M1 has 8M of sdram.

Is the Mobility M1 really suppported?


-- 
Richard A. Smith
rsmith@bitworks.com




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
