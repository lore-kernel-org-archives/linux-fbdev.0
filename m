From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: [PATCH 2.6.16] Add 1366x768 (WXGA) mode to modedb
Date: Mon, 1 May 2006 16:14:21 -0400
Message-ID: <A0E53E2F-A1E5-4C6D-8A48-EDAB6DF7EAF7@cecropia.com>
References: <B3DB462A-3D86-4803-AC99-52C8F94541F3@cecropia.com> <4452ADD2.6040002@gmail.com> <D34BD406-8A9A-41B4-BF3F-C1FD4095B91C@cecropia.com> <4452D24A.6090909@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Faeja-0007kL-U8
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 May 2006 13:11:06 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Faeja-00056l-RF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 May 2006 13:11:06 -0700
Received: from mail7.sea5.speakeasy.net ([69.17.117.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FaejZ-0003EG-Tp
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 May 2006 13:11:06 -0700
Received: from lex098.cecropia.com (HELO [192.168.3.25]) (dmunsie@cecropia.com@[63.138.212.98])
          (envelope-sender <dmunsie@cecropia.com>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted SMTP
          for <linux-fbdev-devel@lists.sourceforge.net>; 1 May 2006 20:11:05 -0000
In-Reply-To: <4452D24A.6090909@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Just checked on the actual machine.  1366x768M-32@60 did not work at  
all -- the display is completely jumbled.  1366x768MR-32@60 seems to  
work, but I'm not entirely convinced.  The display looks a bit scaled  
at points, but fbset -i reports that it is indeed running at  
1366x768.  But, the other issue is that it's still reporting 59Hz  
instead of 60Hz.

Since it seems sketchy that the 1366x768 would continue to work since  
CVT specifies rounding off the pixels to multiples of 8, I think the  
best solution would be to put the modeline in the table.

dennis

On Apr 28, 2006, at 10:41 PM, Antonino A. Daplas wrote:

> Dennis Munsie wrote:
>> I'm away from the actual machine, but I did just try it blindly and
>> checked out the output from the driver with dmesg:
>>
>> fbcvt: Aspect ratio not CVT standard
>> fbcvt: 1360x768@60: CVT Name - Not a CVT standard - 1.044 Mega  
>> Pixel Image
>>
>> intelfb: intelfb_check_var: accel_flags is 0
>> intelfb: intelfb_var_to_depth: bpp: 32, green.length is 0
>> intelfb: Initial video mode is 1366x768-32@59.
>>
>> It looks as if something valid is coming back and the driver is  
>> setting
>> up the mode, but at this point I don't know if there is really  
>> something
>> on the display or not.  One thing that is disconcerting is that I  
>> asked
>> for 60Hz and it returned back 59Hz.  Another thing, which may be
>> nothing, is that second line where it says the mode is 1360x768.   
>> I am
>> specifically requesting 1366x768M-32@60 in for my modeline.
>
> Ah, okay.  The CVT standard will always round off the horizontal  
> resolution
> to 8 pixels so 1360 from 1366.
>
>>
>> I will be able to test it more thoroughly on Monday when I am back in
>> the office.
>
> Let me know if it works, but I'll still send your patch to mainline.
>
> Tony


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
