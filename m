From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Detect switching to X?
Date: Mon, 28 Nov 2005 23:17:41 +0100
Message-ID: <438B8205.7070604@t-online.de>
References: <43894E39.9080902@t-online.de> <438A3568.50100@gmail.com> <438A9BA8.3070600@t-online.de> <438AB24C.60405@gmail.com> <438ABBF3.20104@t-online.de> <438AC4D9.9040603@gmail.com> <438B0A1A.6010409@t-online.de> <438B134F.8080406@gmail.com> <438B1E6D.7060305@t-online.de> <438B24B8.80306@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgrJS-0003Lt-NQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 14:17:30 -0800
Received: from mailout01.sul.t-online.com ([194.25.134.80])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EgrJN-0005xJ-9j
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 14:17:30 -0800
In-Reply-To: <438B24B8.80306@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


>I have this code since 2.6.12 and thereabouts.  Currently, I'm at
>linux-2.6.15-rc2-mm1.
>
>You might want to also check drivers/char/vt.c:do_blank_screen().
>If going to KD_GRAPHICS mode, entering_gfx != 0.
>
>Tony
>
>  
>
Well, the code does work perfectly well. During the transition to 
KD_GRAPHICS
there is first a switch to the tty that is used by X, then the mode 
switch occures. But
I activated cyblafb for tty1 only, vesafb was in control of all other 
ttys. So the
restore_state of cyblafb never was called. Stupid mistake on my side ...

Please submit the patch.

cu,
 knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
