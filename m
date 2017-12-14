From: Max Staudt <mstaudt@suse.de>
Date: Thu, 14 Dec 2017 15:37:37 +0000
Subject: Re: [RFC PATCH v2 01/13] bootsplash: Initial implementation showing black screen
Message-Id: <96fd9c2f-a1d5-877c-af33-68e40211cc08@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-2-mstaudt@suse.de>
 <db71f29f-a9e0-070c-fd08-274323fc83a5@infradead.org>
In-Reply-To: <db71f29f-a9e0-070c-fd08-274323fc83a5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, philm@manjaro.org, bernhard.rosenkranzer@linaro.org

On 12/14/2017 12:55 AM, Randy Dunlap wrote:
> On 12/13/2017 11:47 AM, Max Staudt wrote:
>> This is the initial prototype for a lean Linux kernel bootsplash.
>>
>> As it is now, it will show a black screen rather than a logo, and
>> only if manually enabled via the kernel cmdline:
>>
>>   bootsplash.enable=1
> 
> Is it .enable or .enabled?  (compare below)

Oops. It's neither, I've kicked out the option and updated the documentation, but forgot about the commit message.


Thanks!

Max
