From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Detect switching to X?
Date: Mon, 28 Nov 2005 06:38:32 +0800
Message-ID: <438A3568.50100@gmail.com>
References: <43894E39.9080902@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgVAp-0004bq-LG
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Nov 2005 14:39:07 -0800
Received: from zproxy.gmail.com ([64.233.162.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EgVAn-0000AB-2L
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Nov 2005 14:39:07 -0800
Received: by zproxy.gmail.com with SMTP id z3so1990924nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 27 Nov 2005 14:39:04 -0800 (PST)
In-Reply-To: <43894E39.9080902@t-online.de>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Knut Petersen <Knut_Petersen@t-online.de>

Knut Petersen wrote:
> Hi everybody,
> 
> I could significantly increase the speed of cyblafb if I decided to
> use some registers the trident driver of X* does not know about.
> 
> Is there any way for a framebuffer driver to detect that a switch
> to X is in progress?

None, although fbcon will detect switches from KD_TEXT<->KD_GRAPHICS. I'm
thinking of adding optional fb_save_state() and fb_restore_state() hooks
which fbcon will call before going to KD_TEXT and before going to
KD_GRAPHICS respectively.

I have the code in my development tree since one of the drivers does
not work with the experimental DRI driver. The DRI driver does not fully
restore its hardware state so the fbdev driver has to do the restore
for it.

Tony 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
