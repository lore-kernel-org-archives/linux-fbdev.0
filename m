From: Claudio Ciccani <klan@users.sf.net>
Subject: Re: radeonfb and newer radeons (Patch)
Date: Sun, 23 Jul 2006 11:59:13 +0200
Message-ID: <44C34871.6080201@users.sf.net>
References: <44C23E93.2000805@users.sf.net>
	<Pine.LNX.4.62.0607221919040.23027@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G4akE-0000a1-In for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 23 Jul 2006 02:59:30 -0700
Received: from smtp.cheapnet.it ([62.94.8.244])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G4akD-0002Zz-W7
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 23 Jul 2006 02:59:30 -0700
Received: from unknown (HELO [62.94.177.2]) ([62.94.177.2])
	(envelope-sender <klan@users.sf.net>)
	by smtp.cheapnet.it (qmail-ldap-1.03) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	23 Jul 2006 11:59:15 +0200
In-Reply-To: <Pine.LNX.4.62.0607221919040.23027@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Geert Uytterhoeven wrote:
> On Sat, 22 Jul 2006, Claudio Ciccani wrote:
>> the attached patch fixes some issues with R300 based chipsets and
>> adds support for a number of new devices (mostly X800/X850).
>> It also enlarges the mmio size to 0x8000 because many 3d registers
>> of the R300 are located after offset 0x4000 and we need them for
>> DirectFB (DRI needs too).
>> The patch applies to linux-2.6.18-rc2, hope there have not been changes
>> in the meanwhile.
> 
>> --- linux-2.6.18-rc2/drivers/video/aty/radeon_accel.c	2006-01-03 04:21:10.000000000 +0100
>> +++ /usr/src/linux-2.6.18-rc2/drivers/video/aty/radeon_accel.c	2006-07-22 12:49:43.000000000 +0200
>> @@ -203,9 +203,7 @@
>>  	host_path_cntl = INREG(HOST_PATH_CNTL);
>>  	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
>>  
>> -	if (rinfo->family == CHIP_FAMILY_R300 ||
>> -	    rinfo->family == CHIP_FAMILY_R350 ||
>> -	    rinfo->family == CHIP_FAMILY_RV350) {
>> +	if (IS_R300_VARIANT(rinfo)) {
>>  		u32 tmp;
>>  
>>  		OUTREG(RBBM_SOFT_RESET, (rbbm_soft_reset |
>> @@ -241,9 +239,7 @@
>>  	INREG(HOST_PATH_CNTL);
>>  	OUTREG(HOST_PATH_CNTL, host_path_cntl);
>>  
>> -	if (rinfo->family != CHIP_FAMILY_R300 ||
>                           ^^                  ^^
>> -	    rinfo->family != CHIP_FAMILY_R350 ||
>                           ^^                  ^^
>> -	    rinfo->family != CHIP_FAMILY_RV350)
>                           ^^
>> +	if (IS_R300_VARIANT(rinfo))
>             ^^
> These trigger a warning in my head...

If you have a look to the code from xorg, you will see this is right.
Indeed the previous code was REALLY wrong, because the condition returns
always true (while it should return true for R300 based chipsets).



-- 
Regards,
     Claudio Ciccani

klan@users.sf.net
http://directfb.org
http://sf.net/projects/php-directfb

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
