From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: scroll modes
Date: Wed, 30 Nov 2005 13:43:12 +0100
Message-ID: <438D9E60.7040007@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhRIT-00063W-6Z
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 04:42:53 -0800
Received: from mailout09.sul.t-online.com ([194.25.134.84])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhRIR-0001vs-VD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 04:42:53 -0800
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

Hi everybody,

Is there a patch for "true ywrap" scrolling?

Lets have a look at a mode xres=vxres=1024, yres=768, depth=32. As there
is 8 Mb of available memory, we can use a vyres of 2048. With an 8x16 font
this gives exactly 128 lines of text in virtual memory, 48 lines are 
displayed.

Current code stops to ypan at text line 80, moves image data to the 
beginning of the
video memory and continues. The frequent calls to copyarea are a major 
cause of
slowing down at high image depths.

Optimal scrolling for the cyberblade would mean nothing but to emit new 
lines
with hwaccel imageblit up to the very end of video memory and to ypan 
accordingly.
There is no need for moving data around in video memory or to redraw the 
screen
as the cyberblade hardware handles wrapping at the end of the video 
memory perfectly
fine.

cu,
 knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
