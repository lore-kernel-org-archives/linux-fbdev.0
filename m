From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] backlight: Fix Kconfig dependency
Date: Sun, 28 May 2006 14:49:18 +0800
Message-ID: <447947EE.4090705@gmail.com>
References: <4478F1DF.9080804@gmail.com> <20060527232305.954b7703.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkF5b-0007b5-Ag
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 23:49:27 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FkF5a-0000X9-VZ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 23:49:27 -0700
Received: by py-out-1112.google.com with SMTP id b29so5892pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 May 2006 23:49:26 -0700 (PDT)
In-Reply-To: <20060527232305.954b7703.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, zap@homelink.ru, rpurdie@rpsys.net

Andrew Morton wrote:
> On Sun, 28 May 2006 08:42:07 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> CONFIG_FB = m and CONFIG_{BACKLIGHT:LCD}_CLASS_DEVICE = y is possible
>> resulting in link errors. Fix by making backlight and lcd class also
>> depend on FB
>>
>> Signed-off-by: Antonino Daplas <adaplas@pol.net>
>> ---
>>
>>  drivers/video/backlight/Kconfig |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
>> index 02f1529..022f9d3 100644
>> --- a/drivers/video/backlight/Kconfig
>> +++ b/drivers/video/backlight/Kconfig
>> @@ -10,7 +10,7 @@ menuconfig BACKLIGHT_LCD_SUPPORT
>>  
>>  config BACKLIGHT_CLASS_DEVICE
>>          tristate "Lowlevel Backlight controls"
>> -	depends on BACKLIGHT_LCD_SUPPORT
>> +	depends on BACKLIGHT_LCD_SUPPORT && FB
>>  	default m
>>  	help
>>  	  This framework adds support for low-level control of the LCD
>> @@ -26,7 +26,7 @@ config BACKLIGHT_DEVICE
>>  
>>  config LCD_CLASS_DEVICE
>>          tristate "Lowlevel LCD controls"
>> -	depends on BACKLIGHT_LCD_SUPPORT
>> +	depends on BACKLIGHT_LCD_SUPPORT && FB
>>  	default m
>>  	help
>>  	  This framework adds support for low-level control of LCD.
> 
> Would I be correct in believing that this is a mainline fix and hence
> 2.6.17 material?
> 

It's mainline fix, though I would say that it's not urgent.

Tony




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
