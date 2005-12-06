From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
Subject: dirty artefacts on bootup
Date: Tue, 06 Dec 2005 13:25:27 +0100
Message-ID: <1133871927.5595.8.camel@noti>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EjbtD-0000Qu-Ly
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Dec 2005 04:25:47 -0800
Received: from mail3.netbeat.de ([193.254.185.27])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1Ejbt9-0006sE-6C
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Dec 2005 04:25:47 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Benjamin,

I'm using the radeon framebuffer driver on a sony-notebook with a radeon
9200 mobile.

During bootup I get dirty artefacts on the screen. 
It's hard to explain. The text first is clear on the screen, but then
there come so many dirty lines on top of it, that you cannot read
anything.
When the xserver is started, the problem is away. switching to a console
with [Alt][CTRL][F1] works perfectly. And then you can read the text
normally.

I have compiled the driver with the debug-option, which brought the
following output.
I'm not quite sur, if this can help, because I got it, when the console
worked after starting X.

[  148.839846] hStart = 1040, hEnd = 1176, hTotal = 1344
[  148.839851] vStart = 770, vEnd = 776, vTotal = 806
[  148.839855] h_total_disp = 0x7f00ync_strt_wid = 0x11040a
[  148.839858] v_total_disp = 0x2ff0325noti login: [  148.839846] hStart
= 1040, hEnd = 1176, hTotal = 1344
[  148.839851] vStart = 770, vEnd = 776, vTotal = 806
[  148.839855] h_total_disp = 0x7f00a7ync_strt_wid = 0x60301
[  148.839860] pixclock = 15384
[  148.839862] freq = 6500

Is there anything I can do to get this dirty lines away?

Thanks for your help 

Dirk





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
