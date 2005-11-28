From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Detect switching to X?
Date: Mon, 28 Nov 2005 15:31:24 +0800
Message-ID: <438AB24C.60405@gmail.com>
References: <43894E39.9080902@t-online.de> <438A3568.50100@gmail.com> <438A9BA8.3070600@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgdUn-00069y-Ui
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Nov 2005 23:32:17 -0800
Received: from xproxy.gmail.com ([66.249.82.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EgdUm-0000Xa-FL
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Nov 2005 23:32:18 -0800
Received: by xproxy.gmail.com with SMTP id h29so2000293wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 27 Nov 2005 23:32:14 -0800 (PST)
In-Reply-To: <438A9BA8.3070600@t-online.de>
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
> Hi Tony
> 
>>>
>>> Is there any way for a framebuffer driver to detect that a switch
>>> to X is in progress?
>>>   
>>
>> None, although fbcon will detect switches from KD_TEXT<->KD_GRAPHICS. I'm
>> thinking of adding optional fb_save_state() and fb_restore_state() hooks
>> which fbcon will call before going to KD_TEXT and before going to
>> KD_GRAPHICS respectively.
>>
>> I have the code in my development tree since one of the drivers does
>> not work with the experimental DRI driver. The DRI driver does not fully
>> restore its hardware state so the fbdev driver has to do the restore
>> for it.
>>
>>  
>>
> Please do submit that code as a patch to the main kernel tree as soon as
> possible.
> 

The patch is not really palatable.  It is a patch that attempts to fix
bugs in X, not fbcon.  Unless the problem is really widespread, then maybe
I'll go for it for mainline.

> I cannot take advantage of the full memory reserved for the
> cyberblade/i1 because
> the trident X driver only knows about the vga style way of setting the
> screen start
> address. The other way involves the usage of the register at GEBase +
> 0x10, but
> that disables the vga style setting completely.
> 
> There is one alternative way: I could hook somewhere into a periodically
> called
> interrupt, put some insane value into the vga style regs and check for a
> change.
> Then I would assume that X has switched to KD_GRAPHICS and enable the
> vga style again.

You need not do that (do a periodic check).  A set_par() will always be
called by fbcon whenever the console transitions from KD_GRAPHICS to
KD_TEXT.  So all you need to do is possibly check some register that says
the hardware is in legacy mode.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
