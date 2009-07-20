From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH v2 1/2] ep93xx video platform support
Date: Tue, 21 Jul 2009 08:55:19 +1200
Message-ID: <4A64D9B7.8050005@bluewatersys.com>
References: <4A60D6F3.5060906@bluewatersys.com>
	<4A6309CD.9070505@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901AC23A5@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ryan@bluewatersys.com>) id 1MSzry-0000lo-NY
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Jul 2009 20:53:58 +0000
Received: from mail.bluewatersys.com ([202.124.120.130]
	helo=hayes.bluewaternz.com)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MSzrr-0006HU-Q0
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Jul 2009 20:53:58 +0000
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901AC23A5@mi8nycmail19.Mi8.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, d.venzano@motronica.com, linux-fbdev-devel@lists.sourceforge.net, arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>

H Hartley Sweeten wrote:
> On Sunday, July 19, 2009 4:56 AM, Ryan Mallon wrote:
>   
>> Updated version of the ep93xx video driver platform support patch with
>> fixes suggested by Hartley.
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>>     
>
> A couple more formatting issue comments below.
>
>   
>>  static struct clk clk_uart1 = {
>>  	.sw_locked	= 1,
>> @@ -73,6 +73,13 @@ static struct clk clk_keypad = {
>>  	.set_rate	= set_keytchclk_rate,
>>  };
>>  
>> +static struct clk clk_video = {
>>     
>
> Unnecessary blank line.
>   
I like having blank lines between structures :-). I can remove it if you
want.
>>  
>> +static unsigned long calc_clk_div(unsigned long rate, int *psel, int *esel, 
>> +				  int *pdiv, int *div)
>> +{
>> +	unsigned long max_rate, best_rate = 0, 
>> +		actual_rate = 0, mclk_rate = 0, rate_err = -1;
>> +	int i, found = 0, __div = 0, __pdiv = 0;
>> +	
>> +	/* Don't exceed the maximum rate */
>> +	max_rate = max(max(clk_pll1.rate / 4, clk_pll2.rate / 4),
>> +		       (unsigned long)EP93XX_EXT_CLK_RATE / 4);
>> +	rate = min(rate, max_rate);
>> +	
>> +	/*
>> +	 * Try the two pll's and the external clock
>> +	 * Because the valid predividers are 2, 2.5 and 3, we multiply
>> +	 * all the clocks by 2 to avoid floating point math.
>> +	 *
>> +	 * This is based on the algorithm in the ep93xx raster guide:
>> +	 * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
>> +	 *
>>     
>
> Unnecessary extra '*'.
>   
Again, I think this is okay, it spaces the comment out a bit and makes
it more readable (IMHO).
> Looks good other than that.
>
> I'm not sure which tag is appropriate for this patch.  So here's both.
>
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>   
Sorry, your signed-off-by should have been there from the start.
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>   
I'm not sure if you can have both a signed-off-by and acked-by tag on
the same patch. Russell?

I'm also putting together a short document on how to use the driver
since Daniele was having trouble getting it going. I would like to wait
until he has it fully working before this gets applied since that gives
us a third independent person who can confirm it all works.

Russell, will this eventually be okay to go through the ARM patch
system, or does it need to go via the framebuffer people?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

       Ryan Mallon                              Unit 5, Amuri Park
       Phone: +64 3 3779127                     404 Barbadoes St
       Fax:   +64 3 3779135                     PO Box 13 889
       Email: ryan@bluewatersys.com             Christchurch, 8013
       Web:   http://www.bluewatersys.com       New Zealand
       Freecall Australia  1800 148 751         USA 1800 261 2934


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
