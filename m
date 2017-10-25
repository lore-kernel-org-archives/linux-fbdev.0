From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 17:23:09 +0000
Subject: Re: [RFC 10/14] bootsplash: Add animation support
Message-Id: <e1dd42e7-d6f8-a0a8-409d-fab95b24279c@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
 <20171025124602.28292-11-mstaudt@suse.de>
 <2b47c2af-1ddd-a526-601e-1781bef65232@infradead.org>
In-Reply-To: <2b47c2af-1ddd-a526-601e-1781bef65232@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

On 10/25/2017 07:20 PM, Randy Dunlap wrote:
> On 10/25/17 05:45, Max Staudt wrote:
>> @@ -117,17 +128,45 @@ static bool is_fb_compatible(struct fb_info *info)
>>   */
>>  void bootsplash_render_full(struct fb_info *info)
>>  {
>> +	bool is_update = false;
>> +
>>  	mutex_lock(&splash_global.data_lock);
>>  
>> -	if (!is_fb_compatible(info))
>> -		goto out;
>> +	/* If we've painted on this FB recently, we don't have to do
>> +	 * the sanity checks and background drawing again.
>> +	 */
> 
> multi-line comment style needs to be corrected in multiple places (in
> several of the patches).

Sorry, I'll fix that. Thanks.


Max
