From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: Re: [PATCH v2 1/2] ep93xx video platform support
Date: Mon, 20 Jul 2009 17:01:00 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901AC23BF@mi8nycmail19.Mi8.com>
References: <4A60D6F3.5060906@bluewatersys.com>
	<4A6309CD.9070505@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901AC23A5@mi8nycmail19.Mi8.com>
	<4A64D9B7.8050005@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hartleys@visionengravers.com>) id 1MSzyu-0004Bq-QA
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Jul 2009 21:01:08 +0000
Received: from exprod6og115.obsmtp.com ([64.18.1.35])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MSzyq-0000Mb-I7 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Jul 2009 21:01:08 +0000
Content-class: urn:content-classes:message
In-Reply-To: <4A64D9B7.8050005@bluewatersys.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, d.venzano@motronica.com, linux-fbdev-devel@lists.sourceforge.net, arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Monday, July 20, 2009 1:55 PM, Ryan Mallon wrote:
>>> Updated version of the ep93xx video driver platform support patch with
>>> fixes suggested by Hartley.
>>>
>>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>>>     
>>
>> A couple more formatting issue comments below.
>>
>>   
>>>  static struct clk clk_uart1 = {
>>>  	.sw_locked	= 1,
>>> @@ -73,6 +73,13 @@ static struct clk clk_keypad = {
>>>  	.set_rate	= set_keytchclk_rate,
>>>  };
>>>  
>>> +static struct clk clk_video = {
>>>     
>>
>> Unnecessary blank line.
>>   
> I like having blank lines between structures :-). I can remove it if you
> want.

Only because all the other clk's don't have a blank line separating them.

>>>  
>>> +static unsigned long calc_clk_div(unsigned long rate, int *psel, int *esel, 
>>> +				  int *pdiv, int *div)
>>> +{
>>> +	unsigned long max_rate, best_rate = 0, 
>>> +		actual_rate = 0, mclk_rate = 0, rate_err = -1;
>>> +	int i, found = 0, __div = 0, __pdiv = 0;
>>> +	
>>> +	/* Don't exceed the maximum rate */
>>> +	max_rate = max(max(clk_pll1.rate / 4, clk_pll2.rate / 4),
>>> +		       (unsigned long)EP93XX_EXT_CLK_RATE / 4);
>>> +	rate = min(rate, max_rate);
>>> +	
>>> +	/*
>>> +	 * Try the two pll's and the external clock
>>> +	 * Because the valid predividers are 2, 2.5 and 3, we multiply
>>> +	 * all the clocks by 2 to avoid floating point math.
>>> +	 *
>>> +	 * This is based on the algorithm in the ep93xx raster guide:
>>> +	 * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
>>> +	 *
>>>     
>>
>> Unnecessary extra '*'.
>>   
> Again, I think this is okay, it spaces the comment out a bit and makes
> it more readable (IMHO).

That's fine.

>> Looks good other than that.
>>
>> I'm not sure which tag is appropriate for this patch.  So here's both.
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>   
> Sorry, your signed-off-by should have been there from the start.
>> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>   
> I'm not sure if you can have both a signed-off-by and acked-by tag on
> the same patch. Russell?

I guess it should be a Signed-off-by, you will need an ack from someone
else (Russell?).

> I'm also putting together a short document on how to use the driver
> since Daniele was having trouble getting it going. I would like to wait
> until he has it fully working before this gets applied since that gives
> us a third independent person who can confirm it all works.

I was going to suggest that.  Or you could submit a patch for the
snappercl15 showing an example usage.

> Russell, will this eventually be okay to go through the ARM patch
> system, or does it need to go via the framebuffer people?

I think Russell could ok this part of the support.  The actual driver
will probably need to go via the framebuffer people.

I'm reviewing the driver right now.  You should have my Signed-off-by
later today.

Regards,
Hartley

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
