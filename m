From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH]: frame buffer driver for 2700G LCD
 controller
Date: Tue, 11 Jul 2006 17:33:47 +0800
Message-ID: <44B3707B.7010402@gmail.com>
References: <44AD2B75.6050302@compulab.co.il> <44ADC4AE.2040903@gmail.com>
	<44B11542.7010402@compulab.co.il> <44B18F68.2080802@gmail.com>
	<44B378A8.3060906@compulab.co.il>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0Ed2-0007KM-JO for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 02:34:04 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G0Ecz-0002o3-3d
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 02:34:04 -0700
Received: by py-out-1112.google.com with SMTP id c31so4242472pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 11 Jul 2006 02:33:59 -0700 (PDT)
In-Reply-To: <44B378A8.3060906@compulab.co.il>
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
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-fbdev-devel@lists.sourceforge.net

Mike Rapoport wrote:
> Antonino A. Daplas wrote:
> 
>> Mike Rapoport wrote:
>>  
>>
>>> Antonino A. Daplas wrote:
>>>
>>>   
>>>> Mike Rapoport wrote:
>>>>
>>>>
>>>>     
>>>>> This patch adds frame buffer driver for 2700G LCD controller
>>>>> present on
>>>>> CompuLab CM-X270 computer module.
>>>>> This pacth is versus current Linus git tree.
>>>>>
>>>>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>>>>>
>>>>>
>>>>>       
>>> +/* extern unsigned long virt_base_2700; */
>>> +#define __REG_2700G(x)    (*(volatile unsigned
>>> long*)((x)+virt_base_2700))
>>>   
>>
>> BTW, you will need to use generic accessors (readb|w|l, writeb|w|l or
>> __raw_readb|w|l, __raw_writeb|w|l, etc). This will entail a lot of
>> changes.
>> Otherwise, this driver won't get past Andrew Morton and Rusty.
>>
>> See include/asm/io.h.
>>  
>>
> What's the better way?
> {
>    ...
>    writel((readl(REG) | bits), REG);
>    ...
> }
> 
> or
> 
> {
>    ...
>    u32 some_reg = readl(REG);
>    ...
>    some_reg |= bits;
>    ...
>    writel(some_reg, REG)
>    ...
> }

Both are okay, but I prefer the first one for its brevity.


Tony


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
