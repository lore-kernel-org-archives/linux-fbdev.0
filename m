From: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
Date: Tue, 23 Jun 2015 13:05:06 +0000
Subject: Re: [PATCH] staging: sm750fb: remove unused variables
Message-Id: <AM3PR06MB1297B255392202530D7729EBCFA00@AM3PR06MB1297.eurprd06.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150622072017.GA32220@IND12F0122>
In-Reply-To: <20150622072017.GA32220@IND12F0122>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



On Tuesday 23 June 2015 02:16 PM, Dan Carpenter wrote:
> On Mon, Jun 22, 2015 at 07:26:25AM +0000, Gujulan Elango, Hari Prasath (H.) wrote:
>> @@ -122,7 +121,7 @@ void setChipClock(unsigned int frequency)
>>  		* Sometime, the chip cannot set up the exact clock required by User.
>>  		* Return value from calcPllValue() gives the actual possible clock.
>>  		*/
>> -		ulActualMxClk = calcPllValue(frequency, &pll);
>> +		calcPllValue(frequency, &pll);
> 
> Should we get rid of calcPllValue() as well?  I guess I would prefer to
> leave the warnings until someone has the answer to this.
> 
> Warnings are good because they show where the bugs are.  It's not always
> the right thing to silence them.
> 
> regards,
> dan carpenter
> 
> 

Okay.Let us drop this patch and leave the warning as it is. Sudip,I saw
your e-mail on the same topic. Thank you both for reviewing.


-- 
thanks & regards,
Hari Prasath
