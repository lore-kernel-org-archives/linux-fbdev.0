From: "Cheshire Cat Fish" <cat_fish@hotmail.com>
Subject: Negative screen coords in putcs?
Date: Sun, 07 Sep 2003 23:00:43 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Law15-F63omP0l0HQFD0000c593@hotmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wF5S-00044Z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Sep 2003 23:01:18 -0700
Received: from law15-f63.law15.hotmail.com ([64.4.23.63] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wF5R-0001Df-Ki
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Sep 2003 23:01:17 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net


Should putcs get negative Y values?

I am getting calls with 'yy' less than 0, and I am wondering if I have 
screwed something up, or if that is correct, how I should handle them?

Thanks,
Noel
--
A precariously balanced mixture of myopic optimism and rampant paranoia.

_________________________________________________________________
Get a FREE computer virus scan online from McAfee. 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
