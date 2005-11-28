From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Detect switching to X?
Date: Mon, 28 Nov 2005 23:39:36 +0800
Message-ID: <438B24B8.80306@gmail.com>
References: <43894E39.9080902@t-online.de> <438A3568.50100@gmail.com> <438A9BA8.3070600@t-online.de> <438AB24C.60405@gmail.com> <438ABBF3.20104@t-online.de> <438AC4D9.9040603@gmail.com> <438B0A1A.6010409@t-online.de> <438B134F.8080406@gmail.com> <438B1E6D.7060305@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Egl7I-000681-4v
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 07:40:32 -0800
Received: from zproxy.gmail.com ([64.233.162.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Egl7D-0005L5-3y
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 07:40:28 -0800
Received: by zproxy.gmail.com with SMTP id r28so488394nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 28 Nov 2005 07:40:24 -0800 (PST)
In-Reply-To: <438B1E6D.7060305@t-online.de>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Hi Tony,
> 
>> Works here.  I inserted printk's before the calls to
>> fb_save|restore_state
>> in fbcon.c, switched to X and console several times, and I get this:
>>
>>  
>>
> Q: kernel version ?

I have this code since 2.6.12 and thereabouts.  Currently, I'm at
linux-2.6.15-rc2-mm1.

You might want to also check drivers/char/vt.c:do_blank_screen().
If going to KD_GRAPHICS mode, entering_gfx != 0.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
