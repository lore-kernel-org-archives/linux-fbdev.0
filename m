From: Voser Peter <peter.voser@siemens.com>
Subject: Writing a driver for a 128*64 dots LCD (black/white only)
Date: Mon, 20 Jan 2003 17:27:45 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <BF282B4C857BD111BA9700600868A28606BF34F9@ZRHA131A.zrh.siemens.ch>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zrha220a.siemens-sbs.ch ([194.204.64.135])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18anv6-0001vq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jan 2003 18:13:44 -0800
Received: from fw3ext.siemens.ch (fw3ext.siemens-sbs.ch [194.204.64.99])
	by zrha220a.siemens-sbs.ch (Build 101 8.9.3/NT-8.9.3) with ESMTP id DAA19112
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Jan 2003 03:14:31 +0100
Received: from zrha131a.zrh.siemens.ch (ZRHA131A.zrh.siemens.ch [139.16.10.12])
	by zrha221a.zrh.siemens.ch (Build 101 8.9.3/NT-8.9.3) with ESMTP id RAA10488
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jan 2003 17:29:44 +0100
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
To: "'linux-fbdev-devel@lists.sourceforge.net'" <linux-fbdev-devel@lists.sourceforge.net>

Hello, 
I have the pleasure to write a driver for a 128*64 dots LCD. 
It's just a black and white display (without grey scale). 
The display is connected to a KS0713 controler circuit. 

Questions: 
- What window messenger do I have to use in order to write 
  texts and draw bitmaps?
- Can anyone recommend a driver I can use as an example?
- How can I edit bitmaps?

Regards, 
Peter


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
